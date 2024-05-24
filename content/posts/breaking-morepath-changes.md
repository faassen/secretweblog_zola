+++
title = "Breaking Morepath Changes"
date = 2014-01-22
slug = "breaking-morepath-changes"

[taxonomies]
tags = ["planetpython", "python", "morepath"]
+++

I'm slowly heading to a first release of the Morepath web framework, but
right now I can still change anything without breaking any significant
code. So I took the opportunity to do so.

What's Morepath? Morepath is your friendly neighborhood web framework
with superpowers. Read more [here](http://morepath.readthedocs.org).

These changes are in fact less big than some refactorings I do to
Morepath frequently, but they break the public API of Morepath, so
they're big in that sense.

These are the changes:

- The `@app.model` directive was renamed to `@app.path`, as I realized
  the directive is describing a path more than a model. Here's what it
  looks like now:

  ``` python
  @app.path(model=Document, path='documents/{id}')
  def get_document(id):
      return query_document(id)
  ```

  The name is justified as such: just like the view directive describes
  a view, the path directive describes a path. Paths and views are
  related to each other by model class. The word `model` was rather
  overused in Morepath anyway.

- The `@app.view` directive decorates a function that's a view. It used
  to get `request, model` parameters. I've changed this to
  `self, request`, reversing the order. This to make it clearer to
  people that a view is really much like a method, and to free up the
  word `model` some more. Here's what it looks like:

  ``` python
  @app.view(model=Document)
  def document_default(self, request):
      return "Hello document: %s" % self.id
  ```

  `self` is not a reserved word in Python, so I figured this was a good
  place to use it, even though `document_default` really is a function,
  not a method. But since it's a generic function it's like a method
  anyway.

  The *lookup* of the view is still done giving `request` a greater
  weight than `model`, like in Pyramid. That's mostly an implementation
  detail in Morepath. In Pyramid this matters a lot more, but in
  Morepath there really isn't anything done yet with different request
  classes.

- The `@app.root` directive is now gone. It wasn't pulling its weight
  anymore, as it had become just an alias for `@app.path` with a `path`
  parameter of `"/"`. This is what it looks like now:

  ``` python
  @app.path(model=Root, path='/')
  def get_root():
      return the_root
  ```

(by the way, if the docs on the Morepath
[website](http://morepath.readthedocs.org) don't update for you, do a
shift reload. I'm not sure how long it takes for the cache to expire.)

Want to talk to me about Morepath? Leave a comment here, drop me an
email, use the [Morepath issue
tracker](https://github.com/morepath/morepath/issues?state=open) or join
the \#morepath IRC channel on freenode. Hope to hear from you!
