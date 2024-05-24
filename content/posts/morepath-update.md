+++
title = "Morepath Update"
date = 2014-01-20
slug = "morepath-update"

[taxonomies]
tags = ["python", "planetpython", "morepath"]
+++

I've been hard at work on [Morepath](http://morepath.readhtedocs.org)
recently, and I thought I'd give an update. Morepath is your friendly
neighborhood Python web framework with super powers.

# Models and linking

URL parameters are now a first-class citizen in Morepath model-link
generation, meaning that you can generate a link like:

    /document?id=100

as easily as a link like this:

    /document/100

with the same invocation:

    request.link(doc)

It just depends on how you register the document.

Morepath can now also automatically decode the string `"100"` into the
int `100` and encode it back again, and this is extensible to other
kinds of objects.

Much more about this can be found in the [model and
linking](http://morepath.readthedocs.org/en/latest/models_and_linking.html)
section in the Morepath documentation.

# Views

Views also have had their own powers and capabilities for a while.

Writing a generic view is as easy as writing any view in Morepath. You
can extend view matching with new predicates, and composing views
programmatically is as easy as calling `request.view()`.

What's new are the docs. [Read much more about
views](http://morepath.readthedocs.org/en/latest/views.html).

# Comparing Morepath with other web frameworks

There are so many web frameworks, why should you even consider Morepath?
I attempted to give a bit of background on how Morepath is the same and
how it is different, and why, in the [Comparison with other Web
Frameworks](http://morepath.readthedocs.org/en/latest/compared.html)
document.

# Feedback

Even a little bit of feedback can be enormously helpful to me, so I
invite everybody again to leave a comment, drop me a mail, or join us on
the tiny but growing `#morepath` IRC channel on freenode!

Join the Morepath in the early days and gain "I was there at the time"
bragging rights!
