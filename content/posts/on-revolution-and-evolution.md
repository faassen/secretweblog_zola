+++
title = "On Revolution and Evolution"
date = 2008-01-29
slug = "on-revolution-and-evolution"

[taxonomies]
tags = ["open source", "zope", "plone", "silva"]
+++

Malthe
[started](http://mockit.blogspot.com/2008/01/revolution-that-would-be-televised.html)
an
[interesting](http://blog.delaguardia.com.mx/index.php?op=ViewArticle&articleId=101&blogId=1)
[discussion](http://vanrees.org/weblog/archive/2008/01/28/plone-and-revolution-a-response)
on the possibility to rewrite Plone from scratch. I have some thoughts
on the topic of rewrites, evolution and revolution. Here are some of my
scattered observations.

While at [Infrae](http://www.infrae.com), I led the development of
[Silva](http://infrae.com/products/silva) for many years. I also
initiated the Five project. The creation of Five was driven by two
concerns:

- Silva needed the customization and flexibility potential of Zope 3
  technology.
- I realized that a complete rewrite of Silva based on Zope 3 was going
  to be unlikely.

I participated early on and enthusiastically in the development of Zope 3. I'm still a big fan of the project. At the time it was generally
assumed that this was the next-generation platform that in time would
replace Zope 2. The stories about how we were going to port Zope 2 code
over were always vague. Luckily Silva can almost completely export its
state as XML. I therefore assumed for quite a while that soon enough
we'd end up rewriting Silva on the Zope 3 platform, and even without a
way to port any code, we'd at least be able to carry over the content.

As time progressed, it became clearer and clearer that the rewrite of
Silva was not going to be happen. Of course not! Would any customer
would pay for it? What would you tell a customer? Give us lots of money
and we'll give you a new version with initially less features and more
bugs? Infrae has wonderful, quite enlightened customers who care about
Silva, but telling them that was unlikely to solicit very positive
responses, and for good reason!

Now Plone has the benefit of having a much larger community than Silva
does, and it's full of all kinds of energy. But telling community
members that you are going to rewrite Plone is going to be almost as
hard a sell, and will give rise to inevitable confusion.

Given the experience we had with the confusion surrounding Zope 3, I
wouldn't announce you're rewriting Plone. Don't call it Plone, at least.
You might get away with it if you are the sole dictator of a project.
Apple could more or less do it with Macs, transitioning to Mac OS X.
Microsoft could do it with Windows 95 and Windows NT. But even these use
the same brand name and name the individual things differently - note
how they use names that are not much like a version number.

There is no Plone dictator. A rewrite project named Plone will certainly
give rise to confusion in the community. You'll get questions like
"sould I use Plone X or Plone Y?", ages before Plone Y is even ready.
"Hey, why can't I run PloneAmazingProduct on top of Plone Y?"

It's easy to avoid such confusion. If you want to create a new thing,
give the thing a new identity. I even gave Five an identity by itself,
and it wasn't really a new thing at all - it's whole idea was to combine
existing things! I also learned the best way to make a new thing is to
base it off some existing thing: Zope 2 and Zope 3 for Five. libxml2 and
elementtree for [lxml](http://codespeak.net/lxml). Zope 3 for Grok.

If you want to get a lift from Plone's community, by all means try.
Closely ally it with Plone somehow. Make it easy for the two systems to
work together, perhaps. That's the relationship we're aiming for between
[Grok](http://grok.zope.org) and Zope 3. But naming it the same is a bad
idea. We have namespaces in code for a reason; without namespaces
confusion and bugs are more likely. I think the same applies to
projects.

It's true that reimplementing software is very attractive to software
developers (it is to me). It's also true it's frequently not a good
idea. I disagree with the position that rewrites from scratch are
_always_ a bad idea. I do agree that any idea to rewrite should be
scrutinized aggressively. It's good that it's happening. This needs to
be done, as rewrites have huge costs. Even backwards incompatible
changes have a severe cost, especially where they are done low-down in
the stack. Rewrites are like backwards incompatible changes with a lot
_more_ confusion to the community. If one would change the name for the
new effort, is it a good idea for Plone? I think it could lead to useful
things, but it could as well lead to nowhere. I don't know.

When I was pushing Five, I used the phrase "evolution, not revolution".
After a while I started hearing this back from others, so the meme was
spreading. I still think this is a good idea for the position Plone is
in - the same position Silva is in.

So was the Zope 3 project, a near-complete rewrite, a bad idea? It's
hard to say. I certainly like much about how it's turned out. It's one
of the most advanced pieces of web technology out there. There's so much
mostly untapped potential in it. The Grok project is now happily in the
process of tapping it. So is the Zope 2 project! I believe we can go
very, very, far with Zope 3 technologies. I think we'll surprise a few
people with that...

On the other hand, Zope 3 was incredibly disruptive to our community.
False impressions as strong as promises were given, and much of what was
generally expected never became a reality. We needed to do a lot of work
to reforge the community in the aftermath of these disruptions.

Then again, Zope 3 is also serving as a unifying force to our
communities. Silva, Plone, and Zope 2 itself, have a more or less clear
direction: toward the adoption of Zope 3 technologies. This saved the
Zope community from breaking up into separate splinter groups. I think
this is a great thing. Could a project more closely allied to Zope 2, a
less disruptive project, reached the same thing? I don't know. I do
think that by being independent from Zope 2, Zope 3 could make braver
choices and helped us set a clear course.

So Zope 3 was a curse to our community, and it's a blessing. It hurt us
and reinvigorated us.

Where will the evolution end up? Can Plone or Silva ever evolve to a
purer Zope 3 base, using Five? That, after all, was also the idea behind
Five. Can we slowly reengineer our applications so in the end they run
on a pure Zope 3 core? I don't know. It remains to be seen. Certainly it
appears quite distant in the future right now. Certainly also people are
making great strides forward with every release. No matter whether we'll
reach the end goal soon, later, or perhaps never: I am convinced that
the direction we're going in, as a unified community, is a good one
overall.

Paradoxically, these days, I'm more in a revolution mood. I'm pretty
free in what I can do now. I feel I paid my dues to Zope 2. So I'm
aiming to change the world with Grok. Grok is purely Zope 3 based. It's
Pythonic. It lets go of the past. No need to worry about Zope 2 cruft
anywhere. A revolution!

But note that Grok is pretty conservative in its revolutionary plans -
Grok is Zope 3 in a different coat. Grok is not a rewrite but based on
Zope 3 technology in development since 2001. It's revolutionary for me,
as instead of combining two existing things I'm just building on one!
It's hopefully revolutionary to others as we're putting a lot of power
into the hands of many.

We will end up going full circle. People keep asking me about supporting
Grok technology in Zope 2. I think this will eventually happen; it's not
hard, and so many people are asking about it one day someone will
actually get up and do the work. Unless someone pays me a lot of money,
I'm not going to do it myself. I'll support it though! Grok needs Zope 2. Grok needs Plone. We can count on many of our best contributors to
come from those communities.

Perhaps the Zope community evolves by [punctuated
equilibrium](http://en.wikipedia.org/wiki/Punctuated_equilibrium). Long
periods of seeming stability with intermittent fast spurts of new
developments based on evolutionary innovations that took place almost in
the hidden. Or perhaps that is just another metaphor that doesn't quite
fit.

We are about 10 years into a fascinating experiment. Can Zope continue
evolve forward? Can we continue to be at the forefront of development?
Will we continue to innovate? Can we reinvent ourselves while keeping
our community whole? (and what a community! What other Python web
framework has [two](http://foundation.zope.org)
[foundations](http://plone.org/foundation) and a [business partner
network](http://www.zeapartners.org/)?) Can Zope continue to be relevant
in the future?

Yes, I believe it can, and very much so.
