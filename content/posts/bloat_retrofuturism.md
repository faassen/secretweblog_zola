+++
title = "Bloat and Retrofuturism"
date = 2024-05-26 18:06:00
slug = "bloat-retrofuturism"
description = "Developers like to complain about bloat in software. But should we feel guilty? What do to about it? Do we need software environmentalism and a retrofuturistic approach?"

[taxonomies]
tags = ["programming"]
+++

## Everything is so bloated

Developers like to complain about bloated applications taking too many computer
resources.

Back in the olden days programmers could do amazing things with kilobytes on
extremely limited CPUs. It's
[true](https://www.youtube.com/watch?v=lC4YLMLar5I)!

I too have these thoughts on occasions. What is huge and sluggish always
changes and stretches upward. The joke was, long ago, that Emacs was an acronym
for Eight Megabytes and Constantly Swapping as 8 megabytes is too big for main
memory and would force the use of the swap partition on the hard disks. Now we
think 8 megabytes is _tiny_.

Computers have gotten incredibly powerful. They have many thousands of times
more computing resources than back in the day.

**Applications today indeed often do a lot more than applications back in the
day, but thousands of times more, probably not!**

**Code is a lot easier to write than back in the day, but thousands of times
easier, probably not!**

**We have squandered a lot of those resources.**

Software getting slower more rapidly than hardware is becoming faster has been
observed for a long time. It even has a law named after it, [Wirth's
Law](https://en.wikipedia.org/wiki/Wirth%27s_law)

## It's our fault

Related to this is that modern software uses too many layers - it's too far
from the metal. And related too is that software uses too many dependencies:
"my node_modules is 100 gigs". Our software has grown gigantic because we pile
layers upon layers.

Layers and dependencies bring us a lot of benefits. They allow use to reuse
someone else's hard work without having to reimplement it. They allow us
abstraction from hardware concerns, so our software is more multi-platform.

It allows our applications to do more than they did in the past. But not,
usually, thousands of times more.

There's a big caveat. Some of our modern applications can scale to massive
quantities of data while those applications in the olden days could not.

But still.

We complain these things are bad, yet we keep doing it. We keep creating more
software like this. We keep using software like this. How bad do we _really_
think it is, then?

And let's not just blame management here. The evil management, so convenient.
Too easy.

It's us. We do it.

## What are the problems?

What are the actual underlying problems? and economic and environmental
wastefulness, and excessive and accidental underlying complexity. There is
also a more aesthetic concern: good, efficient design can be beautiful. Let's
discuss these topics in a bit more detail.

### Wastefulness

Wastefulness is our software taking more resources than is necessary. It wastes
computing resources and energy.

To reduce wastefulness, we can use better algorithms and more efficient
languages. For organizations at a certain scale this becomes a real economic
problem, and people invest effort in this already. So I think this is at least
partially in hand as it aligns with a lot of interests.

But it's conceivable that a dramatically simpler stack could lead to far more
efficiency. I don't know whether that's true. It's worth exploring, however.

### Complexity

Why is excessive complexity a problem? Besides the wastefulness aspects, there
are educational issues, and issues of expertise.

Educationally, it makes sense to deal with a simpler system. But we can create
simplified educational sandboxes easily enough already. So while it could
certainly be beneficial if we could use production software in education about
software, it's not a huge problem overall.

It would be nice to be an expert on a larger part of a simpler stack, but I am
not sure this is a pressing concern. For all their flaws many of these layers
of abstraction are actually working fairly well for us!

It could be a pressing concern in one way however: _software security_. If we
don't understand all the layers, we may more leave serious security flaws in
the system. In general, more layers, more security risks. A simpler stack
could reduce the risks here quite a bit.

### Aesthetics

That leaves aesthetic concerns. I don't want to dismiss this; happiness
matters, plus our aethestic feelings about complexity gives us the strong
suggestion real improvements are possible. But it's also the one least
important in most real world contexts. The forces at work are mostly passion
projects and hobbies. Code as art. I love this exploration myself.

## How should we feel?

Should we feel guilty about this situation of excessive bloat? Not too much.
Perhaps a little. I only feel a little bit guilty for this situation myself.
I'm only playing a small part and there are a lot of forces around me.

I am not that interested in just complaining. It makes sense to use the
bountiful resources we have anyway to make your program just a little bit
easier to write. Complaining seems a bit too easy; you get to feel a bit
superior, perhaps?

## How to fix this?

What if we were serious about reducing complexity in real world software?
Throwing out layers on an individual basis won't work. It's difficult to do and
these layers are adopted because there are real forces that makes their
adoption seem worthwhile.

Instead, we would need to carefully analyze layers and either somehow simply a
layer significantly internally, or try to replace multiple layers with a single
simpler one that offers the same services, or at least the subset in use.
Moreover, we need to do this incrementally, and lots people need to buy
into it to have a real world effect.

## Software environmentalism

Reducing layers in real software is hard, the benefits are indirect. Lots of
people and organizations would have to work together to have a real impact.

**This is starting to sound like an environmental problem.**

It may be that at the moment the environmental problem of software complexity
isn't big enough to hurt us much. Or maybe we haven't really noticed it, and
it's there already. How much money is lost through security flaws, for
instance?

It's conceivable that at some point it hurts so much we actually start to
notice. Security is one area. Energy use is also an increasing concern.

Awareness of the costs of software bloat and complexity is a good place to
start, but individual awareness is not enough with an environmental problem.
Reducing complexity in software might require a society scale effort to solve.

## Retrofuturism?

Recently I read an interesting discussion about
[Oberon](http://projectoberon.net/), a fascinating project led by
[Wirth](https://en.wikipedia.org/wiki/Niklaus_Wirth) to simplify the software
stack back in the 1980. Oberon was ambitious: programming language, operating
system, GUI, even CPU were all in scope.

In that discussion, [@datarama@hachyderm.io](https://hachyderm.io/@datarama)
made the following [fascinating
observation](https://hachyderm.io/@datarama/112445630811540850):

> I read a while ago that perhaps the reason retrocomputing has taken off so
> much in recent years is that it takes us back to a more innocent time, when
> we could all still imagine computing as personal empowerment rather than
> bleak people-farming, dehumanization and surveillance feudalism.

> But perhaps what we should be thinking about is less retrocomputing and more
> retrofuturistic computing. What would a 2024 Oberon successor be like?

Let's think about topics like this more often. Just for fun if nothing else.

One retrofuturism topic I like to ponder about is whether you can have a modern
programming language with advanced features like static typing but implemented
in a simpler way. Is that even possible? What is essential complexity and what
is not? Could we give up features in a programming language to accomplish this?

There are many retrofuturism topics. Let's imagine alternatives!

## Conclusion

I will end my musings on software complexity for now. For me the interest is
mostly aesthetic, but my environmental sensibilities, both physical and
complexity, are slowly starting to wake up.

What do you think? Should be become software environmentalists? Should we
imagine alternative versions of the present more often, roads not taken?
