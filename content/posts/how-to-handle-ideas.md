+++
title = "how to handle ideas"
date = 2011-07-15
slug = "how-to-handle-ideas"

[taxonomies]
tags = ["open source"]
+++

# how to handle ideas

Over the years I gained some experience with how open source communities
function. Sometimes these communities make it difficult for relative
outsiders (or even insiders) to make a proposal or to share an idea.

Recently I made a proposal on a mailing list of a project. It's a very
useful project, and there are fine, smart people working on it. But here
are some of the responses I got:

- no! this is wrong! (no explanation)
- your use cases can be solved in another way. Therefore our project
  automatically doesn't need to tackle them.
- actually I don't use our own project for these use cases even though I
  know many others are. Instead I use an entirely different system, and
  you should too.
- do it yourself! solving these use cases for yourself is trivial! you
  just need to write your own tools, there is no documentation on how to
  do it, and there are a lot of details you need to worry about.
  Therefore this project is not going to handle your use cases,
  everybody is on their own on this one. But really it's trivial.
  trivial, really.
- what you are proposing is immoral.

I humbly submit that this is not a very constructive set of responses.
It sounds lot like "go away". This will likely frustrate the person who
made the proposal. They can:

- go away, therefore nobody got educated and nothing was improved.
- go away and not come back with new ideas.
- show their frustration, therefore putting the people in the project on
  the defensive. This rarely leads to a good discussion either.

These were smart, well-meaning people. I got more constructive responses
too. Still, evidently it's easy for a group of such people to still give
this kind of feedback.

Let's discuss what would be better responses to someone sharing an idea.

The best response for the proposer and the people who run the project of
course would be:

- this is already solved: here's the solution

Sounds great, right? And it is, if it's true.

Unfortunately the desire to give this response on the part of the
project tempts people to say this when it isn't exactly true. It's
tempting to present "do it yourself" as "it's already solved". So the
"here's the solution" part is important.

There's another good response for the proposer:

- hey, that's a good idea! let's work together to implement it!

This is less good for the people who run the project, as now they need
to do work. Still, if this is a good idea, it'll be good for everybody,
so nobody will really be complaining about this: they're in a community
to get things solved together, after all. And in the best case scenario
the proposer will actually join the project and help out.

But of course an idea is not always obviously a good idea. Perhaps the
idea needs some tweaking. Perhaps the motivations behind the idea need
to be better understood. So another great response to a proposal would
be:

- hm, I'm not sure about this. let's analyze your use cases in some more
  detail.

So now the people in the project start asking questions, give
suggestions, consider solution strategies. The idea will likely change
in shape as things become more clear. The project, and the person making
the proposal, may end up with new features and at the very least the
project will have learned something. Incidentally this is *also* a great
way to draw newcomers into a project.

Sometimes however a project will have to say no. If it's immediately
obvious why no, this generally means this discussion has come up in the
past. Perhaps it's time to document the decision on this in the project
documentation? Then the project can point newcomers to the
documentation. Perhaps they'll read the documentation before they even
arrive on your mailing list. Or perhaps, just maybe, if this idea keeps
coming up, is there something to it after all?

Here are some good ways to reject an idea:

- our project is not actually about fulfilling these use cases. Here are
  the project's goals, and here's why your idea won't fit.
- solving this might fit our project's goals, but would increase our
  maintenance burden to levels not acceptable to the project, and here's
  why. We weigh this against how common the use case really is.

If you handle newcomers and new ideas well, your project stands a better
chance at growing, or at least remaining viable over time as people
leave and new people come in.

Perhaps eventually your project will be so successful there will be
masses of ill-formulated ideas that your project just can't handle. Then
it's time to start coming up with other strategies to deal with the
situation. Generally these would involve some form of layering or
partitioning in the project, so that not everybody is swamped by
everything all the time. Most projects aren't there yet, though, and
even many successful projects will never grow to this size.
