+++
title = "web frameworks considered useful"
date = 2010-04-15
slug = "web-frameworks-considered-useful"

[taxonomies]
tags = ["framework"]
+++

# web frameworks considered useful

There is a a strain of thought in the Python web development community
these days that considers web frameworks a bad idea. Even beginners are
sometimes told: why do you need a framework anyway? Just build your app
from scratch with WSGI! Or just compose your own out of existing
libraries and tools!

I'm going to argue that frameworks are useful. I'm going to argue that
we should normally not be telling beginners to avoid frameworks. And I'm
going to argue that experienced developers should carefully consider
whether their perspective isn't warped a little by their experience, and
that frameworks can be useful for them too.

## Frameworks get in your way

I want to do something that should be simple, and would be simple if I
just did it at a low level. But because the framework forces a certain
way of working on me, it becomes needlessly difficult. I have to create
workarounds, and it sucks.

Frameworks *can* get into your way, as they've made certain choices. How
much they are constraining depends on the framework, your experience
with it, and what you're trying to accomplish.

But if you picked the right framework for the job, regularly the task
you're trying to perform is something that a framework makes very easy.
The first time around you use a framework for something that it is good
at, you're going to be impressed at how easy it was to accomplish your
task. Before long however, you might become so used to the benefits that
a framework brings that you won't even *notice* what the framework is
doing for you anymore; it's now in the background. And humans are very
attuned to pain, so the pain points are going to remain. You're going to
remember the ugly workarounds better than the times when things just
worked.

I think frameworks get in the way for beginners less than they do for
experienced developers. Beginners need to learn the basics, and having a
framework can be a useful guide to gain an understanding of the basics
and how they go together. An experienced developer will understand all
that already, and is more likely to work on more challenging projects
where the choices that the framework made are not the right ones. But
does that mean that the framework is wrong for all tasks, and that we
should tell a beginner not to use them at all? And does it really mean
that experienced developers shouldn't use frameworks at all anymore,
either? What about those tasks where the pain is minimal? And what if
you are working in a group that includes beginners? And may it be that
your time is more productively spent improving the framework to make the
pain go away, instead of avoiding it entirely?

## Building from scratch feels more productive

A developer might argue to the last point: no, I am a *lot* more
productive if I build something from scratch, and list a whole range of
things they've built up in a short amount of time.

And of course building something from scratch can feel very liberating,
and sometimes it is the right way to go. But frequently you will only
*feel* more productive - if you're spending time to reimplement the
features of the framework you discarded, you might be productive in
implementing those features, but what about the task you're actually
trying to accomplish? What about the web app you're trying to build? And
how much code that only you understand will you end up trying to
maintain?

There are cases where you may *feel* a lot more productive, because
you're having more fun, when you actually aren't. We all know
programmers like to reinvent wheels. Reusing existing code may be more
painful, but it isn't necessarily less productive, although of course it
can be.

And seriously, do we really think beginners without much experience of
frameworks have enough knowledge to be able to build their web apps from
scratch and do it well?

## Don't use a framework, just reuse existing building blocks

Lots of people would agree with me that building things from scratch is
not the way to go. But, they'll argue, people can just assemble the
components they need for their application themselves, instead of using
a framework.

And it's true: there are a lot of building blocks available these days,
and that's good. There are libraries and middleware and components and
so on to do everything from interfacing with a web server to talking to
a database. Instead of picking a ready-made pre-assembled framework, you
can instead pick and choose the best of breed components that are out
there and use those to develop your application. Since you are doing it,
it may be better suited to *your* requirements than any pre-assembled
framework can offer. You'll understand it better too.

I believe there is a lot of value in this approach. The Python web
development world has been moving in this direction for a while; there's
the emphasis on WSGI, and there is the emphasis on easily distributing
and combining libraries. I'll note that the Python web *framework*
development has been moving in this direction too, because web framework
developers are also aware of the benefit of sharing useful components
with each other.

But does this mean we should recommend to everyone all the time to just
ignore frameworks and assemble the bits themselves? No.

The obvious case where this is a bad idea is in the case of beginners. A
beginner will have little understanding of how components can go
together. A beginner will have no way to evaluate components. A beginner
is usually much better off to use a pre-assembled framework where these
choices have already been made. The beginner can find information in a
one-stop shop: they'll learn about the template language and the
approach to databases of the framework in one place, and they'll see not
just descriptions of the bits and pieces but also how they go together.
This means that they won't have to do this integration themselves
anymore; they'll see examples. There's also a community where they can
ask questions.

These reasons for a beginner to use a pre-assembled framework also
frequently apply to more experienced developers. You don't always have
time to go out and assemble components together, and figure out how to
make it work. Sure, what you might end up with might be slightly better
suited to a particular task than a pre-assembled framework, but is it
really always worth the effort? Do you really want to make all those
choices each time, for each app you build? And you'll still be stuck
with the maintenance burden - the glue code you wrote of course, but
also the assembly itself: what if there are newer releases of the
components you are using?

Finally, these smaller components are often quite complex frameworks
too - and if you integrate them yourself there might be less unity of
vision than a good framework can offer, and the whole might end up
*harder* to understand.

The burden of assembling and integrating best of breed components can be
shared: that's what the developers of a framework do. And if you base
your work on a pre-assembled framework, it's likely to be less work for
you to upgrade, because the framework developers will have taken care
that the components in the framework work together in newer versions.
There is also a larger chance that people will write extensions and
documentation for the this same assembly, and that is very likely
something you may benefit from in the future.

So it often makes sense to share the assembling and integration of
components in an open source fashion just like it makes sense to share
the components themselves. An assembly is not just a collection of loose
parts, it can be a *new* thing, with a vision of it own.

## Conclusion

All the points above are true: frameworks can get into your way, using a
framework (especially when wrestling with it) can feel less productive
than building something new from scratch, and reusing components
yourself is often more flexible.

But frameworks can also take care of a lot of issues for you, even
though after a while you only feel it when they are in the way.
Frameworks make choices for you so you don't have to make them all the
time. Frameworks can save time. Frameworks offer an integrated whole so
you won't have to worry about the rest of the world for a while. Good
frameworks will also be flexible enough to handle a huge amount of tasks
more than adequately.

So, there is a place for web frameworks. It makes sense to recommend web
frameworks to beginners. It also makes sense for experienced developers
to consider using a web framework. It's not always the right tool for
the job, but it often is. By all means let's discuss the particular pain
points of frameworks, doing things without a framework and assembling
components yourself. But let's not forget the benefits that web
frameworks bring to many of us.
