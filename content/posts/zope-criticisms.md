+++
title = "Zope Criticisms"
date = 2009-03-03
slug = "zope-criticisms"

[taxonomies]
tags = ["zope"]
+++

Chris McDonough just posted a capsule criticism of the Zope project and
culture to zope-dev in a discussion I started. I believe Chris and I
have been "violently" agreeing on most many issues in this discussion...
I thought this characterization is quite interesting and I'd like to
share it with the wider world. I agree with it so much and disagree so
much at the same time.

Even though I disagreed with the decision to include underwear as a logo
on a (now rejected) design for a new zope.org homepage, I do think it's
good to sometimes focus on our dirty laundry as it can help with a
cultural renewal I think the Zope community needs and is ready for.

I think this information can also be interesting for developers of other
web frameworks. Look at the stuff we deal with after having been around
so long! Don't let this post mislead you: I see a lot of value in Zope
technology and its community otherwise I wouldn't have stuck with it for
more than 10 years. Chris obviously sees value in it too, otherwise he
wouldn't be arguing with me on zope-dev and extracting so many of its
concepts into Repoze components.

I hope he'll forgive me for quoting him here:

> I have no faith whatsoever that staying on the course we've been on
> for the last 9 years (large interconnected codebase, backwards
> compatibility at all costs, lack of any consumable documentation at a
> package level, not much curiosity about how other Python web
> frameworks work, not much real cooperation with folks that maintain
> other Python web frameworks, a constitutional inability to attract new
> users) will bring any sort of positive change.

As a background, Chris is characterizing the Zope culture in such an
extreme way as it contrasts with the Repoze project he leads that tries
to these things differently. The Grok project shares quite a few of
these values as well, and wants to get closer.

I agree with much of this in the sense that it's a useful caricature of
what's wrong with the Zope community and what needs to be improved. It's
amusing that I look for ways to apply the lessons of Repoze and Grok
(among others) to Zope we end up arguing so much. Chris interpreted my
proposals for cultural renewal as a way to codify all things bad he
describes, while my intent was more or less the opposite. I have to
improve the way I express myself!

Let's go into the details:

> I have no faith whatsoever that staying on the course we've been on
> for the last 9 years

9 years is a long time, and while I agree that some cultural
deficiencies such as bad presentation of modern Zope technologies to
developers and a bad installation story, have lasted a very long time
without enough of an effort to fix them, other deficiencies we're aware
of and we're making progress on.

> large interconnected codebase,

This characterizes the current Zope 3 codebase quite well, but at the
same time doesn't characterize our goals or efforts.

We had an effort in 2007 to split up our large interconnected codebase
into small components. These are now the many zope.\* and related areas
on PyPI. Some of these are reusable independently, but far too many
still pull in way too many dependencies (basically all the others), due
to some seriously circular dependencies between them.

Recently I and others have spent quite a bit of time in trying to make these
dependencies [better](@/posts/cleaning-up-zope-3-s-dependencies.md), and this
is part of an on-going process.

I think this is a mischaracterization therefore in the sense that is
something the community knows about and is actively working on.

> backwards compatibility at all costs,

I agree that we have erred on the side of too much backwards
compatibility. That increased the overhead of changes tremendously and
blocked innovation.

That said, I also see a lot of value of having a lot of components that
can work together, and we do have a large collection of those in the
Zope ecosystem. This is why Grok is so careful to stay compatible with
Zope 3, so we can share that pool of components.

I'm in favor of an evolutionary approach where backwards compatibility
on occasion is broken and it's clearly documented what developers should
do to fix their code. We've found this worked quite well for changes in
Grok. I'm also in favor of an approach where due to proper dependency
factoring we can dump whole chunks of code that we aren't using (such as
the Zope 3 ZMI) in a large step.

> lack of any consumable documentation at a package level,

I agree that most package-level documentation could be improved
tremendously by focusing on writing real documentation instead of
half-test/half-documentation stuff.

That said, we also have a tremendous level of package-level
documentation and interface documentation, and it's a
mischaracterization of the values of the Zope project to say we haven't
cared about documentation at all. We innovated with interface-level
documentation and doctests, as well as making those doctests available
on PyPI.

Chris has said in the past that this is a sort of "false optimum" that
stops people from really fixing documentation issues, and I agree with
him there that this is wrong (even though [I do value
doctests](@/posts//i-like-doctests.md)). We
should make an effort to change our culture and redirect our
documentation efforts to go beyond doctests. We've seen the adoption of
Sphinx in our community in the last year, and I have good hopes we will
make a lot of progress on this in the coming year.

I'll also note that documentation for the whole _system_ has
traditionally been lacking (how to get started, install it?). For this
my answer is [Grok](http://grok.zope.org/). If you want to use the Zope
3 technology stack, it's by far the easiest way to get started.

> not much curiosity about how other Python web frameworks work,

I'm not sure whether this characterization is accurate or not. Because
Zope was there sooner than many other Python web frameworks, it's
probably true we've not studied the competition as much as if we'd been
there later and had more chance to compare and contrast.

I've personally been quite interested in seeing how the cultures
surrounding other web frameworks work and trying to adopt lessons from
this (DRY and convention over configuration for Grok, for instance, and
proper documentation).

I've been able to apply the lessons I've learned from other web
frameworks far better in the context of Grok than I have been in the
context of the wider Zope community, and I wish that would change. In
fact I'm trying to apply some lessons I've observed from Chris' efforts,
Repoze, to Zope.

So, we should do more of this, indeed.

> not much real cooperation with folks that maintain other Python web
> frameworks,

It's hard to judge this one, because what is "real cooperation"? We've
tried reaching out quite a few times over the history of Zope, but I do
think we can do better. Of course reaching out like this is one of the
main things that Repoze is trying to do, so it's unlikely we'll be able
to get up to the level of the Repoze folks any time soon.

The culture of cooperation between other Python web frameworks has
started really taking off surrounding WSGI. Zope has tried to integrate
with WSGI (and Twisted before then), but with moderate success in
gaining community benefits from this. This means we need to try harder.
I believe Grok's upcoming 1.0 release will help us a lot with the
adoption of this technology, as we've been working quite hard to make
sure it works out of the box.

I think we should do our best to integrate other technology in our own
stuff, and we've had some progress with things like WSGI, Twisted and
SQLAlchemy. Maybe Repoze is next, but I hear they think very badly of us
indeed, probably because they know us so well. :)

> a constitutional inability to attract new users

I share that concern [very
much](@/posts/what-zope-can-learn-from-ruby-on-rails.md). Part of the reason we
don't attract more users is our lack of attention to documentation, proper web
presentation, and our "here's a giant toolbox, it's flexible, you figure it
out" approach. Grok has been one answer to this, and we've had a lot of good
progress in bringing the old Zope 2 documentation up to speed as well.

It's good that the Zope technology is so central to other projects which
do attract new users (Grok, Zope 2, especially through Plone) so we
still have an influx of new users that way. We also get an influx of
users of our individual libraries such as `zope.interface` and
`zope.component`, and we want to encourage that happening more.

Besides this, I'm always surprised we are able to attract new users of
the Zope 3 app server directly itself as well - there are more than
you'd think given our rather bad public presentation. There must be some
value in it after all then! :)

I think we should recognize the position of the Zope technology as
central to Zope web frameworks that _do_ attract users. I want to call
that technology the "Zope Framework". It's not something users install
directly, but it's something that is used to build Grok, Zope 3 and Zope
2, that _can_ be installed.

We need to manage the Zope Framework as such. In it, there is a tension
between the concerns of the individual libraries (the parts) and the
whole (the integrated set of them that's traditionally been called Zope
3, but is also used by Zope 2 and Grok). We need to think of the Zope
Framework as a whole, and as parts. In order to make whole better we
need to improve the parts, but in order to improve the parts we often
need to think about how they fit into the whole as well.

We need to manage it so that we can resolve this tension so that we can
have _both_ good individual libraries _and_ a better integrated
experience. I'm optimistic we can resolve this tension to the betterment
of the whole and the parts.

We need to look at ways to make the Zope Framework smaller, composed of
more easily digestible parts, and being a whole that's easier to
comprehend.

In reality we're not managing one big thing, but a tree of libraries
that depend on each other, and people can approach parts of the trees as
well as the whole. Breaking the tree metaphor, branches or nodes of the
tree can be adopted into _other_ trees such as repoze.bfg and Twisted.
The Zope Framework, like Chris' description, is in a way a caricature of
something more complex. It's a handy concept to organize a community
around.

That community is the Zope community. Here's our dirty laundry. We're
washing it so you can use it too. And we'll need to wash it again in the
future. We're used to doing laundry. We've been at it for over a decade,
and we won't be going away any time soon. Care to join us? :)
