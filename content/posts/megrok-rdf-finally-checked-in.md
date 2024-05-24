+++
title = "megrok.rdf finally checked in"
date = 2008-08-01
slug = "megrok-rdf-finally-checked-in"

[taxonomies]
tags = ["grok"]
+++

Jasper Op de Coul and I worked on megrok.rdf during the post-europython
[Grok](http://grok.zope.org) sprint a few weeks ago. We had a few
logistical problems concerning access to svn.zope.org, but yesterday
Jasper finally managed to check in megrok.rdf:

<http://svn.zope.org/megrok.rdf/trunk/>

megrok.rdf is far from finished, and should be classified as a
prototype. It has me excited for two reasons:

- if people were to hack on this I think Grok could quickly grow
  first-class RDF support without tremendous effort. What megrok.rdf can
  do for you is represent RDF subjects as models. These can then get
  views and adapters and such. RDF predicates can show up as object
  relations. These relations can be made to be traversable using
  grok.traversable().
- the way megrok.rdf works is quite similar to megrok.rdb, Grok's
  SQLAlchemy integration. This is not a surprise, as megrok.rdf's design
  is heavily influenced by my experiences with megrok.rdb. It still
  helps validate to me that Grok's way of exposing models makes a lot
  sense and is flexible. Grok has ZODB-backed Models and Containers, but
  it also has RDB backed Models and Containers and now, at least
  experimentally, RDF backed versions of the same.

A lot of work remains to be done. One thing we should do is to actually
start documentation/doctests to solidify the approach. The way an RDF
database is accessed (and integrated with Zope's transaction machinery)
also needs attention.

I hope we can get some help from people interested in RDF. If people are
interested, please join us at
[grok-dev](http://mail.zope.org/mailman/listinfo/grok-dev).
