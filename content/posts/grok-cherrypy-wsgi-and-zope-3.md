+++
title = "Grok, CherryPy, WSGI and Zope 3"
date = 2006-11-29
slug = "grok-cherrypy-wsgi-and-zope-3"

[taxonomies]
tags = ["grok", "wsgi"]
+++

# Grok, CherryPy, WSGI and Zope 3

Yesterday night I experimented with getting Zope 3/Grok to work
CherryPy, through WSGI. This led to all kinds of interesting adventures
and opportunities. Follow the path I took:

This started as I had been doing some work with
[CherryPy](http://www.cherrypy.org) recently. I like what I see of
CherryPy so far; a nice, Pythonic and powerful web server.

Currently Zope 3 uses [Twisted](http://www.twistedmatrix.com) as the
default web server implementation. Using Twisted has lots of advantages.
It's a high-quality framework with a lot of features. It's also
maintained by people *other* than the Zope developers, which is good.
Since Zope was one of the first in the Python web space, the Zope
developers still maintain a version of Medusa for Zope 2 called ZServer.
It made sense to do that at the time, but it doesn't now.

So if Twisted is so nice, why look at CherryPy at all? Because it's nice
and because it's fun to try would be reasons that are good enough, but
there are some other reasons that make CherryPy interesting for Zope
too:

- CherryPy supports threaded webservers in a non-begrudging manner.
  Since Zope uses a threaded model for web serving, that might be a nice
  match. Twisted supports threads just fine too, but when you do, one
  always gets this idea that thousands of Twisted developers screaming
  at you just outside the range of your hearing.
- CherryPy is committed to supporting
  [WSGI](http://www.python.org/dev/peps/pep-0333/), the framework for
  Python web interoperability. Zope has committed to using WSGI as
  well.The Twisted community sometimes seems to be a bit more
  half-hearted about supporting this.
- CherryPy installs cleanly as a Python egg. This means I can use
  setuptools and
  [buildout](http://cheeseshop.python.org/pypi/zc.buildout/) easily.
  When I asked a few months ago I got the impression the Twisted
  developers don't like eggs very much and certainly have no plans to
  support them any time soon. Since Zope is moving towards using eggs,
  CherryPy is interesting.

Then I got slightly side-tracked. I figured that the easiest way to
integrate Zope 3 with CherryPy was to use CherryPy's WSGI server and use
Zope 3 as a WSGI app, which Zope 3 has support for. This gave me a nice
opportunity to play with WSGI for a bit. Now CherryPy's WSGI server is
not actually CherryPy's server, so there goes my goal of integrating the
whole of CherryPy... I heard a few good things about CherryPy's WSGI
server too though, and it was easier to do, so I tried that.

This became a nice opportunity to play with some other things. One of
the reasons I wanted to try running Zope 3 and Grok with CherryPy is
that it would allow me to experiment with what the minimal Zope 3
configuration of Zope 3 would need to be. Grok comes in nicely here:
aiming for Grok support made that minimal configuration quite
well-defined. I didn't need to aim to get Zope 3's own management UI up,
just to get the basic Grok functionality to work.

One of my aims is to make Zope 3's startup procedure a lot faster when
you're doing Grok development. Another aim is to be prepared for the
time when Zope 3 comes as a whole bunch of eggs: we can just use the
eggs that Grok needs and not anything else. Combined with buildout this
makes for an easy and powerful development and deployment system.

So those are my aims and motivations - how far did I get? Quite far: I
got a basic Grok view working with CherryPy's WSGI server when I
stopped. Not needing the whole of Zope 3 to load up, the server also
starts a bit faster, though not as fast as I'd like yet. Here it is:

<http://svn.zope.org/megrok.cherry>

There are some interesting parts. This is the site.zcml that includes
the smallest minimum of ZCML I've managed to get to yet:

<http://svn.zope.org/megrok.cherry/trunk/site.zcml?view=markup>

This is the WSGI-based server that hooks Zope 3 as a WSGI app into
CherryPy's WSGI server:

<http://svn.zope.org/megrok.cherry/trunk/src/megrok/cherry/server.py?view=markup>

Not a lot of code, thanks to WSGI!

This shows that Grok works at least minimally; we're registering a view
for Zope 3 containers (such as the root folder):

<http://svn.zope.org/megrok.cherry/trunk/src/megrok/cherry/demo.py?view=markup>

A lot more work needs to be done if this wants to become anywhere near
production ready. This code right now is just an experiment. I just
thought I'd get my thoughts out there, and see who's interested.

Since it's all a buildout, you can install it safely and if you're on a
sufficiently Unixy machine, make it work:

    $ svn co svn://svn.zope.org/repos/main/megrok.cherry megrok.cherry
    $ cd megrok.cherry
    $ python2.4 bootstrap.py
    $ bin/buildout
    $ bin/startserver

This starts a server running on port 8080. It doesn't do much yet, but
what it does is allowing you to access:

> <http://localhost:8080/test>

This is rendered by the <span class="title-ref">demo.py</span>
referenced before.

Let me know what you think!
