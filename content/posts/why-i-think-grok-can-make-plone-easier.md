+++
title = "Why I think Grok can make Plone easier"
date = 2008-10-18
slug = "why-i-think-grok-can-make-plone-easier"

[taxonomies]
tags = ["grok", "plone"]
+++

# Why I think Grok can make Plone easier

Let me start off by saying that I'm not a Plone developer. I've got a
lot of experience with Zope 2 development though, and I keep an eye on
the Plone community. I hope the Plone developers will not mind a
relative outsider's observations and suggestions.

I understand that many of the people developing with Plone, or learning
Plone, are frustrated. Now this is nothing unusual - I think
fundamentally it's pretty difficult to extend and customize such a
feature-rich system.

We should ever strive to move forward however, and the situation is
clearly worse than it could be: Plone presents many different ways of
doing things to the developer. This is largely a result of its evolution
over time. Things a Plone developer has to deal with are Zope 2, the
CMF, various Zope 3 technologies, the Five integration layer, and many
technologies the Plone developers created.

I'm responsible for creating the Five project some years ago (many
others did a lot too), bringing Zope 3 technology to the Zope 2
platform. This ultimately led to the introduction of Zope 3 technologies
into Plone. This has been, I take it, a mixed blessing.

I think Zope 3 technologies have undoubtedly given Plone developers new
abilities to create powerful, pluggable features for Plone. That's
great. It's also allowed Plone to adopt well-engineered Zope 3
libraries. It has also aligned the interests of the Plone community
better with those of the Zope 3 community, and the Python community as a
whole. This led to us all working together better; a not to be
underestimated benefit in open source development. As a result, Plone
developers are now working on code that is useful outside of Plone (for
instance with Grok), and similarly Zope 3 developers are working on code
useful in Plone.

On the other hand, the addition of Zope 3 technology adds yet another
way to do it for those people who want to extend the customize Plone.
It's yet another set of concepts to learn about. What's worse, these
concepts interact in "interesting" ways with older bits that are already
there. This results in frustration and head-scratching.

In addition, when given a powerful tool for creating pluggable
frameworks, it's easy for a developer to go overboard, and create
something powerful, very pluggable, but not very *agile*. That's not
directly the fault of the tool itself. Building a good framework and
using tools well is a learning process. But in the mean time this is
results in yet more complexity for people to deal with.

Why can't there be a simple, uniform way of extending and customizing
Plone?

In fact, the Zope 3 developers created at least the basis of such a
uniform system. It's been informed by history: it built on lessons
learned with Zope 2 and CMF. This uniform system for customization and
extending software is called the Zope 3 component architecture. In
addition, there's an explicit, and valuable, notion of configuration
that supports extending and customization of software by changing the
configuration.

Plone is a victim of its success. It's been around for a while. Plone is
therefore a piece of software with a history. There are many useful
features in Plone that use the older ways of doing things. The community
has finite resources to rewrite these. It's generally not a good idea to
start rewriting everything at once, either. And if you manage to rewrite
something, you'll have people complain about breaking backwards
compatibility...

Still, Plone is being rewritten, step by step, to make use of Zope 3's
component and configuration technology. Misteps are made. People are
frustrated. But I do believe Plone is fundamentally going in the right
direction with this. The Plone developers have been working for *years*
on creating a uniform system for customizing and extending Plone,
building on Zope 3 foundations. Ironically, but entirely understandably,
this effort is also a source of frustration.

Why can't this component and configuration system "Just Be Python"?

Zope 3 is far from perfect. Traditionally, configuration is done with
Zope 3's ZCML; the bit that's making life harder for many people working
with Plone today. I can understand this frustration very well myself, as
I've felt it when developing with Zope 3.

Now I'm not someone who is fundamentally against the notion of
domain-specific configuration languages. As I indicated above, I think
there is a lot of value in having a notion of explicit configuration in
your system. ZCML and Zope 3's configuration system are valuable. So I
understood why ZCML was there. I even defended it - you can dislike it
because it's an XML dialect, but that's really superficial.

Then I worked with it. I learned over time that ZCML is one of the
aspects of Zope 3 that cuts down on my agility as a developer. Not
because it's XML, but because it's *separate*. I have to do too many
mental context switches - Python code to ZCML and back. If I forget to
write a bit of ZCML to hook things up, which is easy to do, things won't
work. I don't see the complete picture when reading the code, and I
don't see the complete picture when reading ZCML. I concluded it didn't
fit my brain. I think it fits the brains of some people, but I also
think there are quite a lot of people like me.

ZCML wasn't the only thing that made Zope 3 harder for me to work with
than I thought it should be. Other bits are its very explicit and
invasive security system (but that doesn't bother a Zope 2 developer
already, as it's not in Five), and the tendency (partially culturally
and partially encouraged by Zope 3's security system) to write a lot of
explicit interfaces before they are really needed. I see a lot of value
in the explicit interfaces that
[zope.interface](http://pypi.python.org/pypi/zope.interface) supports,
but I typically want to add them to my code gradually as I evolve it. I
don't want to feel the pressure to write them up front.

My response to these issues back in the summer of 2006, was to start
thinking about Grok. In the fall of 2006, now two years ago, some of us
got together and fleshed out the design of Grok into more detail, then
started building it. Along with improving the technical aspects of the
Zope 3 experience, we also wanted to take a fresh look at the way the
Zope 3 community works and how it presents itself. We got quite far in
two years.

The Grok technologies we developed are now finding their way back into
Zope 2. The process started with the extraction of the
[grokcore.component](http://pypi.python.org/pypi/grokcore.component)
library from Grok.
[grokcore.component](http://pypi.python.org/pypi/grokcore.component)
works out of the box in Zope 2. Seeing this, Zope 2 developers then
started working on the five.grok project, bringing back more Grok
technologies to Zope 2.

There has been a nice synergy between the efforts to bring Grok
technology to Zope 2, and the efforts to integrate Grok technology in
non-Grok ("legacy" :) Zope 3 applications. The libraries we've been
extracting for reuse in Zope 2 are reusable in Zope 3 a well, and vice
versa, with only a little bit of extra effort. Both motivations (use in
Zope 2, use in Zope 3) nicely drive development in the same direction.
It is, I think, a nice example of how our larger community can work
together, something the Five project has helped make possible.

I hope Grok technologies makes their way into Plone. I think it can help
the developer's experience a lot.

Why should Plone developers believe a guy who is partially responsible
for bringing the whole ZCML mess to you in the first place? Above I make
the case that the Five project brought a lot of value to us, not just
frustration. And the Five project allows us to *share* our frustrations
in a larger community: although I'm not a Plone developer, I've shared
some of your frustrations, and helped start work on a solution: Grok.

Grok is here today. The technology is there for the taking. It's
essentially "Just Python": you do not write ZCML, and you don't even
have to write much more than the Python code you'd need to write
anyway - it just gets configured for you. Frustrated with the Zope 3
component and configuration system? Grok technology is designed to make
those things easier!

People have a legitimate fear it will result in yet another layer they
will have to learn about, and have to deal with during development. This
will be true in part, as ZCML isn't going to go away right away
everywhere. This means, I fear, people will need to know about it at
least a bit. But at least by adopting Grok technology you'd be moving
forward, in backwards compatible fashion. You'd keep the good things
that Zope 3 already offers while getting rid of some of the bad aspects
of it.

Grok, as a sub-community, cares intensely about the developer
experience. We care about DRY: don't repeat yourself. We care about
bringing a smooth learning curve towards the advanced technologies of
Zope 3, while not breaking compatibility with it. We try to make our
"new layer" as thin as possible, choosing to replace an existing layer
instead of piling yet another new one on top of it. We're about making
the easy things easy; thanks to Zope 3, the hard things are *already*
possible and we do not take away from this power.

I hope the Plone project will align its interests with those of the Grok
project. I admit am self-interested; I think adoption of Grok technology
in Plone would be of benefit to the Grok project at least as much as it
would be to the Plone project. But that's what good open source
development is about: aligning interests.

Thanks for listening!
