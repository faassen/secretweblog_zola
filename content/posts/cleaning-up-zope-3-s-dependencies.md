+++
title = "Cleaning up Zope 3's dependencies"
date = 2009-01-29
slug = "cleaning-up-zope-3-s-dependencies"

[taxonomies]
tags = ["zope", "django"]
+++

# Cleaning up Zope 3's dependencies

This week a bunch of us (myself, Christian Theune, Wolfgang Schnerring,
Brandon Rhodes, Jan-Wijbrand Kolman and Sylvain Viollon) have been
sprinting in my house at the "Grok Cave sprint". We've been working on
cleaning up Zope 3's dependency structure, which in places is very
hairy. This meant that you could often pull in one fairly innocent
looking Zope 3 package and as a result pull in almost all of them. This
makes it difficult to reuse packages and upgrade code. Loosely coupled
code and all that.

See also [Mark Ramm's talk at the Django
Conference](http://compoundthinking.com/blog/index.php/2008/09/17/djangocon-and-learning-from-zope-2/)
about why having a sane physical dependency structure between packages
is a good thing.

One major part of this dependency reduction project has involved
extracting a new package `zope.container` out of `zope.app.container` .
Another part involved reversing the dependency relationship between
`zope.traversing` and `zope.location` \[UPDATE: I mistyped
`zope.security` instead of `zope.traversing` here previously\]. We've
also started extracting `zope.site` from `zope.app.component` and moved
some code from `zope.app.security` and `zope.app.component` into
`zope.security`. In addition we created two new tools
(<span class="title-ref">z3c.recipe.compattest</span> and an addition to
the Zope test runner) to help us keep track of things. We've also made a
lot of use of an existing tool to track dependencies between packages
called `tl.eggdeps`.

That's all gobbledygook to most people. So here are the *before* and the
*after* pictures (of the `zope.container` and
`zope.location`/`zope.traversing` work in particular).

Here is the **before**, the dependency graph of `zope.app.container`
(with core packages `zope.interface` and `setuptools` excluded as they
don't depend on anything and clutter up the graph):

![image](http://startifact.com/cavesprint2009/zope.app.container-before.png)

And here is the **after**, `zope.container`, which can be used instead
of `zope.app.container` almost everywhere (and `zope.app.container` in
fact uses it too), again with `zope.interface` and `setuptools` not
shown:

![image](http://startifact.com/cavesprint2009/zope.container-after.png)

We believe this is significant progress! It's still a lot of packages of
course, but we can at least motivate the existence of a dependency
relationship on them in most cases.

All this work is far from done. It's been a lot of work to get this far.
There are still many dependencies more to clean up. It will take more
work after the sprint to get to a good dependency structure for the
complete set of Zope 3 libraries. We're starting to see some light at
the end of the tunnel now though.
