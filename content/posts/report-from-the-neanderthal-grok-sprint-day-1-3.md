+++
title = "report from the Neanderthal Grok sprint (day 1-3)"
date = 2007-10-04
slug = "report-from-the-neanderthal-grok-sprint-day-1-3"

[taxonomies]
tags = ["grok", "sprint"]
+++

Hello from the fourth [Grok](http://grok.zope.org) sprint! I wanted to
write this report tuesday but didn't get around to it. The [Neanderthal
Grok sprint](http://wiki.zope.org/grok/NeanderthalerSprint) is now more
than halfway over: monday and tuesday were full sprint days. Wednesday
was our day off visiting Neanderthal itself, but we did do some more
sprinting in the evening at the hotel.

So what have we worked on so far?

- The grok.zope.org website. We've have a team working on reimplementing
  this website on top of Plone 3, so we lose the current maintenance
  bottlenecks in getting new Grok tutorials published and modified.
  We've put the contents in a Plone 3 website, using PloneHelpCenter,
  and we've also been working on integrating a layout for grok.zope.org
  into a Plone skin. Hopefully our experiences with grok.zope.org will
  also be helpful in the efforts to update the wider zope.org website,
  which we're keeping track of. Having a good web presence is really
  important for Grok so I'm thrilled with the progress we've made.
- [megrok.kss](http://svn.zope.org/megrok.kss) is
  [KSS](http://www.kssproject.org) integration for Grok. KSS makes it
  really easy to make your web pages dynamic without writing javascript.
  megrok.kss makes it really easy to use KSS with Grok. There is more
  work to do (it needs to be released, for instance), but using KSS can
  now be accomplished with very little code.
- We've made a lot of progress on the reference documentation for Grok.
  Both the content itself as well as the method to maintain and publish
  it were improved. JW, also here at the sprint, already discussed this
  extensively in [his blog
  entry](http://jw.n--tree.net/blog/dev/python/first-and-second-day-of-neanderthal-sprint)
  about the sprint.
- JW also mentions a smaller task: Grok now doesn't grok modules that
  are called 'ftests' and 'tests' by default. Generally one doesn't want
  the test setup to be grokked when running a live application, after
  all.
- Work is being done to extend and improve the Grok admin UI, in
  particular to show information about which views are available for a
  content object. Also one of our conclusions of these discussions is
  that "admin UI" is not a very good name. It's really a UI dedicated to
  serving developers while they develop a Grok-based application. We
  haven't figured out a good new name for this yet.
- [Genshi](http://genshi.edgewall.org) integration. Grok uses Zope Page
  Templates (ZPT) as its main template language. Genshi is a templating
  language quite a bit like ZPT, but with a lot of improvements and new
  ideas. We think it could be a good fit for Grok, so we're working on
  ways to it easy to use Genshi with Grok. This involves making Grok's
  templating system more pluggable and investigating how to make our
  templating use cases (include images, reuse templates, etc) work with
  Genshi.
- Some work was done to investigate making grokkers produce Zope 3
  configuration actions. This needs to be done to make it possible to
  use Grok-based code with pure Zope 3 projects (of course we can
  alreasy use all of Zope 3 with Grok, but we need to be a good Zope 3
  citizen).
- Finally, the most critically important task of the sprint: pinning
  down the versions of the packages that Grok depends on, so that when
  we release the next version of Grok, grokproject and buildouts will
  work and continue working no matter what new releases of our
  dependencies appear. We really need to make the process of installing
  Grok reliable.

As I mentioned, yesterday was our day off. We went to the nice
[Neanderthal museum](http://www.neanderthal.de/) in
[Neanderthal](http://en.wikipedia.org/wiki/Neanderthal%2C_Germany). We
had a great time. Our patient tour guide probably got an unusual amount
of observations and comments from us bunch of geeks (me...) on human
evolution. :)

We have a day and a half of sprint left at this time, which is good, as
there's lots to work on still!
