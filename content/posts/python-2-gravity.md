+++
title = "the Gravity of Python 2"
date = 2014-01-06
slug = "python-2-gravity"

[taxonomies]
tags = ["planetpython", "python", "python3"]
+++

Recently there have been some discussions about Python 3 adoption.
Adoption rates aren't great. There are a number of theories on why
Python 3 is not adopted more and what should be done about it. I'll
expand a bit on the [analysis by Ian
Bicking](https://plus.google.com/+IanBicking/posts/iEVXdcfXkz7) and add
my own. I'll offer a few suggestions on what might help.

# The Stick

Some people blame Python 2.7. The core developers were way too nice to
us Python developers by maintaining Python 2.x. If they had dropped
support for Python 2.x years ago, Python 3 adoption would've been much
faster. I think this argument is based on counterfactuals that are very
hard to back up. I wish people would stop making these assertions, as
it's impossible to prove either way. Even if this argument could be
shown to be true, I for one am very glad that the core developers didn't
throw the existing community into the deep end.

Somehow punishing those holdouts on Python 2 so they'll move I'll call
the "stick" approach.

As Ian points out, this supposes some kind of moral authority for Python
3, or at least the progress of the Python language as a whole.

People who are using Python 2 and who don't port code are holding the
language back. We should have some sort of allegiance to Python, and why
aren't we getting off our behinds and do the work? It's not that hard!
You're holding back The Python!

This kind of moral argument may work on those who are active members of
the Python community, but it won't work those who are using Python as a
tool for a job. I'll get back to them, as they're important.

# The Default

Some people blame the Linux distributions. People new to Python
apparently don't do the research, but instead type "python" only to
discover Python 2 and then stick to it. Once Linux distros upgrade their
Python, people will start using Python 3.

I can't believe that this is a major force holding everything back. Most
Python beginners will check out python.org. Python 3 is quite widely
available - it's in my Fedora installation and I'm two releases behind.
Won't a beginner at least check out python.org? On Windows, installing
Python 3 is no problem.

A more realistic problem is that of arcane system administration
practices and obsolete Linux distributions making it harder to get
Python 3 installed. I still don't think this is in any way a dominant
factor.

# The Carrot

Other people blame Python 3. The message is that Python 3 was immature
early on, which is why people didn't adopt it, but that has changed.
It's mature now, and people should adopt it now. If only Python 3 is
made attractive enough, people will adopt it.

I think there is some truth to this. But the problem is that we've had
about five years of people claiming that Python 3 is the superior
version of Python, and it's still not commonly used.

There are other forces at work that I want to highlight here.

# Dependencies

A common theory is that people aren't moving to Python 3 because their
dependencies haven't moved to Python 3 yet.

What's a dependency? If you write code that depends on, say, the
[Reg](http://reg.readthedocs.org) library, and the Reg library only
exists for Python 2, then you have to wait for the developer of the Reg
library (me) to port to Python 3 first before you can port my own code.
Or you have to dive in and port it yourself, hopefully somehow
coordinating that with the original author.

This is the situation that holds you back from Python 3. I think this
theory has a lot of merit. The problem is widely understood, which is
why we see a lot of people urging us to port.

What seems to be widely neglected is the problem of the reverse
dependencies.

# Reverse Dependencies

I am sure that dependencies are an important factor, but what seems to
be ignored in these discussions is the issue of reverse dependencies.
Reverse dependencies have a gravity all their own.

What's a reverse dependency? If you are developing a cool new library,
and you know that this library needs to be integrated into an existing
Python 2 codebase, you need to make sure that this library works in
Python 2.

# Python 2, Python 3 or Polyglot?

There's a common response to this situation. You are writing a Python
library, and you need it to work in a Python 2 context.

Writing the library in Python 3 is now out of the question. You can't
enjoy the cleaner feel of Python 3. You can't use any of the cool new
Python 3 features.

If you feel some moral obligation to The Python, or at least want to be
cool and modern, you might consider writing *polyglot* code: code that
works in Python 2 and Python 3. You gain for this some coolness points,
potential users who use Python 3, and a harder to maintain codebase. You
gain none of the benefits of Python 3.

You can also just write Python 2 code.

Now what is the better programming language to work with? Python 3, of
course! But you can't use it. **If you have to make the choice between
Python 2 and Polyglot, Python 2 is the better programming language**. So
if you don't care about The Python, in this context you are better off
writing Python 2.

# The Gravity

Okay, forget about all those legacy codebases! If we write all our new
code at least in Polyglot, we can start more *new* projects in Python 3.

I think that this does a disservice to those old projects. They were
happy to upgrade to new Python 2.x versions, as that was doable with
little effort. They might've picked Python before Python 3 came along
and created this upgrade bump, or at least before Python 3 was mature
(whatever point in time we pick where Python 3 is considered mature).
But that's a moral argument. We have no allegiance to other people's
codebases.

**But those existing Python 2 codebases are the ones with business value
to people**. Those are the codebases with the *bosses* and *customers*
who want new functionality, not a port to a new version of Python that
involves an effort with no near-future benefits and the potential to
introduce bugs. **Those are the codebases with the money**.

Those codebases have gravity. That's the gravity of Python 2.

# Circular Dependencies

So now we have dependencies holding us back, and reverse dependencies
holding us back. Those create a circular dependency structure. We know
that those are the worst kind to deal with from a maintenance
perspective!

Our code has dependencies. More dependencies are available for Python 2
than Python 3. Those dependencies that are polyglot are more likely to
be battle tested in a Python 2 context than Python 3. Motivation not to
move to Python 3.

The gravity caused by reverse dependencies written in Python 2 then
pulls at people so that the situation remains that way. You will write
your new library in Python 2 or Polyglot, because you have to integrate
with Python 2 codebases. That is going to make *more* Python 2
dependencies available, not less.

# Passing the porting buck down the Python 2 gravity well

The gravity field of Python 2 only pulls lightly on the core developers,
who are high above us in the sky working on The Python. So after an
upgrade path (2to3) was figured out, the porting buck was passed to the
library developers.

The library developers are lower down in the gravity field, so 2to3
didn't work out so well for them. So they figured out how to write
polyglot, and to the credit of the core developers, they made
modifications in both Python 2 and Python 3 to make it easier to write
polyglot. That works okay enough for many, so more and more polyglot
libraries are appearing.

Now the porting buck is passing down the gravity field again, to those
mired in existing Python 2 codebases. The force of bosses and customers
and money is heavy. Porting is harder than for the library authors in
all that weight, not helped by the fact that most applications have much
less test coverage than libraries. What is going to happen? Are they
going to port their codebases? Are they going to be able to do so in
that gravity?

# Escape Velocity?

How do we get out of this situation?

One option is for Python 3 to reach escape velocity. Python 3 the
language becomes attractive enough, along with enough polyglot libraries
being ported, that *new* projects will be written in Python 3. As we
leave the gravity well old Python 2 codebases become just a pale blue
dot in the cosmos. A Python 2 community is left behind.

I don't think that Python 3 reaching escape velocity is exactly
*friendly* to those dealing with Python 2 every day for no fault of
their own, a "bye bye we don't care about you anymore".

Another argument against escape velocity is that this is not healthy for
our community; it would tear it apart. We're feeling some of the strains
today.

Another argument against escape velocity is that this might cut off
significant resources from the Python community. The high gravity Python
2 area that we're trying to leave behind has all the money. Is this
wise?

So should we wish for escape velocity in the first place? Is it
desirable?

# Escape Velocity cannot be reached?

It's also possible that the Python 2 gravity field is too strong,
circular dependencies will keep holding us back, and that escape
velocity cannot be reached. This means we would be in this Python 2
versus Python 3 situation forever. That would suck.

Above I listed some arguments against going for escape velocity in the
first place. What if we take those seriously?

# A Way Forward

How to go forward then? I think it makes sense to work as hard as
possible to lift those Python 2 codebases out of the gravity well.

The moral authority argument encouraging people to port their code is
not going to work down in the gravity well, though. There interest in
The Python is least; people are interested in functionality in actual
applications.

We have to make the way forward for those in the gravity well as easy
and obvious as possible. We know those codebases often don't have great
test coverage. Code is not going to become polyglot, let alone Python 3,
in one fell swoop. We can do this with libraries, but it works less well
for aplications.

The keyword here is porting *incrementally*. Port to polyglot carefully,
on a per-module basis, step by step, and write new modules in polyglot
from the start, until finally you can switch the whole thing over.

Python 2.7 helps. There are tools to help. Recently I ran into
[Future](http://python-future.org), which to me is the most attractive
approach yet. But will those tools work for those down in the gravity
well? Will they even find them? Only things easy and obvious will reach
them.

This is why I argue for more official Python 2 releases, where these
things are built in. This stuff needs to be as obvious as possible.

And to make it even more obvious, we need Python 2.x releases where the
deprecated stuff is *removed*, incrementally. Breaking code is making it
as obvious as you can get! But you don't want to break it all at once,
because then people will be inclined to give up before they even start.

This is why I think a continued future for Python 2.x would be in the
community's interest, even in The Python's interest. I created a
[\#python2.8 IRC
channel](http://blog.startifact.com/posts/python28-discussion-channel-on-freenode.html)
on freenode to gauge interest and discuss this further.
