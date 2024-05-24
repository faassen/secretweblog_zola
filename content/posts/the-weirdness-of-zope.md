+++
title = "The Weirdness of Zope"
date = 2013-10-22
slug = "the-weirdness-of-zope"

[taxonomies]
tags = ["python", "planetpython", "zope", "plone", "silva"]
+++

Besides the use of Python, what were some of the other weirdnesses of
early Zope?

# Web UI

Zope featured a web-based user interface, which was rare thing at the
time. The user interface was a hybrid between a CMS and a development
environment. Using the web interface, people were able to construct and
configure applications using HTML templates, scripts and SQL statements.

The Zope UI was an interesting experiment. It dramatically lowered the
entry barrier for web development. It attracted a lot of people to Zope.
This helped the Zope community grow, but also led to problems, as the
next barrier to real Python web development was way too high.

In the end neither the CMS nor the development environment were
sufficient. The Zope community moved on to build its own CMSes. I helped
create one called [Silva](http://silvacms.org/), but the really big one
is [Plone](http://plone.org). Both are still around. Plone has always
had a very vibrant community, something I witnessed again first hand
last year at the Plone conference.

# Extensibility

Although the APIs were sometimes weird, you could extend Zope with new
components written in Python; just modules in files. Over time the Zope
community -- at least the developers who could -- slowly moved away from
the web user interface to write more and more code the Python way as
Zope extensions. Writing code through a web user interface was too
cumbersome -- it had a deliberately crippled Python for security
reasons, and the code you wrote that way was hard to maintain too;
integration with a version control system was difficult, for instance.

A rich ecosystem of new Zope components written in Python emerged from
the Zope community. One of the first pieces of open source software that
I wrote was a form component called Formulator that you could use to
construct web forms using the Zope web user interface. People still use
Formulator to this day.

Extensibility remained a focus of the Zope project throughout its
history. In a future post I'll talk about some of the extensibility
mechanisms that were introduced later.

# ZODB

Another innovation of Zope was the Zope Object Database (ZODB). The ZODB
is a Python object database, offering near transparent persistence for
Python objects. Over time it grew clustering support and multiple
storage backends. It is nearly magic: you write your Python class and
derive from the Persistent base class, and as long as you attach
instances of that class to a persistent root, they will continue to
exist in the database automatically.

The ZODB was actually sometimes problem commercially -- try to explain
to a customer that they should trust their data not to their precious
SQL database but to this weird Python database. Imaging doing this years
before the NoSQL movement emerged -- if you said "database" at the time,
people thought relational database with SQL. NoSQL has certainly made it
a lot easier now.

The ZODB is still around, and is very useful, though it does have some
drawbacks. Its strength, the integration with the Python language, is
also a source of some of its weaknesses. The ZODB is almost too intimate
with the Python language, making it harder to use data in it outside of
Python.

The intimacy between database and Python classes also makes it more
cumbersome to change the structure of Python code -- changing a Python
class can easily break its existing instances in the database if you
aren't careful.

The ZODB also doesn't support a built-in query engine, though it does
offer the tools to build one. I was one of the people who did
(hurry.query), but a query engine is really one of those things you want
to be taken care of by dedicated maintainers.

# Acquisition

Zope also innovated on something that is too weird to go into much
detail about here: acquisition. Store an object in an attribute of
another, and it will gain all the attributes and method of its
container. While sometimes useful it was a language innovation that went
too far, and had too many unforeseen interactions. I see acquisition as
an educational but failed experiment. If you want to read the
documentation, or if you have a strange desire to shoot yourself in the
foot, [Acquisition](https://pypi.python.org/pypi/Acquisition) is still
available as a library on PyPI today.

This blog entry is a part of a [series on
Zope](/posts/my-exit-from-zope.html) and my
involvement with it.
[Previous](/posts/the-rise-of-zope.html).
[Next](/posts/object-publishing.html).
