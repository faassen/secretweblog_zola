+++
title = "Clarity, ClearSilver integration for Zope 3"
date = 2005-04-15
slug = "clarity-clearsilver-integration-for-zope-3"

[taxonomies]
tags = ["zope", "templating"]
+++

# Clarity, ClearSilver integration for Zope 3

I've just checked in a new package into the Zope 3 base subversion
repository called Clarity. What it does is integrate ClearSilver
templating into Zope 3 (trunk, though I expect Zope X3.0 or even Five
support should be easy enough). It's all still rough, but initial tests
show ClearSilver templates can be quite a bit faster than ZPT, and they
have other possible benefits. In my simplistic experiments I got
transaction rates about 2 to 5 times higher than you can reach with ZPT,
testing this with the 'siege' utility.

Here's an extract from the README that describes the motivation for this
experiment.

## Why?

Zope 3 already has page template and even DTML, why would I want to use
this? Some possible benefits ClearSilver brings are:

- Absolute separation of logic from template. You cannot do complicated
  logic in a ClearSilver template, you can only extract data. You cannot
  call into the Zope 3 API *at all*.
- Increased debuggability. Calling APIs is impossible from the template,
  which means that most bugs the API should appear in Python code
  already, where the programmer can worry about them, not the person who
  is tweaking the templates. While you are building a template you will
  *never* be bothered by, say, ComponentLookupErrors.
- Increased testability. Since you know what HDF structure you expect to
  get in advance, you can test this using a normal unit test from Python
  code. Your template can stay simple.
- Performance. Admittedly simplistic testing with 'siege' shows that for
  larger templates, ClearSilver templates integrated into Zope run
  several times faster than the equivalent ZPT page.

However, since no significant codebases exist that use this facility,
these benefits are somewhat speculative.

## More info and download

More about ClearSilver here:

<http://www.clearsilver.net>

A comparison with other templating system and a motivation for its
design, which they call *dataset driven templates*, can be found here.

Among other systems which use ClearSilver templates is Trac, the
Python-based software project management tool:

<http://projects.edgewall.com/trac/>

You can check out Clarity from the Zope 3 base, here:

<http://codespeak.net/svn/z3/clarity/trunk/>
