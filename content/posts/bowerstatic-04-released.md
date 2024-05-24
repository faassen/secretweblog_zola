+++
title = "BowerStatic 0.4 released!"
date = 2014-09-08
slug = "bowerstatic-04-released"

[taxonomies]
tags = ["planetpython", "python", "static", "morepath"]
+++

What's [BowerStatic](http://bowerstatic.readthedocs.org)? It's a little
WSGI framework application for Python that is easy to plug into any WSGI
web framework. What you can do with it is declare in Python code that
you want some Bower package included in the web page. It knows about
dependencies and such. Like [Fanstatic](http://fanstatic.org) but for
[Bower](http://bower.io/).

<http://bowerstatic.readthedocs.org/en/latest/>

I've released [BowerStatic
0.4](http://bowerstatic.readthedocs.org/en/0.4/changes.html). This fixes
a bug and clears away some technical debt that's been accumulating in
BowerStatic for a little while and was causing bugs. Goes to show that
instead of doing workarounds, be bold and refactor things a bit more
heavily -- life gets better and refactoring doesn't have to take a lot
of time, especially if you have proper automated tests.

BowerStatic has [Morepath](http://morepath.readthedocs.org) integration
in the form of [more.static](http://pypi.python.org/pypi/more.static).
