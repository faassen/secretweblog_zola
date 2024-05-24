+++
title = "What Zope can learn from Ruby on Rails"
date = 2005-04-06
slug = "what-zope-can-learn-from-ruby-on-rails"

[taxonomies]
tags = ["zope"]
+++

Ian Bicking just posted an [insightful
analysis](http://blog.ianbicking.org/what-really-makes-rails-work.html)
of what makes Ruby on Rails work. What struck me most was the following:

> Zope is also unique among web frameworks, and maybe even among Python
> projects, in that it's something where people choose Zope first, then
> Python comes along. With most other projects a developer chooses
> Python then finds a project in Python. As a result, Zope users are
> selected not for an aspect of the implementation -- Python -- but
> because they are specifically attracted to Zope and all its metaphors
> and design decisions.
>
> This is what Ruby on Rails has. People are selecting Rails, and it
> just happens to be written in Ruby. This seems weird, because it's a
> developer framework and intimately tied to the language, but it's
> clearly what's happening. So as a result, the Rails community isn't
> going to fork as developers get frustrated with the specific metaphors
> it chooses. They are choosing the framework, not the implementation.
> In contrast Python web programmers have been choosing implementations,
> then seeing if they can accept the framework (and forking when they
> can't).

Zope has indeed mostly been picked historically for the platform and
what is offers, instead of for the language it is implemented in. I
think in many cases the decision to go with Zope was not a very
technical decision, but more one based on community, visibility, and
user-level features.

Zope has a user interface, for instance, and while it looks somewhat old
fashioned now, this has been a feature that helped tremendously to sell
it to non Python-programmer decision makers. Zope being backed by a
company has also been important. Zope being extensible with all kinds of
components (Products) that offer to add new functionality in a 'building
block' way is also something that looks attractive. The ease of creating
dynamic web pages using the web user interface also helped first
impressions a lot; the amount of stuff you could do with a few simple
(then) DTML pages impressed people _a lot_ (and then the bad part of the
Zope learning curve kicks in, but that's after the decision to adopt
Zope has been made). That Zope is implemented in Python doesn't play a
role for many decision makers at all.

Something that Ian doesn't say explicitly but that I think is very
important in adoption patterns by the wider community is one of
presentation. Ruby-on-Rails presents itself well. We (the Zope
community) can learn from this. Just compare their website:

<http://www.rubyonrails.com/>

to the Zope one, for instance:

<http://www.zope.org/>

Zope's presentation is dull in comparison. Almost no images, and no
hype.

Zope 3's web presence is even worse:

<http://www.zope.org/DevHome/Wikis/DevSite/Projects/ComponentArchitecture/FrontPage>

while zope.org is dull, Zope 3's presentation to the wider community
positively sucks. Nobody is going to convinced to use Zope 3 by looking
at that set of web pages. I know that wiki is not targeted to the wider
community at all, but it's the only thing there is, besides the Zope 3
base, which does look somewhat more appealing:

<http://codespeak.net/z3>

Plone, in constrast, does this a lot better:

<http://plone.org/>

I do not think it is a coincidence that Plone does presentation well and
that Plone took off as it did.

Zope is currently in a phase of transition from Zope 2 to Zope 3. It's
fairly well understood in the community that Zope 3 has desirable
technical merits; we do not need to convince Zope users of this. We do
need to convince other Python programmers of this, but it's clear from
Ian's analysis that this is an uphill battle.

If we want Zope 3 to be popular, what we need to do is learn the lesson
of Plone, learn the lesson of Ruby on Rails, and do presentation well,
and attract new people, from outside the immediate Python community, to
Zope. It's likely we need other people for this than the Zope 3 core
hackers. I'm not ideal either (just look at the 'design' of this blog),
though I can help writing text. How to find the people who are good at
this? I don't know, but if we run into some let's give them all the
support they need.

Technical excellence and quality are important, but for this to be
useful, we also need a community, and to gain a community, marketing can
help a lot. So, let's think a bit about _buzz_, _hype_, and _pretty
pictures_.
