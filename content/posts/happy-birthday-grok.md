+++
title = "Happy birthday Grok!"
date = 2007-10-15
slug = "happy-birthday-grok"

[taxonomies]
tags = ["grok"]
+++

Grok the codebase is 1 year old this week! One year ago, from the 12th
of october until the 17th of october 2006, we started the Grok project
in Halle, Germany. The design discussions for Grok are older - they go
back to EuroPython. And the Zope 3 project, the base without which Grok
would be nothing, started development in 2001.

But one has to start somewhere, and in that sprint Grok really came together.
Four hackers sat together. A beamer projected our code on a wall. We started to
hammer out the design and code of Grok. At the beginning of the sprint there
was a rough sketch of a design and no code. At the end of that sprint, we had
Grok. Grok's caveman theme was born at this sprint. In case you missed it, here
is [my report](@/posts/grok-or-what-i-did-on-my-holiday.md) on that first
sprint.

Over the last year, much has happened. We've had more sprints. We've
presented Grok at conferences. We have given Grok tutorials. We built up
a thriving Grok community centered around our grok-dev mailing list. We
have had a successful summer of code with two projects to improve Grok.
To our delight, many clever contributors joined us to help improve Grok,
which has come a very long way. Two weeks ago, a group of sprinters even
visited the "spiritual home" of Grok:
[Neanderthal](http://en.wikipedia.org/wiki/Neanderthal%2C_Germany) in
Germany.

Grok is far more than just a codebase - it's a community and a mission:
we want to make the powerful Zope 3 technologies appealing to
"cavemen" - by which I mean myself and other people who want to have
power without having their heads explode.

Some features that Grok has today:

- Lively, responsive development community. We're here, we have a
  mission and we're not going to stop.
- Grok is documented: on <http://grok.zope.org> we have a tutorial and
  howtos, and a lot more coming.
- Store your Python objects in a powerful, industry strength object
  database, the ZODB. (or a relational database, should you prefer)
- Grok has a powerful UI that allows you to browse Grok-based
  applications and introspect their objects to see what their APIs are
  and where they are implemented.
- Powerful schema-driven form generation system.
- Index your Python objects for fast search, including full-text
  facilities.
- Zope 3's powerful security infrastructure, optimized for usability.
- Support for XMLRPC and JSON out of the box.
- Upwards compatibility with Zope 3: the huge range of powerful Zope 3
  components will work with Grok.
- Easy to install using
  [grokproject](http://pypi.python.org/pypi/grokproject). This is not
  just an installation tool, but sets up a reproducible application
  buildout for you. This means no long INSTALL.txt files to install a
  Grok-based application (or Grok itself). It's just a few commands to
  get up and running, and the system downloads what's needed from PyPI
  or other Python package indexes.
- Use the powerful Zope 3 component architecture to create flexible,
  pluggable code without writing a lot of separate ZCML XML code to hook
  things together.
- Declarative Python code without a lot of meta-class magic. Just define
  a class and it's registered in the system.
- Well-defined separate library for extending Grok and other Python
  applications: [Martian](http://pypi.python.org/pypi/martian).

Some features that are currently in the works:

- A new website, and then a lot more documentation.
- WSGI support.
- REST support for Grok.
- Pluggable template languages for Grok, starting with Genshi.
- Downwards compatibility with Zope 3: use Grok-based code in other Zope
  3 projects.
- In general, we will continue on our mission to expose more powerful
  Zope 3 technology in a developer-friendly way. Zope 3's component
  software story _works_: There is a _lot_ of Zope 3 technology
  available already, and more is written every day!

So, happy birthday Grok! It was a very good first year, and we'll have a
great next year too, I'm sure of it. Come and [join
us](http://mail.zope.org/mailman/listinfo/grok-dev) if you'd like.
