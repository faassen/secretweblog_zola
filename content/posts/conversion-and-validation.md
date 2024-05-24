+++
title = "Life at the Boundaries: Conversion and Validation"
date = 2014-09-26
slug = "conversion-and-validation"

[taxonomies]
tags = ["planetpython", "python", "morepath", "web", "development", "boundaries"]
+++

In software development we deal with *boundaries* between systems.

Examples of boundaries are:

- Your application code and a database.
- Your application code and the file system.
- A web server and your server-side application code.
- A client-side application and the browser DOM.
- A client-side application in JavaScript and the web server.

It's important to recognize these boundaries. You want to do things at
the boundaries of our application, just after input has arrived into
your application across an outer boundary, and just before you send
output across an inner boundary.

If you read a file and what's in that file is a string representing a
number, you want to convert the string to a number as soon as possible
after reading it, so that the rest of your codebase can forget about the
file and the string in it, and just deal with the number.

Because if you don't and pass a filename around, you may have to open
that file multiple times throughout your codebase. Or if you read from
the file and leave the value as a string, you may have to convert it to
a number each time you need it. This means duplicated code, and multiple
places where things can go wrong. All that is more work, more error
prone, and less fun.

Boundaries are our friends. So much so that programming languages give
us tools like functions and classes to create *new* boundaries in
software. With a solid, clear boundary in place in the middle of our
software, both halves can be easier to understand and easier to manage.

One of the most interesting things that happen on the boundaries in
software is *conversion* and *validation* of values. I find it very
useful to have a clear understanding of these concepts during software
development. To understand each other better it's useful to share this
understanding out loud. So here is how I define these concepts and how I
use them.

I hope this helps some of you see the boundaries more clearly.

# Following a HTML form submit through boundaries

Let's look at an example of a value going across multiple boundaries in
software. In this example, we have a web form with an input field that
lets the user fill in their date of birth as a string in the format
'DD-MM-YYYY'.

I'm going to give examples based on web development. I also give a few
tiny examples in Python. The web examples and Python used here only
exist to illustrate concepts; similar ideas apply in other contexts. You
shouldn't need to understand the details of the web or Python to
understand this, so don't go away if you don't.

## Serializing a web form to a request string

In a traditional non-HTML 5 HTTP web form, the input type for dates is
<span class="title-ref">text</span><span class="title-ref">. This means
that the dates are in fact not interpreted by the browser as dates at
all. It's just a string to the browser, just like
</span><span class="title-ref">adfdafd</span>\`. The browser does not
know anything about the value otherwise, unless it has loaded JavaScript
code that checks whether it the input is really a date and shows an
error message if it's not.

In HTML 5 there is a new input type called `date`, but for the sake of
this discussion we will ignore it, as it doesn't change all that much in
this example.

So when the user submits a form with the birth date field, the inputs in
the form are *serialized* to a longer string that is then sent to the
server as the body of a POST request. This serialization happens
according to what's specified in the form tag's `enctype` attribute.
When the enctype is `multipart/form-data`, the request to the server
will be a string that looks a lot like this:

    POST /some/path HTTP/1.1
    Content-type: multipart/form-data, boundary=AaB03x

    --AaB03x
    content-disposition: form-data; name="birthdate"

    21-10-1985
    --AaB03x--

Note that this serialization of form input to the `multipart/form-data`
format cannot fail; serialization always succeeds, no matter what form
data was entered.

## Converting the request string to a Request object

So now this request arrives at the web server. Let's imagine our web
server is in Python, and that there's a web framework like Django or
Flask or Pyramid or [Morepath](http://morepath.readthedocs.org) in
place. This web framework takes the serialized HTTP request, that is,
the string, and then *converts* it into a `request` object.

This request object is much more convenient to work with in Python than
the HTTP request string. Instead of having one blob of a string, you can
easily check indidivual aspects of the request -- what request method
was used (`POST`), what path the request is for, what the body of the
request was. The web framework also recognizes `multipart/form-data` and
automatically converts the request body with the form data into a
convenient Python dictionary-like data structure.

Note that the conversion of HTTP request text to request object may
fail. This can happen when the client did not actually format the
request correctly. The server should then return a HTTP error, in this
case `400 Bad Request`, so that the client software (or the developer
working on the client software) knows something went wrong.

The potential that something goes wrong is one difference between
conversion and serialization; both transform the data, but conversion
can fail and serialization cannot. Or perhaps better said: if
serialization fails it is a bug in the software, whereas conversion can
fail due to bad input. This is because serialization goes from
known-good data to some other format, whereas conversion deals with
input data from an external source that may be wrong in some way.

Thanks to the web framework's parsing of web form into a Python data
structure, we can easily get the field `birthdate` from our form. If the
request object was implemented by the [Webob](http://webob.org/) library
(like for Pyramid and Morepath), we can get it like this:

    >>> request.POST['birthdate']
    '21-10-1985'

## Converting the string to a date

But the birthdate at this point is still a string `21-10-1985`. We now
want to *convert* it into something more convenient to Python. Python
has a `datetime` library with a `date` type, so we'd like to get one of
those.

This conversion could be done automatically by a form framework --these
are very handy as you can declaratively describe what types of values
you expect and the framework can then automatically convert incoming
strings to convenient Python values accordingly. I've written a few web
form frameworks in my time. But in this example we'll do it it manually,
using functionality from the Python `datetime` library to parse the
date:

    >>> from datetime import datetime
    >>> birthdate = datetime.strptime(request.POST['birthdate'], '%d-%m-%Y').date()
    datetime.date(1985, 10, 21)

Since this is a conversion operation, it can fail if the user gave input
that is not in the right format or is not a proper date Python will
raise a `ValueError` exception in this case. We need to write code that
detects this and then signal the HTTP client that there was a conversion
error. The client needs to update its UI to inform the user of this
problem. All this can get quite complicated, and here again a form
framework can help you with this.

It's important to note that we should isolate this conversion to one
place in our application: the boundary where the value comes in. We
don't want to pass the birth date *string* around in our code and only
convert it into a date when we need to do something with it that
requires a `date` object. Doing conversion "just in time" like that has
a lot of problems: code duplication is one of them, but even worse is
that we would need worry about conversion errors *everywhere* instead of
in one place.

## Validating the date

So now that we have the birth date our web application may want to do
some basic checking to see whether it makes sense. For example, we
probably don't expect time travellers to fill in the form, so we can
safely reject any birth dates set in the future as invalid.

We've already converted the birth date from a string into a convenient
Python `date` object, so *validating* that the date is not in the future
is now easy:

    >>> from datetime import date
    >>> birthdate <= date.today()
    True

Validation needs the value to be in a convenient form, so validation
happens *after* conversion. Validation does *not* transform the value;
it only checks whether the value is valid according to additional
criteria.

There are a lot of possible validations:

- validate that required values are indeed present.
- check that a value is in a certain range.
- relate the value to another value elsewhere in the input or in the
  database. Perhaps the birth date is not supposed to be earlier than
  some database-defined value, for instance.
- etc.

If the input passes validation, the code just continues on its merry
way. Only when the validation fails do we want to take special action.
The minimum action that should be taken is to reject the data and do
nothing, but it could also involve sending information about the cause
of the validation failure back to the user interface, just like for
conversion errors.

Validation should be done just after conversion, at the boundary of the
application, so that after that we can stop worrying about all this and
just trust the values we have as valid. Our life is easier if we do
validation early on like this.

# Serialize the date into a database

Now the web application wants to store the birth date in a database. The
database sits behind a boundary. This boundary may be clever and allow
you to pass in straight Python date objects and do a conversion to its
internal format afterward. That would be best.

But imagine our database is dumb and expects our dates to be in a string
format. Now the task is up to our application: we need transform the
date to a string *before* the database boundary.

Let's say the database layer expects date strings in the format
'YYYY-MM-DD'. We then have to *serialize* our Python date object to that
format before we pass it into the database:

    >>> birthdate.strftime('%Y-%m-%d')
    '1985-10-21'

This is serialization and not conversion because this transformation
always succeeds.

# Concepts

So we have:

Transformation:  
Transform data from one type to another. Transformation by itself cannot
fail, as it is assumed to always get correct input. It is a bug in the
software if it does not. Conversion and serialization both do
transformation.

Conversion:  
Transform input across a boundary into a more convenient form inside
that boundary. Fails if the input cannot be transformed.

Serialization  
Transform valid data as output across a boundary into a form convenient
to outside. Cannot fail if there are no bugs in the software.

Validation:  
Check whether input across a boundary that is already converted to
convenient form is valid inside that boundary. Can fail. Does not
transform.

# Reuse

Conversion just deals with converting one value to another and does not
interact with the rest of the universe. The implementation of a
converter is therefore often reusable between applications.

The behavior of a converter typically does not depend on state or
configuration. If conversion behavior does depend on application state,
for instance because you want to parse dates as 'MM-DD-YYYY' instead of
'DD-MM-YYYY', it is often a better approach to just swap in a different
converter based on the locale than to have the converter itself to be
aware of the locale.

Validation is different. While some validations are reusable across
applications, a lot of them will be application specific. Validation
success may depend on the state of other values in the input or on
application state. Reusable frameworks that help with validation are
still useful, but they do need additional information from the
application to do their work.

# Serialization and parsing

Serialization is transformation of data to a *particular* type, such as
a string or a memory buffer. These types are convenient for
communicating across the boundary: storing on the file system, storing
data in a database, or passing data through the network.

The opposite of serialization is deserialization and this is done by
*parsing*: this takes data in its serialized form and transforms it into
a more convenient form. Parsing can fail if its input is not correct.
Parsing is therefore conversion, but not all conversion is parsing.

Parsing extracts information and checks whether the input conforms to a
grammar in one step, though if you treat the parser as a black box you
can view these as two separate phases: input validation and
transformation.

There are transformation operations in an application that do not
serialize but can also not fail. I don't have a separate word for these
besides "transformation", but they are quite common. Take for instance
an operation that takes a Python object and transforms it into a
dictionary convenient for serialization to JSON: it can only consist of
dicts, lists, strings, ints, floats, bools and `None`.

Some developers argue that data should always be kept in such a format
instead of in objects, as it can encourage a looser coupling between
subsystems. This idea is especially prevalent in Lisp-style homoiconic
language communities, where even code is treated as data. It is
interesting to note that JSON has made web development go in the
direction of more explicit data structures as well. Perhaps it is as
they say:

> Whoever does not understand LISP is doomed to reinvent it.

# Input validation

We can pick apart conversion and find *input validation* inside.
Conversion does input validation before transformation, and
serialization (and plain transformation) does not.

Input validation is very different from application-level validation.
Input validation is conceptually done just *before* the convenient form
is created, and is an inherent part of the conversion. In practice, a
converter typically *parses* data, doing both in a single step.

I prefer to reserve the term "validation" for application-level
validation and discuss input validation only when we talk about
implementing a converter.

But sometimes conversion from one perspective is validation from
another.

Take the example above where we want to store a Python date in a
database. What if this operation does not work for *all* Python date
objects? The database layer could accept dates in a different range than
the one supported by the Python `date` object. The database may
therefore may therefore be offered a date that is outside of its range
and reject it with an error.

We can view this as conversion: the database converts a date value that
comes in, and this conversion may fail. But we can also view this in
another way: the database transforms the date value that comes in, and
then there is an additional validation that may fail. The database is a
black box and both perspectives work. That comes in handy a little bit
later.

# Validation and layers

Consider a web application with an application-level validation layer,
and another layer of validation in the database.

Maybe the database *also* has a rule to make sure that the birth date is
not in the future. It gives an error when we give a date in the future.
Since validation errors can now occur at the database layer, we need to
worry about properly handling them.

But transporting such a validation failure back to the user interface
can be tricky: we are on the boundary between application code and
database at this point, far from the boundary between application and
user interface. And often database-level validation failure messages are
in a form that is not very informative to a user; they speak in terms of
the database instead of the user.

We can make our life easier. What we can do is duplicate any validation
the database layer does at the outer boundary of our application, the
one facing the web. Validation failures there are relatively simple to
propagate back to the user interface. Since any validation errors that
can be given by the database have already been detected at an earlier
boundary before the database is ever reached, we don't need to worry
about handling database-level validation messages anymore. We can act as
if they don't exist, as we've now guaranteed they cannot occur.

We treat the database-level validation as an extra sanity check guarding
against bugs in our application-level code. If validation errors occur
on the database boundary, we have a bug, and this should not happen, and
we can just report a general error: on the web this is a 500 internal
server error. That's a lot easier to do.

The general principle is: if we do all validations that the boundary to
a deeper layer already needs at a higher layer, we can effectively the
inner boundary as not having any validations. The validations in the
deeper layer then only exist as extra checks that guard against bugs in
the validations at the outer boundary.

We can also apply this to conversion errors: if we already make sure we
clean up the data with validations at an outer boundary before it
reaches an inner boundary that needs to do conversions, the conversions
cannot fail. We can treat them as transformations again. We can do this
as in a black box we can treat any conversion as a combination of
transformation and validation.

# Validation in the browser

In the end, let's return to the web browser.

We've seen that doing validation at an outer boundary can let us ignore
validation done deeper down in our code. We do validation once when
values come into the web server, and we can forget about doing them in
the rest of our server code.

We can go one step further. We can lift our validation out of the
server, into the client. If we do our validation in JavaScript when the
user inputs values into the web form, we are in the right place to give
really accurate user interface feedback in easiest way possible.
Validation failure information has to cross from JavaScript to the
browser DOM and that's it. The server is not involved.

We cannot always do this. If our validation code needs information on
the server that cannot be shared securily or efficiently with the
client, the server is still involved in validation, but at least we can
still do all the user interface work in the client.

Even if we do not need server-side validation for the user interface, we
cannot ignore doing server-side validation altogether, as we cannot
guarantee that our JavaScript program is the only program that sends
information to the server. Through that route, or because of bugs in our
JavaScript code, we can still get input that is potentially invalid. But
now if the server detects invalid information, it does not need do
anything complicated to report validation errors to the client. Instead
it can just generate an internal server error.

If we could somehow guarantee that only our JavaScript program is the
one that sends information to the server, we could forgo doing
validation on the server altogether. Someone more experienced in the
arts of encryption may be able to say whether this is possible. I
suspect the answer will be "no", as it usually is with JavaScript in web
browsers and encryption.

In any case, we may in fact want to encourage other programs to use the
same web server; that's the whole idea behind offering HTTP APIs. If
this is our aim, we need to handle validation on the server as well, and
give decent error messages.
