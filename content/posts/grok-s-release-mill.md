+++
title = "Grok's release mill"
date = 2008-10-07
slug = "grok-s-release-mill"

[taxonomies]
tags = ["grok", "release", "silva", "plone"]
+++

It already happened last week, but I thought I'd mention our Grok 0.14
release. [Grok](http://grok.zope.org) 0.14 is the first release of Grok
that officially works with Python 2.5, though unofficially Grok has
worked with Python 2.5 for a while on many platforms. There is already a
[report](http://blog.d2m.at/) of Grok working with Python 2.6!

The other major change in this release is the spin-off of three new
libraries that are also reusable in plain Zope 3 applications as well as
in Zope 2 (through `five.grok`):

- [grokcore.view](http://pypi.python.org/pypi/grokcore.view) - the basic
  support for views and templating in Grok
- [grokcore.security](http://pypi.python.org/pypi/grokcore.security) -
  Grok-style security declarations
- [grokcore.formlib](http://pypi.python.org/pypi/grokcore.formlib) -
  zope.formlib support for Grok

We've also spun off the
[grokui.admin](http://pypi.python.org/pypi/grokui.admin) package. This
contains Grok's user interface. This should means it becomes possible to
deploy Grok applications without this user interface included, which
adds security to deployments.

Earlier already Grok has spun off
[grokcore.component](http://pypi.python.org/pypi/grokcore.component),
which is a layer on top of
[zope.component](http://pypi.python.org/pypi/zope.component) and
<span class="title-ref">zope.configuration</span> enabling you to use
Zope's component architecture while writing plain Python code.

Earlier still, the Grok project spun off the
[martian](http://pypi.python.org/pypi/martian) library for deducing
configuration from Python code itself. Martian has much improved since
its first release, making it easier than ever to auto-register classes
with any configuration system of your choosing, define directives and
declare sensible defaults in case those directives are not used.

Why do we spin all these packages off? Why not develop Grok as one big
lump of code? The reality is that we can't anyway - Grok is based on a
whole range of Zope 3 components and other packages that are developed
separately. Why though do we make our lives harder and split off things
from Grok itself?

First, thanks to [buildout](http://pypi.python.org/pypi/zc.buildout) our
lives are not that much more difficult. It's easy enough for us to
continue to develop these packages in synch with each other when we want
to. We can use svn externals to pull a development version of a package
into another and then tell buildout we want develop using that version.
This is basically an enhanced version of setuptools `develop`
installation mode.

Still, why is it worth it?

In the abstract, splitting off separate packages helps us safeguard
conceptual integrity of a package. Giving a package a separate identity
makes us think about what this package is really _for_, and helps keep
the scope of a package clear.

Since we use separate packages with separate reponsibilities, it allows
us a smoother framework evolution as well - we can more easily decide to
drop a feature from the core and adopt another feature into the core if
these features are independently packaged.

Most importantly and most concretely, the separate packaging helps with
code reusability. The Grok developers want the Grok technologies to be
used by many people. We've already seen the uptake of our
<span class="title-ref">grokcore.\*</span> packages in plain Zope 3
projects by developers who like some of Grok's features but don't want
to pull in _all_ of Grok. Even more importantly Zope 2 developers are
starting to use our technology in CMS projects such as
[Silva](http://www.infrae.com/products/silva) and
[Plone](http://www.plone.org). The martian package has also seen use in
projects like [repoze.bfg](http://static.repoze.org/bfgdocs/). This way
a wider community becomes a stakeholder in the Grok project, and we feel
this is very important.

How easy is it to use our code in non-Zope Python projects? The answer
varies. Martian has only a dependency on
[zope.interface](http://pypi.python.org/pypi/zope.interface).
[grokcore.component](http://pypi.python.org/pypi/grokcore.component) has
a slightly larger but still very well defined set of dependencies and is
still entirely reusable in any Python project. The other packages
unfortunately are dependent on a larger set of Zope 3 dependencies
making them not reusable outside of a Zope setting.

The [Repoze](http://www.repoze.org) project has made many Zope
technologies available to the outside world. The Grok project is looking
at starting to use some of that code. The Zope developers are also
looking at the Zope packages themselves to see whether we can't cut some
more dependencies here and there increasing their reusability. That's
another advantage of separate packages: it makes us aware of reusability
issues, and lets us work on it.
