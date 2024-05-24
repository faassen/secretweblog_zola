+++
title = "extended catalog queries in Zope 3"
date = 2005-07-13
slug = "extended-catalog-queries-in-zope-3"

[taxonomies]
tags = ["zope"]
+++

Yesterday I managed to build something in just a few hours in Zope 3
that I wouldn't have been able to build so easily in Zope 2. What I've
built is an extended query system for the Zope 3 catalogs.

A sample query looks like this:

    q = zapi.getUtility(interfaces.IExtendedQuery)

    t1 = ('catalog', 'fulltext')
    a1 = ('catalog', 'a1')

    r = q.searchResults(And(Text(t1, 'foo'), InSet(a1, [1, 2]))

which, providing the given catalog indexes exist, returns all objects
that have attribute a1 set to either 1 or 2, and have 'foo' in their
fulltext. All kinds of nice operators exist, such as Equals, NotEquals,
InRange and InSet, and you can combine them nicely using And and Or. It
also ought to work over multiple catalogs.

It's not the most efficient implementation, but performance should be
decent enough, and all this just took a few hours to put together and is
a few pages of code. In Zope 2 this would've caused me intense
headscratching and I'd certainly not be done yet.

Why was this so easy in Zope 3? I think there are two reasons:

- clean implementation of the catalog makes its code fairly easy to read
  and thus write similar code. The catalog implementation in Zope 2 is a
  horror to try understanding, in Zope 3 it really is surprisingly easy.
  This pattern holds for much of the Zope 3 code base.
- Zope 3 gives every object an integer id using the IntIds utility,
  which helps making the catalog so clean. IntIds rock!

The code is hidden in a customer project right now. It's easy to extract
and I'll look into extracting this so other people can take a look at
this in the coming weeks.
