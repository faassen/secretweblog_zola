+++
title = "New Year's Python Meme"
date = 2009-12-28
slug = "new-year-s-python-meme"

[taxonomies]
tags = ["python", "rest", "planetpython"]
+++

From
[Tarek](http://tarekziade.wordpress.com/2009/12/28/new-years-python-meme/)
through
[Lennart](http://regebro.wordpress.com/2009/12/28/new-year%E2%80%99s-python-meme/):

## 1. What’s the coolest Python application, framework or library you have discovered in 2009?

Not quote Python, but I've been busy exploring various Javascript libraries
and frameworks. I already knew YUI in 2008, and this year I've explored JQuery
and affiliated extensions quite a bit.

I think I've had the most exploratory fun with JSON Template (Python and
Javascript implementations both).

I started to use [zest.releaser](https://pypi.org/project/zest.releaser/) and
this has made it a lot easier for me to release Python packages.

I only recently started using [pyflakes](https://pypi.org/project/pyflakes/),
and it's been quite useful. A neat tool to supplement my toolbox.

There are other things I ran into that do seem cool but I can't really
feel I've fully discovered them as I haven't really had a chance to
use them.

## 2. What new programming technique did you learn in 2009?

If I can count techniques I've been trying to pioneer myself:
Template-driven development where the web browser renders the
templates. This along with the notion of client-side _views_ can lead
to surprisingly clean rich client-side apps.

I also learned quite a bit about dependency management in a large
collection of related libraries.

## 3. What’s the name of the open source project you contributed the most in 2009? What did you do?

[Grok](https://github.com/zopefoundation/grok) and the [Zope
Toolkit](https://zopetoolkit.readthedocs.io/en/latest/). I'm not sure which
one comes first, but luckily they're related. The Zope Toolkt is a set of
libraries based on a refocused Zope 3. It's used by the Zope community in a
multitude of projects, including Grok.

I also contributed a bit to JSON Template, making it possible to
distribute its Python implementation on PyPI.

I've created a whole set of libraries:

- [z3c.listjs](https://pypi.org/project/z3c.listjs/) (Zope specific)
- [hurry.custom](https://pypi.org/project/hurry.custom/) (mostly Zope specific)
- [hurry.filesize](https://pypi.org/project/hurry.filesize/) (generic)
- [traject](https://pypi.org/project/traject/ (generic)
- [megrok.traject](https://pypi.org/project/megrok.traject/) (Grok specific)
- [clio](https://pypi.org/project/clio/) (based on SQLAlchemy)
- [hurry.jqueryui](https://pypi.org/project/hurry.jqueryui/) (generic)

[hurry.resource](https://pypi.org/project/hurry.resource/) should get a
honorary mention. I actually created it in 2008, but it has seen quite a bit of
uptake by others in 2009. People have been wrapping a number of Javascript and
CSS frameworks with it.

hurry.resource is a general way to distribute and reuse javascript and
css libraries in a fine-grained manner. You should be able to
integrate it with any web framework.

In terms of bang for the buck, I think there were two projects I was
involved in that had the most effect:

- refocusing Zope 3 as the Zope Toolkit and improving the way in which
  it is being developed and managed.

- cleaning up the dependencies of the Zope Toolkit. Cleaner
  dependencies help us cut out unused code, making the code base
  easier to understand, reuse and improve.

  In 2007 we had split up Zope into a collection of libraries. The
  dependency relationships between these libraries was rather
  convoluted, however, meaning that pulling in a single library would
  frequently pull in all the others.

  We had a long-standing wish to clean up these dependencies but
  unfortunately were making up slow progress. The project was however
  daunting.

  In early 2009, I organized a sprint that tackled this project
  head-on, cleaning up dependencies and also developing techniques,
  insights and tools.

  This project has been picked up by a large group of Zope developers
  throughout the year. Different people at different time cleaned up
  this and that, resulting in a vastly improved dependency structure
  compared to last year.

  The gains made by the Zope Toolkit are now making their way into
  Grok and Zope 2.

## 4. What was the Python blog or website you read the most in 2009?

planet.python.org, though that's of course lots of blogs really. I've
also read the Python programming reddit a lot.

## 5. What are the three top things you want to learn in 2010?

I find it easier to say what I want to hack on, undoubtedly learning much as a
side effect:

- a new, lightweight publisher for the Zope Toolkit
- making Grok smaller and more lightweight
- rich client-side frameworks talking to RESTful backends

There's a lot more I'd like to hack on, so we'll see what I get around to.
