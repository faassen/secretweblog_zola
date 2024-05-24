+++
title = "Framework Patterns"
date = 2019-12-04
slug = "framework-patterns"

[taxonomies]
tags = ["python", "planetpython", "morepath", "framework"]
+++

A software framework is code that calls your (application) code. That's
how we distinguish a framework from a library. Libraries have aspects of
frameworks so there is a gray area.

My friend Christian Theune puts it like this: a framework is a text
where you fill in the blanks. The framework defines the grammar, you
bring some of the words. The words are the code you bring into it.

If you as a developer use a framework, you need to tell it about your
code. You need to tell the framework what to call, when. Let's call this
_configuring_ the framework.

There are many ways to configure a framework. Each approach has its own
trade-offs. I will describe some of these framework configuration
patterns here, with brief examples and mention of some of the
trade-offs. Many frameworks use more than a single pattern. I don't
claim this list is exhaustive -- there are more patterns.

The patterns I describe are generally language agnostic, though some
depend on specific language features. Some of these patterns make more
sense in object oriented languages. Some are easier to accomplish in one
language compared to another. Some languages have rich run-time
introspection abilities, and that make certain patterns a lot easier to
implement. A language with a powerful macro facility will make other
patterns easier to implement.

Where I give example code, I will use Python. I give some abstract code
examples, and try to supply a few real-world examples as well. The
examples show the framework from the perspective of the application
developer.

# Pattern: Callback function

The framework lets you pass in a callback function to configure its
behavior.

## Fictional example

This is a <span class="title-ref">Form</span> class where you can pass
in a function that implements what should happen when you save the form.

```python
from framework import Form

def my_save(data):
    ... application code to save the data somewhere ...

my_form = Form(save=my_save)
```

## Real-world example: Python map

A real-world example: <span class="title-ref">map</span> is a
(nano)framework that takes a (pure) function:

```python
>>> list(map(lambda x: x * x, [1, 2, 3]))
[1, 4, 9]
```

You can go very far with this approach. Functional languages do. If you
glance at React in a certain way, it's configured with a whole bunch of
callback functions called React components, along with more callback
functions called event handlers.

## Trade-offs

I am a big fan of this approach as the trade-offs are favorable in many
circumstances. In object-oriented languages this pattern is sometimes
ignored because people feel they need something more complicated like
pass in some fancy object or do inheritance, but I think callback
functions should in fact be your first consideration.

Functions are simple to understand and implement. The contract is about
as simple as it can be for code. Anything you may need to implement your
function is passed in as arguments by the framework, which limits how
much knowledge you need to use the framework.

Configuration of a callback function can be very dynamic in run-time --
you can dynamically assemble or create functions and pass them into the
framework, based on some configuration stored in a database, for
instance.

Configuration with callback functions doesn't really stand out, which
can be a disadvantage -- it's easier to see someone subclasses a base
class or implements an interface, and language-integrated methods of
configuration can stand out even more.

Sometimes you want to configure multiple related functions at once, in
which case an object that implements an interface can make more sense --
I describe that pattern below.

It helps if your language has support for function closures. And of
course your language needs to actually support first class functions
that you can pass around -- Java for a long time did not.

# Pattern: Subclassing

The framework provides a base-class which you as the application
developer can subclass. You implement one or more methods that the
framework will call.

## Fictional example

```python
from framework import FormBase

class MyForm(FormBase):
    def save(self, data):
        ... application code save the data somewhere ...
```

## Real-world example: Django REST Framework

Many frameworks offer base classes - Django offers them, and Django REST
Framework even more.

Here's an example from Django REST Framework:

```python
class AccountViewSet(viewsets.ModelViewSet):
    """
    A simple ViewSet for viewing and editing accounts.
    """
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
    permission_classes = [IsAccountAdminOrReadOnly]
```

A <span class="title-ref">ModelViewSet</span> does a lot: it implements
a lot of URLs and request methods to interact with them. It integrates
with Django's ORM so that you get a REST API that you can use to create
and update database objects.

## Subclassing questions

When you subclass a class, this is what you might need to know:

- What base classes are there?
- What methods can you override?
- When you override a method, can you call other methods on
  <span class="title-ref">self</span>
  (<span class="title-ref">this</span>) or not? Is there is a particular
  order in which you are allowed to call these methods?
- Does the base class provide an implementation of this method, or is it
  really empty?
- If the base class provides an implementation already, you need to know
  whether it's intended to be supplemented, or overridden, or both.
- If it's intended to be supplemented, you need to make sure to call
  this method on the superclass in your implementation.
- If you can override a method entirely, you may need to know what
  methods to use to to play a part in the framework -- perhaps other
  methods that can be overridden.
- Does the base class inherit from other classes that also let you
  override methods? when you implement a method, can it interact with
  other methods on these other classes?

## Trade-offs

Many object-oriented languages support inheritance as a language
feature. You can make the subclasser implement multiple related methods.
It seems obvious to use inheritance as a way to let applications use and
configure the framework.

It's not surprising then that this design is very common for frameworks.
But I try to avoid it in my own frameworks, and I often am frustrated
when a framework forces me to subclass.

The reason for this is that you as the application developer have to
start worrying about many of the questions above. If you're lucky they
are answered by documentation, though it can still take a bit of effort
to understand it. But all too often you have to guess or read the code
yourself.

And then even with a well designed base class with plausible overridable
methods, it can still be surprisingly hard for you to do what you
actually _need_ because the contract of the base class is just not right
for your use case.

Languages like Java and TypeScript offer the framework implementer a way
to give you guidance
(<span class="title-ref">private/protected/public</span>,
<span class="title-ref">final</span>). The framework designer can put
hard limits on which methods you are allowed to override. This takes
away some of these concerns, as with sufficient effort on the part of
the framework designer, the language tooling can enforce the contract.
Even so such an API can be complex for you to understand and difficult
for the framework designer to maintain.

Many languages, such as Python, Ruby and JavaScript, don't have the
tools to offer such guidance. You can subclass any base class. You can
override any method. The only guidance is documentation. You may feel a
bit lost as a result.

A framework tends to evolve over time to let you override more methods
in more classes, and thus grows in complexity. This complexity doesn't
grow just linearly as methods get added, as you have to worry about
their interaction as well. A framework that has to deal with a variety
of subclasses that override a wide range of methods can expect less from
them. Too much flexibility can make it harder for the framework to offer
useful features.

Base classes also don't lend themselves very well to run-time dynamism -
some languages (like Python) _do_ let you generate a subclass
dynamically with custom methods, but that kind of code is difficult to
understand.

I think the disadvantages of subclassing outweigh the advantages for a
framework's external API. I still sometimes use base classes
_internally_ in a library or framework -- base classes are a lightweight
way to do reuse there. In this context many of the disadvantages go
away: you are in control of the base class contract yourself and you
presumably understand it.

I also sometimes use an otherwise empty base class to define an
interface, but that's really another pattern which I discuss next.

# Pattern: interfaces

The framework provides an interface that you as the application
developer can implement. You implement one or more methods that the
framework calls.

## Fictional example

```python
from framework import Form, IFormBackend

class MyFormBackend(IFormBackend):
    def load(self):
        ... application code to load the data here ...

    def save(self, data):
        ... application code save the data somewhere ...

my_form = Form(MyFormBackend())
```

## Real-world example: Python iterable/iterator

The iterable/iterator protocol in Python is an example of an interface.
If you implement it, the framework (in this case the Python language)
will be able to do all sorts of things with it -- print out its
contents, turn it into a list, reverse it, etc.

```python
class RandomIterable:
    def __iter__(self):
         return self
    def next(self):
        if random.choice(["go", "stop"]) == "stop":
            raise StopIteration
        return 1
```

## Faking interfaces

Many typed languages offer native support for interfaces. But what if
your language doesn't do that?

In a dynamically typed language you don't really _need_ to do anything:
any object can implement any interface. It's just you don't really get a
lot of guidance from the language. What if you want a bit more?

In Python you can use the standard library
<span class="title-ref">abc</span> module, or
<span class="title-ref">zope.interface</span>. You can also use the
<span class="title-ref">typing</span> module and implement base classes
and in Python 3.8, [PEP-544](https://www.python.org/dev/peps/pep-0544)
protocols.

But let's say you don't have all of that or don't want to bother yet as
you're just prototyping. You can use a simple Python base class to
describe an interface:

```python
class IFormBackend:
    def load(self):
        "Load the data from the backend. Should return a dict with the data."
        raise NotImplementedError()

    def save(self, data):
        "Save the data dict to the backend."
        raise NotImplementedError()
```

It doesn't do anything, which is the point - it just describes the
methods that the application developer should implement. You could
supply one or two with a simple default implementation, but that's it.
You may be tempted to implement framework behavior on it, but that
brings you into base class land.

## Trade-offs

The trade-offs are quite similar to those of callback functions. This is
a useful pattern to use if you want to define related functionality in a
single bundle.

I go for interfaces if my framework offers a more extensive contract
that an application needs to implement, especially if the application
needs to maintain its own internal state.

The use of interfaces can lead to clean composition-oriented designs,
where you adapt one object into another.

You can use run-time dynamism like with functions where you assemble an
object that implements an interface dynamically.

Many languages offer interfaces as a language feature, and any
object-oriented language can fake them. Or have too many ways to do it,
like Python.

# Pattern: imperative registration API

You register your code with the framework in a registry object.

When you have a framework that dispatches on a wide range of inputs, and
you need to plug in application specific code that handles it, you are
going to need some type of registry.

What gets registered can be a callback or an object that implements an
interface -- it therefore builds on those patterns.

The application developer needs to call a registration method
explicitly.

Frameworks can have specific ways to configure their registries that
build on top of this basic pattern -- I will elaborate on that later.

## Fictional Example

```python
from framework import form_save_registry

def save(data):
   ... application code to save the data somewhere ...

# we configure what save function to use for the form named 'my_form'
form_save_registry.register('my_form', save)
```

## Real-world example: Falcon web framework

A URL router such as in a web framework uses some type of registry. Here
is an example from the Falcon web framework:

```python
class QuoteResource:
    def on_get(self, req, resp):
        ... user code ...

api = falcon.API()
api.add_route('/quote', QuoteResource())
```

In this example you can see two patterns go together:
<span class="title-ref">QuoteResource</span> implements an (implicit)
interface, and you register it with a particular route.

Application code can register handlers for a variety of routes, and the
framework then uses the registry to match a request's URL with a route,
and then can all into user code to generate a response.

## Trade-offs

I use this pattern a lot, as it's easy to implement and good enough for
many use cases. It has a minor drawback: you can't easily see that
configuration is taking place when you read code. Sometimes I expose a
more sophisticated configuration API on top of it: a DSL or language
integrated registration or declaration, which I discuss later. But this
is foundational.

Calling a method on a registry is the most simple and direct form to
register things. It's easy to implement, typically based on a hash map,
though you can also use other data structures, such as trees.

The registration order can matter. What happens if you make the same
registration twice? Perhaps the registry rejects the second
registration. Perhaps it allows it, silently overriding the previous
one. There is no general system to handle this, unlike patterns which I
describe later.

Registration can be done anywhere in the application which makes it
possible to configure the framework dynamically. But this can also lead
to complexity and the framework can offer fewer guarantees if its
configuration can be updated at any moment.

In a language that supports import-time side effects, you can do your
registrations during import time. That makes the declarations stand out
more. This is simple to implement, but it's also difficult to control
and understand the order of imports. This makes it difficult for the
application developer to do overrides. Doing a lot of work during import
time in general can lead to hard to predict behavior.

# Pattern: convention over configuration

The framework configures itself automatically based on your use of
conventions in application code. Configuration is typically driven by
particular names, prefixes, and postfixes, but a framework can also
inspect other aspects of the code, such as function signatures.

This is typically layered over the procedural registration pattern.

Ruby on Rails made this famous. Rails will automatically configure the
database models, views and controllers by matching up names.

## Fictional example

```python
# the framework looks for things prefixed form_save_. It hooks this
# up with `myform` which is defined elsewhere in a module named `forms`
def form_save_myform(data):
   ... application code to save the data somewhere ...
```

## Real-world example: pytest

pytest uses convention over configuration to find tests. It looks for
modules and functions prefixed by <span class="title-ref">test\_</span>.

pytest also goes further and inspects the arguments to functions to
figure out more things.

```python
def test_ehlo(smtp_connection):
    response, msg = smtp_connection.ehlo()
    assert response == 250
    assert 0  # for demo purposes
```

In this example, pytest knows that
<span class="title-ref">test_ehlo</span> is a test, because it is
prefixed with <span class="title-ref">test\_</span>. It also knows that
the argument <span class="title-ref">smtp_connection</span> is a fixture
and looks for one in the same module (or in its package).

Django uses convention over configuration in places, for instance when
it looks for the variable <span class="title-ref">urlpatterns</span> in
a specially named module to figure out what URL routes an application
provides.

## Trade-offs

Convention over configuration can be great. It allows the user to type
code and have it work without _any_ ceremony. It can enforce useful
norms that makes code easier to read -- it makes sense to prefix tests
with <span class="title-ref">test\_</span> anyway, as that allows the
human reader to recognize them.

I like convention over configuration in moderation, for some use cases.
For more complex use cases I prefer other patterns that allow
registration with minimal ceremony by using features integrated into the
language, such as annotation or decorator syntax.

The more conventions a framework has, the more disadvantages show up.
You have to learn the rules, their interactions, and remember them. You
may sometimes accidentally invoke them even though you don't want to,
just by using the wrong name. You may want to structure your
application's code in a way that would be very useful, but doesn't
really work with the conventions.

And what if you wanted your registrations to be dynamic, based on
database state, for instance? Convention over configuration is a
hindrance here, not a help. The developer may need to fall back to a
different, imperative registration API, and this may be ill-defined and
difficult to use.

It's harder for the framework to implement some patterns -- what if
registrations need to be parameterized, for instance? That's easy with
functions and objects, but here the framework may need more special
naming conventions to let you influence that. That may lead the
framework designer to use classes over functions, as in many languages
these can have attributes with particular names.

Static type checks are of little use with convention over configuration
-- I don't know of a type system that can enforce you implement various
methods if you postfix your class with the name
<span class="title-ref">View</span>, for instance.

If you have a language with enough run-time introspection capabilities
such as Ruby, Python or JavaScript, it's pretty easy to implement
convention over configuration. It's a lot harder for languages that
don't offer those features, but it may still be possible with sufficient
compiler magic. But those same languages are often big on being
explicit, and convention over configuration's magic doesn't really fit
well with that.

# Pattern: metaclass based registration

When you subclass a framework-provided baseclass, it gets registered
with the framework.

Some languages such as Python and Ruby offer meta-classes. These let you
do two things: change the behavior of classes in fundamental ways, and
do side-effects when the class is imported. You can do things during
class declaration that you normally only can do during instantiation.

A framework can exploit these side-effects to do some registration.

## Fictional example

```python
from framework import FormBase

class MyForm(FormBase):
    def save(self, data):
        ... application code save the data somewhere ...

# the framework now knows about MyForm without further action from you
```

## Real-world example: Django

When you declare a Django model by subclassing from its
<span class="title-ref">Model</span> base class, Django automatically
creates a new relational database table for it.

```python
from django.db import models

class Person(models.Model):
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
```

## Trade-offs

I rarely use these because they are so hard to reason about and because
it's so easy to break assumptions for the person who subclasses them.

Meta-classes are notoriously hard to implement. If they're not
implemented correctly, they can also lead to surprising behavior that
you may need to deal with when you use the framework. Basic assumptions
that you may have about the way a class behaves can go out of the door.

Import-time side-effects are difficult to control -- in what order does
this happen?

Python has a simpler way to do side-effects for class declarations using
decorators.

A base-class driven design for configuration may lead the framework
designer towards meta-classes, further complicating the way the
framework uses.

Many languages don't support this pattern. It can be seen as a special
case of language integrated registration, discussed next.

# Pattern: language integrated registration

You configure the application by using framework-provided annotations
for code. Registrations happen immediately.

Many programming languages offer some syntax aid for annotating
functions, classes and more with metadata. Java has annotations. Rust
has attributes. Python has decorators which can be used for this purpose
as well.

These annotations can be used as a way to drive configuration in a
registry.

## Fictional example

```python
from framework import form_save_registry

# we define and configure the function at the same time
@form_save_registry.register('my_form')
def save(data):
   ... application code to save the data somewhere ...
```

## Real-world example: Flask web framework

A real-world example is the <span class="title-ref">@app.route</span>
decorator of the Flask web framework.

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'
```

## Trade-offs

I use this method of configuring software sometimes, but I'm also aware
of its limitations -- I tend to go for language integrated
_declaration_, discussed below, which looks identical to the end user
but is more predictable.

I'm warier than most about exposing this as an API to application
developers, but am happy to use it inside a library or codebase, much
like base classes. The ad-hoc nature of import-time side effects make me
reach for more sophisticated patterns of configuration when I have to
build a solid API.

This pattern is lightweight to implement at least in Python -- it's not
much harder than a registry. Your mileage will vary dependent on
language. Unlike convention over configuration, configuration is
explicit and stands out in code, but the amount of ceremony is kept to a
minimum. The configuration information is co-located with the code that
is being registered.

Unlike convention over configuration, there is a natural way to
parameterize registration with metadata.

In languages like Python this is implemented as a possibly significant
import-time side-effect, and may have surprising import order
dependencies. In a language like Rust this is done by compiler macro
magic -- I think the Rocket web framework is an example, but I'm [still
trying to understand how it
works](https://mobile.twitter.com/faassen/status/1198341833060999169).

# Pattern: DSL-based declaration

You use a DSL (domain specific language) to configure the framework.
This DSL offers some way to hook in custom code. The DSL can be an
entirely custom language, but you can also leverage JSON, YAML or
(shudder) XML.

You can also combine these: I've helped implement a workflow engine
that's configured with JSON, and expressions in it are a subset of
Python expressions with a custom parser and interpreter.

It is typically layered over some kind of imperative registration
system.

## Fictional example

```JSON
{
   "form": {
     "name": "my_form",
     "save": "my_module.save"
   }
}
```

We have a custom language (in this case done with JSON) that lets us
configure the way our system works. Here we plug in the
<span class="title-ref">save</span> behavior for
<span class="title-ref">my_form</span> by referring to the function
<span class="title-ref">save</span> in some Python module
<span class="title-ref">my_module</span>.

## Real-world example: Plone CMS framework

[Pyramid](https://trypyramid.com/) and [Plone](https://plone.org/) both
are descendants of
[Zope](@/posts/my-exit-from-zope.md), and
you can use ZCML, a XML-derived configuration language with them both.

Here is some ZCML from Plone:

```XML
<configure
    xmlns="http://namespaces.zope.org/zope"
    xmlns:browser="http://namespaces.zope.org/browser"
    i18n_domain="my.package">

  <!-- override folder_contents -->
  <configure package="plone.app.content.browser">
      <browser:page
          for="Products.CMFCore.interfaces._content.IFolderish"
          class="my.package.browser.foldercontents.MyFolderContentsView"
          name="folder_contents"
          template="folder_contents.pt"
          layer="my.package.interfaces.IMyPackageLayer"
          permission="cmf.ListFolderContents"
      />
  </configure>
</configure>
```

This demonstrates a feature offered by a well-designed DSL: a way to do
a structured override of behavior in the framework.

## Trade-offs

Custom DSLs are a very powerful tool if you actually need them, and you
do need them at times. But they are also a lot more heavyweight than the
other methods discussed, and that's a drawback.

A custom DSL is thorough: a framework designer can build it with very
clean boundaries, with a clear grammar and hard checks to see whether
code conforms to this grammar. If you build your DSL on JSON or XML, you
can implement such checks pretty easily using one of the various schema
implementations.

A custom DSL gives the potential for non-developers to configure
application behavior. At some point in a DSL there is a need to
interface with user code, but this may be abstracted away quite far. It
lets non-developers reuse code implemented by developers.

A DSL can be extended with a GUI to make it even easier for
non-developers to configure it.

Since code written in a DSL can be stored in a database, you can store
complex configuration in a database.

A DSL can offer certain security guarantees -- you can ensure that DSL
code can only reach into a limited part of your application.

A DSL can implement a declaration engine with sophisticated behavior --
for instance the general detection of configuration conflicts (you try
to configure the same thing in conflicting ways in multiple places), and
structured, safe overrides that are independent of code and import
order. A DSL doesn't have to use such sophistication, but a framework
designer that designs a DSL is naturally lead in such a direction.

A drawback of DSL-based configuration is that it is quite distant from
the code that it configures. That is fine for some use cases, but
overkill for others. A DSL can cause mental overhead -- the applciation
developer not only needs to read the application's code but also its
configuration files in order to understand the behavior of an
application. For many frameworks it can be much nicer to co-locate
configuration with code.

A DSL also provides little flexibility during run-time. While you
_could_ generate configuration code dynamically, that's a level of meta
that's quite expensive (lots of generate/parse cycles) and it can lead
to headaches for the developers trying to understand what's going on.

DSL-based configuration is also quite heavy to implement compared to
many other more lightweight configuration options described.

# Pattern: imperative declaration

You use a declaration engine like in a DSL, but you drive it from
programming language code in an imperative way, like imperative
registration. In fact, an imperative declaration system can be layered
over a imperative registration system.

The difference from imperative registration is that the framework
implements a deferred configuration engine, instead of making
registrations immediately. Configuration commands are first collected in
a separate configuration phase, and only after collection is complete
are they executed, resulting in actual registrations.

## Fictional example

```python
from framework import Config

def save(data):
   ... application code to save the data somewhere ...

config = Config()
config.form_save('my_form', save)
config.commit()
```

The idea here is that configuration registries are only modified when
<span class="title-ref">config.commit()</span> happens, and only after
the configuration has been validated.

## Real-world example: Pyramid web framework

From the Pyramid web framework:

```python
def hello_world(request):
    return Response('Hello World!')

with Configurator() as config:
    config.add_route('hello', '/')
    config.add_view(hello_world, route_name='hello')
```

This looks very similar to a plain registry, but inside something else
is going on: it first collects _all_ registrations, and then generically
detects whether there are conflicts, and generically applies overrides.
Once the code exits the <span class="title-ref">with</span> statement,
config is complete and committed.

## Trade-offs

This brings some of the benefits of a configuration DSL to code. Like a
DSL, the configuration system can detect conflicts (the route name
'hello' is registered twice), and it allows sophisticated override
patterns that are not dependent on the vagaries of registration order or
import order.

Another benefit is that configuration can be generated programmatically,
so this allows for a certain amount of run-time dynamism without some
the costs that a DSL would have. It is still good to avoid such dynamism
as much as possible though, as it can make for very difficult to
comprehend code.

The code that is configured may still not be not co-located with the
configuration, but at least it's all code, instead of a whole new
language.

# Pattern: language integrated declaration

You configure the application by using framework-provided annotations
for code. This configuration is declarative and does not immediately
take place.

Language integration declaration looks like language integrated
registration, but uses a configuration engine like with imperative
declaration.

## Fictional example

```python
from framework import Config

config = Config()

# we define and configure the function at the same time
@config.form_save('my_form')
def save(data):
   ... application code to save the data somewhere ...

# elsewhere before application starts
config.commit()
```

## Real-world example: Morepath web framework

My own [Morepath](https://morepath.readthedocs.io) web framework is
configured this way.

```python
import morepath

class App(morepath.App):
    pass

@App.path(path='/hello')
class Hello(object):
    pass

@App.view(model=Hello)
def view_get(self, request):
    return "Hello world!"
```

Here two things happen: an instance of
<span class="title-ref">Hello</span> is registered for the route
<span class="title-ref">/hello</span>, and a
<span class="title-ref">GET</span> view is registered for such
instances. You can supply these decorators in any order in any module --
the framework will figure it out. If you subclass
<span class="title-ref">App</span>, and re-register the
<span class="title-ref">/hello</span> path, you have a new application
with new behavior for that path, but the same view.

## Trade-offs

I like this way of configuring code very much, so I built a framework
for it.

This _looks_ very similar to language-integrated **registration** but
the behavior is declarative.

It's more explicit than convention over configuration, but still low on
ceremony, like language-integrated registration. It co-locates
configuration with code.

It eliminates many of the issues with the more lightweight
language-integrated registration while retaining many of its benefits.
It imposes a lot of structure on how configuration works, and this can
lead to useful properties: conflict detection and overrides, for
instance.

It's a lot more heavy-weight than just passing in a callback or object
with an interface -- for many frameworks this is more than enough
ceremony, and nothing beats how easy that is to implement and test.

You can't store it in a database or give it to a non-programmer: for
that, use a DSL.

But if want a configuration language that's powerful and friendly, this
is a good way to go.

It's a lot more difficult to implement though, which is a drawback. If
you use Python, you're in luck: I've implemented a framework to help you
build this, called [Dectate](https://dectate.readthedocs.io). My
[Morepath](https://morepath.readthedocs.io) web framework is built on
it.

In Dectate, import-time side-effects are minimized: when the decorator
is executed the parameters are stored, but registration only happens
when <span class="title-ref">commit()</span> is executed. This means
there is no dependence on run-time import order, and conflict detection
and overrides are supported in a general way.

# Conclusion

I hope this helps developers who have to deal with frameworks to
understand the decisions made by these frameworks better. If you have a
problem with a framework, perhaps I gave you some arguments that lets
you express it better as well.

And if you design a framework -- which you should do, as larger
applications need frameworks to stay coherent -- you now hopefully have
some more concepts to work with to help you make better design
decisions.
