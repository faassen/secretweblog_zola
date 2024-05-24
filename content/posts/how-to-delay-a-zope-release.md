+++
title = "How to delay a Zope release"
date = 2005-03-18
slug = "how-to-delay-a-zope-release"

[taxonomies]
tags = ["zope"]
+++

# How to delay a Zope release

Jim Fulton, today, on the Zope-3 dev list:

> Now that that the decision has been made to include Zope 3 in Zope
> 2.8, I'd really prefer that Zope 2.8 use X3.1 code, not X3.0 code. In
> general, having code shared by Zope 2 and Zope 3 will complicate
> deprecation, probably increasing the length of time we must keep
> backward-compatibility code. I'd like to try to keep the Zope 3 code
> used in Zope 2 and the Zope 3 code used in Zope 3 in sync as much as
> possible.

We've made more than just a *decision*. This week, about 5 to 10 of the
best Zope developers in the world have been gathered here in Paris. Many
of us have worked all day on Zope 2.8, and integrating Zope X3 into it.
This is a quite significant expenditure of resources.

In this week, we've heard that:

- really we should be learning zpkgtools, a system only used for Zope 3,
  so we can integrate Zope X3 into Zope 2.8
- really there needs to be a ZODB 3.4 release. The ZODB 3.3 that Zope
  2.8 is built for and revolved around is out of date.
- and now, really there needs to be a new Zope X3.1 release before we
  can do a Zope 2.8 release. Note that Stephan Richter's best guess is
  that this is done in may or june or so.

Implications:

- the Five hackers would have to adjust Five so it works with Zope X3.1.
  More dependencies on more people who may not have a lot of time.
- the work we've done this week integrating Zope X3.0 into Zope 2.8 is
  basically thrown away. We can start over with Zope X3.1.
- who knows what changes will sneak into Zope 2.8 and Zope X3.1 before
  june that will further delay matters.

There are *always* good technical reasons to delay a release. And the
longer you delay it, the more good technical reasons come up.

If it is impossible to make a Zope release by throwing this amount of
brain power at it, and this amount of time (and money; we're in business
here), I give up.

*Update*: Jim again:

> My intent is that X3.1 would be released at about the same time, as
> 2.8, so the X3.1 version of the software will be released. Of course,
> if it was in 2.8, it would be released. :)
>
> ...
>
> OK, so maybe 2.8 should not include Zope 3 at all and aim for 2.9 in
> the same timeframe as X3.1. I doubt this makes much difference because
> 2.8 is not yet ready to go out.

*Update*: A clarification by Brian Lloyd cleared up the air a lot. We're
going to stick with Zope X3.0 for Zope 2.8, which will make life a lot
easier.
