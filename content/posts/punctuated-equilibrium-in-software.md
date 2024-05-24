+++
title = "Punctuated Equilibrium in Software"
date = 2016-09-06
slug = "punctuated-equilibrium-in-software"

[taxonomies]
tags = ["software development", "morepath", "reg", "python", "planetpython"]
+++

# Punctuated equilibrium

[Punctuated
equilibrium](https://en.wikipedia.org/wiki/Punctuated_equilibrium) is a
concept in evolution theory. It was developed to explain a feature of
the fossil record: biological species appear quite suddenly and then
tend to be in relative stasis for a long period, only undergoing very
gradual changes. The species is in equilibrium with its environment.
Then suddenly this stasis is punctuated: there is a relatively brief
period where a large series of changes occur. This results in the
evolution of a new species. The rapid changes can be brought on by
changes in the environment, or by a lucky mutation in a single
individual that opens up a whole set of possibilities for subsequent
changes.

**I've noticed that software too can evolve with a pattern of punctuated
equilibrium.** I'll illustrate this using a Python library that I work
on: [Reg](http://reg.readthedocs.io). To explain how it evolved I need
to go into some detail about it. Luckily, Reg is quite an interesting
little library.

[Reg](http://reg.readthedocs.io) is predicate dispatch implementation
for Python. It didn't start out that way, but that's what it is now. The
[Morepath](http://morepath.readthedocs.io) web framework, which I also
work on, uses Reg to enable some powerful features. I'll refer to
Morepath a few places in this article as it provides use cases for Reg.

# Reg ancestry

The ancestor of Reg is the
[zope.interface](http://pypi.python.org/pypi/zope.interface) library,
which was created around the year 2002 by Jim Fulton. It is still in
very active use by large projects like the Pyramid web framework and the
Plone CMS.

`zope.interface` lets you define interfaces for Python objects. It's
similar to the Python `abc` module, though `zope.interface` came earlier
and is more general.

`zope.interface` also implements a registry that maps interface (or
type) to interface to support an adapter lookup pattern: you can adapt
an object of an interface (or type) to an object with an interface you
want.

In a web application you could for instance look up a HTML view
interface (API) for a given content object such as a document or a
someone's address, or whatever other type of content object you may have
in your system. We'll give an example of this in code when we get to
Reg.

The genesis of `zope.interface` took a few years and involved a
predecessor project. Like Reg itself it underwent evolution by
punctuated equilibrium in its early years. I describe this a bit in the
[Reg history](http://reg.readthedocs.io/en/latest/history.html)
document.

**I try to keep history documents describing the evolution of various
projects I work on, as I think they can provide insight into a project
beyond what the rest of the documentation can bring.** If you like
software history, see [Morepath
history](http://morepath.readthedocs.io/en/latest/history.html),
[Dectate history](http://dectate.readthedocs.io/en/latest/history.html)
and [Reg history](http://reg.readthedocs.io/en/latest/history.html).
(The Reg history overlaps with this article, so if you're curious to
learn more, do check it out later.)

After 2002 `zope.interface` became stable: its API hasn't changed much,
and neither has its implementation. There were a few small tweaks here
and there, in particular to add Python 3 compatibility, but that's it.
At some point around 2009 I made some proposals to improve its API, but
got nowhere. That's when I started playing around with the idea to
reimplement it for myself.

# The genesis of Reg

**It often takes a period of experimentation and play to create
something new. It's important during this phase not to think too much
about immediate practical goals.** Focus on a few core features that
interest you; don't worry about it covering everything. Banish any
thoughts about backwards compatibility and how to upgrade existing large
code bases; that would be detrimental to the spirit of playfulness.

_"Why are you reimplementing zope.interface, Martijn?"_

_"Just for fun, I don't expect anyone to use this."_

After a few years of occasional play with various ideas I had concerning
`zope.interface`, they finally started to come together in 2013. The
goal of Reg at the time was straightforward: it was to be like
`zope.interface`, but with an implementation I could understand, and
with a streamlined API.

I'm going to show sample code now. Be aware that the sample code in this
article may be somewhat fictional for educational purposes.

Reg initially worked like this:

```python
# the view API
class IView(reg.Interface):
    def __call__(self):
        "If you call this, you get a web representation."

# register implementation of the view API for Document and
# HTTP Request classes
@IView.register(Document, Request)
class DocumentToViewAdapter:
    def __init__(self, doc, request):
        self.doc = doc
        self.request = request

    def __call__(self):
        return "<p>%s</p>" % self.doc.content

# can register other implementations, for example for Address and
# Request

# create instances we can look up for
doc = Document()
request = Request()

# look up the view adapter for a specific object, in this case a document
# The specific implementation you find depends on the class of doc and
# request arguments
view = IView.adapt(doc, request)
# and get the representation
html = view()
```

Here we define an `IView` interface. You can then register adapters for
this view that take parameters (the object and a HTTP request) and turn
it into an object that can create a HTML representation of the
parameters.

# Major transition to generic functions

I worked with the `zope.interface` version of Reg for a while in the
context of the Morepath web framework. This gave me some practical
experience. I also talked about Morepath and Reg in public and got some
feedback. **Even minimal feedback is great; it sets thoughts into
motion.** I quickly realized that Reg's API could be simplified if I
centered it around [generic
functions](https://en.wikipedia.org/wiki/Generic_function) with
[multiple dispatch](https://en.wikipedia.org/wiki/Multiple_dispatch)
instead of interfaces and adapters. Something like this:

```python
# generic function definition instead of interface
@reg.generic
def view(obj, request):
    """"If you call this, you get a web representation."""
    raise NotImplemented

# an implementation for Document and Request
@view.register(Document, Request)
def document_view(obj, request):
    return "<p>%s</p>" % obj.content

# get representation for document by calling view()
html = view(doc, request)
```

This looks simpler. The interface definition is gone, the adapter class
is gone. We just have a function that dispatches on the type of its
arguments.

Reg worked like this for over a year. It was stable. I didn't foresee
any more large changes.

# Major transition to predicate dispatch

_Meanwhile..._

I created a predicate registry implementation. This lived inside of a
module in Reg, but it could as well have been in a totally different
library: the code was unrelated to the rest of Reg.

The use case for this predicate registry was Morepath view lookup. The
predicate system let you register objects by a selection of keys. You
could look up a view based on the `request_method` attribute (HTTP
`GET`, `POST`, etc) of the `request` object, for instance, not just by
type.

Two things came together in the fall of 2014:

- I realized that it was annoying that the multiple dispatch system
  automatically dispatched on _all_ arguments to the function -- in many
  cases that wasn't required.
- I needed the predicate system to understand about types and
  inheritance. The multiple dispatch system in Reg understood types but
  not predicates, and the predicate dispatch system understood
  predicates but not types.

Then I realized that if I generalized Reg and turned it into a
[predicate dispatch](https://en.wikipedia.org/wiki/Predicate_dispatch)
system, I could actually unify the two systems. **The dialectic (thesis,
antithesis, synthesis) is a strong force for creativity in software
development**

With predicate dispatch you can dispatch on _any_ aspect of the
arguments to a function; not just its class but also any attribute of
it. You can still do multiple dispatch as before: dispatch on the type
of an argument is now just be a special case. Since arguments now needed
a description of what predicate they dispatch on, I could also have
arguments that are ignored by the dispatch system altogether.

This is when I finally understood some of the reasoning behind the
[PEAK-Rules](https://pypi.python.org/pypi/PEAK-Rules) library, which is
a Python predicate dispatch implementation that predates Reg by many
years. **Almost everything has been implemented before, but with
reimplementation you gain understanding.**

With that insight, the equilibrium was punctuated, and Reg underwent
rapid change again. Now it looked like this:

```python
# dispatch function instead of generic function
# note how we explicitly name the arguments we want to match on
# (obj, request) in the predicates, and how we match on the
# request_method attribute. match_instance still matches on type.
@reg.dispatch(reg.match_instance('obj'),
              reg.match_key('request_method',
                            lambda request: request.request_method))
def view(obj, request):
    raise NotImplemented

# an implementation for GET requests of documents
@view.register(obj=Document, request_method='GET')
def document_view(obj, request):
    return "<p>%s</p>" % obj.content

# get representation for document by calling view()
html = view(doc, request)
```

When we define a dispatch function, we can now precisely describe on
what aspects of the arguments we want to do dispatch. When we register
an implementation, we can use more than just the types of the arguments.
We can also have arguments that do not play a role in dispatch at all.

This system allows Morepath to have views looked up by the type of the
instance being represented, the last name in the path (`/edit`,
`/details`), the HTTP request method (`GET`, `POST`, etc), and the type
of object in the `POST` body, if any.

I succeeded in making predicates participate in the cache that I already
had to speed up multiple dispatch, so this change both simplified and
increased performance.

# Major transition to dispatch methods

After this huge change, Reg was stable again for almost 2 years. I
didn't think it needed further major changes. I was wrong.

The trigger was clear this time, as it was a person. Stefano Taschini,
who started contributing to the Morepath web framework project.
Stefano's a very smart guy, so I'm doing my best to learn from him.
**Listen hard, even if your impulse, like mine, is to defend your design
decisions.** I was lucky that Stefano started to think about Reg. So
while Reg seemed outwardly stable, the pressure for change was slowly
building up.

In the summer of 2016 Stefano and I had a lot of discussions and created
a few branches of Reg and Morepath. All that work has now landed in
master of Reg and Morepath. The implementation of Reg is simpler and
more explicit, and its performance has been increased. Yet again we had
a major punctuation in the evolution of Reg.

I mentioned before how the code samples in this article are somewhat
fictional. One fiction is the way you register implementations in Reg.
It didn't actually work this way until now. Instead of this:

```python
@view.register(obj=Document, request_method='GET')
def document_view(obj, request):
    return "<p>%s</p>" % obj.content
```

until very recently, you'd write something like this:

```python
r = reg.Registry()

def document_view(obj, request):
    return "<p>%s</p>" % obj.content

r.register(view, document_view, obj=Document, request_method='GET')
```

So, we used to have an explicit registry object in Reg. This was there
because of a use case of Reg that I haven't told you about yet: we need
it to support separate dispatch contexts in the same run-time. Morepath
uses this let you compose a larger web application out of multiple
smaller ones, each with their own context.

To control which context Reg used you could pass in a special magic
`lookup` parameter to each dispatch function call:

```python
view(doc, request, lookup=registry)
```

Dispatch implementations needed access to the context too. They could
get to it by defining a magic lookup argument in their signature:

```python
def document_view(obj, request, lookup):
    return "<p>%s</p>" % process_content(obj.content, lookup=lookup)
```

If you didn't specify the `lookup`, an implicit thread-local lookup was
used.

All this wasn't ideal. During the creation of Reg I was fully aware of
Python's mantra "explicit is better than implicit", but I didn't know a
better way to make context-specific dispatch calls work. I tried my best
to at least isolate the implicit behavior in a well-controlled portion
of Reg, and to allow a fully explicit option with `lookup` arguments,
but the machinery to support all this was more complex than I'd wish.

When Stefano and I discussed this we came up with the following ideas:

- Remove multiple registries. Instead allow simple registration on
  dispatch functions as we've already seen in the examples above. Each
  function keeps its own private registry. Stefano pushed hard for this
  while I was resistant, but he was right.
- To control context, introduce the notion of dispatch _methods_. Build
  dispatch methods on dispatch functions.

A dispatch method is associated with a context class:

```python
class Context:
    @reg.dispatch_method(reg.match_instance('obj'))
    def foo(self, obj):
        raise NotImplementedError()
```

You can register implementations with the method:

```python
@Context.foo.register(obj=Document)
def implementation(self, obj):
    ...
```

When you call the dispatch method you call it in its context:

```python
c = Context()
c.foo(doc)
```

Each subclass of the context class creates a _new_ context, with a fresh
set of registrations:

```python
# a completely new and clean context
class NewContext(Context):
    pass
```

Instead of a magic `lookup` argument to call a generic function in a
particular context, you simply use `self` as the instance of the
context. This fits Python a lot better and is faster as well. Magical
lookup arguments were gone. Thread-local implicit context was gone too.
All is well. With Stefano on board now, Reg's [bus
factor](https://en.wikipedia.org/wiki/Bus_factor) has doubled too.

# A new period of stasis?

**Large changes create room for further changes**. We've already seen a
lot of follow-on changes, especially in the area of performance, and I
think we haven't seen the end of this yet. I am starting to understand
now why PEAK-Rules has AST manipulation code. We may not quite have
reached a point of equilibrium yet.

But after that performance engineering, surely Reg won't need any
further drastic changes anymore? I can't think of any. But I've been
here several times before. `zope.interface` is assumed to be done; Reg
isn't. **If you assume a project is done that could become a
self-fulling prophecy and cause the project to stagnate before its
time.**

# Dare to change

Reg is a piece of software that sits at the lower levels of our software
stack. Morepath is on top of it, and applications built with it are on
top of that. I've been impressed by how much of the underlying codebase
of Morepath we've been able to change without breaking Morepath
applications much.

Of course the amount of code written with Morepath is insignificant
compared to that written with web frameworks like Django or Flask or
Pyramid, so we can still afford to be be bold -- now, when the community
is still small, before many more people join us, is the time to make
changes. That is why we can play with a cool technique like predicate
dispatch that while not new, is still unfamiliar to many. **It is also a
creative challenge to make the unfamiliar approachable.**

If you're interested in any of this and want to talk to us, the Morepath
devs [are one click away](https://discord.gg/0xRQrJnOPiRsEANa).

**Self-serving mercenary statement**: if you need a developer and like
what you hear, talk to me -- I'm on the [lookout for interesting
projects](/posts/looking-for-project.html).
