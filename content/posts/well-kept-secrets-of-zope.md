+++
title = "Well-kept secrets of Zope"
date = 2007-09-10
slug = "well-kept-secrets-of-zope"

[taxonomies]
tags = ["zope"]
+++

## Well-kept secrets of Zope

Zope is a web framework that comes equipped with powerful, apparently
secret, features. Some of the things Zope has had for literally years
other web frameworks are only evolving today. And in other cases, Zope
comes equipped with features that other web framework communities are
currently only dreaming about.

If Zope has such powerful features, why are they a secret? I think it's
a combination of an unfortunate (but partially well-deserved) reputation
Zope has in large parts of the Python community, and Zope isolating
itself in its own community (it managed to build a large community many
years ago).

Before I start off _yet another_ discussion with people burned by Zope 2
in the past: Zope 3 is not Zope 2. It's not crufty. It _is_ hard to
approach, but we're fixing this with [Grok](http://grok.zope.org), which
cuts down on the complexity hard.

Now let's go into some features that Zope has and that we seem to be
keeping a secret very carefully from the rest of the world.

### Zope 3 has unicode everywhere

In july 2007, the Django project [started to support
unicode](http://www.unessa.net/en/hoyci/2007/07/django-say-hello-unicode/).
I'm happy to say that the Zope 3 project has supported unicode
throughout [since 2002](http://wiki.zope.org/zope3/UnicodeForText).
Consistently. Without backwards compatibility cruft. When the Django
project gains this support, I, who doesn't really follow Django
developments, learned about it from various blogs. We in the Zope
community don't _tell_ anyone as that'd spoil the surprise. Or
something.

### Zope 3 has a built-in form generation and validation system

Last year, I heard a lot about ToscaWidgets. This year I hear a lot
about Django newforms, replacing Django's older form generation system.

Development of Zope 3's declarative schema system and form generation
system started, guess when, <span class="title-ref">in 2002</span>,
based on ideas we had been exploring for a few years by then in the Zope
2 context. We've had 5 years of experience with it since then. This led
to the evolution of a new form generation system (on top of the
existing, solid, declarative schema system) in 2004. This year we've
seen a further evolution of this system with
[z3c.form](http://www.gossamer-threads.com/lists/zope/announce/208280)
(a _fourth_ new forms iteration evolving the work that had gone before).

So, Zope has a headstart of years of experience. We keep this hidden
within our own community, because otherwise it'd be like, _telling_!

### An object database

[CouchDb](http://couchdb.org) is gaining some attention recently. While
not an object database, it promises to store documents, not relational
database tables. Recently we've also witnessed some [ORM
Wars](http://www.b-list.org/weblog/2007/sep/04/orm-wars/) in various
Python blogs.

Meanwhile, some people in the Rails world [have been
thinking](http://gilesbowkett.blogspot.com/2007/05/evan-weavers-railsconf-presentation.html)...
Wouldn't it be nice if instead of all this impedance mismatch between
objects and relational databases we could use a true object database?
Wouldn't that be cool?

It's time for me to yawn and say "been there, done that". People might
somehow have missed it, but Zope 3 is equipped with an ACID-compliant,
clusterable object database, the ZODB, that has been under development
since _1997_. The Zope people _know_ the benefits of document-oriented,
object databases for web applications. We've worked in this
impedance-mismatch-free world for so long that we know the drawbacks
too, and thus have built Zope 3 extensions to work with SQLAlchemy as
well.

### Buildout

We have been putting together complicated web applications from many
different bits and pieces for a while now in the Zope world. Setting up
a development environment or rolling out a deployment is quite an
involved job often involving endless `INSTALL.txt` files. Setuptools and
eggs offer a lot of help here, and the Zope project has been embracing
them in a major way. They still leave a lot of stuff to do by hand
however, especially if non-library components are involved such as web
servers.

Enter [zc.buildout](http://pypi.python.org/pypi/zc.buildout/).
<span class="title-ref">zc.buildout</span> is an extensible Python
system for assembling Python applications from multiple parts. It will
work for any Python project: I've used it with TurboGears, and to set up
a game development environment, among others. Zope itself is of course a
major user of it, and it was forged in the fires of long experience and
requirements of the Zope community. It's a lot to chew on to learn, but
I believe any significant Python development project can benefit from
using it. I believe buildout is another example of where the Zope
project is tackling problems years ahead of many others within the
Python community. And now we've told you about it.

### To conclude

These features shouldn't be a secret. We should shout it off the
rooftops: the Zope community in many ways is _still_ pushing the
frontiers of Python web framework development.

Zope 3 has powerful features, and now also has an easy entry point. If
you want an easy way to learn about the future of web development in the
Python world, please try it out in the form of
[Grok](http://grok.zope.org), which promises to make Zope 3 safe for the
cave man or woman in all of us.
