+++
title = "New HTTP 1.1 RFCs versus WSGI"
date = 2014-08-19
slug = "new-http-rfcs-versus-wsgi"

[taxonomies]
tags = ["planetpython", "python", "wsgi"]
+++

Recently [new HTTP 1.1
RFCs](https://www.mnot.net/blog/2014/06/07/rfc2616_is_dead) were
published that obsolete the old HTTP 1.1 RFCs. They are extensively
rewritten.

Unfortunately the WSGI PEP 3333 refers to something only made explicit
in the _old_ version of the RFCs, but which is much harder to find in
the new versions of the RFCs. I thought I'd leave a report of my
investigations here so that others who may run into this in the future
can find it.

WSGI is a protocol that's like HTTP but isn't quite HTTP. In particular
WSGI defines its own iterator-based way to send larger responses out in
smaller parts. It therefore cannot deal with so-called "hop-by-hop"
headers, which try to control this behavior on a HTTP level. [The WSGI
spec
says](http://legacy.python.org/dev/peps/pep-3333/#other-http-features) a
WSGI application must not generate such headers.

This is relevant when you're dealing with a WSGI-over-HTTP proxy. This
is a special WSGI application that talks to an underlying HTTP server.
It presents itself as a normal WSGI application.

The underlying HTTP server could very well be sending out stuff like
such as `Transfer-Encoding: chunked`. The WSGI spec does not allow a
WSGI application to send them out though, so a WSGI proxy must strip
these headers out.

So what headers are to be stripped out? The WSGI spec refers to [section
13.5.1](http://www.w3.org/Protocols/rfc2616/rfc2616-sec13.html#sec13.5.1)
in now-obsolete RFC 2616.

This nicely lists hop-by-hop headers:

- Connection
- Keep-Alive
- Proxy-Authenticate
- Proxy-Authorization
- TE
- Trailers
- Transfer-Encoding
- Upgrade

That RFC also says:

"All other headers defined by HTTP/1.1 are end-to-end headers."

and then confusingly:

"Other hop-by-hop headers MUST be listed in a Connection header,
(section 14.10) to be introduced into HTTP/1.1 (or later)."

which one is it, HTTP 1.1? I guess that's one of the reasons this text
got rewritten.

In the new rewritten version of HTTP 1.1, this list is gone. Instead it
specifies for some headers (such as `TE` and `Upgrade`) that these
should be added to the `Connection` field. A HTTP proxy can then strip
out the headers listed in `Connection`, and then also strip out
`Connection` itself.

Confusingly, while the new RFC 7230 refers to the concept of
'hop-by-hop' early on, and also say this in the change notes in `A.2`:

"Also, "hop-by-hop" header fields are required to appear in the
Connection header field; just because they're defined as hop-by-hop in
this specification doesn't exempt them."

it doesn't actually _say_ any headers are hop-by-hop anywhere else.
Instead it mandates some headers should be added to `Connection`.

But wait: `Transfer-Encoding` is _not_ to be listed in the `Connection`
header, as it's not hop-by-hop. At least, not anymore. I've seen it
described as 'hopX-by-hopY', but not in the RFC. This is, I think,
because a HTTP proxy _could_ let these through without having to remove
them. But not for a WSGI over HTTP proxy: it _MUST_ remove
`Transfer-Encoding`, as WSGI applications have no such concept.

I think the WSGI PEP should be updated in terms of the new HTTP RFC. It
should make explicit that some headers such as `Transfer-Encoding` must
not be specified by a WSGI app, and that no headers that must be listed
in `Connection` can be specified by a WSGI app, or something like that.

Relevant mailing list thread:

<http://lists.w3.org/Archives/Public/ietf-http-wg/2014JulSep/thread.html#msg1710>
