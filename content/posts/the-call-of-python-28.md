+++
title = "The Call of Python 2.8"
date = 2014-04-14
slug = "the-call-of-python-28"

[taxonomies]
tags = ["python", "planetpython", "python3"]
+++

# Introduction

Guido recently felt he needed to re-empathize that there will be no
Python 2.8. The Python developers have been very clear for years that
there will never be a Python 2.8.

<http://legacy.python.org/dev/peps/pep-0404/>

At the Python language summit there were calls for a Python 2.8. Guido
reports:

> We (I) still don't want to do a 2.8 release, and I don't want to
> accelerate 3.5, but I do think we should make things better for people
> who have to straddle Python 2 and 3 in a single codebase, by
> developing more tools, and by security and possibly installer updates
> to 2.7 (PEP 466).

At his keynote at PyCon, he said it again:

![image](/img/guido_no.jpg)

A very good thing happened to recognize the reality that Python 2.7 is
still massively popular: the end of life date for Python 2.7 was
[changed](http://hg.python.org/peps/rev/76d43e52d978?utm_content=buffer55d59&utm_medium=social&utm_source=facebook.com&utm_campaign=buffer)
by Guido to 2020 (it was 2015). In the same change he felt he should
repeat there will be no Python 2.8:

    +There will be no Python 2.8.

The call for Python 2.8 is strong. Even Guido feels it!

People talk about a Python 2.8, and are for it, or, like Guido, against
it, but rarely talk about what it should _be_. So let's actually have
that conversation.

Why talk about something that will never be? Because **we can't call for
something, nor reject something if we don't know what it is**.

# What is Python 2.8 for?

Python 2.8 could be different things. It could be a Python 2.x release
that reduces some pain points and adds features for Python 2 developers
independent from what's going on in Python 3. It makes sense, really: we
haven't had a new Python 2 feature release since 2010 now. Those of us
with existing large Python 2 codebases haven't benefited from the work
the language developers have done in those years. Even polyglot
libraries that support Python 2 and 3 both can't use the new features,
so are also stuck with a 2010 Python. Before Python 2.7, the release
cycle of Python has seen a new compatible release every 2 years or less.
The reality of Python for many of its users is that there has been no
feature update of the language for years now.

But I don't want to talk about that. I want to talk about Python 2.8 as
an incremental upgrade path to Python 3. If we are going to add features
to Python 2, let's take them from Python 3. I want to talk about
bringing Python 2.x closer to Python 3. Python 2 might never quite reach
Python 3 parity, but it could still help a lot if it can get closer
incrementally.

# Why an incremental upgrade?

In the discussion about Python 3 there is a lot of discussion about the
need to port Python libraries to Python 3. This is indeed important if
you want the ability to start new projects on Python 3. But many of us
in the trenches are working on large Python 2 code bases. This isn't
just maintenance. A large code base is alive, so we're building _new_
features in Python 2.

Such a large Python codebase is:

- Important to some organization. Important enough for people to
  actually pay developers money to work on Python code.
- Cannot be easily ported in a giant step to Python 3, even if all
  external open source libraries are ported.
- Porting would not see any functional gain, so the organization won't
  see it as a worthwhile investment.
- Porting would entail bugs and breakages, which is what the
  organization would want to avoid.

You can argue that I'm overstating the risks of porting. But we need to
face it: many codebases written in Python 2 have low automatic test
coverage. We don't like to talk about it because we think everybody else
is better at automated testing than we are, but it's the reality in the
field.

We could say, fine, they can stay on Python 2 forever then! Well, at
least until 2020. I think this would be unwise, as these organizations
are paying a lot of developers money to work on Python code. This has an
effect on the community as a whole. It contributes to [the gravity of
Python 2](@/posts/python-2-gravity.md).

Those organizations, and thus the wider Python community, would be
helped if there was an incremental way to upgrade their code bases to
Python 3, with easy steps to follow. I think we can do much more to
support such incremental upgrades than Python 2.7 offers right now.

# Python 2.8 for polyglot developers

Besides helping Python 2 code bases go further step by step, Python 2.8
can also help those of us who are maintaining polyglot libraries, which
work in both Python 2 and Python 3.

If a Python 2.8 backported Python 3 features, it means that polyglot
authors can start using those features if they drop Python 2.7 support
right there in their polyglot libraries, _without giving up Python 2
compatibility_. Python 2.8 would actually help _encourage_ those on
Python 2.7 codebases to move towards Python 3, so they can use the
library upgrades.

Of course dropping Python 2.x support entirely for a polyglot library
will _also_ make that possible. But I think it'll be feasible to drop
Python 2.7 support in favor of Python 2.8 much faster than it is
possible to drop Python 2 support entirely.

# But what do we want?

I've seen Python 3 developers say: but we've done all we could with
Python 2.7 already! What do you _want_ from a Python 2.8?

And that's a great question. It's gone unanswered for far too long. We
should get a lot more concrete.

What follows are just ideas. I want to get them out there, so other
people can start thinking about them. I don't intend to implement any of
it myself; just blogging about it is already breaking my stress-reducing
policy of not worrying about Python 3.

Anyway, I might have it all wrong. But at least I'm trying.

# Breaking code

Here's a paradox: I think that in order to make an incremental upgrade
possible for Python 2.x we should actually break existing Python 2.x
code in Python 2.8! Some libraries will need minor adjustments to work
in Python 2.8.

I want to do what the `from __future__` pattern was introduced for in
the first place: introduce a new incompatible feature in a release but
making it optional, and then later making the incompatible feature the
default.

# The Future is Required

Python 2.7 lets you do `from __future__ import something` to get the
interpreter behave a bit more like Python 3. In Python 2.8, those should
be the default behavior.

In order to encourage this and make it really obvious, we may want to
consider _requiring_ these in Python 2.8. That means that the
interpreter raises an error unless it has such a `from __future__`
import there.

If we go for that, it means you _have_ to have this on the top of all
your Python modules in Python 2.8:

- `from __future__ import division`
- `from __future__ import absolute_import`
- `from __future__ import print_function`

`absolute_import` appears to be uncontroversial, but I've seen people
complain about both `division` and `print_function`. If people reject
Python 3 for those reasons, I want to make clear I'm not in the same
camp. I believe that is confusing at most a minor inconvenience with a
dealbreaker. I think discussion about these is pretty pointless, and I'm
not going to engage in it.

I've left out `unicode_literals`. This is because I've seen _both_ Nick
Coghlan _and_ Armin Ronacher [argue against
them](https://github.com/PythonCharmers/python-future/issues/22). I have
a different proposal. More below.

What do we gain by this measure? It's ugly! Yes, but we've made the
upgrade path a lot more obvious. If an organisation wants to upgrade to
Python 2.8, they have to review their imports and divisions and change
their print statements to function calls. That should be doable enough,
even in large code bases, and is an upgrade path a developer can do
incrementally, maybe even without having to convince their bosses first.
Compare that to an upgrade to Python 3.

# `from __future3__ import new_classes`

We can't do everything with the old future imports. We want to allow
_more_ incremental upgrading. So let's introduce a new future import.

New-style classes, that is classes that derive from `object`, were
introduced in Python 2 many years ago, but old-style classes are still
supported. Python 3 only has new-style classes. Python 2.8 can help here
by making new style classes the default. If you import
`from __future3__ import new_classes` at the top of your module, any
class definition in that module that looks like this:

    class Foo:
       pass

is interpreted as a new-style class.

This might break the contract of the module, as people may subclass from
this class and expect an old-style class, and in some (rare) cases this
can break code. But at least those problems can be dealt with
incrementally. And the upgrade path is really obvious.

# `__future3__`?

Why did I write `__future3__` and not `__future__`? Because otherwise we
can't write polyglot code that is compatible in Python 2 and Python 3.

Python 3.4 doesn't support `from __future__ import new_classes`. We
don't want to wait for a Python 3.5 or Python 3.6 to support this, even
there is even any interest in supporting this among the Python language
developers at all. Because after all, there won't be a Python 2.8.

That problem doesn't exist for `__future3__`. We can easily fake a
`__python3__` module in Python 3 without being dependent on the language
developers. So polyglot code can safely use this.

# `from __future3__ import explicit_literals`

Back to the magic moment of Nick Coghlan and Armin Ronacher agreeing.

Let's have a `from __future3__ import explicit_literals`.

This forces the author to be entirely explicit with string literals in
the module that imports it. `"foo"` and `'foo'` are now errors; the
module won't import. Instead the module has to be explicit and use
`b'foo'` and `u'foo'` everywhere.

What does that get us? It forces a developer to think about string
literals everywhere, and that helps the codebase become incrementally
more compatible with Python 3.

# `from __future3__ import str`

This import line does two things:

- you get a `str` function that creates a _Python 3 str_. This string
  has unicode text in it and cannot be combined with Python 2 style
  bytes and Python 3 style bytes without error (which I'll discuss
  later).
- if `from __future__ import explicit_literals` is in effect, a bare
  literal now creates a Python 3 str. Or maybe `explicit_literals` is a
  prerequisite and `from __future3__ import str` should error if it
  isn't there.

I took this idea from the [Python future](http://python-future.org/)
module, which makes Python 3 style str and bytes (and much more)
available in Python 2.7. I've modified the idea as I have the imaginary
power to change the interpreter in Python 2.8. Of course anything I got
wrong is my own fault, not the fault of Ed Schofield, the author of the
`future` module.

# `from __past__ import bytes`

To ensure you still have access to Python 2 `bytes` (really `str`) just
in case you still need it, we need an additional import:

    from __past__ import bytes as oldbytes

`oldbytes`<span class="title-ref"> can be called with Python 2
</span><span class="title-ref">str</span><span class="title-ref">,
Python 2
</span><span class="title-ref">bytes</span><span class="title-ref"> and
Python 3
</span><span class="title-ref">bytes</span><span class="title-ref">. It
rejects a Python 3 </span><span class="title-ref">str</span>\`. I'll
talk about why it can be needed in a bit.

Yes, `__past__` is another new namespace we can safely support in Python 3. It would get more involved in Python 3: it contains a forward port of
the Python 2 bytes object. Python 3 bytes have less features than Python
2 bytes, and this has been a pain point for some developers who need to
work with bytes a lot. Having a more capable bytes object in Python 3
would not hurt existing Python 3 code, as combining it with a Python 3
string would still result in an error. It's just an alternative
implementation of `bytes` with more methods on it.

# `from __future3__ import bytes`

This is the equivalent import for getting the Python 3 bytes object.

# Combining Python 3 str/bytes with Python 2 unicode/str

So what happens when we somehow combine a Python 3 str/bytes with a
Python 2 str/bytes/unicode? Let's think about it.

The `future` module by Ed Schofield forbids `py3bytes + py2unicode`, but
supports other combinations and upcasts them to their Python 3 version.
So, for instance, `py3str + py2unicode -> py3str`. This is a consequence
of the way it tries to make Python 2 string literals work a bit like
they're Python 3 unicode literals. There is a big drawback to this
approach; a Python 3 bytes is not fully compatible with APIs that expect
a Python 2 str, and a library that tried to use this approach would
suffer API breakage. See [this
issue](https://github.com/PythonCharmers/python-future/issues/27) for
more information on that.

I think since we have the magical power to change the interpreter, we
can do better. We can make real Python 3 string literals exist in Python
2 using `__future3__`.

I think we need these rules:

- `py3str + py2unicode -> py3str`
- `py3str + py2str: UnicodeError`
- `py3bytes + py2unicode: TypeError`
- `py3bytes + py2str: TypeError`

So while we upcast existing Python 2 unicode strings to Python 3 str we
refuse any other combination.

Why not let people combine Python 2 str/bytes with Python 3 bytes?
Because the Python 3 `bytes` object is not compatible with the Python 2
`bytes` object, and we should refuse to guess and immediately bail out
when someone tries to mix the two. We require an explicit Python 2 `str`
call to convert a Python 3 bytes to a `str`.

This is assuming that the Python 3 `str` is compatible with Python 2
`unicode`. I think we should aim for making a Python 3 string behave
like a subclass of a Python 2 `unicode`.

# What have we gained?

We can now start using Python 3 `str` and Python 3 `bytes` in our Python
2 codebases, incrementally upgrading, module by module.

Libraries could upgrade their internals to use Python 3 str and bytes
entirely, and start using Python 3 str objects in any public API that
returns Python 2 unicode strings now. If you're wrong and the users of
your API actually do expect str-as-bytes instead of unicode strings, you
can go deal with these issues one by one, in an incremental fashion.

For compatibility you can't return Python 3 bytes where Python 2
str-as-bytes is used, so judicious use of `__past__.str` would be needed
at the boundaries in these cases.

# After Python 2.8

People who have ported their code to Python 2.8 and have turned on all
the `__future3__` imports incrementally will be in a better place to
port their code to Python 3. But to offer a more incremental step, we
can have a Python 2.9 that requires the `__future3__` imports introduced
by Python 2.8. And by then we might have thought of some other ways to
smoothen the upgrade path.

# Summary

- There will be no Python 2.8. There will be no Python 2.8! Really,
  there will be no Python 2.8.
- Large code bases in Python need incremental upgrades.
- The upgrade from Python 2 to Python 3 is not incremental enough.
- A Python 2.8 could help smoothen the way.
- A Python 2.8 could help polyglot libraries.
- A Python 2.8 could let us drop support for Python 2.7 with an obvious
  upgrade path in place that brings everybody closer to Python 3.
- The old `__future__` imports are mandatory in Python 2.8 (except
  `unicode_literals`).
- We introduce a new `__future3__` in Python 2.8. `__future3__` because
  we can support it in Python 3 today.
- We introduce `from __future3__ import new_classes`, mandating new
  style objects for plain class statements.
- We introduce `from __future3__ import explicit_literals, str, bytes`
  to support a migration to use Python 3 style str and bytes.
- We introduce `from __past__ import bytes` to be able to access the
  old-style bytes object.
- A forward port of the Python 2 bytes object to Python 3 would be
  useful. It would error if combined with a Python 3 str, just like the
  Python 3 bytes does.
- A future Python 2.9 could introduce more incremental upgrade steps.
  But there will be no Python 2.9.
- I'm not going to do the work, but at least now we have something to
  talk about.
