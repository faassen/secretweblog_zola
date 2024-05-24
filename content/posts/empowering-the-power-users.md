+++
title = "Empowering the power users"
date = 2005-12-15
slug = "empowering-the-power-users"

[taxonomies]
tags = ["framework", "zope"]
+++

# Empowering the power users

In [my last
article](http://faassen.n--tree.net/blog/view/weblog/2005/12/15/0) I
talked about the problems that occur on the borderland between content
and software, but didn't give enough examples. I figured I'd add some
more text about this very important topic.

One response to the problem I describe is to treat this as an either/or
choice. You could say: either give someone all the power in the world,
and deal with the maintenance risk, or not give it at all. If those are
the only choices, then I'd give all the power to programmers only, and
no programming powers to end users at all.

But it's not an either/or choice. The problem occurs when you *do* want
to give non-programmers access to software development facilities, so
they can tweak and customize a system. You want to, as these power
users, *customizers*, can be very successful creating the things they
need. But you don't want to, because what they create tends to be hard
to maintain and develop further.

There's a kind of user that's not a programmer and not an end-user. This
class of user has traditionally been very important to the Zope
community, and has attracted many people to Zope. This class of user
wants to do more than an end-user, but they can create trouble, for
themselves, for the system, and for those maintaining the system.
They're application scripters, site designers, site maintainers, power
users.

I think the current Zope 2 ZMI gives this class of user too much raw
programming power. Sure, there are security restrictions, but people can
build whole web applications with the ZMI as well. Very often, these
people are not building a new application at all: they just want to
tweak a bit on top of an existing system. But then those tweaks tend to
grow in hard to maintain ways rather easily.

How to make the scripter's life easier while not making life too hard on
the programmers? There might be focused systems that can make scripters
effective. I promised examples.

Formulator. It's a simple form design system. People can develop forms
in a web interface. Empowered lots of people. Also gave me (and others
at Infrae) lots of problems as Formulator solves only half of what
people really want to do -- creating and validating the forms, but not
actually *doing* something with the form input. What people really want
to do is send an email, create a database record, or create a new
content object. If they want to do that, they suddenly have to grapple
with rather a lot of detail, and I'll among those telling them that
really if they write code, they should do it on the filesystem and check
it into a version control system. But what if there was a system that
let them do some of these tasks without exposure to software
development?

Another example is site layout and navigation tweaks. Often, when a site
is being built, or is small, it's maintained by someone who can tweak
page templates, get quite far that way, but isn't a professional
programmer. They use simple tools and tend to work through the ZMI.

Perhaps there is a better way to let power users tweak without driving
them to copy large page templates, or large amounts of page templates.
One answer to this is a limited, domain specific language: CSS. I don't
think CSS is all of the answer -- sometimes server side tweaking is
necessary. There should be a natural way for scripters to tweak things,
empowering them to do what they want, but also without giving
programmers a lot of pain if they need to maintain this eventually.

We know of other domain specific languages with less power than the full
Python but very focused to particular tasks, such as workflow
description languages.

I don't think the full answer is "just put a graphical user interface on
it and it'll be easy for the non-programmers". For a while when people
complained about the complexity of ZCML in Zope 3, it was sometimes
said, oh, we'll build a through the web UI and your life will be easy
then. But that's too easy an answer. Python Scripts have a UI in the
ZMI, but they can contain a lot of complexity. Philipp, with his article
[ZCML needs to do
less](http://www.z3lab.org/sections/blogs/philipp-weitershausen/2005_12_14_zcml-needs-to-do-less),
is thinking about the real problem.

You first need to think about what the UI needs to express before you
can design the right UI, graphical or anything. I suspect that for tasks
on the borderland between software and content, often a domain specific
language is the best UI, or at least the place to start thinking about a
graphical UI. I suspect it's often easier to design a UI for a domain
specific language than to extract a domain specific language from an
existing UI afterward. I did the latter with Formulator XML; and the
resulting language is imperfect. Domain specific languages breed
conceptual integrity better than UIs.

So what do I want to do? I want to allow people to tweak just a single
page template without introducing fragility and maintainability issues
to the whole system, without forcing them to have to *learn* about the
system's complexities. I want to look for ways to make ZCML easier. I
want to look for ways to express ZCML-like things through the web. I
want to try applying domain specific languages more. I want to
investigate simpler scripting APIs.

I can't do all of them, or even any of this, on my own, so what I'd like
most of all is for Zope community to take a step back for a bit and
consider all this from a fresh perspective, so we can avoid falling into
patterns only because we're familiar with them, not because they're
better. And of course, I'm not preaching revolution, just a
reconsideration of the ideals we'll try to evolve towards, in small
steps.
