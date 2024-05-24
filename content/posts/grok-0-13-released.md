+++
title = "Grok 0.13 released!"
date = 2008-06-24
slug = "grok-0-13-released"

[taxonomies]
tags = ["grok"]
+++

Grok 0.13 was released yesterday. [Grok](http://grok.zope.org), of
course, is the powerful web application development framework. See the
details in the release notes here:

<http://grok.zope.org/project/releases/0.13/>

The really involved details are in the changelog here:

<http://pypi.python.org/pypi/grok>

Grok 0.13 is the first release of grok which uses
[grokcore.component](http://pypi.python.org/pypi/grok), a standalone
library that only depends on
[zope.component](http://pypi.python.org/pypi/zope.component) and its
dependencies. We have also released a new, more powerful version of
[martian](http://pypi.python.org/pypi/martian).

Why is this significant? There are a number of reasons:

- grokcore.component allows you to more easily use the famous Zope 3
  component architecture in arbitrary Python applications.
- grokcore.component can be used in arbitrary Zope 3 projects without
  pulling in the rest of Grok.
- grokcore.component works out of the box in Zope 2.
- grokcore.component can also be used in arbitrary Python projects.
- Martian makes developing domain-specific configuration systems in
  Python a lot easier, and the new version of Martian makes it easier
  still, introducing a powerful way to introduce custom class-level
  directives. Martian has evolved to take away a lot of ad-hoc behavior
  away from Grok, making Grok's configuration rules more explicit, even
  though they continue to work the same as they did before.

I'm proud we're able to spin off cool, reusable technology like this
with the Grok project. This is one of the best aspects of Zope 3
development, which Grok shares.

Of course all these reusable libraries don't take away from Grok's
integrated feel. Grok is a megaframework, but it's also _integrated_. If
you just want to use Grok to build your web applications, you don't need
to worry about these underlying components unless you want move into
quite advanced areas.

The 0.13 release is also the first release that includes a lot work done
at the Grokkerdam sprint in early may. This includes some of the Martian
work mentioned above, but also many other things. Thank you sprinters!

The work will now start on Grok 0.14. One major topic on the agenda for
0.14 is to finally get good out of the box WSGI integration for Grok.
WSGI has been possible with Grok for a long time, but since it's not out
of the box lots of people had to figure it out for themselves.

Another release that will happen soon is the new and improved
[grokproject](http://pypi.python.org/pypi/grokproject), the tool that
helps you install grok and create grok-based projects. We ran into a few
minor snags at release time yesterday so we stuck with the older
version, but those should be resolved soon enough.

Hopefully we'll also soon be able to publish our Sphinx-based
documentation. We've been maintaining some larger, more "official"
documentation in SVN for a long time, and while we've published it to
the web through Plone the workflow is not optimal. We are planning to
roll out per-release official documentation along with the releases in
the future.

Interested in Grok? Do check out <http://grok.zope.org> - there is a lot
of documentation that will help you get started, and we're always
working on more.
