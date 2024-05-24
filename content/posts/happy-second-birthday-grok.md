+++
title = "Happy Second Birthday Grok!"
date = 2008-10-17
slug = "happy-second-birthday-grok"

[taxonomies]
tags = ["grok", "silva"]
+++

Grok the codebase is 2 years old this week. Two years ago we had the
first Grok sprint in Halle, Germany, at the Gocept offices. A lot has
happened since then. For me personally Grok is my development workhorse
now and has been since early 2007. It's something I use during
development every day.

Let's review some of the highlights of whave happened since [last year's
birthday](http://faassen.n--tree.net/blog/view/weblog/2007/10/15/0).

- Grok has a Plone-based website. This site hopefully looks welcoming to
  new users and thanks to the CMS backing it, it allows people to
  contribute documentation for Grok easily.
- In addition to the Plone-driven website, Grok has a sphinx driven
  documentation website. This allows the developers to maintain
  important pieces of documentation in subversion, along with the
  codebase.
- Grok now officially works with Python 2.5.
- Grok's technology became usable in non-Grok Zope 3 applications and in
  Zope 2 as well, as we split off important functionality into reusable
  libraries.
- Some feature highlights since the last year are viewlet support and
  ZCML auto-inclusion, as well as eggbasket support for grokproject.

What's currently in the works?

- From what I've seen, Grok's going to really improve the development
  experience in the next feature release of the
  [Silva](https://infrae.com/products/silva.html) CMS. A lot of the drive to
  port Grok technology to Zope 2 has also come from members of the
  [Plone](https://plone.org/) community, so I have good hopes that Plone will
  benefit from Grok technology as well. I know there is currently a lot of pain
  felt by Plone developers - too many ways to do things, and too many files to
  edit. I hope Grok technology can be useful to make their lives easier.
- WSGI out-of-the-box support is _still_ in the works, but should be
  released very soon now. People have been using Grok with WSGI for a
  long time now, but we still need to ship with a story that works
  straight away.
- People have been working on improving integration between Grok and the
  powerful `z3c.form` form generation and handling library.
- We've worked a lot on Grok's integration with SQLAlchemy in the form
  of `megrok.rdb`. An initial release of this package should be around
  the corner.
- We've been reviewing how Grok's view story works in connection with
  inheritance, and we have hopes to improve this.
- We've been working on improving Grok's support for the inclusion of
  static resources.

I think we should be heading towards a Grok 1.0 release within the next
couple of months. Meanwhile, we're already thinking about larger changes
that can go into Grok afterwards. I think there are quite a few exciting
technologies that should be included in Grok out of the box, and also a
lot of opportunities for engineering Grok's underlying technology to be
even better.
