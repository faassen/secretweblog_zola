+++
title = "Grok Status Update part 3"
date = 2008-06-11
slug = "grok-status-update-part-3"

[taxonomies]
tags = ["grok"]
+++

Lots more is going on in the Grok world, so the Grok Status Update has
received a part 3. See also [part
1](http://faassen.n--tree.net/blog/view/weblog/2008/06/02/0) and [part
2](http://faassen.n--tree.net/blog/view/weblog/2008/06/03/0).

**grok.OrderedContainer**

Thanks to work at the Grokkerdam sprint, Grok 0.13 will contain an
`IOrderedContainer` implementation besides the normal container:
`grok.OrderedContainer`.

**grok.Require**

We realized during the Grokkerdam sprint that we should allow the user
to pass the permission class directly to `grok.require`, instead of
having to pass the permission name. Using permission names is still
possible (and sometime necessary if the permission isn't defined by Grok
itself), but in Grok 0.13 it will also be possible to pass the
permission class directly:

    class MyPermission(grok.Permission):
       grok.name("my.permission")

    class MyView(grok.View):
       grok.require(MyPermission)

**menus in Grok**

Jan-Wijbrand and myself discussed what menus in Grok could look like a
week or two ago. We found many parallels with viewlet managers (menu
itself) and viewlets (menu entries), and we think we can build this on
top of viewlets. We need to work out a more detailed design proposal and
discuss it on grok-dev next.

**grokcore.component release**

At the post-PyCon sprint, Brandon Craig Rhodes and Robert Marianski
worked on extracting generic bits from Grok into a separate package
called `grokcore.component`. At the Grokkerdam sprint, Philipp von
Weitershausen polished it off, merged the branch that makes the Grok
trunk depend on it, and released it to PyPI.

`grokcore.component` is compatible with Zope 3 and also with Zope 2. It
is more light-weight than Grok itself, so it's easier to integrate in
existing projects. Various Zope 3 and Zope 2 developers have started
using this package in their own projects.

**five.grok**

At the Paris Plone sprint, held in the week before the Grokkerdam
sprint, a new package `five.grok` was created. This package aims to
provide Grok functionality to Zope 2. It builds on `grokcore.component`,
and extends its functionality with other things like view support.
During the Grokkerdam sprint Eric Casteleijn continued work on
`five.grok`, adding tests and updating it as `grokcore.component` itself
was updated.

The task is now to get a dedicated set of volunteers who want to bring
`five.grok` up to speed. The idea is that `five.grok` will as much as
possible make available Grok's APIs in Zope 2. It won't engage in the
invention of new APIs; that is for other packages which build on this.

**directive refactoring**

A large project was completed at the Grokkerdam sprint by Philipp von
Weitershausen and Jan-Wijbrand Kolman. During the Snow sprint in
january, I noticed quite a bit of regularity in the way directives were
used in Grok. I figured there was a way to abstract this out and push it
into our Martian configuration library, so on the train trip back from
the Snow sprint, I started a project to implement this in Martian.

Philipp and Jan-Wijbrand extended this work at the Grokkerdam sprint,
started using it in `grokcore.component` and Grok itself, cleaning up
Grok's grokkers quite a bit.

At the end of the sprint we reviewed this work and started work on the
next step of this pattern: declare exactly what directives a grokker
uses in the Grokker. This cleans up the code even more, and should make
it much easier for the Grok introspector to deduce useful information
for the introspector UI.

Philipp continued this work after the sprint. This is now merged into
the Grok trunk as well (and `grokcore.component` uses it too, already
released). Since then, we noticed another pattern in the way classes
were grokked that actually register the methods of these classes.
Philipp set out to work on this too, and this resulted in a new part of
Martian called the `MethodGrokker`, which codifies this pattern. This
further cleans up Grok.

Since then, I've further extended Martian. It now has a nicer
[tutorial](http://pypi.python.org/pypi/martian), and it uses the new
directive infrastructure to define grokkers as well. This makes a
grokker look like any grokked class -it derives from a base class and
has a few directives.

All this work will land in Grok 0.13.

**CRUD**

[Joachim
Schmitz](http://faassen.n--tree.net/blog/view/weblog/2008/05/14/0) and
myself worked on a demonstrator project to see how we could construct a
powerful CRUD framework on top of Grok, automating the user interface.
This is code that typically needs a lot of pluggability, and
pluggability is where the Zope component architecture shines. Hopefully
we'll see more progress on CRUD in Grok in the future.

**EuroPython Grok sprint**

We will be having another Grok sprint after EuroPython this year. We are
looking for people to participate. If you want to join in, please add
your name here:

<http://wiki.zope.org/grok/EuroPython2008Sprint>
