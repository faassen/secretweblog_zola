+++
title = "I like doctests"
date = 2008-12-01
slug = "i-like-doctests"

[taxonomies]
tags = ["testing", "python"]
+++

# I like doctests

It seems to be a recent trend to point out things you don't like about
doctests. There are
[two](http://andrew.puzzling.org/diary/2008/October/23/narrative-tests)
[articles](http://andrew.puzzling.org/diary/2008/October/24/more-doctest-problems)
by Andrew (? - see update below) and
[one](http://nedbatchelder.com/blog/200811/things_i_dont_like_about_doctest.html)
by Ned Batchelder. There's also [one by Marius
Gedminas](http://mg.pov.lt/blog/on-narrative-doctests).

I take the doctest negativity as a sign of increased popularity of
doctesting in the Python world. Doctests are now being seen and read by
a larger amount of Python programmers, so there are now more people to
talk about the undoubted drawbacks of doctests. (Of course it is *also*
a sign of people disliking aspects of doctests - Marius for one has been
exposed to narrative doctests for years)

I like narrative doctests, and have been using them for years now. They
often constitute the bulk of the tests of my code. To Andrew at least,
that probably means I "abuse" them. Why do I like them?

Doctests are not an ideal testing tool. There are pros and cons. Read
the linked articles for some cons (and pros: Andrew points out they are
easy to write). Narrative doctests aren't an ideal form of developer
documentation either: a well-written, well-maintained dedicated text is
better.

The great thing about doctests is that you can write fair tests and fair
developer documentation, *at the same time*. You can use doctests to
provide reasonable test coverage suitable for solid, real-world code.
Importantly, those same doctests then also provide developer-level
documentation that may not always be great, but is still much better
than the frequent alternative (nothing).

One advantage of using doctests to describe your API is that you use the
API of your code in the doctest before you actually use it for real. As
a result, the API of the code you write becomes better as you are forced
to think about it early on during the design process. Unit tests of
course have the same benefit: improved API design is actually one of the
great but rather underacknowledged benefits of unit testing. But
doctests encourage you to think about your API design more than plain
unit tests, as you're actually writing prose that tries to *explain* the
way your API works to the reader. If it's hard to explain, it may be
time to change the design.

Doctests often contain usage examples. Unit tests do too, but doc tests
have a narrative around them, including the often all-important setup
code. Instead of digging around to see which objects you're supposed to
create and what methods you're supposed to call in what order, you have
a narrative in the doctest that tells you what to do.

Another advantage of doctests is that they spell out the intent of the
tests better than a typical unit test suite does. An individual unit
test can of course describe its intent by being well-named and by having
comments, but nothing encourages you to do so. Doctests have an actual
narrative, so this style of testing actively encourages writing down the
intent.

Here are some examples of narrative doctests I've written over the
years. I don't find it particularly hard to work with doctest. In all
cases below they form the bulk of the tests in the codebase. Is this
abuse of the doctest format? Judge for yourself whether you like
narrative doctests or not:

- [hurry.resource](http://pypi.python.org/pypi/hurry.resource/) (a
  general framework for including resources (CSS, JS) in web pages. I
  intend to write more about it in the future)
- [martian](http://pypi.python.org/pypi/martian) (declarative
  configuration embedded in Python code without metaclasses)
- [classix](http://pypi.python.org/pypi/classix/) (an experimental
  configuration system for hooking up classes to lxml elements)
- [z3c.vcsync](http://pypi.python.org/pypi/z3c.vcsync/) (synchronizing
  application state with a version control system, for Zope 3)
- [hurry.workflow](http://pypi.python.org/pypi/hurry.workflow/) (a
  simple workflow system for Zope 3)
- [z3c.saconfig](http://svn.zope.org/z3c.saconfig/trunk/src/z3c/saconfig/README.txt)
  (integrating SQLAlchemy with Zope 3's component architecture)
- [imageSTORE](http://imagestore.googlecode.com/svn/trunk/src/imagestore/rest.txt)
  (an example of using doctests with an application instead of a
  library. This doctest works through the REST protocol that this
  application offers)

Narrative doctests are not an ideal tool; no tool is. You have to
actually write a narrative and if you don't, you are left with a testing
tool that is in many respects worse than unit tests. I maintain that
doctesting is an approach that's good enough to write good, solid
software with reasonable developer-level documentation. You can enhance
the reuse potential and API design of your library by writing a
narrative doctest for it.

Feel free to use unittest and doctest where appropriate, to your taste.
But don't be scared off by the recent negativity that seems to surround
doctests. Doctests have many benefits. Doctests are a good balance for
me personally, and perhaps they will be for you as well.

\[update: I don't know why I gave Andrew a last name; I'm not sure where
I got that from so I'll take it away again.\]
