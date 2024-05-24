+++
title = "Back to the Center"
date = 2013-12-17
slug = "back-to-the-center"

[taxonomies]
tags = ["zope", "python", "planetpython", "grok"]
+++

Grok the web framework was simple enough on its surface, but like an
iceberg, beneath its simple surface lurked a vast codebase. This made it
harder to understand Grok. We also were depending on a lot of code Grok
was in fact *not using*. That unused code was still being loaded,
distracting, and even at one point interacting with Grok to generate a
security bug.

To simplify Grok we had to lose that code. This meant we couldn't go
around the center of the Zope project anymore. We had to go back to the
center.

# Unused UI Code

When the new Zope was built, we thought we were going to create
something like the old Zope, where management and even development of
web applications could be done using a through-the-web UI. The new Zope
therefore consisted of two parts: a selection of libraries that could be
used as a web framework (or the plumbing of one, in the case of Grok),
and a selection of libraries built on top of that which implemented the
web UI and its content.

The old Zope and Grok had started to use the new Zope as a collection
libraries, but had no need for the user interface bits.

Why did we have to include the UI code if we didn't want it? Because the
Zope libraries were all tangled up. To shift the metaphor from icebergs,
they were like a ball of wool after a cat's done playing with it: all
tangled up.

# The New Zope as Libraries

The new Zope had originally been developed as a collection of libraries
all in the same repository, in a giant tree of packages. Dependencies
between parts of the tree had been rather freely introduced.

Then, around 2006, we became early adopters of setuptools, and split up
these libraries into a collection of independent libraries, and
published them on PyPI. We learned a lot along the way on how to do
proper releases and how to manage such collections of libraries.

But now we had a collection of supposedly independent libraries with a
large amount of dependencies to each other. What was worse, we had
*circular* dependencies. This meant that just about all libraries were
linked to all other libraries. Grab one Zope library off PyPI, get all
of them. All 80 or so...

As Chris McDonough pointed out later, what we *should* have done is
extract the libraries one by one, and for each give a clear purpose and
documentation.

But it was too late. And at least the problem was clear now.

# The Cave Sprint

So the beginning of 2009 I organized a [small
sprint](http://blog.startifact.com/posts/older/cleaning-up-zope-3-s-dependencies.html).
We'd just moved house and now had the room for it. I'm now in two minds
about this sprint: while we did manage to make a good first step in
cleaning up dependencies, it was also the beginning of the end of my
involvement in Zope. Plus cleaning up dependencies is not a very
rewarding creatively, and I think sprints should inspire as well as get
work done.

During this sprint we had a discussion about the Zope project itself.
The original leader of the Zope project, Jim Fulton, had slowly become
less involved with it, and there was a gap that needed to be filled if
we wanted to drive Zope forward. It had become difficult to make
decisions.

Christian Theune and Wolfgang Schnerring convinced me we should engage
the Zope project more actively instead of working around it with Grok. I
was convinced, as I knew that the problem of simplifying the code base
needed engagement with the Zope project.

# Steering Zope

So after the sprint some of us organized a Zope Steering Group, and set
up a lightweight system for technical decision making so we could
hopefully move Zope forward. I think it did help.

The Zope community reformulated the new Zope as a Zope Toolkit,
recognizing its status as the foundation of projects like Zope 2 and
Grok. We rebranded the new Zope away from the confusingly named Zope 3,
which for years had implied that the new Zope was going to be a true
successor to the old Zope, something that it never quite became but
confused people. On the technical level at the end of the year we were
able to disconnect the UI-related packages from the rest, and had left a
directed acyclic graph of foundational packages, without circular
dependencies.

My hope was also that new leadership could infuse new energy in the Zope
project beyond just maintenance tasks like cleaning up dependencies. The
web was evolving, and could we get together and do exciting new things
again? The answer was no, but that will have to wait for the next
article in this series.

This blog entry is a part of a [series on
Zope](http://blog.startifact.com/posts/my-exit-from-zope.html) and my
involvement with it.
[Previous](http://blog.startifact.com/posts/implementing-grok.html).
[Next](http://blog.startifact.com/posts/the-centre-cannot-hold.html).
