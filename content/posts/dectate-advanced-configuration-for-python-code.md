+++
title = "Dectate: advanced configuration for Python code"
date = 2016-04-04
slug = "dectate-advanced-configuration-for-python-code"

[taxonomies]
tags = []
+++

Dectate is a new Python library. It's geared towards framework authors.
It's a meta-framework: a framework you can use to easily construct
robust and powerful Python frameworks.

So what's a framework anyway? A *framework* is a system that you supply
with code and then it calls it at the appropriate times. *Don't call us,
we'll call you!*

What does this look like in practice? Let's imagine you're building a
web framework, and you want the people that use your framework to
provide routes and functions that generate responses for those routes:

``` python
@route('/foo')
def foo_view(request):
    return "Some response!"
```

This hypothetical web framework then interprets HTTP requests, matches
the path of the query with `/foo`, and then calls the function
`foo_view` to generate the response. Once the response is generated, it
sends it back as a HTTP response.

In the abstract, the developer that uses the framework uses it for *code
configuration*: you supply some functions or classes along with some
configuration meta data. The framework then uses this code at the
appropriate times.

So why would you, the framework author, need a *meta framework* to
implement `route`? You just create a Python decorator. When it's called
you just register the path and the function with some global registry
somewhere. Yeah, yeah, "*you just*", we have heard that before. You
could indeed just do that, but perhaps you want more:

- What if the developer that uses your framework uses `route('/foo')` in
  two places? Which one to pick? Does the last one registered win or
  should this be an error? If the framework should pick the last one,
  what *is* the last one? Does this depend on import order?
- What if there's an error? What if there is some configuration conflict
  or perhaps your framework decides the developer passed in bad meta
  data? Ideally you'd like to tell the developer that uses your
  framework exactly what decorators where have the problem.
- Perhaps you want to allow reuse: a developer can define a whole bunch
  of routes and then extend them with some extra routes for particular
  use cases.
- Perhaps you want to allow overrides: a developer can define a whole
  bunch of routes but then override specific ones for particular use
  cases.
- Perhaps you want your framework to be extensible with new decorators
  and new registries. How do you allow this in a way that still allows
  reuse, overrides and error reporting?

[Dectate](http://dectate.readthedocs.org/) takes care of all that stuff.
It is a documented and well-tested library, and it works for Python 2
and Python 3 code.

Dectate is a spin-off from the
[Morepath](http://morepath.readthedocs.org) web framework. Morepath is
great and you should use it. Morepath has had a sophisticated
configuration framework for some years now, but it had grown new
features over time, which resulted in a bit of cruft and it also was not
well documented. To remedy that and make some other improvements, I've
spun it into its own independent library now: Dectate. You can read more
about Dectate's history
[here](http://dectate.readthedocs.org/en/latest/history.html); Dectate
is an expression of many lessons learned over a long time.

It is my hope that Dectate goes beyond Morepath and will be considered
by other framework authors. Maybe someone will create a Dectate-based
configuration system for other web frameworks such as Django or Flask or
Pyramid. Or perhaps someone will use Dectate for some new framework
altogether, perhaps one not at all related to the web. Maybe *you* will!
Let me know.
