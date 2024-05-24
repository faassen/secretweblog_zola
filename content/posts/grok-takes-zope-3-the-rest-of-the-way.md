+++
title = "Grok takes Zope 3 the rest of the way"
date = 2008-04-19
slug = "grok-takes-zope-3-the-rest-of-the-way"

[taxonomies]
tags = ["grok", "zope"]
+++

# Grok takes Zope 3 the rest of the way

My friend Lennart's blog entry [Zope 3 rocks and
rolls](http://regebro.wordpress.com/2008/04/18/zope-3-rocks-and-rolls/)
is fascinating, not least as it has one of the most misleading titles
I've ever seen. Reading that title, you'd be surprised Lennart talks
mostly about a series of difficulties encountered with Zope 3 and
decision to switch to Plone for a project instead.

Only the first paragraph has positive things to say about Zope 3: it's a
framework that in many ways tries to stay out of your way, letting you
do your thing. A success story for Zope 3, though it sounds like many of
the facilities in Zope 3 weren't actually used to the project's
detriment. Hopefully most people will only read the title and the first
paragraph, as the rest of the article goes into another project and how
it failed to make use of Zope 3, and why.

This is interesting reading to me. I care about Zope 3 technologies. I
think it is great stuff. I want people to use it more. I want the
community of people who use it to grow, so we get *more* great stuff. We
can do a lot to make this happen. We shouldn't sit back and think if we
build great technology, they will come. We should take the attitude that
if smart people don't use Zope technology, it's [our
fault](http://faassen.n--tree.net/blog/view/weblog/2008/04/05/0). Yes, I
can think of other reasons for non-uptake of Zope that have nothing to
do with the faults of the Zope community, but I'm not so interested in
those reasons. I am interested in things we *can* fix. The rest will
have to take care of itself.

The bit in Lennart's blog about z3ext, a new Zope 3-based CMS which I
know little about myself, is a good example of why first impressions are
so important. Lennart tried to work with z3ext, but it had bugs. He
didn't give up immediately: he helped fixed some bugs. It still wouldn't
work for him. As a result, he gave up on z3ext even though the
developers fixed more bugs later.

With Grok, we had a problem last year after we switched to using eggs
for the Zope 3 packages it depends on, instead of relying on a single
monolithic Zope 3 release. The splitting up of Zope 3 into many smaller
packages is a good thing, as you can evolve dependencies more or less
independently from each other, as separate projects. We also had some
teething problems, though. We didn't have the versions of our
dependencies hammered down enough. We could have a working Grok one day,
but then someone would update some dependency somewhere, breaking some
compatibility, typically in an innocuous way. As a result Grok suddenly
failed to install properly. Most people who tried out Grok at such a
point in time probably went away in frustration. We never heard from
them in the first place. This is a loss of people to a community that
the community cannot even *see*. Karl Fogel describes this disastrous
problem quite well in his book [Producing Open Source
Software](http://producingoss.com/).

Some people who tried out Grok luckily were kind enough to let us know
things didn't work. We were grateful, as those are the rare cases. One
of the absolute priorities of the Grok project became to make it install
out of the box, with a fixed set of versions for its dependencies.
Jan-Wijbrand Kolman and Luciano Ramalho worked hard to fix this at the
Neanderthal Sprint last October. Grok's installation story still isn't
perfect, but it's gotten a lot better and should work for most people
again.

Back to Lennart. After failing to use z3ext as a whole, Lennart then
tried to use some z3ext modules instead. The nice thing about Zope 3
applications is that they are often composed of components you are, at
least in theory, able to reuse independently. So he set up a Grok
project and tried to use these components. Unfortunately this failed due
to dependency skew. Since Grok fixed its dependencies last year, some
Zope 3 packages have been changed and new releases have been made. One
common superficial change that does break things is that some code got
moved to another package. z3ext was relying on newer versions of its
dependencies than Grok was, and thus z3ext couldn't be used with Grok.
Lennart had to give up on that too.

Ugh! This breaks Grok's aim of being fully compatible with Zope 3. We
should fix this. Some of the solution is already very close. The Zope 3
project also recognized the problem Grok saw, and a bit after Grok fixed
its list of versions, Stephan Richter developed a system known as KGS,
which maintains a list of "known good" dependencies for a Zope 3
installation that are known to work together. KGS has nice
infrastructure for running the tests of all these packages together to
make sure. Grok doesn't use the KGS list yet as we converged on a
versions list earlier. Hopefully at the Grokkerdam sprint someone will
look at using the newer list. If z3ext components make use of the same
list, we should be fine in reusing these components.

One of the essential strategies to ensure your project can be built on
is to release it; Lennart mentions this too. When people work with a
released version, they know it doesn't change unless they decide to
switch to a newer release. A release should *include* a stable set of
versions for dependencies: we learned this lesson the hard way with
Grok. Having this stability means you can start to build things on it.
Release your projects! Zope 3 has been a moving target without a proper
final release. Grok has suffered from this lack of clarity and
instability: if Zope 3 had made a final 3.4.0 release half a year ago, I
imagine Grok would have been using it now. Like Lennart I believe it was
more than stable enough to do so back then, though in its defense it
couldn't happen yet then as we had the egg teething problems to work
out.

Lennart also talks about how religious doctesting is a problem in Zope
3. He says that doctests are often hard to read and go into low-level
details of the package without giving the easy picture of how to use the
code. That's true. Doctests often make for pretty sucky documentation.

But I still see the glass as being half-full here where Lennart sees it
as a problem. A module with a doctest is usually further along on the
path towards good documentation than one *not* doing doctesting. The
documentation tends to suck as it often lacks context and is too heavy
on the details, and there's no tutorial, but it's *there*. That's a
whole lot better than having *no* documentation about how things go
together at all. Realistically, no documentation is often the
alternative for busy developers. I'll take flawed documentation any day!
Incidentally I also think doctests help make tests easier to follow;
that's worthwhile in itself.

The problem is not the doctesting. I think the religious doctesting is a
good thing. The problem is that too often we see the doctest as an end
point. We should add context, tutorial-style content, and start
refactoring the doctests to become better documentation. I think we
often cannot expect the developers themselves to do this. While of
course I hope developers will improve their documentation, let's also be
happy they got as far as to include a doctest. We can help take the
package the rest of the way by writing a tutorial or an example.

One more thing I want to add: using a new component or library is often
just plain hard. Even with perfect documentation it takes study. You can
try to make it easier, but each new component will present its own
challenges. This will never end. What we can do is make the common case
easier, with good documentation, good APIs and sensible default
behavior. By doing this, we actually create artifacts that make the
component easier to learn for everybody. Some effort will always remain
however. Programming is learning. No gain without some effort,
especially where the component you want to use is rich and powerful. I
know Lennart knows this, but I feel it's important to point it out.

Lennart's second Zope 3 project failed and he went to Plone with it. We
can defend Zope 3: perhaps he was trying to be too ambitious and
expected too much from Zope 3. The nice thing about Plone is that it's
there, does a lot, and works out of the box. Lennart is intimately
familiar with it too. Zope 3 is not about being an application that just
works, but a "roll it yourself" toolkit. But that doesn't take away the
problems with Zope 3 that we *can* fix.

Lennart concludes that Zope 3 isn't ready when you want to reuse other
people's modules. That's true - it's half-way there, which I think is
actually quite far along and a good basis to start from. Lennart says
this is a problem of the Zope 3 community. I agree, but I also believe
the Zope 3 community by itself does not have enough interest to really
fix this.

I've stopped expecting a fix of this kind of thing from the Zope 3
community. As I see it, the Zope 3 community is primarily interested in
technical problems, and write flexible, reusable components that *they*
can reuse. They aren't very interested in actually doing the rest of the
work to make sure *other* people can reuse their stuff. If they were,
Zope 3 would have a proper website by now. Even experienced Zope
developers that very familiar with Zope 3 technologies like Lennart,
bounce off.

I've come to accept this attitude of the Zope 3 community and I actually
think it's mostly fine - they should do what they are interested in and
what they are good at. They should scratch their own itches. We should
be happy they are already bringing their components half-way to
reusability by others, which as I said before, is actually quite far.
The amount of work to do that shouldn't be underestimated.

While the Zope 3 community is not fixing this, the wider *Zope*
community is actualy busy fixing this. The project to fix it has a name:
Grok. We care about attracting people to our project, and we got proof
as we got a website: <http://grok.zope.org>

The Grok project cares about making it more easy to use powerful Zope 3
technology. Let the Zope 3 developers do what they are good at and
produce interesting, powerful, flexible components. Grok will then
happily polish them until they work for others. We will do the rest of
the job: making Zope 3 safe for the common caveman. That's our mission.
We are successful at it: in its relatively brief existence, Grok has
untapped an amazing amount of wealth and has made Zope 3 technology a
lot more accessible to developers.

There is a lot more wealth to untap however. Let's also recognize the
problems we have. Lennart pointed out some of the things we still need
to do. Let's continue this process. If you care about this too, please
join us and help!
