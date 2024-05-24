+++
title = "Porting Zope to different Pythons"
date = 2008-04-14
slug = "porting-zope-to-different-pythons"

[taxonomies]
tags = ["python", "zope", "python3"]
+++

Zope has been under development since 1996. It wasn't called Zope back
then yet: it was called bobo, and later pieces were called Principia,
and only in 1998 did it become Zope.

When Zope was born, there was just one Python implementation: CPython.
CPython is important. It's the main line of Python evolution, has the
most libraries available to it, and can integrate with all sorts of C
and C++ libraries, and even other languages such as Java can be
integrated with it.

Then there was another implementation, born in 1997: Jython (originally
JPython), Python on the JVM. Unfortunately after a good start, Jython's
development lagged behind CPython's for some time. More recently
development of Jython picked up speed again, and received actual backing
by Sun. Jython is very interesting as it can speak to Java libraries
natively. Java has _lots_ of libraries.

Meanwhile, in 2004, the originator of Jython, Jim Huginin, came up with
another implementation of Python: IronPython, on top of Microsoft's
common language runtime infrastructure. Microsoft hired him to work on
it further and IronPython has come far since then. IronPython is also
interesting as it can speak to lots of .NET platform libraries natively.
In addition, IronPython runs on top of Mono too, meaning there is what
looks like an open source implementation of this stack (no license
flamewars please, though. I may be wrong). Not very open sourcy is that
last I heard, Microsoft developers cannot accept patches to IronPython
from the outside. Still, it's very interesting technology.

Then there's PyPy, in development possibly longer than IronPython
actually, since 2003. PyPy is, in theory, very compatible with CPython.
The PyPy Python interpreter can, in theory, be translated to run on the
"C platform", on the JVM, and on the CLR, among other things. There is,
in theory, potential for tremendous speed boosts once JIT technology is
integrated into it, as is intended. It also allows, in theory, all kinds
of interesting features in the interpreter that other Python
implementations don't allow.

You noticed I used the words "in theory" a lot concerning PyPy.
Unfortunately so far PyPy's coolness, though they have lots of working
code, remains mostly theory. You can dream about PyPy but not really use
it. The PyPy developers are not showing public signs of actually working
towards a release we can all use. They are not actually showing public
signs of working towards any release at all: their last release was over
a year ago and a new release doesn't appear to be in sight. They seem to
prefer developing in their SVN repository, organize sprints and present
at conferences. In my book, if it's not actually used for real-world
projects it can still be cool, but only _theoretically_ cool. This makes
PyPy rather a dark horse that may become useful one day. I hope it does,
but I'm not holding my breath anymore.

This year, 2008, Python 3.0 will be released. It's actually the least
compatible version of Python of the list so far, which is risky. It will
most likely become important as significant amounts of people start
using it as their main development platform.

The varieties of Python don't end there. There are Python interpreters
that aim to be small in some sense, such as TinyPy and PyMite. There are
the Python implementations geared towards translation to efficient C or
C++ code: Pyrex and its spinoff Cython, and Shedskin. PyPy's RPython
subset can also do things like this, but is only used for PyPy's
implementation itself so far.

One other variety of Python that received lots of hype in the last week
is the Google App Engine. It's of course CPython 2.x, but it doesn't
allow write access to the file system, or opening sockets, nor the
installation of libraries that contain C-language components (unless
Google does it for you). If you want to store data, you will have to use
Google's way to do it. This means that porting code to the App Engine is
indeed that: a porting activity, just like to the other Python versions.

Zope, today, runs on CPython 2.x only. Given all these other Pythons
around, this is a situation that probably can't and shouldn't last
forever. When I say "Zope", I mean the Zope libraries as much as the
framework itself - Zope has been moving to a reusable-library approach
for some years now.

We have already seen the first work towards spreading Zope technology
beyond CPython already. Some porting work was done, I believe by people
from the Twisted team, who also use it, to translate one important core
package (`zope.interface`) to Jython.

The Jython project is hoping to start a Google Summer of Code project
this year to port more Zope 3 packages, such as `zope.component` to
Jython. The Zope Foundation is very grateful to the Jython project for
taking this initiative; I believe it's of great importance to Zope as a
whole. So, we hope that project gets accepted. The Zope Foundation going
to make sure the project is well-supported by the Zope community.

Hopefully the porting work to Jython can be done without the need to
fork the packages involved. Forking packages is bad, so the hope is that
the plain Python components can be tweaked to work with Jython while
they remain compatible with CPython. This leaves the C-based components.
Luckily Zope has maintained parallel Python versions of much of its C
code, which will hopefully make it easier to port these packages. That
said, it may well be that some drift has happened between the C versions
and the Python versions, and the Python code may need to catch up. There
is also C code that doesn't have a Python equivalent.

One of the hardest packages to port will be the ZODB, the Zope Object
Database. It does significant meta-class trickery and has a significant
amount of C code that doesn't have Python equivalents. Luckily most Zope
libraries aren't dependent on the ZODB at all. We also devising ways for
Zope 3 to run completely without the ZODB. Instead, object relational
mappers (ORM) can be be used instead. This means that even without
porting the ZODB, we can still use Zope much as it is.

There is another option that might help us allow the use of the ZODB on
Jython: RelStorage. This is a ZODB backend that is backed by a
relational database backend instead of by the usual big file in
FileStorage, the most-commonly used ZODB backend. It may be that
RelStorage is easier to port to the Jython platform than FileStorage,
but perhaps not. Let the experts speak out!

Porting to the Jython platform will also teach us important lessons
about porting to other platforms. If we can make Zope work on Jython, it
may also be easier to make it work on IronPython. Or PyPy.

What about the current hot topic, the Google App Engine? Can we port
Zope to that? Zope's C libraries won't work, just like with Jython.
That's the same problem as we have with Jython! There is a synergy
between these porting projects. Hopefully the Jython port (cross fingers
that it'll happen!) will help make sure Zope works without the C
extensions, and therefore also on the Google App Engine.

With the Google App Engine, we will also need to use Google's way to
store data. We can integrate with that like we integrate with an ORM.
There has also been some talk about porting the ZODB on top of it - the
ZODB supports multiple backends, so why not Google's? I'd love to hear
from Shane Hathaway, the author of RelStorage, to see whether
RelStorage's approach could be used for this.

If we can make Zope run without the need for C extensions, and we have
ZODB backends for the various platforms out there, we may be looking at
a future where many run Zope applications on the Java platform, .NET,
the Google App Engine, or maybe even PyPy.
