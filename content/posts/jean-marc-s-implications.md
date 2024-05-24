+++
title = "Jean-Marc's implications"
date = 2006-09-24
slug = "jean-marc-s-implications"

[taxonomies]
tags = ["zope"]
+++

# Jean-Marc's implications

Jean-Marc Orliaguet is rewriting CPSSkins again, this time in Java, as
Nuxeo is [switching their CPS platform from Python and Zope to the Java
language](http://www.nuxeo.com/en/java-switch) . The reasons for this
switch are detailed in the FAQ. I'm not going to debate them here.

Jean-Marc, part of the community around Nuxeo making the switch, now
posted [some interesting criticisms of Zope and the Zope
community](http://www.z3lab.org/sections/blogs/jean-marc-orliaguet/2006_09_23_times-they-changin).
I am compelled to give a response from the perspective from the Zope
community. If it's all a bit long and ranty, please forgive me.

I'm going to quote Jean-Marc copiously here. Let's start:

*"You probably read the news the other day. There have been very few
reactions so far apart from Phillip reporting the news and Paul making
an allusion to it."*

Jean-Marc, the news means Nuxeo's exiting our Zope community. I
sincerely regret Nuxeo's leaving, as they contributed a lot. It's a
major loss and we're mourning it. We're a diverse lot, so we don't have
a single reaction. Possibly many of us feel that too much reaction would
result in an argument about how wrong the other side is, as we're not
joining you in the switch to Java for our own Zope-based platforms, and
you're not going to be convinced to switch back either. So, there's not
all that much to say overall, except to wish you luck.

I'm sure Jean-Marc's motivations in posting the criticisms are a genuine
attempt to help us improve our Zope community. Thank you, Jean-Marc,
that's valuable. I do however admit frankly that I'm a bit bothered by
some of Jean-Marc's implications. I realize that it makes sense
psychologically to defend the choice you've made, much like it makes
sense for me to defend Zope and Python in the face of criticism.

Overall I think my answers give me the impression that Zope 3 isn't
doing so badly, even from a Java perspective. :)

He starts by saying: "For Zope, what can be learned from the Java
technologies?" and then lists some points. I'll repeat his points and
give a response for each.

## The Importance of the IDE

IDEs can indeed be very helpful. It's a general issue with Python that
IDEs are not as powerful and well-developed as those in the Java world.
Tools can compensate for the deficiencies in a language, and languages
can compensate for the deficiencies of tools.

For a lot more about this, there is [an insightful
article](http://osteele.com/archives/2004/11/ides) about the psychology
behind all this. I'm a "language maven" myself, but I recognize that
other people are "tool mavens". More power to them, but I'm doing fine
myself, thank you.

Again as a language maven, I don't think we as the Zope community should
make an IDE a priority, as we only have so many resources to go with.
Since this is an open source community anyone can step up and try to
implement one, though.

## The Importance of stable APIs

Jean-Marc says:

*"The bottom-line is that there is only one chance for a developer to
get the API right, because other developers expect it to be stable and
easy to extend."*

I can't get an API right the first time unless I have a *lot* of
experience with the problem at hand, meaning having gotten the API wrong
already a number of times. That appears to be true at first sight for
Jean-Marc too; I'm sure it's easier to get the API right for CPSSkins
the third time around.

Stable APIs are, of course, important. That's one reason why in the Zope
community we've adopted explicit interface descriptions heavily, and
test everything to heck just so we know we're not accidentally breaking
something.

Concerning getting things right the first time in the Java community:
the Java community understands refactoring well though. The IDEs have
built-in support.

Jean-Marc:

*"And no, the deprecation feature is not a tool available to developers
for doing cosmetic refactoring or for renaming packages."*

This point is not backed up by argumentation. I'm a big believer in
iterative development as I know I'm not smart enough to get things right
the first time. Instead of living with a mistake forever, I think it's
often more effective to correct the mistake when possible, instead of
living with it forever.

Instead of just breaking people's code when we change things, we make
the commitment to support the old code for a significant period while
issuing deprecation warnings.

It's somewhat ironic that Jean-Marc's point is stated in the context of
the Nuxeo switch away from Python to Java - I imagine that will break a
few APIs in CPS here and there as people move over to the new
platform... Of course, Nuxeo uses the same reason I did just now: it's
better to change from Python to Java now by API breakage than it is
living with it forever.

## The importance of standards

Yes, following established specifications is often a good idea, so I (as
a member of the Zope community) have often argued it's useful to follow
specifications. In fact, I wrote a [whole
article](http://faassen.n--tree.net/blog/view/weblog/2005/3/1/0) about
how to evaluate them. Note that not all specifications are equally
valuable. Sometimes they're inappropriate for the job. Sometimes they're
too heavy and more light-weight processes are in order.

*"Lots of packages are being added in the Zope3 repository without
proper reviewing, implying: "we find this useful, hence someone else may
find it useful too". This is relatively harmless for utility packages
that have a limited scope, but for framework foundation modules this is
a problem."*

Jean-Marc, you're implying we're adding new framework foundation modules
to Zope 3 without proper reviewing. I don't think that's happening.
We've added *non-framework packages* to the Zope 3 *software
repository*. That doesn't mean they're core and that doesn't mean you
have to use them.

Before I start using a piece of open source software I evaluate how
mature it is, whether it has developers backing it up, and so on. This
is a fact of life in the open source community (or for any software
developer, really). If I were just focused on standards I might use
PyXML, as it supports DOM. I then realize PyXML is not very actively
developed anymore, and that it tends to suck to work with the DOM API in
Python, so I might switch to lxml or Amara.

We've had extensive discussions in the Zope 3 community on how to
formalize the process of component maturation and mark packages as more
or less stable and more or less supported more explicitly, and we'll
continue taking steps in that direction.

It's important to realize that people learn, though. Software components
that are perfectly good at some stage may still be replaced by better
ones later. This process of evolution is healthy.

*"But having 3 or 4 different specifications of a same basic feature
because they were hurried in simply means a lack of concertation."*

Sure. Are you implying we're hurrying in features a lot? Are you
implying we regularly have 3 or 4 different specifications of same basic
features in Zope 3? Are you implying that such a thing never happens
with Java software?

Concerning package naming convention, I don't think we're doing too
badly. Zope uses namespace packages extensively.

*"Otherwise as a developer I may well start using a zope.abc package to
learn 3 months later that the package was just the result of an
experiment, and that it will be replaced by a "better" implementation."*

I'm missing something here. Are you implying we just dump everything
into the 'zope' namespace package? We clearly do not. Zope Corporation
uses 'zc' for its package namespace. I've been using 'hurry'. We also
got 'lovely' for Lovely Systems packages, and 'z3c' for packages managed
by the communit, and so on.

'zope' is used for core packages, though admittedly we do have some
non-Zope core packages sitting around - a situation we want to resolve.
I'm not saying our situation is perfect, but I think we struck the
balance between too cumbersome and too lightweight pretty well overall.

## The Design Patterns

*"There are no such things as adapters, factories, utilities, events in
the Java language, these are just design patterns."*

The implication here is that these things are all available in the
Python language, but I think Jean-Marc here is comparing the Java
language with the Zope 3 component architecture here. Perhaps it
would've made more sense to compare Zope 3's component architecture with
some component model in Java, such as J2EE or whatnot. Perhaps that
makes no sense - I don't know much about J2EE.

Indeed:

- adapters are not in the Python language. Adapters can be easily
  implemented as a design pattern. In Zope, there's no adapter base
  class either. What the Zope 3 component architecture adds is adapter
  registration and lookup, not adapters themselves. Those are just
  simple classes.
- factories are a basic concept in the Python language. It's something
  that can be called and returns an object. It's easy to implement a
  factory in Python: you just define a class. It's also easy to switch
  from classes to custom functions when necessary, without changing the
  calling location. Java, using the 'new' keyword, does not have this
  benefit and the calling location will need to be changed if a factory
  function is used instead.
- utilities are a Zope 3 component architecture concept, and not a
  Python language concept. You can see it as context-dependent module
  import by interface. Again the implementation of the utility is free -
  Zope 3 just offers a way to register them and look them up. It's a
  design pattern supported by the framework. We noticed it was useful as
  we've been doing a lot of this stuff in Zope 2 (CMF tools, for
  instance).
- events: frameworks written in the Java language, such as user
  interface toolkits, use events. Zope 3 has an event system too. It
  helps you implement the design pattern where you want to decouple the
  caller from the callee and such.

*"In other words, in some cases using the Adapter pattern may be a good
idea while in other cases, it may be a bad idea. One cannot know the
solution until the problem to be solved has been described."*

Indeed, sometimes the adapter pattern is not a good idea, and sometimes
it is. You seem to be implying that we think it's always a good idea and
that we think we can know the solution to a problem before it is has
been described.

Sometimes it's nice to have a registry of adapters so you can find the
right one automatically. The latter is what Zope's component
architecture offers and it makes it more easy to devise APIs with plugin
points.

*"My impression is that the 4 basic patterns promoted in the zope3
architecture as the "new religion" are predefined solutions to problems
that are yet to be identified."*

Let me hereby correct your impression, as it doesn't appear to be
correct. Zope 3's component architecture provides useful facilities for
looking up adapters and utilities, yes. It's not a religion and I
personally encourage everybody to write plain Python where possible.

We've also been doing this Zope thing for some years and indeed have
identified several problems in architecture we keep running into and
that we'd like to have some assistance with. Hence the component
architecture.

*"Conclusion: the Component Architecture is not a universal solution for
particular problems."*

You seem to be implying we think it is. No, it's a bit more subtle than
that, just like Design Patterns.

It's interesting to contrast, by the way, how first you recommend
specifications as a way to get APIs right the first time around, and now
you argue against solving solving problems that are yet to be
identified.

## The Component Architecture

Jean-Marc argues that hooking up small dedicated components is overhead.
He then says that small dedicated components are the wrong appproach. I
agree that hooking up small dedicated components is overhead, and
reducing this overhead is something that I'm personally interested in
tackling (sprint in about 3 weeks coming up). I disagree that this means
small components are the wrong approach. I do agree that it is useful
for us to study plugin-architectures in other systems.

I'll note that Java-based frameworks are not generally well known for
having low developer overhead for hooking things up. One of the reasons
of the success of Ruby on Rails is that it is a reaction to the overhead
of getting things set up in Java. This therefore appears to be a
criticism we possibly share with the Java world, not necessarily
something to *learn* from the Java world.

*"Conclusion: the Component Architecture does not replace high-level API
design"*

You seem to be implying that someone thinks it does. We don't. We think
that it *helps* in API design, as it gives you tools enabling you to
write pluggable APIs, such as interface-based lookup of adapters and
utilities.

## ZCML is not XML

The title of this point is rather odd. ZCML is of course valid XML. If
you run it through an XML parser and you get an error, then that's a
bug, please report it to us.

Anyway, the general point is that we should reduce the amount of XML for
component configuration. I agree with this point.

I'll note again that Java-based frameworks are not generally well known
for having low developer overhead for hooking things up. That doesn't
make this criticism less valid, though.

## The Presentation Layer

Jean-Marc knows a lot more about this than I do, and I'm sure there are
useful things to learn from various Java-based frameworks here. Thanks
for the pointers!

## The "pythonic" trip

*"What is "pythonic" what is not? but who cares basically as long as you
have a good API and a great framework? Really, it is better to spend
energy on more important things."*

You seem to be implying we spend a lot of time arguing about some
mystical quantity called Pythonic, being on some "trip" so to speak, but
you know that's not what we do most of the time. Besides, for a system
to be Pythonic *means* that system has a good API, following the
conventions of the Python language and community.
[Here](http://faassen.n--tree.net/blog/view/weblog/2005/08/06/0) is what
I had to say about this, when I stopped for a change and *did* discuss
it.

## Balkanization

*"The balkanization of the Python community is a real issue I think."*

Indeed. As you might know I've been
[arguing](http://lists.nuxeo.com/pipermail/z3lab/2005-May/000020.html)
for the Zope community to engage positively other areas of the Python
community (and beyond) for a long time. So, good criticism, and one
we've been aware of for a while. Zope 3 is in part one reaction to the
criticism from the Python community on Zope 2, for instance - we've been
developing that since 2001.

I believe there's strength in our diversity, but I also believe there's
a lot to benefit from working together. Recent developments help ease
the sharing of components between communities through the egg
distribution mechanism, so I'm very hopeful we're on the right track.

But this is perhaps not so good a criticism in the context of learning
from Java. From a distance I have the feeling that the Java community
hasn't entirely solved the issue of balkanization just yet either. There
appear to be multiple competing web frameworks for instance, Eclipse and
NetBeans for IDEs, multiple UI toolkits, and so on.

## Self-criticism

I'm going to quote this section entirely, as this one really upset me on
a personal level:

*"Self-criticism is about being able to see what others did and admit
when it is the case that they did some things better; especially taking
a look at JEE, JBoss, Eclipse, or Ruby-On-Rails, Turbogears, Django,
etc.*

*JBoss Seam for instance was created as a Java response to the
Ruby-on-Rails' success.*

*What has the Zope Community's response been to RoR?*

- *"that's just because they have a better web site"*
- *"that's just hot air and marketing, all that we need is a better web
  site"*

*Maybe it is time for constructive self-criticism?"*

Come *on*, Jean-Marc. You imply here, no, outright say, that we do not
engage in constructive self-criticism, while nothing could be further
from the truth. I, along with many others in the Zope community, fully
admit other communities have done things better than Zope, *including*
the Java community, and I personally have been working on these issues
where I can.

While I dislike what you've been saying by implication so far, at least
most of them are points that can be honestly debated, but this one I
think is just completely unfair. Constructive self-criticism is taking
place continuously in the Zope community. I know, as I've been engaged
in it for a long time now, as you should well know.

You also mischaracterize our position concerning a web site. I do
believe we need a better web site for Zope and better marketing towards
developers in general. I think that's *one* lesson we can learn from
Ruby on Rails and friends. Do you disagree?

You imply we believe that's the *only* thing other platforms have going
for it. I feel offended by the implication that you think we do, and
that we're so blind we don't even *look*. We do.

Jean-Marc, you appear to be saying a lot by implication. It's not my
preferred style of criticism.
