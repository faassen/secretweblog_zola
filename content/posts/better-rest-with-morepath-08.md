+++
title = "Better REST with Morepath 0.8"
date = 2014-11-13
slug = "better-rest-with-morepath-08"

[taxonomies]
tags = ["morepath", "python", "planetpython", "rest"]
+++

Today I released Morepath 0.8
([CHANGES](http://morepath.readthedocs.org/en/0.8/changes.html)). In
this release Morepath has become faster, simpler and more powerful at
the same time. I like it when I can do all three in a release!

I'll get faster and simpler out of the way fast, so I can go into the
"more powerful", which is what Morepath is all about.

# Faster

I run this simple benchmark once every while to make sure Morepath's
performance is going in the right direction. The benchmark does almost
nothing: it just sends the text "Hello world" back to the browser from a
view on a path.

It's still useful to try such a small benchmark, as it can help show how
much your web framework is doing to send something that basic back to
the browser. In July when I presented Morepath at EuroPython, I measured
it. I was about as fast as Django then at this task, and was already
significantly faster than Flask.

I'm pleased to report that **Morepath 0.8 is 50% faster than in July. At
raw performance on this benchmark, we have now comfortably surpassed
Django and are leaving Flask somewhere in the distance.**

Morepath is not about performance -- it's fast enough anyway, other work
will dominate in most real-world applications, but it's nice to know.

Performance is relative of course: Pyramid for instance is still racing
far ahead on this benchmark, and so is wheezy.web, the web framework
from which I took this benchmark and hacked up.

# Simpler

Morepath 0.8 is running on a new engine: a completely refactored
[Reg](http://reg.readthedocs.org) library. Reg was originally inspired
by zope.interface (which Pyramid uses), but it has since evolved almost
beyond recognition into a powerful generic dispatch system.

**In Reg 0.9, the dispatch system has been simplified and generalized to
also let you dispatch on the value of arguments as well as their
classes. Reg 0.9 also lifts the restriction that you have to dispatch on
all non-key keyword arguments. Reg could also cache lookups to make
things go faster, but this now also works for the new non-class-based
dispatch.**

Much of Morepath's flexibility and power is due to Reg. Morepath 0.9's
view lookup system has been rewritten to make use of the new powers of
Reg, making it both faster and more powerful.

Enough abstract talk: let's look at what implementing a REST web service
looks like in Morepath 0.8.

# The Power of Morepath: REST in Morepath

## Scenario

Here's the scenario we are going to implement.

Say you're implementing a REST API (also known as a hypermedia API).

You want to support the URL (hostname info omitted):

    /customers/{id}

When you access it with a `GET` request, you get JSON describing the
customer with the given id, or if it doesn't exist, 404 Not Found.

There's also the URL:

    /customers

This represents a collection of customers. You want to be able to `GET`
it and get some JSON information about the customers back.

Moreover, you want to `POST` JSON to it that represents a new customer,
to add it a customer to the collection.

The customer JSON at `/customers/{id}` looks like this:

    {
      "@id": "/customers/0",
      "@type": "Customer",
      "name": "Joe Shopper"
    }

What's this `@id` and `@type` business? They're just conventions (though
I took them took from the [JSON-LD](http://json-ld.org/) standard).
`@id` is a link to the customer itself, which also uniquely identifies
this customer. `@type` describes the type of this object.

The customer collection JSON at `/customers` looks like this:

    {
      "@id": "/customers",
      "@type": "CustomerCollection"
      "customers": ['/customers/0', '/customers/1'],
      "add": "/customers",
    }

When you POST a new customer `@id` is not needed, but it gets added
after `POST`. The response to a POST should be JSON representing the new
customer we just POSTed, but now with the `@id` added.

## Implementing this scenario with Morepath

First we define a class `Customer` that defines the customer. In a
real-world application this is backed by some database, perhaps using an
ORM like SQLAlchemy, but we'll keep it simple here:

```python
class Customer(object):
    def __init__(self, name):
        self.id = None  # we will set it after creation
        self.name = name
```

`Customer` doesn't know anything about the web at all; it shouldn't have
to.

Then there's a `CustomerCollection` that represents a collection of
`Customer` objects. Again in the real world it would be backed by some
database, and implemented in terms of database operations to query and
add customers, but here we show a simple in-memory implementation:

```python
class CustomerCollection(object):
     def __init__(self):
         self.customers = {}
         self.id_counter = 0

     def get(self, id):
         return self.customers.get(id)

     def add(self, customer):
         self.customers[self.id_counter] = customer
         # here we set the id
         customer.id = self.id_counter
         self.id_counter += 1
         return customer

customer_collection = CustomerCollection()
```

We register this collection at the path `/customers`:

```python
@App.path(model=CustomerCollection, path='/customers')
def get_customer_collection():
    return customer_collection
```

We register `Customer` at the path `/customers/{id}`:

```python
@App.path(model=Customer, path='/customers/{id}'
          converters={'id': int})
def get_customer(id):
    return customer_collection.get(id)
```

See the `converters` bit we did there? This makes sure that the `{id}`
variable is converted from a string into an integer for you
automatically, as internally we use integer ids.

We now register a `dump_json` that can transform the `Customer` object
into `JSON`:

```python
@App.dump_json(model=Customer)
def dump(self, request):
   return {
      '@type': 'Customer',
      '@id': self.id,
      'name': self.name
   }
```

Now we are ready to implement a `GET` (the default) view for `Customer`,
so that `/customer/{id}` works:

```python
@App.json(model=Customer)
def customer_default(self, request):
    return self
```

That's easy! It can just return `self` and let `dump_json` take care of
making it be JSON.

Now let's work on the `POST` of new customers on `/customers`.

We register a `load_json` directive that can transform JSON into a
`Customer` instance:

```python
@App.load_json()
def load(json, request):
    if json['@type'] == 'Customer':
        return Customer(name=json['name'])
    return json
```

We now can register a view that handles the `POST` of a new `Customer`
to the `CustomerCollection`:

```python
@App.json(model=CustomerCollection,
          request_method='POST',
          body_model=Customer)
def customer_collection_post(self, request):
    return self.add(request.body_obj)
```

This calls the `add` method we defined on `CustomerCollection` before.
`body_obj` is a `Customer` instance, converted from the incoming JSON.
It returns the resulting `Customer` instance which is automatically
transformed to JSON.

For good measure let's also define a way to transform the
`CustomerCollection` into JSON:

```python
@App.dump_json(model=CustomerCollection)
def dump_customer_collection(self, request):
    return {
        '@id': request.link(self),
        '@type': 'CustomerCollection',
        'customers': [
            request.link(customer) for customer in self.customers.values()
        ],
        'add': request.link(self),
    }
```

`request.link` automatically creates the correct links to `Customer`
instances and the `CustomerCollection` itself.

We now need to add a `GET` view for `CustomerCollection`:

```python
@App.json(model=CustomerCollection)
def customer_collection_default(self, request):
    return self
```

We done with our implementation. Check out a [working
example](https://github.com/morepath/morepath_rest_dump_load) on Github.
To try it out you could use a commandline tool like `wget` or `curl`, or
Chrome's Postman extension, for instance.

## What about HTTP status codes?

A good REST API sends back the correct HTTP status codes when something
goes wrong. There's more to HTTP status codes than just `200 OK` and
`404 Not Found`.

**Now with a normal Python web framework, you'd have to go through your
implementation and add checks for various error conditions, and then
return or raise HTTP errors in lots of places.**

**Morepath is not a normal Python web framework.**

Morepath does the following:

`/customers` and `/customers/1`  
`200 Ok` (if customer `1` exists)

_Well, of course!_

`/flub`  
`404 Not Found`

_Yeah, but other web frameworks do this too._

`/customers/1000`  
`404 Not Found` (if customer `1000` _doesn't_ exist)

_Morepath automates this for you if you return None from the
\`\`@App.path\`\` directive._

`/customers/not_an_integer`  
`400 Bad Request`

_Oh, okay. That's nice!_

`PUT` on `/customers/1`  
`405 Method Not Allowed`

_You know about this status code, but does your web framework?_

`POST` on `/customers` of JSON that does not have `@type` `Customer`  
`422 Unprocessable Entity`

_Yes, 422 Unprocessable Entity is a real HTTP status code, and it's used
in REST APIs -- the Github API uses it for instance. Other REST API use
400 Bad Request for this case. You can make Morepath do this as well._

## Under the hood

Here's the part of the Morepath codebase that implements much of this
behavior:

```python
@App.predicate(generic.view, name='model', default=None, index=ClassIndex)
def model_predicate(obj):
    return obj.__class__


@App.predicate_fallback(generic.view, model_predicate)
def model_not_found(self, request):
    raise HTTPNotFound()


@App.predicate(generic.view, name='name', default='', index=KeyIndex,
               after=model_predicate)
def name_predicate(request):
    return request.view_name


@App.predicate_fallback(generic.view, name_predicate)
def name_not_found(self, request):
    raise HTTPNotFound()


@App.predicate(generic.view, name='request_method', default='GET',
               index=KeyIndex, after=name_predicate)
def request_method_predicate(request):
    return request.method


@App.predicate_fallback(generic.view, request_method_predicate)
def method_not_allowed(self, request):
    raise HTTPMethodNotAllowed()


@App.predicate(generic.view, name='body_model', default=object,
               index=ClassIndex, after=request_method_predicate)
def body_model_predicate(request):
    return request.body_obj.__class__


@App.predicate_fallback(generic.view, body_model_predicate)
def body_model_unprocessable(self, request):
    raise HTTPUnprocessableEntity()
```

Don't like `422 Unprocessable Entity` when `body_model` doesn't match?
Want `400 Bad Request` instead? Just override the `predicate_fallback`
for this in your own application:

```python
class MyApp(morepath.App):
    pass

@MyApp.predicate_fallback(generic.view, body_model_predicate)
def body_model_unprocessable_overridden(self, request):
    raise HTTPBadRequest()
```

Want to have views respond to the HTTP `Accept` header? Add a new
predicate that handles this to your app.

Now what are you waiting for? Try out
[Morepath](http://morepath.readthedocs.org)!
