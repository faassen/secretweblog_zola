+++
title = "Fixing the Zope release process"
date = 2005-03-17
slug = "fixing-the-zope-release-process"

[taxonomies]
tags = ["zope", "silva"]
+++

# Fixing the Zope release process

## Fixing the Zope release process

In this article, I will identify problems with the Zope release
strategy, attribute blame, propose solutions, and offer some hope for
the future.

While this article contains criticism, I have great faith in the Zope
developers, and I hope the criticsm will be considered constructive by
those it targets. I also realize I'm part of this process myself -- this
article is one way in which I try to participate.

### Zope feature releases

Let's look at the release dates of Zope feature releases.

Zope 2.6.0 was released in october, 2002. Zope 2.7 was released in late
may, 2004. It is now march, 2005, and there is no Zope 2.8 release yet.

On the Zope 3 front, Zope 3 developed started in 2001. The first release
of Zope 3, Zope X3 3.0.0 appeared in november of 2004.

Note bugfix releases of Zope do appear on a regular basis, most recently
thanks to the wonderful efforts of Andreas Jung and others. We can
however safely say we do not see a very regular cycle of Zope feature
releases.

### Zope release announcements

Let's now look at a brief history of Zope release announcements. Some of
these were made in an informal mailing list setting, others during more
formal settings such as a conference.

In november 2003, we got the following
[signal](http://mail.zope.org/pipermail/zope-dev/2003-November/020986.html)
from Jim Fulton:

> We want Zope 2.8 to happen as soon as possible, so we can start
> working on Zope 2.9. Zope 2.9 will be the release that incorprates
> major parts of Zope 3.

In december 2003, we heard more (mail to zope3-dev by Jim Fulton, about
a sprint the following january):

> Zope 2.9 will begin the transition to Zope 3 by making some features
> of Zope 3 available in Zope 2. This sprint will map out and begin to
> integrate these features.

On the [Zope Development
Roadmap](http://www.python.org/pycon/dc2004/papers/3/PyCon2004ZopeRoadmap.pdf),
a presentation at PyCon 2004, in march 2004, the first release of Zope
X3 was said be july of 2004 (with a question mark):

> Final in July (?)

And Zope 2.8 is announced to be in quarter 3, 2004:

> Q3 2004 (After X3.0)

For Zope X3.1, the release after Zope X3.0, we see the following on a
[wiki
page](http://www.zope.org/Wikis/DevSite/Projects/ComponentArchitecture/RoadMap):

> Depending on community distributions, we are thinking about releasing
> X3.1 in December, 2004. This release will include several cleanups to
> the framework and feature the new Pluggable Authentication Service
> (PAS) and Workflow packages.

('distributions' is a typo for 'contributions')

In november 2004, we heard the following in the Zope 3
[newsletter](http://webforce.at/Members/d2m/Blog/2004110901), from Jim
Fulton:

> After our initial release of Zope X3.0, we are beginning to
> contemplate an X3.1 release, possibly as early as January 2005.

Then, in early march 2005, we see the [following
post](http://comments.gmane.org/gmane.comp.web.zope.zope3/12129) from
Stephan Richter about the Zope X3.1 release:

> Theoretically, this could be next week, but my experience from the
> X3.0 release tells me it will be more of the time scale of 2-3 months.
>
> I wish I could give you a much narrower date range, but the community
> is currently too small to make sound predictions.

which puts back Zope X3.1 to may or july, 2005.

### Something is wrong

The core software, Zope, that the Zope community relies on, is not
evolving very quickly. In itself, too quick evolution of a mature system
like Zope 2 is probably not very desirable. For Zope 3, at this stage in
its evolution, a faster release cycle is desirable. In the case of both
however, we need more regularity.

Why? Because irregularity and unpredictability discourage people from
contributing to the Zope platform. Imagine you want to contribute a
feature to Zope. You need this feature for a customer project to be
released within a few months (which is the typical horizon for many
projects in the Zope world). You think this feature is general enough to
benefit many Zope developers, so you want to spread the benefit and the
burden of maintaining it by contributing it to the Zope software itself.

But then you realize that adding this to Zope will not show up in any
stable release for perhaps a year. Perhaps you can ask the lead
developers of the project, but since they're wrong so often, you [can't
really believe
them](http://mail.zope.org/pipermail/zope3-dev/2003-December/009023.html).

So what do you do? You decide not to contribute to Zope, but maintain
your contribution yourself. Perhaps as a Zope product, or perhaps,
worse, as a monkey patch. The community does not gain the fix, and you
don't gain the input of others.

(ironically in the mail referenced I make a release prediction about
what was to become [Five](http://codespeak.net/z3/five/) which was way
off, and I also claim I don't care about the Zope release cycle being
slow -- I've since changed my mind)

### Who to blame?

The easy thing is to blame the Zope core developers. But they're the
ones actually doing the work, and doing their best, not paid by us, so
that wouldn't be fair at all. When they make a release estimate, they're
not lying; they make their honest best guess. So, Jim Fulton and all the
others, thank you.

Who then? What do the core developers themselves say? Lack of resources
is the most frequent explanation I see from them. If they had more
resources, releases might come faster.

Since this is an open source project, a large resource is community
contributions. And these are lacking. So the community is to blame
itself; why whine about the lack of Zope releases? They should
contribute!

We can't just turn around and blame the community however. For one, the
community has in fact contributed significantly to development of Zope,
for instance by hosting a whole series of Zope 3 sprints. There should
be more community activity in the form of feature additions and bug
fixes, but we've just given an important reason of why we're not seeing
more of this -- lack of regular releases!

We're in a chicken and egg situation. Regular releases drive
contributions, and contributions drive regular releases. We need to get
out of this trap.

Wait a moment -- do more contribution in fact drive regular releases?
No, not necessarily. The process needs to be in place to channel
contributions the right way. Unstabilizing contributions shouldn't come
just before a release, for instance, as in that case, the contribution
will *delay* the release.

So let's not blame anyone; let's blame the process. Let's now look at
how to fix it.

### How to handle lack of resources

Lack of resources delay a release, but we also need to face it: there is
*always* a lack of developer resources. Good developers experienced with
a project are *always* scarce. Doing regular and predictable releases
will hopefully attract more resources, but they'll never be sufficient,
as human ambition always outstrips any resources

If you want to do a release, you need to manage these scarce resources
and prioritize correctly, so that the release will happen. Without this
management, developers will only tend develop more cool features, and
never release anything.

Luckily, Zope isn't the first project with this problem. We have
examples to study. One project that faced a very similar problem and
solved it is the Gnome project. The problem and the solution were
presented in this
[post](http://mail.gnome.org/archives/gnome-hackers/2002-June/msg00041.html)
in mid 2002, by Havoc Pennington. This quote applies to Zope as well as
it does to Gnome:

> There are two goals of a release strategy: to create stable releases,
> and to generate a lot of excitement and productive work that moves the
> software forward.

and this one does too:

> If we get "stuck" on the stable branch and don't make the jump to
> unstable, then pressure builds to add features to stable, stable
> destabilizes, unstable stagnates and stops being usable because only a
> few people are using it, and it's all downhill from there. If we get
> stuck on the unstable branch, then we never provide anything to the
> majority of end users - we become useful to hackers/testers only.

Gnome has been on a time-based released plan since then, shipping new
feature releases of the Gnome platform to end users regularly.

### How to prioritize?

So, how does one prioritize matters to have releases happen on time?
This is all well-known, though it can't hurt quickly repeating some
concepts.

- announce a feature freeze and stick to it.
- compromise, defer issues aggressively so that they do not all have to
  be done for this release. During the development process, more issues
  than can be solved at the time will always occur. Someone needs to
  defer a lot them, however painful it might be. A good issue tracking
  system is very helpful here to keep track of what needs to be done.
- avoid bottlenecks. Avoid one person holding up a release because only
  they can fix a bug or do something essential in the process. It is
  impossible to always avoid this, but try to minimize this.
- Try to use standard procedures for releases as much as possible, so
  that it is easier for people to help out. If they need to jump through
  special hoops just for your project, they're more likely to give up,
  even if they're *better* hoops. The project innovates enough already
  in its core focus. [YAGNI](http://c2.com/cgi/wiki?YouArentGonnaNeedIt)
  applies here.
- Do not depend on superheroic effort to make a release happen. Only
  [very few people](http://www.ukuug.org/bios+profiles/SRichter.shtml)
  are actual superheros.

### A special recommendation for Zope

One thing that repeatedly seems to have gone wrong with Zope in the past
is setting a release date and *sticking to it*. I hope I have pointed
out that this *important*. In my opinion, it should at times be more
important than features, quality, or cleanups. By that I mean is that on
a regular basis, the *highest* priority should be given to making a
release happen on time, and everything else should be compromised to a
certain extent to make this happen.

When you announce a release date, stick to it. Not announcing a release
date or announcing it and then missing it by months are both bad
options, as I hope to have explained convincingly in this article.
Saying "When it's ready, it's ready", will inevitably delay releases
almost indefinitely.

### Hope for the future

Thanks to the efforts here at the [Paris Zope 3/Five
sprint](http://www.zope.org/Members/nuxeo/news/zope3-five-cms-sprint),
we may have given the final push to make the Zope 2.8 release possible.
We hope to distribute Five along with it, which should finally help
realize what was planned originally for Zope 2.9 in 2004.

For Zope 3, Jim has
[stated](http://mail.zope.org/pipermail/zope3-dev/2005-January/013070.html)
[repeatedly](http://mail.zope.org/pipermail/zope3-dev/2005-February/013398.html)
that he intends to move to a time based release schedule. This is great!
Jim, consider this article as a firm reminder. :)

I hope that our efforts here at the sprint will be followed up by a
commitment of the various parties involved, such as the
[Silva](http://www.infrae.com/products/silva),
[CPS](http://www.cps-project.org/) and [Plone](http://www.plone.org)
developers, as well as [Zope corporation](http://www.zope.com) to
continue working together and to continue contributing on a regular
basis. It's in all our best interest.
