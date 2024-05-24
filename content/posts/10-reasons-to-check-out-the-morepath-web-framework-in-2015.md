+++
title = "10 reasons to check out the Morepath web framework in 2015"
date = 2015-01-05
slug = "10-reasons-to-check-out-the-morepath-web-framework-in-2015"

[taxonomies]
tags = ["python", "planetpython", "morepath"]
+++

Happy new year everybody! Last year we've made a *lot* of progress on
the Morepath web framework for Python. It will go quite a lot further in
2015 as well. Here are 10 reasons why you should check out Morepath this
year:

1.  **Knows about HTTP status codes**. When you write a "Hello World"
    application it does not matter that there are other status codes
    besides `200 OK`, but in real world applications you want your
    application to know about `404 Not Found`, and
    `405 Method Not Allowed`, and so on.

    Morepath does not make you write write verbose and failure-prone
    special cased code to handle status codes. Instead, [Morepath does
    HTTP status codes correctly right
    away.](http://blog.startifact.com/posts/better-rest-with-morepath-08.html#what-about-http-status-codes)

2.  **Morepath makes hyperlinks to objects**. In a typical routing web
    framework, to make a URL, you need to remember the name of a route,
    the parameters that go into the route, and how to get that
    information from the object to which you are making the route. This
    leads to duplicated code and hardcodes route names everywhere. Since
    it does so little, it encourages you to skip it entirely and write
    even more hardcoded URL generation code everywhere.

    Morepath makes it *easier* to do the right thing. [Morepath lets you
    link to Python
    objects](http://morepath.readthedocs.org/en/latest/superpowers.html#link-with-ease).
    Morepath also understands URL parameters can be part of URLs too,
    and can create a link with them in there for you too.

3.  **Built-in permission system**. Morepath does not leave something as
    important as security entirely up to extensions. The core framework
    knows that views can be guarded with permissions. Who has what
    permission for what object is then up to you, and [Morepath lets you
    define permissions powerfully and
    succinctly.](http://morepath.readthedocs.org/en/latest/security.html)

4.  **Compose applications**. If you have a project application and a
    wiki application, you can mount the wiki application into the
    project applications. You can develop and test applications
    independently, and then combine them later. These are true
    coarse-grained components. This way, [Morepath lets build large
    applications out of smaller
    ones.](http://morepath.readthedocs.org/en/latest/building_large_applications.html)

5.  **All views are reusable**. Morepath does not have a separate
    sub-framework to let you write more reusable and generic views than
    the normal ones. Instead *any* view you create in Morepath is
    already reusable. And remember - you don't have to hardcode route
    names, which makes views more generic by default.

    Views in Morepath are true fine-grained reusable components, without
    extra work. [Morepath gives you the tools to build a generic
    UI](http://morepath.readthedocs.org/en/latest/superpowers.html#generic-ui).
    [You can reuse views with ease with
    Morepath.](http://morepath.readthedocs.org/en/latest/superpowers.html#composable-views)

6.  **Subclass applications**. Morepath does not have a separate
    sub-framework to let you write reusable blueprints for applications.
    Instead, *any* application you create in Morepath is already
    reusable in that way. In the real world, applications evolve into
    frameworks all the time, and Morepath does not stand in your way
    with special cases.

    [You can subclass any Morepath app to add new routes and views, or
    override existing
    ones.](http://morepath.readthedocs.org/en/latest/app_reuse.html)

7.  **Made for the modern web**. Many modern web applications feature a
    REST backend with a rich, client-side frontend written in
    JavaScript. [Morepath is written to support REST from the ground
    up](http://morepath.readthedocs.org/en/latest/rest.html) - it's not
    a layer over something else, but it's not a constraining HTTP API
    generation tool either.

8.  **Extensible framework**. Morepath lets you extend the web framework
    in the same way it lets you extend applications written in it. You
    can write new Morepath directives and framework applications. As
    examples,
    [more.static](http://morepath.readthedocs.org/en/latest/more.static.html)
    adds advanced browser static resource handling to Morepath,
    [more.transaction](https://pypi.python.org/pypi/more.transaction)
    integrates Morepath with transaction based databases such as
    SQLAlchemy and the ZODB, and
    [more.forwarded](https://pypi.python.org/pypi/more.forwarded/) adds
    HTTP Forwarded header support.

9.  **Micro framework with macro ambitions**. Morepath is a micro
    framework; it's not a lot of code. It's easy to get an overview of
    what's going on, and it's easy to embed in a larger application.
    **Morepath packs a lot more punch in a small amount of code than
    your typical Python micro web framework**.

    All this does not come at the cost of performance. **When the
    primary selling point of a Python web framework seems to be
    performance, perhaps it's not doing enough for you.** But Morepath
    has more than adequate performance - [on "Hello world" at least
    Morepath outpaces some very popular web Python frameworks
    comfortably](http://blog.startifact.com/posts/better-rest-with-morepath-08.html#faster).

10. **Documentation**. Some Python micro frameworks also have micro
    documentation. Instead, [Morepath has lots of
    docs](http://morepath.readthedocs.org).

Enjoy 2015!
