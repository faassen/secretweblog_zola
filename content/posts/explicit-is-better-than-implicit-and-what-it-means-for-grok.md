+++
title = "Explicit is better than implicit, and what it means for Grok"
date = 2008-04-01
slug = "explicit-is-better-than-implicit-and-what-it-means-for-grok"

[taxonomies]
tags = ["grok", "joke"]
+++

**This post was, of course, an April Fool's joke**

Grok has been using patterns like "Don't repeat yourself" and
"Convention over configuration" to make it more easy to work with Zope 3
code. It is now time to admit that this experiment has been a failure.
Explicit is better than implicit, after all, and we'll put up with
repeating ourselves a few times if we need to.

Consider the following example of Grok code in the module `foo.py`:

    import grok

    class MyModel(grok.Model):
        pass

    class Index(grok.View):
        pass

You then place a template in the module `foo_templates` called
`index.pt` and Grok will automatically associate the template. To add
code that helps render the template, you simply add methods to `Index`
and use them from the template.

All this _looks_ nice and easy, but people do need to remember rules
about base classes, and implicit association. Grok does offer more
explicit directives to do so:

    import grok

    grok.templatedir('foo_templates')

    class MyModel(grok.Model):
        pass

    class Index(grok.View):
      grok.context(MyModel)
      grok.name('index')
      grok.template('foo')

This also _seems_ like a nice approach at first. The problem with these
directives is that they clutter up your Python code, and distract you
from what is really going on. Instead of conveniently finding out (or
modifying) how your view is hooked up to your model and your template in
a separate XML file, you will have to look through the clutter of
registrations mixed with your Python code.

Wouldn't it be much nicer to be able to write everything down explicitly
and separately, like this:

    import persistent
    from zope.app.container.contained import Contained
    from zope.publisher.browser import BrowserPage

    class MyModel(Contained, persistent.Persistent):
       pass

    class MyView(BrowserPage):
       pass

And then we have a separate `configure.zcml` file containing the
following:

    <configure
      xmlns:browser="http://namespaces.zope.org/browser"
      xmlns="http://namespaces.zope.org/zope">

      <browser:page>
        for=".foo.MyModel"
        name="index"
        class=".foo.MyView"
        template="foo_templates/index.pt"
        permission="zope.Public" />

    </configure>

To encourage good security practices, we will make security pervasive.
Whenever you have a method on a model that you want to be called, for
instance `bar` on class `MyModel`, we should declare this in ZCML as
well:

    <class=".foo.MyModel">
      <require
        attributes="bar"
        permission="mypermission">
    </class>

Programming against interface is a good thing. Instead of associating
our view directly against `MyModel`, let's write a file `interfaces.py`
that spells out the interface that `MyModel` implements:

    from zope.interface import Interface

    class IMyModel(Interface):
      def bar():
         "The famous bar method"

Now we change `foo.py` to use the interface:

    import persistent
    from zope.app.container.contained import Contained
    from zope.publisher.browser import BrowserPage
    from zope.interface import implements
    from interfaces import IMyModel

    class MyModel(Contained, persistent.Persistent):
      implements(IMyModel)

    class MyView(BrowserPage):
      pass

And we change the ZCML to use that interface too:

    <configure
      xmlns:browser="http://namespaces.zope.org/browser"
      xmlns="http://namespaces.zope.org/zope"

      <browser:page
        for=".interfaces.IMyModel"
        name="index"
        class=".foo.MyView"
        template="foo_templates/index.pt"
        permission="zope.Public"
    </configure>

These abstractions are _always_ a good thing as our application will
undoubtedly grow. We have to refer to the name of the interface in a few
extra places, but the code becomes more understandable as a result.

We can then also declare security against interface instead of
implementation, which cuts down on the amount of writing we will have to
do if we have more than one method or attribute we want to protect! Like
this:

    <class class=".foo.MyModel"
      <require
        interface=".interfaces.IMyModel"
        permission="mypermission" />
    </class>

We will have to distinguish between a modification interface for
`MyModel` and an access-only interface for `MyModel` so we can assign
different permissions to different methods, though, for instance
`IReadModel` and `IWriteMyModel`.

In conclusion, I think everybody can clearly see that being explicit is
a good thing. The ZCML directives are separated out from the Python
code, making both the Python code easier to understand and the way
directives work very explicit and easier to remember. We make sure we
keep control by having everything explicit. Security is also very
explicit in the application, and as a result you can be secure from the
start.

So, Grok the caveman can go back into his cave. In fact we are
considering a next step very seriously: to get rid of the Python
language and going for a more explicit language like, for instance,
Java. It's only a small matter of rewriting our codebase. This April
first, 2008, Grok unsmashes ZCML, giving it back its rightful, explicit,
place in development.
