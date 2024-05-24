+++
title = "Grokkerdam sprint topics"
date = 2008-04-11
slug = "grokkerdam-sprint-topics"

[taxonomies]
tags = ["grok", "sprint"]
+++

# Grokkerdam sprint topics

The [Grokkerdam](http://wiki.zope.org/grok/GrokkerdamSprint) sprint is
coming up in a few weeks. I've put some topics people may want to work
on during the sprint on the wiki page. Since those topics are just
one-liners, I figured I might expand a bit on them here. The sprinters
are not required to pick these tasks of course, and can choose something
else entirely. If you have ideas, pleases expand the list of tasks!

This blog post will discuss some of the sprint topics. I hope to write
another blog entry soon that discusses the rest.

## Martian directives improvements (and introspector UI improvements)

When refactoring Grokkers during the Snow Sprint, I noticed some
patterns in the ways various Grok class directives are used. A common
pattern in particular is falling back on a default. Let's for example
look at the following code:

    class MyView(grok.View):
       grok.require('zope.Public')

This code is equivalent to this, as `zope.Public` is the default:

    class MyView(grok.view):
       pass

Currently the grokkers that register this code handle this with code
like this:

    permission = class_annotation(view, 'grok.require', 'zope.Public')

The knowledge of how the default behavior works for directives is
encapsulated in the grokkers, not in the directives. The new directive
implementation instead allows you to do this to get at the right
permission:

    require_directive.get(view)

The `require_directive` has been set up so that it knows what the
default is should the `view` have no explicit definition of default. In
real-world code things will get more complicated -defaults might not be
static but calculated, and dependent on which kind of class the
directive is used on. I believe we can still encapsulate this in the new
directive implementation. I expect the following advantages:

- the implementation of grokkers becomes shorter.
- grokkers will be easier to understand.
- grokkers will be easier to write.
- We will notice inconsistencies in the use of directives sooner. An
  inconsistency for instance is the use of `grok.name()`; it defaults to
  the class name for views, but for utilities it defaults to the empty
  string. This is likely an inconsistency we want to retain, but at
  least we'll not do this by accident so easily.
- we build important infrastructure for introspection. We want the
  introspector UI to tell the user which directives were used on a
  class, and also which defaults were assumed. The new directives should
  encapsulate this information so that the introspector UI can make use
  of this.

On the train trip back from the Snow Sprint I started sketching out the
implementation of such declarative directives in Martian, for now in a
new, unused, module called `ndir.py` and doctest called `ndir.txt`. See
the code [here](http://svn.zope.org/martian/trunk/src/martian/).

At the sprint, if anyone is interested, we can hopefully push this
implementation forward to a point where we can start using it in Grok.
We can then also look into how we can use this code in the introspector
UI.

## Relational database integration

I already wrote much about this [earlier this
week](http://faassen.n--tree.net/blog/view/weblog/2008/04/08/0). I think
making relational database integration a first class citizen is a really
important topic for Grok.

## Improving KSS integration

[KSS](http://kssproject.org/) is a declarative framework for doing AJAX
style UIs. With KSS there is no need to write Javascript unless you want
to expand it with new plugins. KSS aims to make it very easy to write
dynamic web applications. KSS, while independent from Zope, does come
from nearby in our community - it originated in the Zope community, and
some of the KSS core hackers are involved in Grok.

We built an rough integration of KSS into Grok at the Neanderthal sprint
last october, and at the Snow Sprint this was improved somewhat. Now it
will be time to polish this integration, making it work as easily as
possible out of the box, so that people can run with it.

The aim here is that someone can sit down and read a simple tutorial and
has their Grok application working with KSS within 10 minutes.

## Improving WSGI integration

Grok has been speaking WSGI since last year now, but we want to make
this integration there by default. We need to investigate how to easily
enable WSGI middleware with Grok, and how we are going to change the
default Grok deployment to make use of the WSGI infrastructure. We also
should investigate some useful middleware components we may want to ship
with Grok by default.

The aim is again polishing: we have the code, but it's only halfway done
if someone cannot sit down and use it within a reasonable amount of
time.

## Menu infrastructure

One feature that Grok doesn't support easily yet is the dynamic
generation of 'menus'. If I have an object that I want to show up in my
navigation menu, I should be able to do so in a straightforward fashion.
If I have different add views in my application that each create a type
of object, I want to be able to generate a drop-down list of all add
views available. As with everything in Zope 3 and Grok, it needs to be
extensible: I should be able to write an extension to a core application
that also adds its own entries to the menus defined in the core.

This is a design task first: identify the use cases and then think about
some patterns in code that would fulfill them.

After that, set out to implement this. It may be that the viewlets
support (in Grok trunk) will be helpful here as a foundation.
