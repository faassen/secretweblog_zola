+++
title = "What is Pythonic?"
date = 2005-08-06
slug = "what-is-pythonic"

[taxonomies]
tags = ["python", "pythonic"]
+++

# What is Pythonic?

*What the heck does "pythonic" mean?*

This was a question asked a few months ago, on, of all places, the
EuroPython mailing list, which is mainly used to plan the EuroPython
conference. It was an interesting question though. I realized I've seen
the word been used a lot, but that I've hardly seen any attempts to
explain what it means. In the thread that ensued, different people,
including myself, gave their own answers. I rewrote my answer for my
weblog, as it may benefit others.

"Pythonic" is a vague concept, but not necessarily that much more vague
than concepts like "intelligence" or "life", which, when you try to
actually define them, tend to be slippery. That they're hard to define
doesn't mean that they're useless though; humans work well with messy
definitions. "Pythonic" means something like "idiomatic Python", but now
we'll need to describe what that actually means.

Over time, as the Python language evolved and the community grew, a lot
of ideas arose about how to use Python the right way. The Python
language actively encourages a large number of idioms to accomplish a
number of tasks ("the one way to do it"). In turn, new idioms that
evolved in the Python community has have in turn influenced the
evolution of the language to support them better. The introduction of
the dictionary <span class="title-ref">.get()</span> method, which
combines in one operation what would be done with a combination of
<span class="title-ref">has_key()</span> and item access before, can be
considered an example of such an evolution.

Idioms are frequently not straightforwardly portable from another
programming language. For example, the idiomatic way to perform an
operation on all items in a list in C looks like this:

    for (i=0; i < mylist_length; i++) {
       do_something(mylist[i]);
    }

The direct equivalent in Python would be this:

    i = 0
    while i < mylist_length:
       do_something(mylist[i])
       i += 1

That, however, while it works, is not considered Pythonic. It's not an
idiom the Python language encourages. We could improve it. A typical
idiom in Python to generate all numbers in a list would be to use
something like the built-in <span class="title-ref">range()</span>
function:

    for i in range(mylist_length):
       do_something(mylist[i])

This is however not Pythonic either. Here is the Pythonic way,
encouraged by the language itself:

    for element in mylist:
       do_something(element)

A frequent question on comp.lang.python involves how to pass or modify
references directly, something that is not possible in Python; there's
just assignment (and its close relatives the
<span class="title-ref">import</span>,
<span class="title-ref">class</span> and
<span class="title-ref">def</span> statements). This is undoubtedly
sometimes driven by the desire to write code that returns multiple
values from a function. The idiomatic way to do this in C and a number
of other languages is to pass to this function pointers or references:

    void foo(int* a, float* b) {
        *a = 3;
        *b = 5.5;
    }

    ...
    int alpha;
    int beta;
    foo(&alpha, &beta);

It's possible in Python to hack up strategies to pass function results
through arguments, such as like this:

    def foo(a, b):
        a[0] = 3
        b[0] = 5.5

    alpha = [0]
    beta = [0]
    foo(alpha, beta)
    alpha = alpha[0]
    beta = beta[0]

This is however considered to be screamingly unpythonic, as the
idiomatic way to return multiple values from a function is quite
different and looks much nicer. It exploits tuples and tuple unpacking:

    def foo():
        return 3, 5.5

    alpha, beta = foo()

Code that is not Pythonic tends to look odd or cumbersome to an
experienced Python programmer. It may also be overly verbose and harder
to understand, as instead of using a common, recognizable, brief idiom,
another, longer, sequence of code is used to accomplish the desired
effect. Since the language tends to support the right idioms,
non-idiomatic code frequently also executes more slowly.

To be Pythonic is to use the Python constructs and datastructures with
clean, readable idioms. It is Pythonic is to exploit dynamic typing for
instance, and it's definitely not Pythonic to introduce static-type
style verbosity into the picture where not needed. To be Pythonic is to
avoid surprising experienced Python programmers with unfamiliar ways to
accomplish a task.

The word "Pythonic" can also be applied beyond low-level idioms. For a
library or framework to be Pythonic is to make it as easy and natural as
possible for a Python programmer to pick up how to perform a task. A
library or framework, although written in Python, could be considered
unpythonic if it necessitated programmers using it to write cumbersome
or non-idiomatic Python code. Perhaps it's not using constructs Python
offers, such as classes, even though they would make the library more
convenient or easier to understand. Possibilities like being allowed to
pass functions and methods as arguments to functions might be overlooked
where they could be handy. A class defined in a library might be trying
to do its best to enforce information hiding like you have in a language
like Java, while Python more operates under the looser strategy of
'advisory locking', where attributes are typically available but the
programmer is hinted about their privacy by a leading underscore.

Of course, when you get to such a larger scale, to libraries and
frameworks, it gets more contentious whether something is Pythonic or
not. There are still some guidelines though. One is that of lesser
verbosity: APIs of Python libraries tend to be smaller and more
lightweight than those of Java libraries doing the same thing. Python
library which have a heavy-weight, overelaborate API are not considered
to be very "Pythonic". The W3C XML DOM API, for instance, which has been
implemented in Python quite a few times, is not considered to be
Pythonic. Some people think it's "Java-esque", though from what I heard
it's in fact not considered very Java-like either by many Java
programmers...

A Python-based framework can be considered Pythonic if it doesn't try to
reinvent the wheel too much where there already language idioms to
accomplish the same thing. It should also follow common Python
conventions concerning idioms.

Of course the problem is that frameworks, being frameworks, almost
*inevitably* try to introduce patterns and ways of doing things that may
not be familiar if you're used to smaller applications. That's how you
exploit the power of a framework. Zope 2, a framework I'm intimately
familiar with, is an example of a framework that definitely introduces a
lot of particular ways of doing things that you don't run into so often
elsewhere. Acquisition is an example. As a result, it's not considered
very Pythonic by many experienced Python programmers.

It's difficult to create a Pythonic framework. It isn't helped by that
the fact that the notion of what is cool, idiomatic, good Python code
has evolved quite significantly over the years. Features like
generators, sets, unicode strings and datetimes are now considered
Pythonic. Zope 2 is an example of a framework that definitely shows its
age there, and in part it cannot be blamed for it, as it was first
developed in 1997 or so. Considering that, it's holding up very well
indeed, thank you.

An example of a new trend in Pythonicness that I witnessed myself in
recent years is the movement towards standardizing idioms of package and
module structure in Python. Newer codebases like Twisted, Zope 3, and
PyPy all more or less follow this pattern:

- package and modules names are brief, lowercase, and singular
- packages are frequently namespace packages only, i.e. have empty
  \_\_init\_\_.py files.

I've also tried to follow this convention in libraries I wrote, such as
lxml.

Sometimes I think the condemnation of software as 'unpythonic' may be
somewhat unfair and may obscure other positive aspects of the software.
A less powerful framework that is easy to pick up for a Python
programmer may be considered more Pythonic than a far more powerful
system that takes more of a time investment to learn.

Finally, for another, complementary perspective on what is Pythonic
design, try the following in a python interpreter:

    import this
