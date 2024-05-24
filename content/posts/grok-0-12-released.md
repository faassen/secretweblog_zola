+++
title = "Grok 0.12 released!"
date = 2008-04-25
slug = "grok-0-12-released"

[taxonomies]
tags = ["grok", "release"]
+++

# Grok 0.12 released!

It happened a few days already, but I hadn't mentioned it here yet:
[Grok 0.12](http://grok.zope.org/project/releases/0.12/) has been
released! Thanks go to Jan-Wijbrand Kolman for again playing the role of
release manager, and to all contributors that made this release
possible!

Grok 0.12 is a release that brings two new features:

- z3c.autoinclude. At the snow sprint last january I worked with Ethan
  Jucovy and Robert Marianski on this library, which Grok now uses by
  default. It implements another DRY (don't repeat yourself) feature for
  Grok: it takes away the need to manually include the ZCML of a package
  if you use it in `setup.py`. I was really fortunate to meet Ethan and
  Robert at the snow sprint, as they're great guys and they both became
  contributors to Grok afterward! Ethan has been very supportive in
  making sure z3c.autoinclude works well afterwards, and has expanded
  its feature set in response to a feature request from Martin Aspeli
  (with an eye on Plone).
- viewlet support. Viewlets are a powerful construct from Zope 3 to
  flexibly configure and plug in "parts of pages". With Grok we've made
  it about as easy to create a viewlet as it is to create a view.
  Unfortunately we're still working on documentation for them, but this
  should be fixed soon. The feature was originally integrated into Grok
  by Kevin Smith. I had the pleasure of working on finalizing this
  feature with Tim Terlegård and Robert Marianski at the snow sprint.
  Tim was the one who pushed to get this one done and I'm very glad he
  did so. After the sprint various community members helped to test this
  and polish this up, so it should be in good shape.

It also has a host of bug fixes. We are now ready to start evolving Grok
further. At the PyCon Grok sprint, Robert Marianski and Brandon Craig
Rhodes worked on separating out some of Grok's core component
architecture configuration bits out of Grok into its own independently
reusable library: grokcore.component. Philipp von Weitershausen and
Brandon will be merging the branch that uses this library into the Grok
core soon.

Grok's evolution is quite interesting. While the way Grok works on the
surface hasn't changed all that much since the fateful first Grok sprint
back in 2006, Grok has undergone quite an evolution underneath. During
the first Grok sprint, we set out to just make Grok as we envisioned it
work. We wrote nice clean but somewhat ad-hoc code. After the sprint, I
noticed some patterns in this code and abstracted out the concept of
"grokkers". Grokkers allow Grok's behavior to be extended: you can
register new grokkers to handle extension or application-specific
registration for new base classes.

About a year ago, I refactored the way grokkers work into its own Python
library, [Martian](http://pypi.python.org/pypi/martian), and made Grok
work with this library. Martian offers a way to avoid meta-classes while
still having automatic registration of classes. This is possible as Grok
(and Zope 3) have an explicit, separate configuration phase:
configuration is done separately from import time.

Meta-classes are a powerful tool, but can lead to complexity during
initialization and surprises for developers who may get unexpected
behavior from seem to be normal Python classes. Django uses them for
registration, and sometimes a developer has to resort to
[self-admitted](http://simonwillison.net/2008/Apr/12/django/) [scary
solutions](http://www.djangosnippets.org/snippets/703/). I recall having
to resort to some magic code from PEAK to do something similarly scary
when I was struggling with a problem in Five some years ago (Zope 2/Zope
3 integration layer, where Zope 2's acquisition metaclass was making
trouble). Grok, with Martian, sidesteps the need for meta-classes to do
configuration. The only meta-class in Grok code is the venerable and
quite well-behaved `Persistent` (when you use the ZODB).

Grok's evolution continued. At the Neanderthal sprint last october,
Godefroid Chapelle initiated a refactoring of Grok's standard grokkers
to use Zope 3 configuration actions. The benefit of these is that
conflicting registrations (two views with the same name for the same
object, say) are detected, and this greatly enhanced compatibility of
Grok-based code with Zope 3 based code as well. The action support was
something we had been planning from the start but never finalized. After
the sprint Philipp von Weitershausen picked up on this work and pushed
it a lot further, completing it.

So now we see the step of taking some of the reusable component
registrations for basic `zope.component` features such as adapters into
a reusable library as well, `grokcore.component`. The next release of
Grok will make use of this library. The library also make it possible to
write Zope 3 libraries that use `grokcore.component` as a configuration
mechanism, and can be dropped into straight Zope 3 applications (the
reverse was already possible from the start). That should largely
conclude Grok's development of full Zope 3 compatibility.

While all this was being done, Grok applications continued to work with
only minor adjustments required. I really like how this worked out for
Grok so far. We really are creating abstractions and reusable libraries
the way it's supposed to be done: by doing it step-by-step and learning
from code that already works.

A next step on this path is a better directive implementation for
Martian, something I mentioned in [an earlier blog
entry](http://faassen.n--tree.net/blog/view/weblog/2008/04/11/0). This
should help us making grokkers easier to read, and help up maintain
consistency. Most importantly, it should make it easier to expand our
introspection tools for Grok, giving them knowledge about Grok
directives. We will start on this project as part of the Summer of Code
project of Uli Fouquet (with me as the mentor).
