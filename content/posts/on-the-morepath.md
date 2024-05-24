+++
title = "On the Morepath"
date = 2013-10-31
slug = "on-the-morepath"

[taxonomies]
tags = ["python", "morepath", "reg", "planetpython", "zope", "pyramid"]
+++

# Introduction

For a while now I've been working on Morepath. I thought I'd say a bit
about it here.

Morepath is a Python web micro-framework with super powers. It looks
much like your average Python micro-framework, but it packs some
seriously power beneath the hood.

# Web micro-framework battle wiki!

Let's start with sample code, a wiki implementation:

<https://github.com/morepath/morepath_wiki/blob/master/mpwiki/wiki.py>

This code is based on an example devised by Richard Jones for his [web
micro-framework battle
presentation](http://www.slideshare.net/r1chardj0n3s/web-microframework-battle).
When I asked him, he kindly shared his
[codebase](https://bitbucket.org/r1chardj0n3s/web-micro-battle) with
implementations for various micro-frameworks.

The Morepath wiki code uses the reusable module `storage.py` that
Richard created which implements the wiki backend and page rendering.
This is actually a little bit unfortunate for Morepath, as `storage.py`
doesn't expose an object oriented API. There is no wiki `Page` class for
instance, so I had to come up with a simple one myself, as Morepath is
very model-driven. Perhaps I'll refactor `storage.py` in the future so I
can better show off how Morepath can empower your models.

# Configuration

Morepath at first sight looks quite a bit like a Flask application. You
create an application object. You then use methods on the application
object as decorators to configure it.

But there is a significant difference with Flask (or many other web
frameworks, including Django) in that loading the configuration is not a
import-time side-effect, but an explict step. Morepath is like Zope and
Pyramid in this respect. The Pyramid documentation has an [extensive
section](http://docs.pylonsproject.org/projects/pyramid/en/1.3-branch/designdefense.html#application-programmers-don-t-control-the-module-scope-codepath-import-time-side-effects-are-evil)
explaining why this is a good thing.

# Routing to Models

Morepath's routing is different from any routing web framework I've
encountered before. Morepath routes to _models_, not to views. In the
wiki example the route to the wiki page model is done like this:

```python
@app.model(model=Page, path='{name}',
           variables=lambda model: {'name': model.name})
def get_page(name):
    if not storage.wikiname_re.match(name):
        return None
    return Page(name)
```

This says that paths like `/foo` go to a `Page` object with the name
`foo`. If no such wiki page exists, we return `None`, which will result
in a 404 error.

# Views

The routing code where the model is looked up is completely separate
from presentation. That's done in the _view_. Here's the default view
for `Page` (i.e. `/FrontPage`):

```python
@app.html(model=Page)
def display(request, model):
    return wiki.render_page(model.name)
```

And here is the `edit` view (i.e. `/FrontPage/edit`):

```python
@app.html(model=Page, name='edit', request_method='GET')
def edit_form(request, model):
    return wiki.render_edit_form(model.name)
```

# Link generation

Because Morepath routes to models, it can construct a link for a model,
which we see demonstrated for instance in a redirect response:

```python
return redirect(request.link(model))
```

`request.link()` receives a model and optionally a view name. Using the
`variables` argument on the `@app.model` decorator it can reconstruct
the path for you from the model. You don't need to remember route names
or what parameters go into them. Your links will continue to work if you
change your app's routes completely.

# Reuse and Flexibility

Morepath is powered by the generic function library
[Reg](/posts/reg-now-with-more-generic).
This provides a general mechanism for composing, extending and
overriding behavior.

In the wiki example, the `Page` model has a default display view, and
`edit` and `history` views. If you were to create a subclass from `Page`
called `DiscussionPage`, instances of `DiscussionPage` would
automatically share these views. But you can specialize: if you want
your `DiscussionPage` model to have a special way to display itself but
still share `edit` and `history`, this is what you'd do:

```python
@app.html(model=DiscussionPage)
def discussion_display(request, model):
    return "<h2>A different discussion page!</h2>"
```

With Morepath, you can bundle a set of behaviors such as views (and
routes) in a custom framework application, and then let others reuse it
in their own applications. But if in the same run-time you want to have
another application that doesn't share any of this behavior, Morepath
lets you do this too.

That's a lot of power in a small package. It's in fact a condensation of
15 years of [my experience with
Zope](/posts/my-exit-from-zope) packed
together into a micro-framework.

# Development Status

I'm actively developing Morepath and looking for feedback. Documentation
is very scarce right now, but that situation won't continue for long.

The Morepath code is here:

<https://github.com/morepath/morepath>

At PyCon DE earlier this month I gave a keynote speech where I go into
some of the creative process and thinking behind Morepath. If you have
more than an hour to spare, you can
[watch](http://pyvideo.org/video/2416/spinning-a-web-framework) it.

There's an IRC channel, \#morepath on freenode. Hope to see you there!
