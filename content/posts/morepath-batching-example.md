+++
title = "Build a better batching UI with Morepath and Jinja2"
date = 2015-06-29
slug = "morepath-batching-example"

[taxonomies]
tags = ["morepath", "python", "templating", "planetpython"]
+++

# Introduction

This post is the first in what I hope will be a series on neat things
you can do with [Morepath](http://morepath.readthedocs.org). Morepath is
a Python web micro framework with some very interesting capabilities.
What we'll look at today is what you can do with Morepath's link
generation in a server-driven web application. While Morepath is an
excellent fit to create REST APIs, it also works well server
aplications. So let's look at how Morepath can help you to create a
batching UI.

On the special occasion of this post we also released a new version of
Morepath, [Morepath
0.11.1](https://morepath.readthedocs.org/en/0.11.1/changes.html)!

A batching UI is a UI where you have a larger amount of data available
than you want to show to the user at once. You instead partition the
data in smaller batches, and you let the user navigate through these
batches by clicking a _previous_ and _next_ link. If you have 56 items
in total and the batch size is 10, you first see items 0-9. You can then
click _next_ to see items 10-19, then items 20-29, and so on until you
see the last few items 50-55. Clicking _previous_ will take you
backwards again.

In this example, a URL to see a single batch looks like this:

    http://example.com/?start=20

To see items 20-29. You can also approach the application like this:

    http://example.com/

to start at the first batch.

I'm going to highlight the relevant parts of the application here. The
[complete example
project](https://github.com/morepath/morepath_batching) can be found on
Github. I have included instructions on how to install the app in the
README.rst there.

# Model

First we need to define a few model classes to define the application.
We are going to go for a fake database of fake persons that we want to
batch through.

Here's the <span class="title-ref">Person</span> class:

```python
class Person(object):
    def __init__(self, id, name, address, email):
        self.id = id
        self.name = name
        self.address = address
        self.email = email
```

We use the neat
[fake-factory](https://pypi.python.org/pypi/fake-factory) package to
create some fake data for our fake database; the fake database is just a
Python list:

```python
fake = Faker()

def generate_random_person(id):
    return Person(id, fake.name(), fake.address(), fake.email())

def generate_random_persons(amount):
    return [generate_random_person(id) for id in range(amount)]

person_db = generate_random_persons(56)
```

So far nothing special. But next we create a special
<span class="title-ref">PersonCollection</span> model that represents a
batch of persons:

```python
class PersonCollection(object):
    def __init__(self, persons, start):
        self.persons = persons
        if start < 0 or start >= len(persons):
            start = 0
        self.start = start

    def query(self):
        return self.persons[self.start:self.start + BATCH_SIZE]

    def previous(self):
        if self.start == 0:
            return None
        start = self.start - BATCH_SIZE
        if start < 0:
            start = 0
        return PersonCollection(self.persons, start)

    def next(self):
        start = self.start + BATCH_SIZE
        if start >= len(self.persons):
            return None
        return PersonCollection(self.persons, self.start + BATCH_SIZE)
```

To create an instance of <span class="title-ref">PersonCollection</span>
you need two arguments: <span class="title-ref">persons</span>, which is
going to be our <span class="title-ref">person_db</span> we created
before, and <span class="title-ref">start</span>, which is the start
index of the batch.

We define a <span class="title-ref">query</span> method that queries the
persons we need from the larger batch, based on
<span class="title-ref">start</span> and a global constant,
<span class="title-ref">BATCH_SIZE</span>. Here we do this by simply
taking a slice. In a real application you'd execute some kind of
database query.

We also define <span class="title-ref">previous</span> and
<span class="title-ref">next</span> methods. These give back the
previous <span class="title-ref">PersonCollection</span> and next
<span class="title-ref">PersonCollection</span>. They use the same
<span class="title-ref">persons</span> database, but adjust the
<span class="title-ref">start</span> of the batch. If there is no
previous or next batch as we're at the beginning or the end, these
methods return `None`.

There is nothing directly web related in this code, though of course
<span class="title-ref">PersonCollection</span> is there to serve our
web application in particular. But as you notice there is absolutely no
interaction with <span class="title-ref">request</span> or any other
parts of the Morepath API. This makes it easier to reason about this
code: you can for instance write unit tests that just test the behavior
of these instances without dealing with requests, HTML, etc.

# Path

Now we expose these models to the web. We tell Morepath what models are
behind what URLs, and how to create URLs to models:

```python
@App.path(model=PersonCollection, path='/')
def get_person_collection(start=0):
    return PersonCollection(person_db, start)

@App.path(model=Person, path='{id}',
          converters={'id': int})
def get_person(id):
    try:
        return person_db[id]
    except IndexError:
        return None
```

Let's look at this in more detail:

```python
@App.path(model=PersonCollection, path='/')
def get_person_collection(start=0):
    return PersonCollection(person_db, start)
```

This is not a lot of code, but it actually tells Morepath a lot:

- When you go to the root path <span class="title-ref">/</span> you get
  the instance returned by the
  <span class="title-ref">get_person_collection</span> function.
- This URL takes a request parameter
  <span class="title-ref">start</span>, for instance `?start=10`.
- This request parameter is optional. If it's not given it defaults to
  <span class="title-ref">0</span>.
- Since the default is a Python <span class="title-ref">int</span>
  object, Morepath rejects any requests with request parameters that
  cannot be converted to an integer as a 400 Bad Request. So
  <span class="title-ref">?start=11</span> is legal, but
  <span class="title-ref">?start=foo</span> is not.
- When asked for the link to a
  <span class="title-ref">PersonCollection</span> instance in Python
  code, as we'll see soon, Morepath uses this information to reconstruct
  it.

Now let's look at \`get_person\`:

```python
@App.path(model=Person, path='{id}',
          converters={'id': int})
def get_person(id):
    try:
        return person_db[id]
    except IndexError:
        return None
```

This uses a path with a parameter in it,
<span class="title-ref">id</span>, which is passed to the
<span class="title-ref">get_person</span> function. It explicitly sets
the system to expect an <span class="title-ref">int</span> and reject
anything else, but we could've used <span class="title-ref">id=0</span>
as a default parameter instead here too. Finally,
<span class="title-ref">get_person</span> can return
<span class="title-ref">None</span> if the id is not known in our Python
list "database". Morepath automatically turns this into a
<span class="title-ref">404 Not Found</span> for you.

# View & template for Person

While <span class="title-ref">PersonCollection</span> and
<span class="title-ref">Person</span> instances now have a URL, we
didn't tell Morepath yet what to do when someone goes there. So for now,
these URLs will respond with a 404.

Let's fix this by defining some Morepath views. We'll do a simple view
for <span class="title-ref">Person</span> first:

```python
@App.html(model=Person, template='person.jinja2')
def person_default(self, request):
    return {
        'id': self.id,
        'name': self.name,
        'address': self.address,
        'email': self.email
    }
```

We use the <span class="title-ref">html</span> decorator to indicate
that this view delivers data of Content-Type
<span class="title-ref">text/html</span>, and that it uses a
<span class="title-ref">person.jinja2</span> template to do so.

The <span class="title-ref">person_default</span> function itself gets a
<span class="title-ref">self</span> and a
<span class="title-ref">request</span> argument. The
<span class="title-ref">self</span> argument is an instance of the model
class indicated in the decorator, so a
<span class="title-ref">Person</span> instance. The request argument is
a [WebOb](http://webob.org/) request instance. We give the template the
data returned in the dictionary.

The template <span class="title-ref">person.jinja2</span> looks like
this:

```html.j2
<!DOCTYPE html>
<html>
  <head>
    <title>Morepath batching demo</title>
  </head>
  <body>
    <p>
      Name: {{ name }}<br/>
      Address: {{ address }}<br/>
      Email: {{ email }}<br />
    </p>
  </body>
</html>
```

Here we use the [Jinja2 template language](http://jinja.pocoo.org/) to
render the data to HTML. Morepath out of the box does not support
Jinja2; it's template language agnostic. But in our example we use the
Morepath extension
[more.jinja2](https://pypi.python.org/pypi/more.jinja2) which integrates
Jinja2. Chameleon support is also available in
[more.chameleon](https://pypi.python.org/pypi/more.chameleon) in case
you prefer that.

# View & template for PersonCollection

Here is the view that exposes \`PersonCollection\`:

```python
@App.html(model=PersonCollection, template='person_collection.jinja2')
def person_collection_default(self, request):
    return {
        'persons': self.query(),
        'previous_link': request.link(self.previous()),
        'next_link': request.link(self.next()),
    }
```

It gives the template the list of persons that is in the current
<span class="title-ref">PersonCollection</span> instance so it can show
them in a template as we'll see in a moment. It also creates two URLs:
<span class="title-ref">previous_link</span> and
<span class="title-ref">next_link</span>. These are links to the
previous and next batch available, or `None` if no previous or next
batch exists (this is the first or the last batch).

Let's look at the template:

```html.j2
<!DOCTYPE html>
<html>
 <head>
   <title>Morepath batching demo</title>
  </head>
  <body>
    <table>
      <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Address</th>
      </tr>
      {% for person in persons %}
      <tr>
        <td><a href="{{ request.link(person) }}">{{ person.name }}</a></td>
        <td>{{ person.email }}</td>
        <td>{{ person.address }}</td>
      </tr>
      {% endfor %}
    </table>
    {% if previous_link %}
    <a href="{{ previous_link }}">Previous</a>
    {% endif %}
    {% if next_link %}
    <a href="{{ next_link }}">Next</a>
    {% endif %}
  </body>
</html>
```

A bit more is going on here. First it loops through the
<span class="title-ref">persons</span> list to show all the persons in a
batch in a HTML table. The name in the table is a link to the person
instance; we use <span class="title-ref">request.link()</span> in the
template to create this URL.

The template also shows a <span class="title-ref">previous</span> and
<span class="title-ref">next</span> link, but only if they're not
<span class="title-ref">None</span>, so when there is actually a
previous or next batch available.

# That's it

And that's it, besides a few details of application setup, which you can
find in the [complete example
project](https://github.com/morepath/morepath_batching) on Github.

There's not much to this code, and that's how it should be. I invite you
to compare this approach to a batching UI to what an implementation for
another web framework looks like. Do you put the link generation code in
the template itself? Or as ad hoc code inside the view functions? How
clear and concise and testable is that code compared to what we just did
here? Do you give back the right HTTP status codes when things go wrong?
Consider also how easy it would be to expand the code to include
searching in addition to batching.

Do you want to try out Morepath now? Read the [very extensive
documentation](https://morepath.readthedocs.org). I hope to hear from
you!
