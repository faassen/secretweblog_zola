+++
title = "Morepath 0.4.1 released (with Python 3 fixes)"
date = 2014-07-08
slug = "morepath-041-released-with-python-3-fixes"

[taxonomies]
tags = ["python", "planetpython", "morepath", "python3"]
+++

I just released [Morepath 0.4.1](https://pypi.python.org/pypi/morepath).
This fixes a regression with Python 3 compatibility and has a few other
minor tweaks to bring test coverage back up to 100%.

I had broken Python 3 support in Morepath 0.4. I'm still not in the
habit of running 'tox' before a release, so I find out about these
problems too late.

I'll go into a bit of detail about this issue, as it's a mildly amusing
example of writing Python code being more complicated than it should be.

Morepath 0.4 broke in Python 3 because I introduced a metaclass for the
`morepath.App` class. I usually avoid metaclasses as they are a source
of unpredictability and complexity, but the best solution I saw here was
one. It's a very limited one.

One task of the metaclass is to attach to the class with
[Venusian](http://docs.pylonsproject.org/projects/venusian/en/latest/).
Venusian is a library that lets you write decorators that don't execute
during import time but later. This is nice as import time side effects
can be a source of trouble.

Venusian also lets you attach a callback to a Python object (such as a
class) outside of a decorator. That's what I was doing; attaching to a
class, in my metaclass.

Venusian determines in what context the decorator was called, such as
module-level and class-level, so you can use that later. For this it
inspects the Python stack frame of its caller.

My first attempt to make the metaclass work in Python 3 was to use the
`with_metaclass` functionality from the
[future](http://python-future.org/) compatibility layer. I am using this
library anyway in Reg, which is a dependency of Morepath, so using it
would not introduce a new dependency for Morepath.

Unfortunately after making that change my tests broke in both Python 2
and Python 3. That's not an improvement over having the tests being
broken in just Python 2!

It appears that `with_metaclass` introduces a new stack frame into the
mix somewhere, which breaks Venusian's assumptions. Now Venusian's
`attach` has a `depth` argument to determine where in the stack to
check, so I increased the stack depth by one and ran the tests again.
Less tests broke than before, but quite a few still did. I think the
cause is that the stack depth of `with_metaclass` is just not consistent
for whatever reason.

Digging around in the `future` package I saw it includes a copy of
[six](https://pythonhosted.org/six/), another compatibility layer
project. `six` has a name close to my heart -- long ago I originated the
Five project for compatibility between Zope 2 and Zope 3.

That copy of six had another version of `with_metaclass`. I tried using
`future.util.six.with_metaclass`, and hey, it all started working
suddenly. All tests passed, in both Python 2 and Python 3. Yay!

Okay then, I figured, I don't want to depend on a copy of `six` that
just happens to be lying about in `future`. It's not part of its public
API as far as I understand. So I figured I should introduce a new
dependency for Morepath after all, on `six`. It's not a big deal;
Morepath's *testing* dependencies include
[WebTest](http://webtest.readthedocs.org/en/latest/), and this already
has a dependency on `six`.

But when I pulled in `six` proper, I got a newer version of it than the
one in `future.util.six`, and it caused the same test breakages as with
`future`. Argh!

So I copied the code from old-six into Morepath's `compat` module. It's
a two-liner anyway. It works for me. Morepath 0.4.1 done and released.

But I don't know why `six` had to change its version, and why `future`'s
version is different. It worries me -- they probably have good reasons.
Are those reasons going to break my code at some point in the future?

Being a responsible open source citizen, I left bug reports about my
experiences in the `six` and `future` issue trackers:

<https://bitbucket.org/gutworth/six/issue/83/with_meta-and-stack-frame-issues#comment-11125428>

<https://github.com/PythonCharmers/python-future/issues/75>

I much prefer writing Python code. Polyglot is an inferior programming
language as it introduces complexities like this. But Polyglot is what
we got.
