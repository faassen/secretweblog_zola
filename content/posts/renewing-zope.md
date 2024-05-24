+++
title = "Renewing Zope"
date = 2013-10-24
slug = "renewing-zope"

[taxonomies]
tags = ["python", "zope", "planetpython", "plone"]
+++

# Introduction

The Zope community in late 2001 had been around for a few years already,
almost an eternity in web time back then. Still, we weren't afraid to do
bold new things. Perhaps too bold, as we'll see.

# Zope Rewrite

We were learning new, better ways to do web development. Led by Jim
Fulton, lead architect of Zope, we set out to rewrite Zope, fix
mistakes, explore new innovations, make Zope cleaner, easier, and more
powerful. I say *we* now, as by that time I and many others were fully
engaged in this project to build its next generation.

One way that this engagement was fostered was by sprints. The Zope
community pioneered the sprints now widely adopted in the Python
community; we would gather together in real life to work on the new
Zope. At such a sprint you would often find yourself working with Jim
Fulton himself, so they were quite the draw.

In the new Zope, we would have more powerful and more clean
extensibility and reuse mechanisms. Zope components would be developed
as normal Python packages. We would do away with the weird magic of
acquisition. We would make the glueing together of components into
applications an explicit, coherent notion instead of a collection of
ad-hoc APIs.

Central to this was the Zope Component Architecture, which introduced
the notion of an explicit interface, along with a way to register and
look up components that would enrich models (we called them *views* and
*adapters*). It could also fulfill the role of a service locator, and
provided the basis for an event system.

Besides sprint-driven development we were also early adopters of
strongly test-driven development.

This exciting renewal of Zope was done as a complete rewrite. That's
scary; rewrites have a habit of never being completed, and you risk the
[second system
effect](https://en.wikipedia.org/wiki/Second-system_effect). But in many
ways we succeeded -- we had a capable, very powerful and much cleaner
web framework in the new Zope. (There were flaws, as it was not
*easier*, just difficult in new ways, but I'll go into that later.)

So we had an exciting new Zope. We had a practical problem, however.
Almost all of the *real* work done with Zope was done with the old Zope.
This new, better Zope was held up as the future, but was tantalizingly
out of reach for those of us with large codebases built on top of the
old Zope.

# Five: Redefining Zope

I've written a lot of code over the years, some of it generally useful,
most of it not. But I believe some of my biggest contributions to Zope
were not in the form of code, but projects that helped *redefine* what
Zope was all about, giving people new ways to use it, and giving the
project new directions.

The first such redefinition I attempted was Five, a name I came up with
by adding together the version numbers of the old Zope (2) and the new
(3). It was cute, and stuck in people's mind, and such things can
matter.

The new Zope was out of reach to users of the old Zope. The community
had been led to believe that the new Zope would be the *next* Zope. We
thought that at some point in the nebulous future there would be a
transition to the next system, some form of compatibility, some way to
transfer code from the old to the new system. How this would work was
left unspecified.

I grew doubtful about whether it would work at all. It was in the future
and seemed to stay there. And I wanted to use the new stuff.

So in 2004 I took a different approach. I worked out a way to add the
code of the new Zope to the old, using the new Zope as a library,
extending the old Zope: Five. Through Five, the new ways of developing
became available in the old system. We could use the new Zope, right
then and there, in the context of the old Zope. We could use the better
ways of doing things without giving up our existing codebases.

By 2006 the Five technology was merged into the core of the old Zope:
Five became an integral part of it. Finally in 2009 we fixed the
confusing, now deceitful naming, which was still suggesting after all
these years that Zope 3, the new Zope, was the next Zope, which it was
not. We let the new Zope evaporate into a puff of libraries. The next
Zope was no more; there was just Zope. Its code lives on, in the old
Zope, and various successor frameworks.

# The Wisdom of Hindsight

Was the Five solution ideal? It was not. It made the old Zope more
complex. While code written in the new way was more clean and
maintainable, we didn't gain all of the cleanliness, because the old
stuff was still there. The transition from old to new ways of doing
things would be a very long one. The Plone developers, for instance,
adopted the new ways many years ago, but are only now finally able to
remove some of the old ways from the next version of their CMS.

Should we have done things differently? In retrospect, we should perhaps
not have created the new Zope at all. Instead we could have embarked on
a project to renew the old Zope from within, directly. That would have
been very difficult as well, though. We might have missed out on
something too. A clean slate, after all, lets you take a step back from
what you're doing, and helps you think things through more clearly. We
benefited from that as well.

The new Zope project was flawed, and the approach to merge it into the
old Zope generated difficulty as well as opportunity. But through these
projects Zope did continue to evolve, renew itself, and stay relevant.

This blog entry is a part of a [series on
Zope](http://blog.startifact.com/posts/my-exit-from-zope.html) and my
involvement with it.
[Previous](http://blog.startifact.com/posts/object-publishing.html).
[Next](http://blog.startifact.com/posts/jim-fulton-zope-architect.html).
