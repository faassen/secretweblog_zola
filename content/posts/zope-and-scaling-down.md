+++
title = "Zope and scaling down"
date = 2005-10-08
slug = "zope-and-scaling-down"

[taxonomies]
tags = ["zope", "framework"]
+++

Ian Bicking [posts](http://blog.ianbicking.org/zope-3-and-modeling.html)
about what he percieves is a focus of Zope 3 on modeling up-front:

> Good development in the beginning means deferring choices as much as
> possible and focusing on results instead of abstractions. Abstractions
> should emerge from your functional goals, and if you spend a lot of
> time modeling in the beginning then you've made premature choices and
> designed code that you don't yet understand. You haven't just wasted
> time, you've introduced a liability.

I agree completely with this view of software development. This is how I
try to develop software, learned through quite a bit of experience, just
like Ian, I'm sure. And luckily enough, it's perfectly possible to do
such a style of iterative development on top of Zope 3. I'm not sure
what gave Ian the impression that you can't.

At Infrae we've been doing this for a few months now though, and the
application we've worked on definitely evolved, sometimes quite
drastically, in the face of customer feedback and a coming into focus of
sometimes vague requirements. Since Zope 3 tries to stay out of the way
of your Python code, you can refactor like you'd do with any piece of
Python software. In fact, I talked about just this in an older
[post](http://faassen.n--tree.net/blog/view/weblog/2005/09/06/0):

> Jeff Shell already mentioned that Zope 3 makes it easier to build an
> extensible framework while actually building something useful for a
> customer; Zope 3 gives a lot of flexibility and extensibility right
> out of the box without much effort for the application developer. This
> I think is great news for the long term maintainability and
> extensibility of Zope 3 applications.
>
> In addition, I can say that extraction of reusable code from Zope 3
> projects into reusable libraries is much, much nicer than doing it in
> Zope 2. That doesn't mean it's actually easy; writing reusable code is
> always hard, but it's now much more doable. This is one of the coolest
> things about Zope 3.
>
> \[snip\]
>
> Framework extraction from practical applications is often the best way
> to build truly useful reusable components, so Zope 3's vastly improved
> extractability of reusable components is great news.

See also [Jeff Shell's
post](http://griddlenoise.blogspot.com/2005/09/major-zope-3-client-project-finished.html).

Perhaps Ian gets the wrong idea because of Zope 3's focus on the concept
of interfaces. While interfaces are common in the Zope 3 framework
(which needs to be pluggable and flexible), Zope 3's component system
allows you to register adapters and views for classes just fine. There's
no need to start designing lots of interfaces right from the start. It's
convenient to define (and evolve) your data layout of some content
object in a schema, but I'm sure Ian as the creator of SQLObject
wouldn't object too strenuously to this.

Or perhaps Ian gets the idea indeed from my comment on hello world. I
used the word "small", but I meant _really_ small; the context was
"hello world". Zope 3 doesn't scale down well enough to tiny web
applications of the "hello world" scale; the overhead of ZCML and such
feels too big then. We need to do work there.

But as soon as there's enough code for your web app to be useful to do
_anything_, the overhead of ZCML and interfaces quickly shrinks. I'm not
saying it couldn't be improved further, but to say that Zope 3 does
big-design up-front because "hello world" is slightly more difficult
than it should be is a bit of a stretch. We're still programming in
Python, after all!
