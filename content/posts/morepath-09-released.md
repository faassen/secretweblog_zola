+++
title = "Morepath 0.9 released!"
date = 2014-11-26
slug = "morepath-09-released"

[taxonomies]
tags = ["morepath", "python", "planetpython"]
+++

Yesterday I released [Morepath](http://morepath.readthedocs.org) 0.9
([CHANGES](http://morepath.readthedocs.org/en/0.9/changes.html))!

What is Morepath? Morepath is a Python web framework. It tries to be
especially good at implementing modern, RESTful backends. It is very
good at creating hyperlinks. It is easy to use, but still lets you write
flexible, maintainable and reusable code. Morepath is very extensively
documented.

This release doesn't involve earth-shaking changes like the 0.7 and 0.8
releases did, but it still has an interesting change I'd like to
discuss.

# Fully qualified links

Morepath from the beginning generated path-based links that look like
this:

    /foo

In Morepath 0.9 this changed. Now we generate the fully qualified URL,
like this:

    http://example.com/foo

That's what most other web frameworks do.

The path-based links have advantages: they are shorter, you don't have
to worry about the URL scheme, and they have less chance to be exploited
by [HTTP Host header
attacks](http://www.skeletonscribe.net/2013/05/practical-http-host-header-attacks.html).
But they do make the life of REST clients slightly harder, as custom
client code has to be written that adds the base URL to path-based
links. Since Morepath wants to be a good framework for writing RESTful
applications, we decided to change the default behavior to full links.

Morepath wouldn't be Morepath if you couldn't do a few more interesting
things.

# Just path-based links, please

Want the old behavior back for an application? That's easy:

``` python
class MyApp(morepath.App):
     pass

@MyApp.link_prefix()
def myapp_link_prefix(request):
     return ''
```

Now your application generates path based links again like before.

(thanks [Denis Krienbühl](https://github.com/href) for contributing this
directive to Morepath!)

# Proxy support

Morepath by default doesn't obey the <span class="title-ref">HTTP
Forwarded header</span> in link generation, which is a good thing, as it
would allow various link hijacking attacks if it did. But if you're
behind a trusted proxy that generates the `Forwarded` header you *do*
want Morepath to take it into account. To do so, you install the
[more.forwarded](http://morepath.readthedocs.org/en/latest/paths_and_linking.html#proxy-support)
extension and subclass your (root) application from it:

``` python
from more.forwarded import ForwardedApp

class MyApp(ForwardedApp):
     pass
```

We don't have support yet for the old-style `X_FORWARDED_HOST` and
`X_FORWARDED_PROTO` that the `Forwarded` header replaces; we're open to
contributions to `more.forwarded`!

# Linking to external applications

Now we come to a very interesting capability of Morepath: the ability to
model and link to *external* applications.

Let's consider a hypothetical external application. It's hosted on the
ubiquitous `http://example.com`. It has documents listed on URLs like
this:

    http://example.com/documents/foo

We could of course simply create links to it by concatenating
`http://example.com/documents` and the document `id`, `foo`. For such a
simple external application that is probably the best way to go. So what
I'm going to describe next is total overkill for such a simple example,
but I have to use a simple example to make it comprehensible at all.

Here's how we'd go about modeling the external site:

``` python
class ExternalDocumentApp(morepath.App):
    pass

class ExternalDocument(object):
    def _init__(self, id):
       self.id = id

@ExternalDocumentApp.path(model=ExternalDocument, path='/documents/{id}')
def get_external_document(id):
    return ExternalDocument(id)
```

We don't declare any views for `ExternalDocument` as our code is not
going to create representations for the external document, just create
links to it. We need to mount it into our actual applicatino code so
that we can use it:

``` python
@App.mount(path='external_documents', app=ExternalDocumentApp)
def mount_external_document_app():
    return ExternalDocumentApp()
```

Now we set up the `link_prefix` for `ExternalDocumentApp` to point to
`http://example.com`:

``` python
@ExternalDocumentApp.link_prefix()
def external_link_prefix(request):
    return 'http://example.com'
```

As you can see, we've hardcoded `http://example.com` in it. Now if
you're in some view code for your `App`, you can create a link to an
`ExternalDocument` like this:

``` python
@App.json(model=SomeModel)
def some_model_default(self, request):
   return {
     'link': request.link(
          ExternalDocument('foo'),
          app=request.app.child('external_documents'))
   }
```

This will generate the correct `link` to the external document `foo`:

    http://example.com/documents/foo

## Simplification

You can make this simpler by using a `defer_links` directive for your
`App` (introduced in Morepath 0.7):

``` python
@App.defer_links(model=ExternalDocument)
def defer_document(app, obj):
    return app.child('external_documents')
```

We've now told Morepath that any `ExternalDocument` objects need to have
their link generated by the mounted `external_documents` app. This
allows you to write link generation code that's a lot simpler:

``` python
@App.json(model=SomeModel)
def some_model_default(self, request):
   return {
     'link': request.link(ExternalDocument('foo'))
   }
```

## In review

As I said previously, this is total overkill for an external application
as simple as the hypothetical one I described. But this technique of
modeling an external application can be very useful in specific
circumstances:

- This is declarative code. If you are dealing with a lot of different
  kind of links to an external application, it can be worthwhile to
  properly model it in your application, instead of spreading more
  failure-prone link construction code all over the place.

- If you have to deal with an external application that for some reason
  is expected to change its structure (or hostname) in the future. By
  explicitly modeling what you link to, you can easily adjust all the
  outgoing links in your application when that change happens.

- Consider a Morepath application that has a sub-application, mounted
  into it in the same process. You now decide to run this
  sub-application in a separate process, with a separate hostname. To do
  this you break out the code out into its own project so you can run it
  separately.

  In this case you *already* have declarative link generation to it. In
  the original project, you create a hollowed-out version of the
  sub-application that just has the `path` directives that describe the
  link structure. You then hardcode the new hostname using
  `link_prefix`.

  The code that links to it in the original application will now
  automatically update to point to the sub-application on the new host.

  This way you can break a larger application into multiple separate
  pieces pretty easily!

# Conclusion

If you've read all the way to the end, I hope you've enjoyed that and
aren't completely overwhelmed by these options! Just remember: these are
advanced use cases. Morepath grows with your application. It is simple
for simple things, but is there for you when you *do* have more complex
requirements.
