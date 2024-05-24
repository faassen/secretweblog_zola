+++
title = "WebOb and Werkzeug compared"
date = 2014-03-05
slug = "webob-and-werkzeug-compared"

[taxonomies]
tags = ["planetpython", "python", "morepath"]
+++

Yesterday I wrote [an
article](http://blog.startifact.com/posts/morepath-from-werkzeug-to-webob.html)
discussing why Morepath switched from the
[Werkzeug](http://werkzeug.pocoo.org) library to the
[WebOb](http://webob.org) library. I promised a followup with some
feedback on WebOb and Werkzeug, and here it is.

[Morepath](http://morepath.readthedocs.org) is the friendly neighborhood
Python web framework with super powers that I'm working on.

Let me start by stating that Werkzeug and WebOb are extremely similar
libraries. There are some minor differences in the details of the
Request and the Response object API, but the capabilities are pretty
equivalent. It was easy to switch from one to the other.

I am primarily interested in the Request and Response wrappers for WSGI,
and my second interest is in the lower-level APIs to handle HTTP.

# Lower-level APIs

Werkzeug exposes and documents lower level APIs for HTTP processing.
WebOb does not have so much layering, and does not expose a low-level
HTTP API.

I like Werkzeug better here. I noticed the lack in WebOb in one point in
Morepath: dealing with basic authentication. While Werkzeug exposed an
API for parsing the authentication header
([parse_authorization_header](http://werkzeug.pocoo.org/docs/http/#werkzeug.http.parse_authorization_header)),
WebOb did not and I had to steal code from Pyramid. It would be nice if
WebOb included more of such lower-level utility APIs.

# Routing

Werkzeug contains a routing implementation, which always bothered me a
little; I have my own routing implementation in Morepath and do not want
Werkzeug's. WebOb focuses on just request and response handling and is a
better fit for Morepath here.

# Testing Tools

During my testing I ran into a point where I wanted to test cookies.
Werkzeug offers handy [test
utilities](http://werkzeug.pocoo.org/docs/test/) that take care of this.
WebOb does not do it out of the box. But I quickly found
[WebObToolkit](https://pypi.python.org/pypi/webobtoolkit), which does
offer a `Client` class with the same capabilities as the one in
Werkzeug. I could easily convert my tests from Werkzeug to WebOb doing
this, and only have to have a test dependency on WebObToolkit.

# args versus GET, form versus POST

Werkzeug exposes URL parameters in a `args` attribute of the Request
object, and WebOb instead offers a `GET` attribute.

I find the name of the `GET` attribute slightly wrong, as you can have
URL parameters for a `POST` request as well.

Werkzeug exposes a parsed form in its `form` attribute, whereas WebOb
uses the `POST` attribute for this. This is also confusing, as it
contains the `POST` body for other HTTP methods as well, such as `PUT`.
In addition with `form` I get the immediate clue that it's a parsed
form, whereas with `POST` I don't get this clue and in fact I had to
check the manual to verify it *only* can contain form data.

WebOb also offers `params`, which is `GET` and `POST` combined, but
Morepath needs specific access, not this combined one. Werkzeug calls
this `values`.

It's easy enough to learn this and only a minor annoyance. Still, I
wonder whether it'd be worth it for WebOb to introduce `args` and `form`
as aliases for `GET` and `POST` and then perhaps deprecate the old
style.

# Performance

As discussed, WebOb is a bit faster for my use cases than Werkzeug. I
suspect a lot of the performance in WebOb has to do with the
optimization efforts by Chris McDonough, who uses WebOb in Pyramid.

Werkzeug's performance issues may be a regression due to compatibility
code for Python 3 -- much of it seems to be due to an excessive amount
of `isinstance` calls that probably have to do with string processing.

# Python 3

Both WebOb and Werkzeug are Python 3 compatible, though the way WebOb
introduced this compatibility evidently avoided performance issues.

# Pyramid Compatibility

While Morepath *looks* like Flask, it is quite similar to Pyramid under
the hood in many details.

When I announced the switch to WebOb from Werkzeug I got some positive
feedback -- of course I might've gotten equivalent positive feedback
from the Flask folk if I'd switched the other way around; it's
impossible to say. I do know that in the Pyramid world there seems to be
a bit more of a culture of sharing generic libraries than there is in
the Flask world.

People already expressed interest in sharing code between Pyramid
libraries and Morepath libraries, and this should now be easier as the
request and response objects are shared.

This should in particular make it easier to write
[tweens](http://morepath.readthedocs.org/en/latest/tweens.html) in such
a way that they work in Pyramid and Morepath both. Tweens are an idea I
took from Pyramid and a tween function has the same API in Pyramid and
Morepath -- it takes a request and returns a response.

This would involve some refactoring of tween factory code however (or a
compatibility layer), as the way tweens are created is different.

# Mixins

One thing that bothered me with Werkzeug are the many mixins provided
that you can include in the Request and Response objects. It was never
quite clear to me what mixins Morepath should be using exactly, except
in one case, where I *had* to involve `CommonResponseDescriptorsMixin`
to make sure the `content_type` header got set properly on the response
-- which I found out only after some debugging.

I don't really see the point of all these mixins; in theory you could
include just the functionality you need, but in practice the extra
functionality does not really hurt on the original Request and Response
objects itself, and I just get confused as what I should use.

WebOb does offer `BaseRequest` versus `Request`, where `Request` adds
the `AdhocAttrMixin`, which seems to maintain all non-webob attributes
on the Request in the WSGI environment for some reason. Once I saw the
performance drawback that brought, I quickly started using `BaseRequest`
instead.

# Debug Server

Werkzeug has a built-in debug server with some interesting capabilities.
WebOb does not. I hadn't used the debug server myself with Morepath yet,
though I had integrated it, so I didn't feel terrible in replacing it
with the server of `wsgiref` for development purposes. Still, I should
look around in WSGI/WebOb land to see whether I can find something
similar. Anyone have any ideas?

# HTTP Exceptions

Werkzeug implements HTTP exception classes, and WebOb does too. This
means you can raise a HTTP exception and have the framework catch it and
use it as a HTTP response. Very convenient, and I use it in Morepath.

But Werkzeug actually documents the [HTTP exception classes
available](http://werkzeug.pocoo.org/docs/exceptions/), and I can link
to them with the Morepath documentation using intersphinx.

WebOb does not offer API documentation for its exception classes, and I
had to look at the source. It would be nice if WebOb included API
documentation for these.

# Conclusion

The two frameworks are pretty equivalent. There are not really very
strong reasons to pick one over the other.

Werkzeug does a bit more, which is sometimes nice and something more
than I need. Werkzeug also has better API documentation. On the other
hand it offers a complex system of mixins.

WebOb is faster, and a bit closer to the goldilocks zone for the
purposes of Morepath: not too much, and only rarely too little. It
should also not be hard to improve WebOb in the areas where Werkzeug is
nicer. There's also the hope of more code sharing with the Pyramid
ecosystem.

Hopefully this article will be helpful to those trying to figure out
what WSGI request/response implementation to use, and also to the
maintainers of Werkzeug and WebOb themselves.

Let me know what you think!
