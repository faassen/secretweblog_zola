+++
title = "Dear Django, please ask others about packaging!"
date = 2012-09-10
slug = "dear-django-please-ask-others-about-packaging"

[taxonomies]
tags = ["django", "packaging"]
+++

# Dear Django, please ask others about packaging!

## Introduction

Dear Django, and any human beings interested in what I have to say
too... This blog post is ostensibly about Python packaging. It's
responding to [Tarek's
post](http://blog.ziade.org/2012/09/10/dear-django-help-python-packaging/).

But I'm actually currently not that concerned about Python packaging -
it's good to see it is improving! This blog post is *really* a plea for
people to learn from others if possible, in this case about packaging.
So if you take message to heart already, you can just stop reading now
and I won't mind.

Of course my whole core spiel about learning from others could be seen
as hypocritical as I haven't bothered to learn much about distutils2 yet
and admit this below. This is because I'm not anticipating an imminent
switch to it myself, nor am I actively working on Python packaging
solutions. I do hope to learn more about NodeJS's
[npm](https://npmjs.org/) at some point, which currently confuses me but
also vaguely intrigues me...

I understand why distutils2 is there. It was high time to take a fresh
look at Python packaging. And when you do this it is useful to ignore
details for a while - you can't change everything in one big step.

I also understand why Tarek sees Django, one of Python's most popular
frameworks, as a great opportunity to help distutils2 adoption. This is
because core Django has rejected automated packaging tools until now.
That's a great opportunity for distutils2. I'm one of those people who
has talked about Django and packaging
[before](http://reinout.vanrees.org/weblog/2011/06/07/zope.html). I'm
all for Django look into adopting distutils2. Sounds like a good way
forward for Django!

I think Tarek or others could also help distutils2 adoption a *lot* by
offering interoperability features between old & smelly stuff with
distutils2. More of that please! I hope we'll get to a world soon where
I can adopt distutils2-based packages in my existing buildout-based
Python 2 stacks.

Now we're done with the preamble, and we'll get to the core of my point.

## Greybeard leans over cane and tells his tale...

Setuptools is messy and has misfeatures. But people have been doing all
kinds of advanced packaging projects on top of it for over 5 years
nonetheless, with all kinds of great incremental advances along the way,
and lots of experience gained.

So the existing, smelly, messy stack got strengths too. I really like
being able to be able (with buildout) to automatically install even very
complex development environments that some other developers have worked
on, or give mine to others. That happens quite a lot to me, and the
alternative of telling people to follow complex manual instructions
would have been quite painful.

So I get a bit frustrated when Tarek
[says](http://blog.ziade.org/2012/09/10/dear-django-help-python-packaging/):

> Some people will tell you that the new things we've built are not
> production-ready or that they don't match the features Setuptools
> provides. But ask yourself if those Setuptools features are really
> something you want or are subcultures additions from some specific
> communities.

This is because he is not countering any *specific* argument about bits
not being production ready, nor is it about particular missing features,
meaning this counterargument is, frankly, just as worthless as saying
"it's not production ready" without elaboration. It may even be somewhat
dangerous.

To ignore hard-won experience merely on the basis handwaving it away as
"subculture additions from some specific communities" is to throw out
the experience of those communities, and then you risk being condemned
to repeat some bad history, as, face it, quite a few of us subculture
folks over here (and I'm including Tarek) have *way* more experience
with Python packaging than the subculture of the Django core developers.

## Subculture grumbles

I don't know what distutils2 infrastructure can or cannot do. If I,
native of some undoubtedly backward setuptools-stack subculture, were to
evaluate it, I'd certainly look for various things.

I'd want to know whether it can pin down versions of library
dependencies somehow for my projects. My subculture finds this very
important. Are these just useless backward traditions?

I'd also definitely want some of the features of mr.developer available
to me, so I can easily check out various dependencies of a project in a
hackable form. Another one of those subcultural quirks, or worthwhile
even in modern civilization?

I'd like there a way for me to automate the installation of scripts and
applications that I can then invoke from the command-line, because I
find my subculture projects doing quite a bit of that. Perhaps this is
just ancient subculture stuff or do modern folks need that too?

If I were to build large projects, I'd probably want some features along
the lines of buildout for including non-Python code. Can we do without
such quaint notions in modern times?

Hohum, so, if you are thinking about adopting distutils2, please *do*
ask yourself what particular neat features are offered by setuptools,
buildout, pip, mr.developer, instead of saying "it's just some
subculture thing we don't care about".

Instead, I hope people will try to establish the use cases handled by
these in a distutils2 world in some shape or form. Hopefully it'll work
better with better documentation. Or at least people can reject the call
for particular features with considered opinions and solid
counterarguments.

Now I know that's probably what Tarek means himself when he says that
subculture stuff that just rubs me the wrong way:

> But ask yourself if those Setuptools features are really something you
> want or are subcultures additions from some specific communities.

Do consider feature requests carefully. Try to understand the underlying
use cases. But don't use the "subculture additions from some specific
communities" argument to handwave arguments or people away.
