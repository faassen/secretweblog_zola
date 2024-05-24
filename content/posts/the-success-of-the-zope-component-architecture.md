+++
title = "The Success of the Zope Component Architecture"
date = 2009-11-06
slug = "the-success-of-the-zope-component-architecture"

[taxonomies]
tags = ["zope"]
+++

Prompted by recent brief negative
[pronunciations](http://mockit.blogspot.com/2009/11/emperors-new-clothes.html)
by Malthe on the Zope Component Architecture (ZCA), I thought I'd talk a
bit about what I think about it. I'm not going to go into hermeneutics
here of what Malthe might mean -- others attempts at exegesis exist in
the comments to that blog entry already. Instead, I'll just talk about
what I think makes the ZCA useful, and why it is successful. Finally
I'll go into some reasons why people are frustrated by the ZCA.

## What is the ZCA used for?

What is the ZCA used for? It's used to glue things to each other: glue
event handlers to events, glue views to models, glue plugins into
applications and libraries, and more abstractly, glue adapters to
adaptees. In ZCA terms, providing such glue is termed providing
_configuration_.

Why was the ZCA created? The Zope community had been building pluggable
web applications for a long time and we noticed our components became
overly complex and were hard to glue together and override. The ZCA is
one answer to this problem.

The ZCA is implemented by
[zope.component](http://pypi.python.org/pypi/zope.component). It's a
library for gluing. It's built on top of
[zope.interface](http://pypi.python.org/pypi/zope.interface), a library
that helps one define the bits that are being glued.

What advantage does such gluing bring?

- many, perhaps all, larger applications contain glue. The ZCA makes the
  glue explicit and uniform.
- ZCA glue can be overridden explicitly.
- you can extend existing systems by gluing in new things.

One place where the ZCA is helpful is when you want to write a library
that offers a few plugin points to configure it for a particular
environment. For instance when I wrote
[hurry.resource](http://pypi.python.org/pypi/hurry.resource), a library
for handling javascript and other resources, I included a few plugin
points in it that allow it to be plugged into a particular web
framework. Then to allow it to be used with Zope Toolkit-based
frameworks such as Grok, I wrote
[hurry.zoperesource](http://pypi.python.org/pypi/hurry.zoperesource) to
provide the knowledge about that.

This way, hurry.resource doesn't need to know anything in particular
about URL generation or requests; its plugins can take care of this.
This allowed me to write and test hurry.resource without worrying too
much about the larger Zope Toolkit framework, knowing I could plug it in
later, and now the library becomes more useful for a broader group of
people.

The ZCA doesn't just allow one to glue one thing to another, but also to
override the glue in specific cases. A common example of overriding glue
occurs with views. Zope Toolkit applications follow a view/model
approach, where the view is looked up on the model dependent on its
class (or interface). It happens frequently enough in an application
that I want many models to share a particular view, but override one
model with a more specialized view. This is much like the way
inheritance works in plain Python: I implement a method on a base class
shared completely by some subclasses, but for one subclass I'd like to
override it.

What I described just now is overriding for particular subclasses. The
ZCA also allows other ways of overriding based on the
[zope.configuration](http://pypi.python.org/pypi/zope.configuration)
library, overriding one glue registration with another one. I myself
find myself using this kind of override less frequently, but it's still
very useful in the 1 percent of cases where other options would be very
ugly.

The question is sometimes asked why not just modify code dynamically for
overrides? Why not _monkey patch_ it? (or "open the class", or whatever
other terminology one would like to use).

Brandon Rhodes at PyCon 2008 gave [a great
presentation](http://rhodesmill.org/brandon/adapters/) explaining why
the ZCA approach can be superior to monkey-patching and some other
approaches. The point he makes is that the ZCA is the most composable
and maintainable approach of the alternatives (subclassing, mixins,
monkey-patching, adaptation). I recommend everyone interested in this
topic to read his slides.

Of course as with everything in programming, everything depends on the
trade-offs. In many circumstances the ZCA is overkill. The ZCA can be
misused. But I also maintain that in many circumstances the ZCA is very
useful.

Component approaches have become quite popular with web frameworks. Many
popular ones adopt elements of it, but often in a somewhat limited way.
For instance, one very popular _interface_ is the WSGI interface, and
one popular form of _adaptation_ of this WSGI interface is to use WSGI
middleware and framework components. With WSGI we see that _just one_
well-defined, consensus interface has become an amazing source of
creativity and pluggability within web development. With the ZCA we are
able to define _more than one_ interface in our applications, and
potentially create ecosystems of creativity around those. Not that this
is easy, but at least we have a mechanism and method to do so.

## The ZCA is successful

Why do I say the Zope Component Architecture (ZCA) is successful? It's
successful as it's _being used_, by many people, for many years now. Of
course you can say it's only used by that weird Zope community, and a
bit by weird Twisted people as well perhaps. That's fine, but realize
that the wider Zope community is _big_ and is made of many parts: Plone,
Silva, Zope 2, Zope Toolkit, Grok. I'll also count BFG as part of the
wider Zope community.

The ZCA is successful for _me_. Without it, I'd have to invent something
very much like it. It comes back in much code that I've written. I'm
able to do all kinds of small, cool things in my applications and
libraries on a daily basis, and I'm creating more reusable code as a
result.

## Frustration with the ZCA

The ZCA isn't perfect. Humans aren't perfect, either. It's not easy to
create good reusable interfaces, or to build pluggable frameworks and
applications. It's easy to overdo the pluggability. It's easy to create
the wrong pluggability points. It can get overly complex and
overwhelming.

Writing XML configuration files to glue things together can be
cumbersome and lead to repeating yourself, though his last issue has
been overcome for some time now by the Grok project and its reusable
solution
([grokcore.component](http://pypi.python.org/pypi/grokcore.component))
is available to everybody.

It's easy to let the pain of the mistakes in the use of the ZCA, and the
pain of complex applications in which it is used in general, overshadow
the many successes of the ZCA: in a large part thanks to to the ZCA's
ability to glue things together people are able to use Zope Toolkit
libraries within a Zope 2 or Plone context. Grok was able to remix the
Zope Toolkit in part because we could easily modify and extend the
framework. I think the web frameworks that use the ZCA offer
pluggability and flexibility unrivaled by the competition.

We generally don't say that the problems and complexities in our large
libraries and applications are due to the Python programming language.
While Python isn't perfect, we tend to think overall it helps. I also
tend to think that the ZCA helps.

Are there alternatives to the ZCA? Certainly: any library or application
specific pluggability system is an alternative. Sometimes a specific
approach is better than a generic one. It can be easier to understand
it's smaller.

Usually I'd say it's the other way around. Each custom pluggability
system is another one to learn, and has its own limitations. I've found
multiple times that I can make a far more powerful pluggability system
for a library in a shorter time if I build it on top of the ZCA.

There are also more general approaches where there's at least some
overlap with the ZCA: setuptools entry points, WSGI middleware, and
PEAK-Rules. To use any of them for pluggability and overriding one needs
to have a notion of an interface one can implement and plug into, a
notion that the ZCA makes explicit.

## Conclusions

The ZCA is useful. The ZCA is powerful. The ZCA is successful. The ZCA
is imperfect. When I've run into its imperfections I've helped build
solutions on top of it, such as Grok's in-python gluing approach.
Sometimes I've considered its use overkill and gone for some other
approach. I think it's useful to step back and consider alternative
approaches. But let's consider them in the light of the success of the
ZCA as much as in the light of its flaws.
