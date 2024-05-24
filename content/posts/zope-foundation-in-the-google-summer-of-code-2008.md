+++
title = "Zope Foundation in the Google Summer of Code"
date = 2008-04-23
slug = "zope-foundation-in-the-google-summer-of-code-2008"

[taxonomies]
tags = ["zope foundation"]
+++

# Zope Foundation in the Google Summer of Code

The Zope Foundation is very happy to announce it has five projects
accepted by the Google Summer of Code. Thank you Google! In this
article, I will introduce the projects, students and mentors.

**Zope2 on Python2.5**

student: ranjith babu kannikara

mentor: Sidnei da Silva

This project is a followup of the Zope 3 on Python 2.5 project that was
successfully completed in last year's summer of code by another student
from the same school, Nikhil N. It's safe to say this project is
considered essential by everyone in our community.

Nikhil N already explored some of this porting project and Ranjith
communicated with him about it, so we're off to a good start. Sidnei,
the mentor, is very experienced in all things Zope and has been in our
community for many years. He is also a long-standing contributor to
Plone, the popular Zope-based CMS, and which should help make sure that
Plone works on the Python 2.5 version of Zope as well.

<http://code.google.com/soc/2008/zope/appinfo.html?csaid=3F42269E3CDF31BD>

**Improved replication for ZODB through ZEO Raid**

student: Dirceu Pereira Tiegs

mentor: Christian Theune

ZEO Raid is an approach to eliminating the single point of failure that
clustered ZODB projects traditionally have: the single ZEO server. ZEO
Raid introduces a redundant array of these servers. Doing this should
expand the scalability and robustness of Zope's powerful transactional
object database technology further.

I know Dirceu already as he has been active in the Grok community. He
wrote the great `megrok.form` library for Grok. Mentor Christian Theune
is the original developer of ZEO Raid. He has been a very active member
of the Zope community for many years, contributing to Zope 2, Zope 3,
Plone, the ZODB, the German Zope User Group DZUG, and helping to found
the Grok project, and much more.

<http://code.google.com/soc/2008/zope/appinfo.html?csaid=480505ACAC256B7D>

**Flint: a simple Grok-based CMS**

student: Luciano Ramalho

mentor: Leonardo Rochael Almeida

The [Flint project](http://code.google.com/p/flint-cms/) aims to create
a lightweight CMS based on the Grok web application framework. The idea
is also to learn from this project to feed features and documentation
back into Grok. I hope that besides an separately installable CMS, this
project will also result in the development of some CRUD UI layers that
can be easily be integrated into any Grok application.

Luciano is participating the second time as a student for the Zope
Foundation. I had the pleasure of mentoring him last year in another
Grok-related project. He continued to contribute to Grok after the
conclusion of the summer of code project, and I had the great fortune of
being able to meet him in person at the Neanderthal sprint at the
offices of GfU Cyrus AG in Cologne last fall. This year he will be
mentored by Leonardo Rochael Almeida, who is a contributor to Zope 2 and
Zope 3, and an active participant in the Grok community. They know each
other in person, so Leonardo can go over with a club to Luciano's house
to keep him in check.

<http://code.google.com/soc/2008/zope/appinfo.html?csaid=3B4AE1B198100838>

**OCQL a Query Language for ZODB (Phase 0)**

Student: Charith Lakshitha Paranaliyanage

Mentor: Ádám Gröszer

This ambitious project will aim to add an object query language to the
Zope object database. The ZODB is great as you can just store Python
objects. Relational databases are great as you can just query
everything. For the ZODB this is a bit more involved, and you're
required to set up an index. Adding an object query language to the ZODB
would help us get closer to the ease of querying a relational database
for a database of Python objects.

Charith responded well in the application phase and wrote a good
proposal. Zope 3 contributor and mentor Ádám was thorough in testing
this prospective student by asking him to write code. Ádám already
helped start a project to implement this earlier on and has looked up
relevant academic papers, so we're off to a good start here. As someone
with an occasional interest in such things I'm quite excited by this
project and look forward to following it.

<http://code.google.com/soc/2008/zope/appinfo.html?csaid=D03B177E4CFF8E51>

**Grok: Introspector**

Student: Uli Fouquet

Mentor: Martijn Faassen (me!)

The Grok introspector project was begun by Uli in last year's summer of
code, and since then we have gained experience and we have some new
ideas. There is more to do: the component architecture lets us
introspect all kinds of object associations that we don't display yet in
the UI. In addition, it'd be good if we displayed what Grok directives
were used in the introspector UI as well. We will develop a new package,
tentatively named `zope.introspector` that will provide a common
infrastructure for introspecor facilities. In this project we will work
together with Martin Lundwall, who is going to work on a related project
for the Plone Foundation, more about which I'll say below.

Student Uli contributed crucial introspector infrastructure to Grok in
last year's summer of code. I also had the pleasure of getting to know
Uli in person at a number of sprints and conferences last year. Last
year his mentor was Philipp von Weitershausen, but this year I'll have
the pleasure of mentoring him myself.

<http://code.google.com/soc/2008/zope/appinfo.html?csaid=67681C063AA1A4BF>

*Wait! Extra bonus projects!*

Our sister foundation the Plone Foundation also applied to the Google
Summer of Code, and some of the work done there will surely flow back
into Zope. Here is the list of their accepted five projects:

<http://code.google.com/soc/2008/plone/about.html>

I'd like to highlight two in particular:

**Component Registry Introspector**

Student: Martin Lundwall

Mentor: Lennart Regebro

Since there is a lot of commonality with the Grok inspector, during the
proposal period Martin and Uli already started talking about joining
forces. They will work together on `zope.introspector`, where Martin
will focus on Plone integration and Uli will focus on Grok integration.
Mentor Lennart Regebro is also a long-standing contributor in the Zope
community. He's someone I've worked with in the past, and I'm very happy
I'll be able to do so again for this project.

<http://code.google.com/soc/2008/plone/appinfo.html?csaid=9772C1C3ABD45432>

**Buildout Builder - An automated buildout configuration system**

Student: Kenneth Miller

Mentor: Raphael Ritz

This is another project to watch: a system to help buildout
configurations is of benefit to all of us that use buildout, and
moreover, a more personal interest: this system will be developed using
Grok!

<http://code.google.com/soc/2008/plone/appinfo.html?csaid=69983137B55A28A5>

*Another bonus project!*

That doesn't conclude the bonus projects. There's another project, this
time one hosted by the Python Software Foundation, that is of great
relevance to Zope:

**Improvement of Zope support on Jython**

Student: Georgy Berdyshev

Mentor: Frank Joseph Wierzbicki

Zope Foundation backup mentor: Sidnei da Silva

The immediate goal is to port essential core Zope libraries to the
Jython platform, with an eye on making something like Zope 3 and Grok
run in Jython. Adjustements to the Zope libraries will be fed back to
Zope; some C extensions will be rewritten in Python where this hasn't
happened already.

Jython will gain a bunch of powerful libraries, and a lot of feedback on
what is involved in porting a complicated Python framework to Jython.

For the Zope side, the hope is that in future you'd be able to deploy,
say, your Grok application, on the Jython platform. This means we'd also
have full access to the many java libraries. Another side effect is that
this project would make it easier to port these libraries to *other*
Python interpreter platforms as well. I wrote more about this
[here](http://faassen.n--tree.net/blog/view/weblog/2008/04/14/0).

Mentor Frank Wierzbicki is project lead of the Jython project, recently
hired by Sun to work full time on Jython. He is the best mentor we could
possibly ask for this project.

It's safe to say the Zope community needs to back this up. Sidnei
offered to be backup mentor for this project. Since he's already
mentoring the Python 2.5 porting project, he is in a great position to
offer useful insights in the Jython porting project as well. Sidnei's
also well connected in the Zope community and knows the people to ask
for help when needed. So Zope community members, if he, Frank or Georgy
asks for your help, please help!

<http://code.google.com/soc/2008/psf/appinfo.html?csaid=59C7870763174C10>
