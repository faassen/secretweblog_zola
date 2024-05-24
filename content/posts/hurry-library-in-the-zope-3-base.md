+++
title = "hurry library in the Zope 3 base"
date = 2005-09-09
slug = "hurry-library-in-the-zope-3-base"

[taxonomies]
tags = ["zope"]
+++

Since various people were curious to see especially the little query
language we wrote on top of the Zope 3 catalog, I've just put up the
generic libraries we developed for documentlibrary project online, at
least in svn in the [Zope 3 base](http://codespeak.net/z3) at codespeak,
here:

<http://codespeak.net/svn/z3/hurry/trunk>

I've done this in the "tradition" of Zope corporation's placing of
zope.formlib and zc.catalog in the Zope svn repository. That is, we at
Infrae feel the libraries are useful and want to share them to obtain
feedback, but more communication and work is necessary before these
could be accepted into common codebases like the Zope 3 core or the
Z3ECM project. And if pieces don't end up there that's fine too; it
works just fine as an independent library right now.

The hurry library ("written because we were in a hurry to use these
features") contains:

hurry.query:

> higher level query system built on top of the Zope 3 catalog. Some
> inspiration came from Dieter Maurer's AdvancedQuery for Zope 2. See
> [src/hurry/query/query.txt](http://codespeak.net/svn/z3/hurry/trunk/src/hurry/query/query.txt)
> for documentation. Is undoubtedly still much less powerful than
> Dieter's system for Zope 2, and isn't very optimized, but does make
> using the catalog quite a bit more pleasant.

hurry.workflow:

> a simple but quite nifty workflow system. See
> [src/hurry/workflow/workflow.txt](http://codespeak.net/svn/z3/hurry/trunk/src/hurry/workflow/workflow.txt)
> for documentation.

hurry.file

> advanced file widget which tries its best to behave like other
> widgets. See the doctest in
> [src/hurry/file/browser/file.txt](http://codespeak.net/svn/z3/hurry/trunk/src/hurry/file/browser/file.txt)
> for some documentation.

On the workflow system I need to make an extra comment. We are aware
various powerful workflow systems are under development for Zope 3. At
the time we started the documentlibrary project however none of them
seemed fully baked. After some communication with some of the people
working on the workflow systems and realizing none appeared ready, we
decided to quickly roll our own.

I like its simplicity and it supports quite powerful features, such as
multi-version workflow. It's entirely geared towards the featureset of
the documentlibrary application we're working on but is generic enough
to be also applicable in other contexts. It's however no match for the
systems that are currently being brewed up for Zope 3.

Have fun with hurry! Let's try to channel discussion on this through the
zope3-dev mailing list for the time being.
