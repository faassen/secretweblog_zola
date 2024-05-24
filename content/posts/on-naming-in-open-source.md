+++
title = "On Naming In Open Source"
date = 2014-07-29
slug = "on-naming-in-open-source"

[taxonomies]
tags = ["planetpython", "python", "zope", "naming", "open source"]
+++

Here are some stories on how you can go wrong with naming, especially in
open source software.

# Easy

Don't use the name "easy" or "simple" in your software as it won't be
and people will make fun of it.

## Background

People tend to want to use the word 'easy' or 'simple' when things
really are not, to describe a facade. They want to paper over immense
complexity. Inevitably the facade will be a leaky abstraction, and
developers using the software are exposed to it. And now you named it
'easy', when it's anything but not. Just don't give in to the temptation
in the first place, and people won't make fun of it.

## Examples

`easy_install` is a Python tool to easily and automatically install
Python packages, similar to JavaScript npm or Ruby gems. `pip` is a more
popular tool these days that does the same. `easy_install` hides, among
many other complicated things, a full-fledged web scraper that follows
links onto arbitrary websites to find packages. It's "easy" until it
fails, and it *will* fail at one point or another.

`SimpleItem` is an infamous base class in Zope 2 that pulls in just
about every aspect of Zope 2 as mixin classes. It's supposed to make it
easy to create a new content type for Zope. The amount of methods made
available is truly intimidating and anything but simple.

# Demo

Don't use the word "demo" or "sample" in your main codebase or people
will depend on it and you will be stuck with it forever.

## Background

It's tempting in some library or framework consisting of many parts to
want to expose an integrated set of pieces, just as an example, within
that codebase itself. *Real* use of it will of course have the
developers integrating those pieces themselves. Except they won't, and
now you have people using `Sample` stuff in real world code.

The word `Sample` or `Demo` is fine if the entire codebase is a demo,
but it's *not* fine as part of a larger codebase.

## Examples

`SampleContainer` was a part of Zope 3 that serves as the base class of
most *actual* container subclasses in real world code. It was just
supposed to demonstrate how to do the integration.

# Rewrite

Don't reuse the name of software for an incompatible rewrite, unless you
want people to be confused about it.

## Background

Your software has a big installed base. But it's not perfect. You decide
to create a new, incompatible version, without a clear upgrade path.
Perhaps you handwave the upgrade path "until later", but that then never
happens.

Just name the new version something else. Because the clear upgrade path
may never materialize, and people *will* be confused anyway. They will
find documentation and examples for the old system if they search for
the new one, and vice versa. Spare your user base that confusion.

The temptation to do this is great; you want to benefit from popularity
of the name of the old system and this way attract users to the shiny
new system. But that's exactly the situation where doing this is most
confusing.

## Examples

Zope 3: there was already a very popular Zope 2 around, and then we
decide to completely rewrite it and named it "Zope 3". Some kind of
upgrade path was promised but conveniently handwaved. Immense confusion
arose. We then landed pieces of Zope 3 in the old Zope 2 codebase, and
it took years to resolve all the confusion.

# Company name

If you want a open source community, don't name the software after your
company, or your company after the software.

## Background

If you have a piece of open source software and you *want* an open
source community of developers for it, then don't name it after your
company. You may love your company, but outside developers get a clear
indication that "the Acme Platform" is something that is developed by
Acme. They know that as outside developers, they will *never* gain as
much influence on the development of that software as developers working
at Acme. So they just don't contribute. They go to other open source
software that isn't so clearly allied to a single business and
contribute there. And you are left to wonder why developers are not
attracted to work on your software.

Similarly, you may have great success with an open source project and
now want to name your own company after it. That sends a powerful signal
of ownership to other stakeholders, and may deter them from
contributing.

Of course naming is only a part of what makes an open source project
look like something a developer can safely contribute to. But if you get
the naming bit wrong, it's hard to get the rest right.

Add the potential entanglement into trademark politics on top of it, and
just decide not to do it.

## Examples

Examples omitted so I won't get into trouble with anyone.
