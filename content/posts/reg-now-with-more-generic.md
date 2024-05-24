+++
title = "Reg, Now With More Generic!"
date = 2013-10-28
slug = "reg-now-with-more-generic"

[taxonomies]
tags = ["python", "planetpython", "zope", "reg", "morepath"]
+++

A month ago I first
[announced](http://blog.startifact.com/posts/reg-component-architecture-reimagined.html)
the [Reg](http://reg.readthedocs.org) library for Python. After posting
it I got a comment asking why I didn't just use
[simplegeneric](https://pypi.python.org/pypi/simplegeneric) or [PEP
443](http://www.python.org/dev/peps/pep-0443/?)? One important reason is
that I wasn't aware them. The other reason is that I want some special
features. But it did get me thinking. Thanks commenter yesvee!

# PEP 443

So what's PEP 443? It proposes functionality that lets you create
generic functions that dispatch on their first argument (single
dispatch):

``` python
from functools import singledispatch
@singledispatch
def fun(arg):
    return "The default"

@fun.register(int)
def int_fun(arg):
    return "Int argument"

@fun.register(list)
def list_fun(arg)
    return "List argument"
```

When you now call `fun()` it will dispatch to different implementations
dependent on the type of the first argument:

``` python
>>> fun(1)
"Int argument"

>>> fun([])
"List argument"

>>> fun('foo')
"The default"
```

The advantage: dispatch on type, which is useful to extend classes from
the outside, but just functions to the end user.

# The Zope Component Architecture

Reg is the Zope Component Architecture (ZCA) reimagined. The ZCA is
interface-centric. Objects are looked up by interface, and an interface
looks a lot like a class. Here's what it looked like with Reg (which has
a simpler registration API):

``` python
import reg

class IFunctionality(reg.Interface)
    pass

def int_fun(arg):
    return "Int argument"

def list_fun(arg)
    return "List argument"

r = reg.Registry()
r.register(IFunctionality, [int], int_fun)
r.register(IFunctionality, [list], list_fun)
```

And then this is how you'd use it:

``` python
>>> IFunctionality.adapt(1)
"Int argument"
>>> IFunctionality.adapt("List argument")
"List argument"
```

This API was in fact slightly less good as you could accomplish with the
ZCA itself:

``` python
>>> IFunctionality(1)
"Int argument"
>>> IFunctionality("List argument")
"List argument"
```

This is because I wanted to keep Reg simpler, and the ZCA has to do
quite a lot of wizardy to make the latter functionality work. But I
actually wanted it in Reg. And that starts to look suspiciously like a
generic function implementation.

So I started thinking about rewriting Reg so it presented itself much
like generic functions as in PEP 443, but with special Reg sauce added.
I talked it over with a few people at PyCon DE too. Thanks for helping
me clarify my thinking!

# All New Generic Reg

So last week I refactored Reg so be generic function based. Gone is
lookup by interface, in is generic function calling. Here's what it
looks like with Reg today:

``` python
import reg

@reg.generic
def fun(arg):
    return "The default"

def int_fun(arg):
    return "Int argument"

def list_fun(arg)
    return "List argument"

r = reg.Registry()
r.register(fun, [int], int_fun)
r.register(fun, [list], list_fun)
```

And using it looks like a normal function call, just like in PEP 443:

``` python
>>> fun(1)
"Int argument"
```

Reg doesn't deal with interfaces anymore. Interfaces tend to scare off
Python developers as they're a new concept, and I realize they just
weren't necessary anymore. Now people using your Reg-based APIs just use
functions, like with any other API.

Why not use the decorator approach to register generic function
implementations? Because Reg allows more than one registry. While
writing this I realize that's not a good answer: I *can* provide this in
Reg if I make the decorator a method on `Registry`. Stay tuned!

But anyway, Morepath, the web framework built on Reg that I'm working
on, already supplies a decorator like this that integrates with its
configuration engine.

# Why Reg instead of PEP 443?

So what's the special Reg sauce? Why not just use PEP 443? Reg offers a
few facilities that I needed in Morepath:

- Multiple dispatch. PEP 443 offers single dispatch on the first
  argument. Reg implements multiple dispatch, on multiple arguments.
  This is handy when you're implementing a web framework such as
  Morepath, which dispatches on request and model.
- You can isolate one set of generic implementation function
  implementations from another one in the same runtime. This is because
  Reg allows more than one registry in which these can be registered.
- Registries can also be composed together. This allows a core framework
  to register some implementations and application code some more.
- The registry to use can be implicit, or you can be totally explicit
  about what registry to use when you call a generic function.
- Get *all* the generic functions that would apply to arguments.
  Register other things than functions and still look them up. I use
  these advanced use cases in Morepath in a few places.
- Predicate support. The Pyramid web framework lets you register views
  not only by type, but also by other things, such as HTTP request
  method (`GET`, `POST`, etc). I've put support for this kind of thing
  in Reg itself, and I use it in Morepath. This bit is still
  underdocumented, please stay tuned!

Luckily you don't have to commit to Reg. You could implement your API
using the more modest PEP 443 implementation first, and then switch to
Reg should you discover its features would be helpful to you. You'd have
to change how you register the implementations of generic functions, but
not the API itself.

# The New Reg Docs

I've updated and extended the [Reg docs](http://reg.readthedocs.org/).
Read the [usage docs](http://reg.readthedocs.org/en/latest/usage.html)
and check out the all new [API
documentation](http://reg.readthedocs.org/en/latest/api.html)!

This should help you get started using Reg.

# Road to Morepath

Reg is foundational to Morepath, the up and coming Python micro web
framework with super powers. I've adjusted Morepath to use the new
generic Reg. The morepath code is
[online](https://github.com/morepath/morepath). Stay tuned for docs!
