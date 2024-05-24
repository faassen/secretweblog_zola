+++
title = "WSGI: Bringing web frameworks closer together"
date = 2011-08-02
slug = "wsgi-bringing-web-frameworks-closer-together"

[taxonomies]
tags = ["wsgi", "framework", "django"]
+++

# WSGI: Bringing web frameworks closer together

Recently I have seen a sentiment espoused by some people in the Python
web community that WSGI has failed to live up to one of this promises:
bringing Python web frameworks closer together.

Let's look at history and see whether this is true.

Here's a snapshot of the Python web framework landscape in 2005:

- Zope had its own way of hooking up to web servers. Several ways.
  FastCGI, SCGI, Apache Rewrite rules, ProxyPass.
- Django had just emerged, with its own way of hooking up to web
  servers. Several ways too; I can find references to using mod_python,
  FastCGI, SCGI and AJP.
- TurboGears had also just emerged. TurboGears 1.x used CherryPy as its
  web server. A quick search turns up references to hooking it up to
  Apache using mod_python, and using mod_rewrite.

Let's look at the web framework landscape in 2011:

- Zope (in all its incarnations) can be hooked up to web servers to
  WSGI, and this is generally the preferred method.
  - Zope 2 comes with native WSGI support.
  - Grok has native WSGI support and uses paster as its development
    server.
  - BlueBream has native WSGI support and uses paster as its development
    server.
- Django has WSGI as the preferred method to hook up to web servers.
- TurboGears is now built around WSGI and uses paster as its development
  server.
- Both Pylons the web framework as well as Pyramid are built around
  WSGI, and both use paster as its development server.

\[no claim is made that this represents all Python web frameworks out
there\]

Has this brought web frameworks closer together? The answer is clearly a
resounding YES: if you know how to hook up a WSGI application to your
web server of choice, you have basic knowledge to deal with all of these
web frameworks. You can use Apache mod_wsgi with all of them, for
instance.

In addition, only Zope 2 and Django do not use paster as their default
development web server. We see a major component being shared between
Grok, BlueBream, TurboGears, Pylons and Pyramid. This knowledge
transfers between web frameworks.

So this sentiment is clearly wrong. Thank you to everybody who has
helped create and push WSGI!

Other arguments have been made, for instance that WSGI *middleware* in
particular isn't bringing Python web frameworks closer together. I
believe that's wrong too, but I will leave defending that point to
someone more familiar with that topic.
