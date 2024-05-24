+++
title = "lxml 0.7 released!"
date = 2005-06-15
slug = "lxml-0-7-released"

[taxonomies]
tags = ["lxml"]
+++

I'm happy to announce I've released lxml 0.7 earlier today! It contains
quite a bit of important work, from XInclude and XML Schema support to a
better implementation of tostring(). See the
[changelog](http://codespeak.net/lxml/changes-0.7.html) for more
information.

You can get more information and a download
[here](http://codespeak.net/lxml):

Unfortunately there seem to be some problems compiling with gcc 4.0 due
to some issues with Pyrex. There is a patch out there which aims to fix
it, but it's either incomplete or lxml is doing something weird, as it
doesn't appear to work with lxml yet. The lxml community is helping me
tracking this one down and testing it. Thanks community; your feedback
is very useful to have.

In other lxml related news, I'm going to give a presentation at
[EuroPython](http://www.europython.org) about lxml. So if you're curious
and you're showing up at EuroPython, please consider coming to my talk.
