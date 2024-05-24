+++
title = "Cassandra and how PyPy could help with Python 3"
date = 2012-03-10
slug = "cassandra-and-how-pypy-could-help-with-python-3"

[taxonomies]
tags = ["python3", "python"]
+++

It's probably something everything has experienced in one way or
another, but I now know a little what Cassandra felt like. No, not the
[Cassandra database](https://en.wikipedia.org/wiki/Apache_Cassandra) but
the original [Cassandra](https://en.wikipedia.org/wiki/Cassandra) of
Troy. Recently, [Aaron
Swartz](https://en.wikipedia.org/wiki/Aaron_Swartz) posted [this blog
entry](http://www.aaronsw.com/weblog/python3) about Python 3. In it he
proposes a Python runtime that can run both Python 2 and Python 3 at the
same time, to help cross the chasm that exists between Python 2 and
Python 3.

This is something I remember blogging about, and I think also talking to
Guido about, [back in 2007](@/posts/python-3-worries-feedback.md).

The idea was rejected back then as far as I can recall. It would of
course make, as Aaron also say, the Python runtime a lot more
complicated. Recently Nick Coghlan told me in a comment here:

> You don't know what a pleasure it is to be able to work on a code base
> that isn't weighed down by all the cruft that 2.x had accumulated.
> Things like the efficient Unicode representation coming in 3.3 would
> have been orders of magnitude harder in 2.x (which is the main reason
> why it's only happening now that at least some of the technical debt
> has been paid down).

I of course do understand what a pleasure it is to work on a clean
codebase that isn't weighed down by cruft; I think any experienced
programmer does. But we're moving cruft now:

- many developers of libraries seem to have concluded that 2 to 3 isn't
  working for them. Instead they are maintaining codebases that support
  both languages at the same time.
- this leads to cruft in the libraries.

So we have to consider whether it is worth it to shift cruft from the
language implementation to the library implementations, and the burden
of complexity to the developers of these libraries. This cruft will, of
course, in a nebulous future, be removed from the library
implementations again.

Adding the cruft and then removing it again is work. I'm a lazy
programmer and I'm not ashamed of that; [Larry
Wall](https://en.wikipedia.org/wiki/Larry_Wall) spoke wisdom when he
called laziness a programmer's virtue. So I think trying to
[shame](https://python3wos.appspot.com/) developers who contributed
useful code into porting code to Python 3 is not exactly a noble effort.
I've been through the Zope 2/Zope 3 mess (which made me more sensitive
when Python 3 came along) and I've helped make those work together
better - I've paid my developer dues in this area.

So I still think an interpreter that supported modules written in Python
2 and Python 3 at the same time, with perhaps a central index that marks
which modules and packages are in which version in the language, would
be our best hope to make the transition between Python 2 and Python 3
more smooth, and let lazy developers start to deal with this language. I
am glad to see Aaron has similar ideas. There are serious, complicated,
questions to be answered of course: how (or whether) to handle C
extensions, for instance. But at least that complexity would be isolated
in the interpreter and under control by one group of developers, and not
be devolved onto library maintainers, or even application maintainers.

It'd be nice to see a sense of balance, and that the developers who
wanted the change in the language were the ones who also took on the
burden of the dual runtime. But I don't think that's going to happen.

Nobody likes a Cassandra. I don't want to be just a Cassandra.

I think the Python community's best hope to have a runtime happen that
supports both Python 2 and Python 3 code at the same time is the PyPy
project. So far PyPy's efforts to create a Python 3 implementation have
gone the same way as CPython did: the codebase that implements Python in
PyPy was forked. But I believe PyPy has the best interpreter
infrastructure to try to tackle this problem.

Showing that even a lazy developer will spend a little effort talking
when he thinks it might be useful, I [brought
up](http://mail.libexpat.org/pipermail/pypy-dev/2011-December/008877.html)
this idea on the Python mailing list a few months ago. I got the hopeful
feedback that it _should_ be possible to run the Python 3 and Python 2
interpreters in the same runtime with PyPy - it is a good starting point
for such a project. And that then a lot of work would be required after
that to integrate the two. It hasn't gone anywhere further since that
discussion as far as I'm aware. But I hope the PyPy developers are at
least thinking about it. It would, I think, make PyPy even more relevant
to Python developers than it already is today.

Sometimes the PyPy project asks for monetary contributions for parts of
their effort. If they asked for sponsorship of such a Python 2/Python 3
compatible runtime, then I'd be happy to help pay for it in my own
little way, and perhaps others will too.
