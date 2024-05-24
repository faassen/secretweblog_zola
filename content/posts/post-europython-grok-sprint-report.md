+++
title = "Post-EuroPython Grok sprint report"
date = 2008-07-14
slug = "post-europython-grok-sprint-report"

[taxonomies]
tags = ["sprint", "grok", "silva"]
+++

# Post-EuroPython Grok sprint report

This is a report on the [Grok](http://grok.zope.org) sprint that
followed EuroPython. Thanks to the EuroPython organizers for giving us
the space!

At EuroPython I was thrilled to meet Laurence Rowe. Laurence is the
author of zope.sqlalchemy, the low-level integration layer between Zope
3 (and therefore Grok) and SQLAlchemy's transaction machinery. Also
thanks to a lot of communication with Laurence in the last few months, I
was inspired to write z3c.saconfig on top of this, which integrates
SQLAlchemy's configuration system with the Zope 3 component architecture
in what I think is a nice way.

This in turn is all resulted in massive improvements in megrok.rdb
recently. megrok.rdb is the SQLAlchemy integration layer for Grok.
megrko.rdb tries to make integration with SQLAlchemy to feel "Grok-like"
(grokonic?) and as smooth as Grok's integration with the ZODB. At the
sprint, Laurence and I talked a lot and we sat together to improve
megrok.rdb so it can support database generated primary integer keys as
container keys in relation containers.

Besides this, I also worked a bit on megrok.rdb's support for converting
SQLAlchemy database schemas to Zope 3 schemas, so that nice forms can be
generated automatically. I added some doctests for this, but it still
needs a lot of polishing.

Jasper Op de Coul and I worked on a package called megrok.rdf. Jasper is
very familiar with RDF, so his experience there was invalabule. The
megrok.rdf package uses the approach from megrok.rdb to expose RDF
content as a first-class citizen in Grok. It was surprising and
satisfying to see how well the approach fits RDF-based data as well. The
megrok.rdf package will make it to svn.zope.org soon. If we can form a
group of interested contributors around this package Grok can grow a
powerful way to build web applications on top of an RDF triple store. If
you're interested, please join us at
[grok-dev](http://grok.zope.org/community/grok-dev-mailinglist)!

Kit Blake worked on an mockup of the "local utilities configuration"
screen for the Grok UI. It's very common that applications expose things
to be configured (think relational database connection settings,
catalogs, email configuration, user authentication, etc). It would be
nice if the Grok UI had a screen that allowed per-application
configuration that applications can plug in to. Kit has a lot of
experience with configuration issues in a Zope 2 context (Silva in
particular), so he had some good ideas on how to go ahead.

Sylvain Viollon and Eric Casteleijn worked on applying Grok technology
(in particular grokcore.component and Martian) to Silva in a Zope 2
context. They worked on a lot of Silva-specific grokkers to make it
easier to write Silva content objects and configure Silva in general.
It's exciting to see that the Zope 2 community is now starting to use
Grok technology more and more. This thursday and friday Godefroid
Chapelle is hosting a two-day sprint to work on Grok in a wider Zope 2
context.

I also had some discussions with other people who were trying to learn
Grok technologies (grokcore.component and Martian), also to see how to
apply it to their own Python projects. Ignas Mikalajunas suggested it
would be good to see a PyGTK-based example that used Martian, which is
an interesting idea I hope someone will explore. I also talked with
Christian Scholz about integration of grokcore.component with a non-web
application package that was already using zope.component for
configuration.

Thanks to all the sprinters for the work and feedback! As a
post-conference sprint it tends to be less focused than a dedicated Grok
sprint, but I still feel we made a lot of progress.

It wasn't all work, we also had fun and games. It was a very warm couple
of days in Vilnius, Lithuania. I enjoyed the various dinners I had with
people. I also enjoyed playing
[Galcon](http://www.imitationpickles.org/galcon/) with a bunch of the
sprinters at the end of the day on saturday. ME GROK CONQUER GALAXY
