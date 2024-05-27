+++
title = "Morepath 0.7: new inter-app linking"
date = 2014-11-03
slug = "morepath-07-new-inter-app-linking"

[taxonomies]
tags = ["python", "planetpython", "morepath", "rest"]
+++

I've just released [Morepath](http://morepath.readthedocs.org) 0.7!

What is Morepath? Morepath is a Python web framework. It tries to be
especially good at implementing modern, RESTful backends. It is very
good at creating hyperlinks. It is easy to use, but still lets you write
flexible, maintainable and reusable code. Morepath is very extensively
documented.

So what's new in Morepath 0.7? The
[CHANGES](http://morepath.readthedocs.org/en/0.7/changes.html) doc as
usual has the details, but I'll give an overview here.

# New features for JSON handling

Morepath 0.7 introduces new ways to deal with JSON. There are two new
directives, `dump_json` and `load_json`. By using these you can teach
Morepath how to automatically convert incoming JSON to a Python object,
and outgoing Python objects to JSON. See the [JSON and
objects](http://morepath.readthedocs.org/en/latest/json.html)
documentation for more.

# Mounting and linking

The big change in Morepath 0.7 however involves the way mounting works,
and how you can link between applications. This introduces a few
breaking changes if you were using these features before. The
[CHANGES](http://morepath.readthedocs.org/en/0.7/changes.html) document
provides documentation that will tell you how to adjust your code.

I'm very happy with the new change. It cleans up several APIs. I believe
this makes them both easier to understand while at the same time
significantly cleaning up the implementation. It also introduces a
powerful new feature for inter-app linking: deferred links.

In brief, Morepath lets you mount one application into another:

```python
import morepath

class RootApp(morepath.App)
    pass

class SubApp(morepath.App):
    pass

@RootApp.mount(path='sub', app=SubApp)
def mount_subapp():
    return SubApp()
```

Now the `SubApp` application, which can be its own whole different thing
(its instance is a WSGI application), is mounted under the `RootApp`
application. When you go to `/sub`, `SubApp` takes over.

This doesn't work just for simple sub-paths like `sub`, but also for
parameterized paths. Consider this:

```python
class WikiApp(morepath.App):
    def __init__(self, wiki_id):
        self.wiki_id = wiki_id

@UserApp.mount(path='/users/{username}/wiki', app=WikiApp)
def mount_wiki(username):
    return WikiApp(wiki_id=wiki_id_for_username(username)
```

Here's we've mounted a wiki app into a user app. When you go to
`/users/foo/wiki`, the wiki app for user `foo` takes over, with its own
routes, views, and the like. The wiki app doesn't need to know about the
user app, and the user app just needs to know how to mount the wiki app.

Morepath is very good at linking: it knows how to construct a link to an
object instance. So, if you want to link to a particular `WikiPage`
instance from within the wiki app, you'd simply write this:

```python
request.link(some_wiki_page)
```

What if you wanted to create a link to a wiki page from the user app?
Just linking to the wiki page will fail, as the user app doesn't know
how to create links to wiki pages. But you can tell it to create a link
to an object in the wiki app explicitly:

```python
wiki_app = request.app.child(WikiApp, username='foo')
request.link(some_wiki_page, app=wiki_app)
```

If you are going to write a lot of such links, this can get boring.
Morepath introduces a new `defer_links` directive to help automate this:

```python
@UserApp.defer_links(model=WikiPage)
def defer_links_wiki_page(app, obj):
    return app.child(WikiApp(obj.wiki_id))
```

You have told Morepath that when it wants to create a link to a wiki
page it should consult a mounted wiki app? Which wiki id to use is
determined by inspecting the wiki page object -- it's assumed it knows
in which wiki it belongs in this example.

Now you can just write this in the user app to link to wiki pages:

```python
request.link(some_wiki_page)
```

Read the [nesting applications
documentation](http://morepath.readthedocs.org/en/latest/app_reuse.html#nesting-applications)
for more details.
