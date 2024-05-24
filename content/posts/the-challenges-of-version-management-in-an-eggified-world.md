+++
title = "the challenges of version management in an eggified world"
date = 2007-09-26
slug = "the-challenges-of-version-management-in-an-eggified-world"

[taxonomies]
tags = ["packaging", "python"]
+++

# the challenges of version management in an eggified world

Zope 3, and [Grok](http://grok.zope.org) in the last few months have
been switching to a brave new eggified world of installation. The idea
is that you compose your Zope application from a large amount of smaller
packages, each providing their own components. I've sometimes described
this Zope as an *integrated megaframework*. Zope is an *integrated*
framework where packages follow common coding conventions, and the
component architecture defines a way for packages to work with each
other. Grok tries to step up by aiming for an integrated feel for
developers. At the same time, Zope is a *megaframework*, allowing you to
swap in best of breed components as they come available. Don't like
zope.formlib? Swap in z3c.form for your form generation needs instead.

So how does eggified Zope work? You use
[zc.buildout](http://pypi.python.org/pypi/zc.buildout) to manage your
development project. This buildout gathers eggs together in one place,
looking at requirements in the setup.py of the various packages, and
sets other programs like a start server script, a test runner, and so
on. eggs that aren't installed locally yet will be downloaded from the
Python cheeseshop and other locations. eggs aren't installed
system-wide, keeping the system python nice and clean. What's more,
different projects can easily use different versions of the same
library. Since zc.buildout is easily extensible with new recipes, many
complicated needs can be covered. To make initial installation of a
buildout easier, Philipp von Weitershausen has developed
[zopeproject](http://pypi.python.org/pypi/zopeproject) and
[grokproject](http://pypi.python.org/pypi/grokproject) to help you set
up new Zope 3 or Grok (pick your flavor) projects.

Being at the forefront with eggs and buildouts means we also have some
interesting challenges. I'll describe one that has been biting the Grok
project more than once recently. This post describes the various
concerns that we have with version management, and a proposed solution.

So, what is our problem? A while back, we made the 0.10 release of Grok.
Grok is a framework and depends on many Zope 3 packages (among others).
This is specified in the `setup.py` of Grok, like this:

    install_requires=[
       ... long list ...
      'zope.proxy',
       ... more dependencies ...
       ]

Unfortunately, this approach has a problem. If someone releases a new
version of, for instance, `zope.proxy` to the cheeseshop, newer
installations of Grok will try to use this version instead of the
version that we tested Grok with.

This is asking for trouble: we have made a release, but what people
actually install keeps changing! No wonder that we've had several
breakages of Grok 0.10 as people accidentally broke backwards
compatibility, or mistakenly released broken eggs. Since these packages
are also used by other Zope 3 applications besides Grok, we cannot ask
these people to stop making such releases - this is a megaframework and
individual packages should be allowed to evolve at a different pace.

How to go about fixing this problem? The simplest approach would be,
whenever we release a new version of Grok, to hardcode a full list of
the packages we depend on with exact version numbers in the
`install_requires` section of Grok's `setup.py`, like this:

    install_requires=[
       ... long list ...
      'zope.proxy == 3.4.0',
       ... more long list ...
       ]

Doing this would mean that anyone who installed Grok would get exactly
those versions, nothing else. If someone tells us: I used Grok 0.10, we
know exactly what that means.

Unfortunately it also locks in application developers into those
versions exactly. If a bugfix release of `zope.proxy` comes out, the
application developer that uses Grok cannot start using this new
version, but instead will need to wait for a new release of Grok that
depends on this newer version of `zope.proxy`. While that's often a good
approach anyway, hardcoding the version dependencies does limit the
developers that build their applications (or frameworks) on top of Grok.

There's another problem. Grok isn't the only Zope 3 package that uses
these packages. `zope.component` for instance depends on
`zope.interface`. If `zope.component` hardcodes a dependency on a
particular version of `zope.interface`, the Grok developers would need
to wait for a new release of `zope.component` in order to get a bugfix
in `zope.interface` too. And remember where we came from: the whole idea
of our megaframework approach was to have the flexibility to recombine
components, and this would be blocking it.

Components, and frameworks, ideally should have weak dependency
requirements to be maximally usable, allowing individual developers or
framework developers to use the versions they want to. But on the other
hand, if someone uses a framework, it should continue to work tomorrow.
If someone releases a framework, it should remain installable tomorrow.
If someone communicates to someone else about framework versions
(important in open source software), they shouldn't have to give a list
of 50 version numbers, but just one.

We therefore have two different requirements pulling in different
directions. On the one hand you don't want to lose flexibility, on the
other hand if you want to have a community working and reusing chunks of
software, you want to be able to rely on stability, and frequently you
even want to count on bug for bug compatibility.

To allow flexibility, instead of hardcoding version numbers in
`install_requires` in `setup.py`, you only loosely specify them. You
say, for instance, that `zope.component` requires `zope.interface`, but
not which version. If you *know* that your version of `zope.component`
needs a feature that's only in `zope.interface` 3.2 or later, you'd
write `zope.interface >= 3.2`.

Now we're back at our original problem, however: we got flexibility, but
damage stability. What if someone makes a new release of some dependency
of Grok?

zc.buildout has a feature that can help us pin versions down for our
particular application. We could ask all the people who use Grok for
their applications to put the following section in their application's
`buildout.cfg`:

    [buildout]
    ...
    versions = grok-0.10

    [grok-0.10]
    ... long list ...
    zope.proxy = 3.4.0
    ... more dependency specifications ...

This can be made work well if you don't use a framework like Grok but
instead develop an application from scratch that uses a long list of
components. But in the case of Grok we want the *framework* to specify
these dependencies. We don't want to require all application developers
to replicate a long list of dependencies in their `buildout.cfg`. It's
easy to make mistakes, it's hard to communicate about such lists to
everybody, and what do people do when they need to perform an upgrade to
a newer version of Grok? They'd need to get a *new* long list and edit
their `buildout.cfg` again. It'd be a lot nicer if they only had to deal
with the change of a single version number instead.

Zope 3 has a culture of where making developers figure things out for
themselves is okay if this leads to maximum flexibility for everybody.
Grok has a different approach: it tries to make things easy, too.
Telling developers to maintain long lists of version numbers is not good
enough for Grok, and probably not good enough for other frameworks built
on Zope 3 either.

So, we need a way to have the Grok framework developers maintain this
list of versions in a central place, and allow all application
developers that use Grok to reuse this list.

zc.buildout does have a feature to help us here too: it can include bits
of external buildouts into your own, using a URL. You can use a pattern
like this in your `buildout.cfg`:

    extends = http://grok.zope.org/releases/grok-0.11.cfg

What this would mean is that developers that use Grok place this in
their own `buildout.cfg`, and we maintain the list of versions under
that URL. When a new release of Grok happens, we create a new URL and
ask people who want to upgrade to update their `buildout.cfg` to reuse
that:

    extends = http://grok.zope.org/releases/grok-0.12.cfg

That should be the only modification they need to make if they didn't
hardcode any dependencies in their `setup.py`. And if they want to
override a version number they can still do so in their own versions
section, so we retain flexibility.

This is likely the approach we are going to use in the near future. It's
pretty good, but not ideal, so I'm going to go into some of the
drawbacks of this next.

For one, this doesn't work in locations you don't have internet access,
such as on a train. Now this problem exists for egg downloads as well,
but in typical buildout setups, you'd have a lot of eggs available in
your home directory available that you downloaded previously, so there's
a good chance you can still create a new Grok project even while you're
on a laptop in the train.

Another problem is that the release managers of Grok will have to deal
with two release artifacts instead of one: besides the usual, easy,
automatic package upload using `python setup.py sdist upload` whichg
places the new version on the cheeseshop, we will now also need to
maintain a list of dependencies somewhere and create a new URL whenever
we release Grok. We also need to communicate this new URL to our
userbase, and this is different from the usual Python dependency
mechanism, which is defined in `setup.py`. This isn't a *major* problem,
but it makes the release process more cumbersome nonetheless so it's
less than ideal.

There is another potential drawback to this approach. Dependency
relationships form a tree. Grok may depend on `zope.component`, which in
turn depends on `zope.interface`. In order to pin down the version for
`zope.interface`, we would need to do this inside Grok. This it not a
big problem for such a small dependency, but when frameworks start to
depend on frameworks it will start to be cumbersome to create a unified
list of dependencies. This may sound theoretical, but in the Zope world
it's common to have frameworks that depend on frameworks: Plone depends
on CMF which depends on Zope, for instance. If someone were to write a
CMS in Grok, they would need to maintain and publish their own list of
version requirements for that CMS, which would include the entire list
for Grok. It'd be nicer if they could just say: here's my list, and for
the rest, please reuse Grok's list.

I think many of these problems could be resolved if we could specify
this list in a package's `setup.py` instead of on a URL. A package would
have an optional extra section in their `setup.py` besides
`install_requires`, perhaps something like `install_recommends`. This
section would contain version number recommendations that have been
known to work with this package. Tools like buildout could then choose
to make use of this information, but the developer is also free to
ignore it. This would solve our "URLs cannot be accessed on a train"
problem. It would allow us to do simple release management again with a
single release artifact: all the information will be available in the
egg instead of on a separate URL. It would also open the door for smart
tools which can combine version recommendations from various packages
into a longer list.

Jim Fulton, creator of zc.buildout, told me that I'd need to convince
the distutils-sig for the need for a `install_recommends` section first,
and wished me luck. So I hope I can get some of the distutils people to
read this blog entry. :)

**Update**: I've just made an [install_recommends
proposal](http://mail.python.org/pipermail/distutils-sig/2007-September/008291.html)
to the distutils-sig.
