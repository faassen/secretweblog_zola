+++
title = "Morepath 0.4 and breaking changes"
date = 2014-07-07
slug = "morepath-04-and-breaking-changes"

[taxonomies]
tags = ["morepath", "planetpython", "python", "bowerstatic"]
+++

I've just released Morepath 0.4!

[Morepath](http://morepath.readthedocs.org) 0.4 is a Python web
framework that's small ("micro") and packs a lot of power. There are a
lot of facilities for [application
reuse](http://morepath.readthedocs.org/en/latest/app_reuse.html). And as
opposed to most web frameworks, it actually has [some intelligence about
generating hyperlinks to
objects](http://morepath.readthedocs.org/en/latest/paths_and_linking.html).

Morepath 0.4 has a breaking change to the way application reuse works.
Don't worry, you can fix your code by making a few minor changes. In
short, Morepath application objects are now classes, not instances, and
you can instantiate this class to get a WSGI object. See the
[CHANGES](http://morepath.readthedocs.org/en/0.4/changes.html#id1) for a
lot of details on what happened and what you need to do.

The big win is that application reuse in Morepath has become Python
subclassing, and that making a WSGI application (even a parameterized
one) is just instantiating the class.

The other win is that Morepath gained even more extensibility features,
namely the ability for Morepath extension to introduce new Morepath
directives (the decorators you see everywhere in Morepath examples). But
I can't talk too much about that until I document them properly.

Along with the new Morepath, I've also made the initial release of
[BowerStatic](http://bowerstatic.readthedocs.org)
([announcement](/posts/announcing-bowerstatic)).
BowerStatic is the WSGI framework that lets you easily include
bower-installed resources in your web page and do the right thing with
caching (forever, thank you, but on a separate URL for each version).

How does that relate to Morepath, you may ask? Well, today I've also
released the Morepath integration for BowerStatic,
[more.static](https://pypi.python.org/pypi/more.static). I've described
in the Morepath documentation [what to
do](http://morepath.readthedocs.org/en/latest/more.static.html) to get
it working in your Morepath project. The reason Morepath 0.4 had the
breaking change was in part to support `more.static`, which needed the
ability to introduce a new Morepath directive among other things.
