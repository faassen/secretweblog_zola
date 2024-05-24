+++
title = "Reg: Component Architecture Reimagined"
date = 2013-09-19
slug = "reg-component-architecture-reimagined"

[taxonomies]
tags = ["planetpython", "python", "zope", "plone", "morepath", "reg"]
+++

Reg is a new Python library for registering and looking up objects. It
provides clever registries to let you build extensible applications,
libraries and frameworks.

Why should you want to use Reg at all? The best way to find out is to
read the [Reg docs](https://reg.readthedocs.org/en/latest/).

The documentation is a work in progress, and especially API
documentation is still lacking (read the `interfaces.py` module in the
source). It should however give you a good overview of the basic usage
of Reg.

The Reg code is here on github:

<https://github.com/morepath/reg>

The project is currently in pre-alpha, with no release yet. The
documented behavior is however expected to be stable.

Let me know what you think!

# Background

Reg is heavily inspired by the Zope Component Architecture (ZCA) as
implemented in `zope.interface` and `zope.component`, though shares no
code in common with Reg, and no knowledge of the ZCA is needed in order
to use Reg. The ZCA is a venerable implementation, going back more than
a decade. Use cases for the ZCA have evolved, some added, some dropped
away, and we have a lot more experience. Learning from this, Reg
provides many of the same features but with a lean, modern API and
implementation.

I must mention Chris McDonough, creator of the Pyramid web framework in
this - he's been leading by example reimplementing (*reimagining*) Zope
concepts in a leaner, clearer, better way for years now. I was
originally skeptical of this approach, but history has proved him right.
Kudos, Chris! I've learned a lot from you.

I've been working on Reg for some years now, on and off, in different
incarnations. Some Plone developers might remember my `Crom` lightning
talk back at the Plone Conference 2012 in Arnhem - Reg is a further
evolution of this. See the history section of the documentation for more
information.

# Road to Morepath

Reg is foundational to Morepath, the up and coming Python micro web
framework with super powers. Stay tuned!
