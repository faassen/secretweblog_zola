+++
title = "A history of Python packaging"
date = 2009-11-09
slug = "a-history-of-python-packaging"

[taxonomies]
tags = ["python", "packaging", "linux"]
+++

## Introduction

Earlier this year I was at PyCon in the US. I had an interesting
experience there: people were talking about the _problem_ of packaging
and distributing Python libraries. People had the impression that this
was an urgent problem that hadn't been solved yet. I detected a vibe
asking for the Python core developers to please come and solve our
packaging problems for us.

I felt like I had stepped into a parallel universe. I've been using
powerful tools to assemble applications from Python packages
automatically for years now. Last summer at EuroPython, when this
discussion came up again, I maintained that packaging and distributing
Python libraries is a _solved problem_. I put the point strongly, to
make people think. I fully agree that the current solutions are
imperfect and that they can be improved in many ways. But I also
maintain that the current solutions are indeed _solutions_.

There is now a lot of packaging infrastructure in the Python community,
a lot of technology, and a lot of experience. I think that for a lot of
Python developers the historical background behind all this is missing.
I will try to provide one here. It's important to realize that progress
has been made, step by step, for more than a decade now, and we have a
fine infrastructure today.

I've named some important contributors to the Python packaging story,
but undoubtedly I've also did not mention a lot of other important
names. My apologies in advance to those I missed.

## The dawn of Python packaging

The Python world has been talking about solutions for packaging and
distributing Python libraries for a very long time. I remember when I
was new in the Python world about a decade ago in the late 90s, it was
considered important and urgent that the Python community implement
something like Perl's CPAN. I'm sure too that this debate had started
long before I started paying attention.

I've never used CPAN, but over the years I've seen it held up by many as
something that seriously contributes to the power of the Perl language.
With CPAN, I understand, you can search and browse Perl packages and you
can install them from the net.

So, lots of people were talking about a Python equivalent to CPAN with
some urgency. At the same time, the Python world didn't seem to move
very quickly on this front...

## Distutils

The Distutils SIG (special interest group) was started in late 1998.
Greg Ward in the context of this discussion group started to create
Distutils about this time. Distutils allows you to structure your Python
project so that it has a `setup.py`. Through this `setup.py` you can
issue a variety of commands, such as creating a tarball out of your
project, or installing your project. Distutils importantly also has
infrastructure to help compiling C extensions for your Python package.
Distutils was added to the Python standard library in Python 1.6,
released in 2000.

## Metadata

We now had a way to distribute and install Python packages, if we did
the distribution ourselves. We didn't have a centralized index (or
catalog) of packages yet, however. To work on this, the Catalog SIG was
started in the year 2000.

The first step was to standardize the metadata that could be cataloged
by any index of Python packages. Andrew Kuchling drove the effort on
this, culminating in [PEP 241](http://www.python.org/dev/peps/pep-0241/)
in 2001, later updated by [PEP
314](http://www.python.org/dev/peps/pep-0314/):

Distutils was modified so it could work with this standardized metadata.

## PyPI

In late 2002, Richard Jones started work on the Python Package Index,
PyPI. PyPI is also known as the Cheeseshop, a name I prefer but
apparently has been deprecated. The first work on an implementation
started, and [PEP 301](http://www.python.org/dev/peps/pep-0301/) that
describes PyPI was also created then. Distutils was extended so the
metadata and packages themselves could be uploaded to this package
index. By 2003, the Python package index was up and running.

The Python world now had a way to upload packages and metadata to a
central index. If we then manually downloaded a package we could install
it using `setup.py` thanks to Distutils.

## Setuptools

Phillip Eby started work on Setuptools in 2004. Setuptools is a whole
range of extensions to Distutils such as from a binary installation
format (eggs), an automatic package installation tool, and the
definition and declaration of scripts for installation. Work continued
throughout 2005 and 2006, and feature after feature was added to support
a whole range of advanced usage scenarios.

By 2005, you could install packages automatically into your Python
interpreter using `easy_install`. Dependencies would be automatically
pulled in. If packages contained C code it would pull in the binary egg,
or if not available, it would compile one automatically.

The sheer amount of features that Setuptools brings to the table must be
stressed: namespace packages, optional dependencies, automatic manifest
building by inspecting version control systems, web scraping to find
packages in unusual places, recognition of complex version numbering
schemes, and so on, and so on. Some of these features perhaps seem
esoteric to many, but complex projects use many of them.

## The problems of shared packages

The problem remained that all these packages were installed into your
Python interpreter. This is icky. People's `site-packages` directories
became a mess of packages. You also need root access to easy_install a
package into your system Python. Sharing all packages in a direcory in
general, even locally, is not always a good idea: one version of a
library needed by one application might break another one.

Solutions for this emerged in 2006.

## Virtualenv

Ian Bicking drove one line of solutions: virtual-python, which evolved
into workingenv, which evolved into virtualenv in 2007. The concept
behind this approach is to allow the developer to create as many fully
working Python environments as they like from a central system
installation of Python. When the developer activates the virtualenv,
easy_install will install all packages into its the virtualenv's
`site-packages`. This allows you to create a virtualenv per project and
thus isolate each project from each other.

## Buildout

In 2006 as well, Jim Fulton created Buildout, building on Setuptools and
easy*install. Buildout can create an isolated project environment like
virtualenv does, but is more ambitious: the goal is to create a system
for \_repeatable* installations of potentially very complex projects.
Instead of writing an `INSTALL.txt` that tells others who to install the
prerequites for a package (Python or not), with Buildout these
prerequisites can be installed automatically.

The brilliance of Buildout is that it is easily extensible with new
installation recipes. These recipes themselves are also installed
automatically from PyPI. This has spawned a whole ecosystem of Buildout
recipes that can do a whole range of things, from generating
documentation to installing MySQL.

Since Buildout came out of the Zope world, Buildout for a long time was
seen as something only Zope developers would use, but the technology is
not Zope-specific at all, and more and more developers are picking up on
it.

In 2008, Ian Bicking created an alternative for easy_install called pip,
also building on Setuptools. Less ambitious than buildout, it aimed to
fix some of the shortcomings of easy_install. I haven't used it myself
yet, so I will leave it to others to go into details.

## Setuptools and the standard library

The many improvements that Setuptools brought to the Python packaging
story hadn't made it into the Python Standard Library, where Distutils
was stagnating. Attempts had been made to bring Setuptools into the
standard library at some point during its development, but for one
reason or another these efforts had foundered.

Setuptools probably got where it is so quickly because it worked around
often very slow process of adopting something into the standard library,
but that approach also helped confuse the situation for Python
developers.

Last year Tarek Ziade started looking into the topic of bringing
improvements into Distutils. There was a discussion just before PyCon
2009 about this topic between various Python developers as well, which
probably explains why the topic was in the air. I understood that some
decisions were made:

- let the people with extensive packaging experience (such as Tarek)
  drive this process.
- free the metadata from Distutils and Setuptools so that other
  packaging tools can make use of it more easily.

## Distribute

By 2008, Setuptools had become a vital part of the Python development
infrastructure. Unfortunately the Setuptools development process has
some flaws. It is very centered around Phillip Eby. While he had been
extremely active before, by that time he was spending a lot less energy
on it. Because of the importance of the technology to the wider
community, various developers had started contributing improvements and
fixes, but these were piling up.

This year, after some period of trying to open up the Setuptools project
itself, some of these developers led by Tarek Ziade decided to fork
Setuptools. The fork is named Distribute. The aim is to develop the
technology with a larger community of developers. One of the first big
improvements of the Distribute project is Python 3 support.

Quite understandably this fork led to some friction between Tarek,
Phillip and others. I trust that this friction will resolve itself and
that the developers involved will continue to work with each other, as
all have something valuable contribute.

## Operating system packaging

One point that always comes up in discussions about Python packaging
tools is operating system packaging. In particular Linux distributions
have developed extremely powerful ways to distribute and install complex
libraries and application, manage versions and dependencies and so on.

Naturally when the topic of Python packaging comes up, people think
about operating system packaging solutions like this. Let me start off
that I fully agree that Python packaging solutions can learn a lot from
operating system packaging solutions.

Why don't we just use a solution like that directly, though? Why is a
Python specific packaging solution necessary at all?

There are a number of answers to this. One is that operating packaging
solutions aren't universal: if we decided to use Debian's system, what
would we do on Windows?

The most important answer however is that there are two related but also
very different use cases for packaging:

- system administration: deploying and administrating existing software.
- development: combining software to develop new software.

The Python packaging systems described above primarily try to solve the
development use case: I'm a Python developer, and I'm developing
multiple projects at the same time, perhaps in multiple versions, that
have different dependencies. I need to reuse packages created by other
developers, so I need an easy way to depend on such packages. These
packages are sometimes in a rather early state of development, or
perhaps I'm even creating a new one. If I want to improve such a package
I depend on, I need an easy way to start hacking on it.

Operating system packaging solutions as I've seen them used are ill
suited for the development use case. They are aimed at creating a single
consistent installation that is easy to upgrade with an eye on security.
Backwards compatibility is important. Packages tend to be relatively
mature.

For all I know it might indeed be possible to use an operating system
packaging tool as a good development packaging tool. But I've heard very
little about such practices. Please enlighten me if you have.

It's also important to note that the Python world isn't as good as it
should be at supporting operating system packaging solutions. The
freeing up of package metadata from the confines of the `setup.py` file
into a more independently reusable format as was decided at PyCon should
help here.

## Conclusions

We are now in a time of consolidation and opening up. Many of the
solutions pioneered by Setuptools are going to be polished to go into
the Python Standard Library. At the same time, the community surrounding
these technologies is opening up. By making metadata used by Distutils
and Setuptools more easily available to other systems, new tools can
also more easily be created.

The Python packaging story had many contributors over the years. We now
have a powerful infrastructure. Do we have an equivalent to CPAN? I
don't know enough about CPAN to be sure. But what we have is certainly
useful and valuable. In my parallel universe, I use advanced Python
packaging tools every day, and I recommend all Python programmers to
look into this technology if they haven't already. Join me in my
parallel universe!

**Update:** I just found out there was a huge thread on python-dev about
this in the last few days which focused around the question whether we
have the equivalent of CPAN now. One of them funny coincidences...
<http://thread.gmane.org/gmane.comp.python.distutils.devel/11359>
