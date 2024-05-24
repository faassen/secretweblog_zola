+++
title = "Alex Gaynor on Python 3"
date = 2013-12-30
slug = "alex-gaynor-on-python-3"

[taxonomies]
tags = ["python", "planetpython", "python3"]
+++

# Introduction

I'm happy to see the Python community starting the Python 3 conversation
again. Alex Gaynor shares his
[analysis](http://alexgaynor.net/2013/dec/30/about-python-3/).

I agree with many of his points and am glad he was brave enough to take
up this difficult topic in public.

Update: I see Ian Bicking has weighed in and he says things I very much
agree with. Thanks Ian! Everybody should read Ian Bicking:

<https://plus.google.com/+IanBicking/posts/iEVXdcfXkz7>

# I told you so

I've been thinking about this for a while. I brought my worries up in
2007, before Python 3 was released:

</posts/older/brief-python-3000-thoughts.html>

I'll quote myself:

> While I understand the need to be able to break backwards
> compatibility, I am worried about Python forking into two parallel
> versions (2.x and 3.x) for many, many years. Such a fork can't be good
> for the Python community.

This sounds a lot like what Alex is talking about today. While it's
something to be able to say "I told you so", overall it just makes me
slightly depressed. I'm sad I don't get excited when a new release of
Python is made, like I used to be. Sometimes I don't even notice. Why
read about exciting new features I won't be using any time soon?

I got feedback and wrote followups:

</posts/older/python-3-worries-feedback.html>

</posts/older/the-purpose-to-my-whinging-about-the-transition-to-python-3.html>

</posts/older/communicating-with-core-developers-on-the-python-3-transition.html>

The feedback burned me quite heavily. I decided I was not going to
actively do anything about Python 3 and would just develop Python 2 code
and let others worry about the problem.

I shut up about Python 3 in public for years, until briefly in 2011, in
response to a blog post by Armin Ronacher:

</posts/older/python-2-8--1.html>

In early 2012 the now sadly deceased Aaron Swartz also talked about this
topic, and I responded, saying "I told you so" (not Aaron personally):

</posts/older/cassandra-and-how-pypy-could-help-with-python-3.html>

# The path taken

In 2007 I was expecting that what the core developers were suggesting
would continue to be the way to go: people would run 2to3 to convert
Python 2 code to Python 3. I was skeptical then about this plan. Instead
I hoped for what Aaron described: an interpreter where people could mix
pure Python 3 modules with pure Python 2 modules.

Instead of 2to3, library authors started to work out ways to write
Python 2 code in such a way that it would also run in Python 3. This was
considered an absolutely unrealistic approach in the beginning, but
gradually became the mainstream approach with support in Python 2.x
itself.

Now much library code has been ported. That is going fairly well. But
when I _see_ such code I think it's scary and ugly: writing code that
needs to work in both interpreters requires language knowledge that is
more like that of an advanced C++ developer. It isn't Pythonic, at all.

Open source library and framework creators have some motivation to port.
They're maintaining their stuff for a long time, and want to attract
users. They also have the interest and skill level to do so. All this
together may outweigh the cost of maintaining more complicated code.

# The bind we're in

It's different for applications. An application developer usually has
motivations _not_ to port. Porting will introduce bugs in working
applications, there's unclear benefit as the application will remain the
same, and less libraries are available. It's also harder to port an
application than a library, as libraries tend to have better test
coverage. Finally applications exist for a reason, many of them are
in-house to some organisation, and how do you motivate a budget to do
the porting activity?

But if application developers don't port, why all the effort to port
libraries then? You have many people continue to maintain and develop
Python 2 applications. Some people write new applications in Python 3.
As Alex says, not good for the community.

# Python 2.8 as way forward?

Alex suggests an incremental upgrade of Python 2 adding more Python 3
features. I think this could be made to work. It might require a Python
2.8 while leaving the door open for a Python 2.9. Incremental backwards
compatibility breaking can be part of the process: you could for
instance drop old-style classes and tell people to adjust their code
when upgrading to 2.8. While that's a relatively scary change, but most
code will continue to work.

Perhaps that with the experience people gained writing 2 + 3 code we can
even make the unicode path smooth enough.

The advantage of this approach compared to a magic Python 2 + 3
interpreter is that it would be possible to do incrementally based on
the Python 2 codebase, with the Python 3 codebase in sight. That may
involve a less scary development effort.

The main advantage is that by gradually dropping compatibility
applications may move forward again, and messy 2+3 codebases can slowly
be cleaned up as support for older versions of Python 2.x is dropped.
I'll repeat that: a path forward for developers to Python 3 that has
your code become _cleaner_, not uglier.

# The closed door

The Python core developers [somewhat gleefully slammed the door shut on
Python 2.8](http://www.python.org/dev/peps/pep-0404/) back in 2011,
though. Recently celebrating the 5 year release of Python 3.0 I heard
people say everything was going according to plan.

One quibble with Alex's post: the suggestion he makes that Python 2
should've been dropped in favor of Python 3 when Python 3 was first
released, so that people would have urgency to port code, strikes me as
unrealistic. I think it could have resulted in a justified rebellion
among users and a fork of the Python interpreter. I'm glad that path was
not taken. In fact since 2011 this has been the path taken, and I'm not
sure it made any difference.

I hope the core developers will change their mind and take up the
momentous unpleasant task of moving Python 2.x forward towards Python
3.x again. But if not, perhaps a brave group of volunteers will stand up
and fork Python 2, and take the incremental steps forward. This will
have to remain just an idle suggestion, as I'm not volunteering myself.
