+++
title = "Morepath 0.6 released!"
date = 2014-09-08
slug = "morepath-06-released"

[taxonomies]
tags = ["morepath", "python", "planetpython", "rest"]
+++

What's [Morepath](http://morepath.readthedocs.org)? Morepath is your
friendly neighborhood web framework with super powers. It lets you
easily create links between resources, and offers a range of mechanisms
that allow you to better organize and reuse code. Morepath is geared
towards this modern age of the web where more and more UI logic is
moving into JavaScript, into the browser -- it does this by being great
at creating RESTful hypermedia APIs.

Besides a few documentation fixes, [Morepath
0.6](http://morepath.readthedocs.org/en/0.6/changes.html) has a minor
improvement and a major improvement.

Both improvements have to do with a relatively obscure use case that I
ran into lately. Application composition _should_ be an important
feature in a modern web framework, and so does linking, but we only
rarely see things like this. That we run into use cases like this goes
to show just how far Morepath is ahead in exploring this area. See
[nesting
applications](http://morepath.readthedocs.org/en/latest/app_reuse.html#nesting-applications)
and [linking to things in other
apps](http://morepath.readthedocs.org/en/latest/app_reuse.html#linking-to-other-mounted-apps)
for more information on these subsystems of Morepath.

The major improvement is the ability to link to other applications by
the _name_ under which they've been mounted into their parent. By
default the name is the _path_ under which they were mounted. Imagine
you have the following URL space:

    /v1/
    /v1/a
    /v2/a

You can model this as two applications, `A` and `B` that are mounted
under a core application mounted at `v1`. That would look like this in
Morepath:

```python
class V1(morepath.App):
    pass

# makes a root object exist under /v1
@app.path(path='/v1')
class Root(object):
    pass

class A(morepath.App):
    pass

class B(morepath.App):
    pass

// mounts everything in app A under /v1/a
@V1.mount(app=A, path='a')
def a_context():
    return {}

// mounts everything in app B under /v1/b
@V1.mount(app=B, path='b')
def b_context():
    return {}
```

Consider how you'd make a link from app `A` to a resource in app `B`
given this setup. In Morepath before 0.6, you'd have to write:

```python
request.parent.child(B).link(obj)
```

This would create a link to whatever `obj` is (which depends on its
path), for instance:

    /v1/b/items/3

The minor improvement is that we realized the `.parent.child`
combination happens a lot and we've introduced a new
[sibling](http://morepath.readthedocs.org/en/latest/api.html#morepath.Request.sibling)
method to combine them in one step:

```python
request.sibling(B).link(obj)
```

Now considers what happens when a new incompatible version of your
overall API arises, because you've changed something fundamentally in
app `B`. Perhaps items appear on a `/foos` path instead of an `/items`
path, like:

    /v2/b/foos/3

You've not changed anything in app `A` though. What you'd like to do is
mount the new `B` and the old `A` into a `V2` app and have everything
work as expected:

```python
class V2(morepath.App):
    pass

// mounts everything in app A under /v2/a
@V2.mount(app=A, path='a')
def a_context():
    return {}

// mounts everything in app NewB under /v2/b
@V2.mount(app=NewB, path='b')
def b_context():
    return {}
```

But this is problematic, as we have a hardcoded dependency on app `B` in
app `A` in the link generation code. Now we'd like to link to app `NewB`
instead of `B`. But we'd want the original `v1` URLs to still work as
before, so we can't just modify app `A` so to include a link to `NewB`.
So in `/v1/a` we'd like links to look like this:

    /v1/b/items/3

But in `/v2/a` we'd like links to go to the new place in `NewB`:

    /v2/b/foos/3

The solution is the new ability to find mount applications by _name_
instead of by class. By the default the name is the same as the `path`
argument you give in the `mount` directive.

If you write linking code in app `A` to read like this:

```python
request.sibling('b').link(obj)
```

there is no more hardcoded dependency on app `B`. Instead the system now
relies on the sibling app mounted under `b` to create the link, whatever
it may be. And if `A` is mounted under `/v1` the sibling will be `B`,
but if it's mounted under `/v2` the sibling will be `NewB`. So the links
will be correct in both cases, and we're saved!
