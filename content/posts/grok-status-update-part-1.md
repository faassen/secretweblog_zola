+++
title = "Grok Status Update Part 1"
date = 2008-06-02
slug = "grok-status-update-part-1"

[taxonomies]
tags = ["grok"]
+++

Time for a [Grok](http://grok.zope.org) status report. I thought the
Grokkerdam sprint was very successful. It is now a few weeks behind us.
A fun time was had by the participants and we got a lot of work done.
What's more we've had followup on many of the projects started there -
people have continued the work started at the sprint.

Meanwhile our release mill is churning along: last week Grok 0.12.1, a
bugfix release, was released!

Here is an overview of some of the recent interesting developments in
Grok-land. There is really too much to mention, so forgive me if I don't
mention your favorite topic. This is part 1. I'll be posting another
blog entry soon which continues the update.

**megrok.rdb**

At the sprint, we started the `megrok.rdb` project to integrate Grok
into SQLAlchemy. We had a long discussion on how to best do this, and
got a lot of valuable input from Christian Theune. After this Christian
Theune, Christian Klinger, Jasper Spaans and myself worked on the
implementation. We now have a sketchy implementation that does have many
of the features we discussed, albeit in unpolished form:

- we use SQLAlchemy's `declarative` extension for defining classes and
  tables.
- we have a `megrok.rdb.Model` and a `megrok.rdb.Container`, analogous
  to the ZODB-backed `Model` and `Container` in Grok core.
- we can traverse a SQLAlchemy generated ORM mapping, both objects and
  through relations (which act like containers).

The current example code using SQLAlchemy with Grok looks like this:

<http://svn.zope.org/grokapps/rdbexample/trunk/src/rdbexample/app.py?&view=markup>

We definitely will be cleaning this up further and will make many
changes, but it already looks pretty clean.

After the sprint the work continued. One important development was the
creation of the `zope.sqlalchemy` package by Laurence Rowe, which is
intended to become the universal foundation to the other SQLAlchemy
projects in the Zope world. It provides transaction integration between
Zope and SQLAlchemy. I have also been extensive discussion with Laurence
and others on how to best implement a multi-application multi-database
setup with SQLAlchemy. Zope, and Grok, support the pattern of having
multiple separate applications in a single server, and when you are
using a database, multiple databases. We need to convince SQLAlchemy to
do the right thing there while preserving ease of use.

**grok.traversable**

During the relational database integration discussion at the Sprint we
discovered a common traversal pattern we decided to codify. Thanks to
the work done by Reinout van Rees and Jasper Spaans we now have a
`grok.traversable()` directive. This makes it trivial to make an
attribute of an object traversable and thus part of URL space.

This directive will be available in the next feature release of Grok
(Grok 0.13).

**Grok on Zope 3.4 (KGS)**

Grok had pinned down the versions of its dependencies to "whatever
worked" back at the Neanderthal sprint. Since then, Stephan Richter
developed and maintains KGS, a package index for Zope 3 packages.
Versions of these packages are tested together.

At the sprint, Maurits van Rees and Tim Terlegård updated the
`versions.cfg` list of Grok to the KGS-based versions. We continue to
maintain our own versions list, but at least Grok depends on the same
versions again as a typical Zope 3.4 install.

After the sprint, we've checked that Windows binary versions are
available of all the eggs currently in KGS. Jim Fulton kindly compiled
them for us and made them available on the Python Package Index, so Grok
0.13 will be windows compatible.

**Sphinx for Grok**

Uli Fouquet did a lot of work before the sprint in integrating the
[Sphinx](http://sphinx.pocoo.org/) documentation utility for Grok's
documentation. Jan-Wijbrand Kolman and Uli spent a lot of time polishing
this off and landing this support in the Grok trunk. We intend to start
publishing some of the SVN managed documents for Grok with this. We will
also continue to publish documents using our Plone website, but some
documents are better suited to being maintained within SVN instead.

Now we only need to start adding this to our documentation workflow;
we've started discussions on how to do this, so hopefully this will land
our website soon.

**Documentation**

A lot of work was done on documentation during the sprint. The website
was reviewed and suggestions for improvements were made. Kamon Ayeva and
Godefroid Chapelle also offered to help maintain the Grok Plone site.
Since the sprint we've set up a grok-web mailing list. This is a welcome
release for our hard-pressed website hero, Kevin Teague. More
documentation has been written since the sprint, and the [documentation
section](http://grok.zope.org/documentation) of our website is starting
to look quite nice.
