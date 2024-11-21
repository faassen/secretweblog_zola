+++
title = "Question Best Practices"
date = 2024-11-19
slug = "question-best-practices"

[taxonomies]
tags = ["programming"]

[extra]
mastodon_comment_id = 113510467830359479

+++


> In software development we have *best practices*. These are the distilled
> wisdom of software engineering, and you should follow best practices to be a
> good software developer, and to develop good software. If someone points
> out you broke them, that should be sufficient to make you mend your ways.

This is what the term "best practices" implies to me [^1]. There are different,
more subtle interpretations, but I think this interpretation is a reasonable
one and in actual usage. Let's go into its problems.

<!-- more -->

## What are "best practices"?

I'm going to give some examples of things people consider best practices:

* avoid global variables

* don't repeat yourself (DRY)

* for modularity in an enterprise application, use web services

* make code changes as a PR that gets reviewed

We're talking a wide variety of practices here. **They are supposed to apply in
any context, having proven themselves in each one of them.**

## "This is (not) best practice"

When is this argument employed? I think these arguments come up
under two circumstances:

* A group of peers is discussing the way forward.

* A more experienced developer is guiding a less experienced developer.

## Discussion among peers

Let's focus on the former, a discussion by peers, first. There is a debate
about the best way forward. This debate is taking place in a very specific
context. But "this is (not) best practice" throws all that context overboard,
and is an appeal to an external authority.

It comes across as a rhetorical power move, and not productive to a fruitful
discussion. **Presumably peers know about these best practices too, and want to
make a different choice. This is a signal that discussion is required.**

That's not to say the practices labeled "best" are useless. They're often great
guidelines and useful defaults. They should function as intuitive warning
bells. If you are about to deviate from one, you better stop and think for a
moment and consider the tradeoffs in your context. Do the benefits of, say,
using a global, outweigh the drawbacks?

So you can say "but a common good practice is that we do X, why do you propose
we deviate from this here?" But that's very different from "this is the best
practice, so we do this".

Maybe you want to avoid a long bikeshed discussion; maybe you think your peers
are investing time in choices that they shouldn't be worrying about as they
don't matter. And that can totally happen! **You can't be questioning everything
all the time. But that's a particular dysfuction you cannot fix by an appeal to
external authority. Try leadership instead.**

## Teaching

So you're dealing with someone who is far less experienced, and you're teaching
them. They're about to do something wrong and you want to teach them that they
should do something different. **How useful is "This is not best practice?" in
this context? I think it's not very useful unless you also explain why the
practice exists, and why in this context it would not be wise to do it. That's
much more difficult to do, but that's how you teach.**

I can however see the value of giving people a bunch of good guidelines as
guardrails without fully explaining to them why they exist, because they don't
understand enough yet to make sound judgments. 

I myself am honest to a fault and have been known to "writing tests is great,
but there are specific circumstances where they are more trouble than they're
worth", but whether that makes me a better teacher I am not sure about. Maybe I
risk confusing people.

## Best

Let's look at the word "best". This implies that there is no superior practice.
Since no context is supplied, it's implied to be best in all contexts, or at
least best in the current implicit, unstated context. People usually leave the
context out in best practice arguments.

**"best" implies some sort of context neutral best option. Does that exist?
Probably not.** These practices are at least supposed to be relatively context
independent, but they're not entirely so.

Practices leading to improved processes and people are more likely to be
generally applicable independent of context than things we do in code. Things
like ["get enough
sleep"](https://increment.com/teams/the-epistemology-of-software-quality/) or
"fix the system rather than blame the individual".

While these ought be pretty uncontroversial (though in cultures where the grind
is elevated as holiness, and the goal is to outperform others, they are), other
best practices are a lot less "best" still.

## Questioning best practices

Earlier I mentioned the use of web services for modularity as a best practice,
and you may have thought "but wait a minute!". The pendulum has been swinging
back on this "best practice" for a while now. We have much easier to manage
ways to do modularity than whole process separation and HTTP serialization,
such as functions, objects and libraries. Yet I've experienced moments where
these well-honed, more efficient tools seemed to be forgotten in favor of web
services. 

I think web services should be the last resort if you really need to delegate
responsibility or scale separately. How come in some subcultures they became
elevated to this point? A game of telephone perhaps, using something that made
sense at scale in inappropriate contexts? That, and [Conway's
Law](https://en.wikipedia.org/wiki/Conway's_law) rearing its ugly head.

## Questioning PR reviews

Let's now be a bit more controversial and question a best practice less
frequently questioned.

Long ago, in a time before Git when Subversion ruled the waves,
I was in a discussion where it was proposed committing to trunk (main) should
be severely restricted to just a few developers, and all work should take place
on branches. This was before PRs were even a thing. 

The argument given was that this is what Google did, and it would help prevent
mistakes. I argued Google is a vast tech company with a huge amount of developers
working on web scale software, where this was a small organization with 5 to 10
developers which wasn't even primarily a development shop.

It made no sense to me - the context was completely different, and supporting
this way of working was going to be very hard.

Today this approach makes sense to a lot more people, as the tooling to support
it is ubiquitous. PRs with peer reviews rule the land. But does it *really*
make sense to use PRs with peer review under all circumstances?

There is one obvious exception: if you're the only developer in a project, PR
reviews make no sense. It's still a good practice to review your own changes,
but there are no peers to approve your changes. And it's totally possible
for a single developer to develop high quality software this way.

This should lead us to think. Is it really the best way to develop software in
all other circumstances too, then? **Are PRs as useful in a co-located small team
of 3 developers as they are with a massively distributed open source project?**
[Maybe not](https://www.youtube.com/watch?v=fYFruezJED). I think this too is a
trend that descended from a different context, in this case from large open
source projects and giant tech companies, that was elevated into a context-free
best practice.

## The psychology

So stuff gets badly communicated, and badly absorbed, and through this game of
telephone a practice can become "best" even though it's clearly not in many
contexts. But that's not the only driver behind this phenomenon.

Why do people use best practice arguments to kill discussions rather than as
didactic tools or intuitive warning bells? 

I once got a comment saying you shouldn't write your own frameworks because the
big open source ones out there are already distillations of the wisdom of the
crowds, and you couldn't possibly compete with those. Everything has already
been invented; no improvement is possible. That feels certain. It feels safe.

**"Best practice" arguments can be a coping mechanism against uncertainty, a lack
of control, and at worst a cudgel for ego. [^2] Rule one of critical thinking is
to be aware of your own biases and weaknesses. As software developers we should
be critical thinkers.** 

Why are these labeled "best" rather than "good" anyway? This prevents
learning or change for the better. "best" is a mind killer.

## Conclusion

"Best practices" (or rather "good practices") can be useful as intuitive guard
rails and educationally. But don't elevate trends into dogma, and don't use
best practices as an argument or mind killer.

It's hard to express your intituitions. It's difficult to find evidence for
software development practices. There is a lot of uncertainty. Often we get
this stuff from culture, tradition or someone who sounds convincing. There is
value in this, but I would rather have the option to examine that value
carefully.

**A good practice, as a human being as much as a software developer, is to stop
once every while, and step back, and think: "isn't there a better way?"**

[^1]:

The immediate trigger for this post is [this post by Martin
Tournoij](https://www.arp242.net/best-practices.html). It makes some of my
points much more succinctly and bluntly than I did. I'll note that many of the
"best practices" he mentions he still considers good practices but argues for
moderation in their application, depending on the circumstances: context
matters.

[^2]:

Thanks in particular to Cat Hicks and Paul Cantrell [for an interesting
discussion about this on
Mastodon](https://mastodon.social/@grimalkina/112893203958840996). All mistakes
and misinterpretations are my own.


