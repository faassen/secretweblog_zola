+++
title = "Grok tech in Plone continued"
date = 2008-10-19
slug = "grok-tech-in-plone-continued"

[taxonomies]
tags = ["grok", "plone", "silva"]
+++

In [my previous blog
entry](http://faassen.n--tree.net/blog/view/weblog/2008/10/18/0) I tried
to make the case for Plone adopting Grok technology. I gave some
background on Grok and talked about some of the pain points that I think
Plone has and that Grok has been trying to tackle. My goal was to
explain where Grok is coming from, and why it's a good fit for Plone.

Martin Aspeli, in a comment, wrote the following:

> However, there are three charges that the advocates of Grok-in-Plone
> would need to counter:
>
> - Not enough people are using Grok, i.e. it's yet another esoteric
>   technology choice
> - It's too much magic (or too hard to debug when things don't do what
>   you'd expect)
> - It's yet another way of doing things that can't completely displace
>   the existing ways
>
> I'd be interested to hear your responses to these. :-)

These are each good points that need to be discussed. Let me respond to
them here.

## Not enough people are using Grok; Grok is too esoteric

The too-clever answer would be that enough people _would_ be using Grok
if the Plone community hopped on board. :)

Grok technology expands on a technology choice that Plone already made:
Zope 3. Grok is the project that is trying to make Zope 3 technology
feel _less_ esoteric. It seems to me therefore that Grok technology is a
way to make Plone's technology choices feel less esoteric, not more.

I would also be interested in hearing alternative suggestions. Are
people suggesting Plone dump Zope 3 technology? What would replace it?
Or are people saying there are better choices to make Zope 3 easier to
work with? Or are people saying Zope 3 technology as it stands is just
fine already?

Grok provides a smooth upgrade path from technology that you're already
using, it has been around for two years now, and it's focused on
reducing pain points for developers. The Grok community isn't an
enormous community, but it's active and growing.

I agree with the general idea that we shouldn't be making too many
esoteric technology choices. On the other hand, the Zope community on
sometimes is tackling problems that others haven't encountered yet. The
solutions will inevitably seem esoteric to some people, because we
simply were the first to get there.

## It's too much magic

Grok's way of doing component configuration builds on the
[Martian](http://pypi.python.org/pypi/martian) library. You can extend
Grok in a declarative fashion. We've continued to work on expanding
Martian so that individual bits of Grok become more declarative and less
special. We're also documenting this behavior extensively.

One can make the charge that the defaulting rules that Grok's directives
(to associate a view with a context, give a name for a view, and so on)
use are too much magic. They're also the core of Grok's convention over
configuration approach. Convention over configuration has two positive
effects:

- it encourages different people to follow the same conventions in code,
  so that code that follows the conventions is more regular.
- it allows people to learn about Grok gradually. They don't need to
  know all directives in order to accomplish something, but once they
  come to a road block and they want to override the default behavior,
  they are ready to learn a new directive.

If you are unsure about Grok's behavior, you can _always_ be explicit by
writing all the directives down explicitly yourself.

As to the suggestion that Grok code is hard to debug when things don't
do what you expect, I'd be interested to see some examples of this
problem. I haven't noticed things being particularly hard to debug
myself, but of course my perspective is special here. Grok ships with a
built-in introspector which should help, although we can certainly
improve it quite a bit lot more.

Grok is a form of automation. One person's automation is another
person's magic. We're on guard against inconsistent automation with lots
of special cases.

## It will be a new way that cannot entirely displace the existing ways

I think this is not a comment particular to Grok. Any new way you
introduce is vulnerable to this charge. It's inherent to the evolution
of a large framework and the tension between moving forward and
backwards compatibility, which I already described in my previous
article.

Grok provides a _smooth_ transition path at least for the Zope 3 code
that already exists in Plone. It allows a gradual transition. It's good
as this is the only way forward for a larger system with so many users.
This is bad because two ways will co-exist at the same time. I'm not
sure this can be avoided, however.

As for non-Zope 3 APIs in Plone, where you need to registers with Zope 2
or the CMF, Martian technology can help there too. The Silva project has
been doing interesting work in this direction; it uses Grok technology
to register its distinctly Zope 2 content types.

I think some people have the impression that Grok takes away from the
power of ZCML. They seem to think Grok is for some basic stuff, but when
things really gets tough you have to fall back on hard-core ZCML. That's
not the case. I find myself writing very little ZCML these days. Grok
isn't a simplifying layer over ZCML; it's an alternative configuration
system for the Zope 3 component architecture that we believe is easier
to use. That said, Grok allows ZCML and Grok code to coexist just fine
if you want or need to have both.

Whether Grok technology, or any technology, will displace old ways
entirely in Plone is not something that is limited by the technology
itself. It is a choice the Plone developers make, and if they make it, a
challenge the Plone developers must rise to.
