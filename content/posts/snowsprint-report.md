+++
title = "Snowsprint report"
date = 2008-01-28
slug = "snowsprint-report"

[taxonomies]
tags = ["grok", "sprint"]
+++

This year, like last year, will be a year of
[Grok](http://grok.zope.org) for me. Grok has given me real hope that
Zope technologies can compete, and compete well, with other Python-based
web frameworks. In the Zope community, as well as outside it, we are
well aware of Zope's flaws, both technology and community-wise. We
sometimes think too little about Zope's assets, which are huge. Zope 3
is _great_ technology, years ahead of the competition in the
pluggability department, and Zope's community is well established. One
of those things in the Zope community is the yearly [Snow
Sprint](http://www.openplans.org/projects/snow-sprint-2008/project-home).
This year was the first time I attended.

The Snow Sprint is organized by [Lovely
systems](http://www.lovelysystems.com/category/home). Lovely systems is
an interesting company with very strong experience in building scalable
Zope 3 applications. The Snow Sprint is not just about Zope 3 though:
like every year, there were a lot of assorted Zope and
[Plone](http://www.plone.org) developers present. Much programming,
learning, discussing, discovering and partying took place. We were 2000
meters high up in Austria, in the middle of nowhere surrounded by
[gorgeous snow-covered
mountains](http://www.flickr.com/photos/mrtopf/tags/snowsprint2008/).
This was a bit problematic when I developed an acute toothache in the
weekend after I arrived. Ouch! _Ouch_! Luckily I was able to descend the
mountain on monday and an Austrian dentist fixed me up.

My personal mission at the Snow Sprint was to work on Grok, and
hopefully get some other people to get involved as well. Luckily it
turned out quite a few people were interested - my
[talk](http://mrtopf.de/blog/meetups/snow-sprint-2008-martijn-faassen-about-grok-technical/)
on Grok was well-attended and many people explored Grok. A bunch of
sprinters started the development of a new CMS system with some
conceptual rethinks called
[vudo](http://mrtopf.de/blog/web20/the-voodoo-interview-video/). It's
based on, among other things, Grok. What will happen with vudo remains
to be seen, but at the very least it was an interesting topic to discuss
and a good learning experience.

I saw many familiar people again at the sprint, and also met many new
people. In particular I met a few nice people from the [Open
Plans](http://www.openplans.org/) project. Whit Morris I had in fact
already met at a previous sprint in Austria (in a castle). New Open
Plans people I met were Robert Marianski, Ethan Jucovy and Jeff Hammel.
We had quite a bit of fun hanging out, and we also worked on
Grok-related tasks. Jeff focused on trying to build a
[KSS](http://kssproject.org/) driven commenting application in Grok.
Meanwhile myself, Robert and Ethan started work on
[z3c.autoinclude](https://svn.openplans.org/svn/snowsprint/z3c.autoinclude/).

z3c.autoinclude is a package that should make it easier to reuse
packages with Grok. I had noticed that reusing a Zope 3 or Grok-based
package takes mentioning this package three or four times:

- you start importing from it in your Python code
- you list it in your `setup.py`'s `install_requires`
- you need to include its ZCML using a ZCML `include` directive
- you probably need to pin down its version in buildout.cfg

This a clear [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself)
violation; we're repeating ourselves in four places! Reducing this
amount is not easy, but we could at least tackle the ZCML issue. If a
package is listed in `setup.py` has a `configure.zcml` or a `meta.zcml`,
we should be able to figure out to include this automatically from the
information in `setup.py`.

Making this work was a challenge in test-driven development. We used
`setuptools` APIs and `zc.buildout`'s `easy_install` module to set up
packages in a doctest. Robert and Ethan hadn't done very much test-first
programming yet, and several times I had to apologize for it not being
that complicated normally. Luckily we stimulated each other in not
giving up on writing the tests, and in the end we benefited from them.
We were able to refactor working bug ugly code towards a much cleaner
API in a very short time; something we wouldn't have dared without
tests.

So now, if z3c.autoinclude is installed and you use the `autoinclude`
directive in your package, you don't have to remember including ZCML
manually anymore if you already list those packages as `setup.py`
dependencies. I hope we will roll this functionality into Grok soon.

Monday, Tim Terlegård arrived on the scene. I know Tim from
[grok-dev](http://mail.zope.org/mailman/listinfo/grok-dev) but hadn't
seen him at the sprint yet. He was immediately eager to go ahead and
work on things. Tim had the great idea to finish up Grok
[viewlet](http://pypi.python.org/pypi/zope.viewlet) support, something
that Kevin Smith had worked on in the past but never got reviewed and
finished. Unfortunately on monday I was recovering from my dentistry and
toothache induced lack of sleep, so it took me to tuesday to really get
involved.

Viewlets are a system in Zope 3 that allows the very flexible inclusion
of page elements into pages based on:

- what the page is viewing (its context)
- the view itself
- the skin that view may be in
- the particular collection of viewlets we want to display (viewlet
  manager)

I always had trouble getting the concept of viewlets to stick in my
mind, not helped by the copious amounts of ZCML configuration that they
required, but I think it finally did at the last sprint.

Tim, Robert and myself started freshening up the viewlet branch and
adding tests. We also thought of ways to make configuring viewlets as
easy as possible. No more ZCML, just Python, to configure viewlets!

It took the rest of the sprint to clean things up and bring the
implementation on a solid footing. I believe the viewlet work is now
close to ready for merging and I can already see many uses for it in my
own code bases.

Along the way we refactored Grok's configuration code a bit, and I got a
few more ideas on how to make progress in this area and make Grok's
configuration system more declarative, helped by a discussion that
started on grok-dev to make sure that Grok contains as little magic as
possible.

Another notable Grok-related event happened last week, though
independently of the sprint. We opened up the new
[grok.zope.org](http://grok.zope.org)! The new grok website is based on
Plone 3. The goal was to refresh the layout, which as you can see has
succeeded, and to make it easier for people to contribute documentation
on Grok. Even before the site officially opened this flow of
contribution started to happen; Grok's documentation section is already
filled with many useful documents. I hope many more documents will be
added in the future!

A lot of people worked hard to make the new grok.zope.org a reality.
Thank you all! In particular I'd like to thank Kevin Teague who pushed
and pushed again to get the website to this point.
