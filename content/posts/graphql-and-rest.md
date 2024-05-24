+++
title = "GraphQL and REST"
date = 2015-06-10
slug = "graphql-and-rest"

[taxonomies]
tags = ["react", "graphql", "rest", "javascript", "morepath"]
+++

## Introduction

There is a new trend in open source that I'm not sure I like very much:
big companies announce that they are _going_ to open source something,
but the release is nowhere in sight yet. Announcing something invites
feedback, especially if it's announced as open source. When the software
in question is available already as closed source for people to play
with I don't really mind as feedback is possible, though it makes me
wonder what the point is of holding back on a release.

It's a bit more difficult to give feedback on something when the thing
announced is still heavily in development with no release in sight. How
can one give feedback? But since you announced you'd open source it, I
guess we should not be shy and give you feedback anyway.

Facebook has been doing this kind of announcement a lot recently: they
announced React Native before they released it. They also announced
Relay and GraphQL, but both have not yet been released. They've given us
some information in a few talks and blog posts, and the rest is
speculation. If you want to learn more about Relay and GraphQL I highly
recommend you read these
[slides](https://speakerdeck.com/laneyk/mutations-in-relay) by Laney
Kuenzel.

From the information we do have, Relay looks very interesting indeed. I
think I'd like to have the option use Relay in the future. That means I
need to implement GraphQL somehow, or at least something close enough to
it, as it's the infrastructure that makes Relay possible.

React is a rethink of how to construct a client-side web application UI.
React challenges MVC and bi-directional data binding.
[GraphQL](https://facebook.github.io/react/blog/2015/05/01/graphql-introduction.html)
is a rethink of the way client-side web applications talk to their
backend. GraphQL challenges REST.

## REST

So what was REST again? Rich frontend applications these days typically
talk to a HTTP backend. These backends follow some basic REST patterns:
resources are on URLs and you can interact with them using HTTP verbs.
Some resources represent single items:

    /users/faassen

If you issue a `GET` request to it you get its representation, typically
in JSON. You can also issue a `PUT` request to it to overwrite its
representation, and `DELETE` to delete it.

In a HTTP API we typically also have a way to access collections:

    /users

You can issue `GET` to this too, possibly with some HTTP query
parameters to do a filter, to get a representation of the users known to
the application. You can also issue `POST` to this to add a new user.

Real proper REST APIs, also known as Hypermedia APIs, go beyond this:
they have hyperlinks between resources. I wrote a web framework named
[Morepath](https://morepath.readthedocs.org/) which aims to make it
easier to create complex hypermedia APIs, so you can say I'm pretty
heavily invested in REST.

## Challenging REST

GraphQL challenges REST. The core idea is that the code that best knows
what data is needed for a UI is not on the server but on the client. The
UI component knows best what data it wants.

REST delivers all the data a UI might need about a resource and it's up
to the client to go look for the bits it actually wants to show. If that
data is not in a resource it already has, the client needs to go off to
the server and request some more data from another URL. With GraphQL the
UI gets exactly the data it needs instead, in a shape handy for the UI.

As we can see
[here](https://facebook.github.io/react/blog/2015/05/01/graphql-introduction.html),
a GraphQL query looks like this:

    {
      user(id: 400) {
        id,
        name,
        isViewerFriend,
        profilePicture(size: 50)  {
          uri,
          width,
          height
        }
      }
    }

You get back this:

    {
      "user" : {
        "id": 4000,
        "name": "Some name",
        "isViewerFriend": true,
        "profilePicture": {
          "uri": "http://example.com/pic.jpg",
          "width": 50,
          "height": 50
        }
      }
    }

This says you want an object of type `user` with `id` `4000`. You are
interested in its `id`, `name` and `isViewerFriend` fields.

You also want another object it is connected to: the `profilePicture`.
You want the `uri`, `width` and `height` fields of this. While there is
no public GraphQL specification out there yet, I _think_ that `size: 50`
means to restrict the subquery for a profile picture to only those of
size 50. I'm not sure what happens if no `profilePicture` of this size
is available, though.

To talk to the backend, there is only a single HTTP end-point that
receives all these queries, or alternatively you use a non-HTTP
mechanism like web sockets. Very unRESTful indeed!

## REST and shaping data

Since I'm invested in REST, I've been wondering about whether we can
bring some of these ideas to REST APIs. Perhaps we can even map GraphQL
to a REST API in a reasonably efficient way. But even if we don't
implement all of GraphQL, we might gain enough to make our REST APIs
more useful to front-end developers.

As an exercise, let's try to express the query above as a REST query for
a hypothetical REST API. First we take this bit:

    user(id: 4000) {

We can express this using a path:

    /users/4000

The client could construct this path by using a [URI
template](https://tools.ietf.org/html/rfc6570) (`/users/{id}`) provided
by the server, or by following a link provided by the server, or by
doing the least RESTful thing of them all: hardcode the URL construction
in client code.

How do we express with HTTP what fields a user wants? **REST of course
does have a mechanism that can be used to shape data: HTTP query
parameters.** So this bit:

    id,
    name,
    isViewerFriend,

could become these query parameters:

    ?field=id&field=name&field=isViewerFriend

And the query would then look like this:

    /users/4000?field=id&field=name&field=isViewerFriend

That is pretty straightforward. It needs server buy-in, but it wouldn't
be very difficult to implement in the basic case. The sub-query is more
tricky. We need to think of some way to represent it in query
parameters. We could do something like this (multi-line for clarity):

    ?field=profilePicture&
      filter:profilePicture.size=50&
      field=profilePicture.uri&
      field=profilePicture.width&
      field=profilePicture.height

The whole query now looks like this:

    /users/4000?
      field=id&
      field=name&
      field=isViewerFriend&
      field=profilePicture&
      filter:profilePicture.size=50&
      field=profilePicture.uri&
      field=profilePicture.width&
      field=profilePicture.height

The result of this query would look the same as in the GraphQL example.
It's important to notice that this REST API is not fully _normalized_ --
the `profilePicure` data is not behind a separate URL that the client
then needs to go to. Instead, the object is embedded in the result for
the sake of convenience and performance.

I'd be tempted to make the server send back some
[JSON-LD](http://www.w3.org/TR/json-ld/) to help here: each object (the
user object and the profileData subobject) can have an `@id` for its
canonical URL and a `@type` as a type designator. A client-side cache
could exploit this `@id` information to store information about the
objects it already knows about. Client-side code could also use this
information to deal with normalized APIs transparently: it can
automatically fetch the sub-object for you if it's not embedded, at the
cost of performance.

Does this REST API have the same features as the GraphQL example? I have
no idea. It probably depends especially on how queries of related
objects work. GraphQL does supply caching benefits, which you wouldn't
have without more work. On the other hand you might be able to exploit
HTTP-level caching mechanisms with this REST-based approach. Then again,
this has more HTTP overhead, which GraphQL can avoid.

Let's briefly get back to the idea to automatically map GraphQL to a
REST API. What is needed is a way to look up a [URI
template](https://tools.ietf.org/html/rfc6570) for a GraphQL type. So,
for the `user` type we could connect it to a URI template `/users/{id}`.
The server could supply this map of GraphQL type to URI template to the
server, so the server can make the translation of the GraphQL to the
REST API.

## Further speculation

What about queries for multiple objects? We could use some kind of
collection URL with a filter:

> /user?filter:startsWith=a

It is normal in REST to shape collection data this way already, after
all. Unfortunately I have no clear idea what a query for a collection of
objects looks like in GraphQL.

I've only vaguely started thinking about mutations. If you can access
the objects's URL in a standard way such as with an `@id` field, you can
then get a handle on the object and send it `POST`, `PUT` and `DELETE`
requests.

## Conclusion

All this is wild speculation, as we don't really know enough about
GraphQL yet to fully understand its capabilities. It's quite possible
that I'm throwing away some important property of GraphQL away by
mapping it to a REST API. Scalability, for instance. Then again, usually
my scalability use cases aren't the same as Facebook's, so I might not
care as long as I get Relay's benefits to client-side code development.

It's also possible that it's actually easier to implement a single
GraphQL-based endpoint than to write or adapt a REST API to support
these patterns. Who knows.

Another question I don't have the answer to is what properties a system
should have to make Relay work at all. Does it need to be exactly
GraphQL, or would a subset of its features work? Which properties of
GraphQL are essential?

Thank you, GraphQL and Relay people, for challenging the status quo!
Though it makes me slightly uncomfortable, I greatly appreciate it.
Hopefully my feedback wasn't too dumb; luckily you can't blame me too
much for that as I can legitimately claim ignorance! I'm looking forward
to learning more.

### Preserved Comments

#### Frank P

> So, somebody noticed that query languages may be useful for application
> development. In the end, we might even get something having well-defined
> semantics like SQL (around 1974?). An interesting question for any "web-scale
> query language" (any HTTP API, in fact) may be, wether to limit the
> expressible computational complexity in the language or the actual load per
> request in a robust implementation to avoid malicious or careless users to
> knock out the infrastructure (imagine a GraphQL query that gives you _all_ of
> Facebook's data).
>
> Regarding GraphQL (or any query language) vs. REST, I'd say that both may
> well work together. We could usefully have services that provide navigable
> REST-style resources/collections and one or more query language HTTP APIs at
> the same time. Or REST collections that support queries/projections in one
> way or the other, like you demonstrated. We could have GET
> /users?graphql=<gibberish> or so.
>
> While dogmatic REST and using-the-web-as-it-was-designed _maybe_ gives us
> discoverable, machine-readable, interlinked resources, hopefully supporting
> web-scale automation (if only we could standardize "semantics" of data),
> simply using web browsers as client runtimes is generating a huge demand for
> simple application programming approaches using well-known services and APIs.
> And that is not a bad place for a frontend framework and a related query
> language. For me, not everything has to look like JSON, but that's another
> question...

### Laurence Rowe

> There's a really interesting presentation from Jafar Husain about Netflix's >
> approach to the same problem: https://www.youtube.com/watch?v=hOE6nVVr14c
>
> I'm using a variation of JSON-LD framing to define the 'join' across the
> graph and return a deeply embedded object as the response. This is the
> representation you want at the point of rendering your page, but the driving
> factor behind this decision in our app was that it made facetting across the
> embedded objects possible when indexed in Elasticsearch.
>
> The downside of this is that it separates the specification of the 'frame'
> from the UI code where you know what's needed. It also significantly bloats
> our complex pages, flattening our data in transit would avoid a lot of
> repetition.
>
> The key point seems to be conceptualising your application's data as a graph.
> Doing so gives you the flexibility to layer more intelligent transports above
> it.

### maparent

> Hello, Martijn!
>
> I had to work with both those issues in a project I'm involved in: I have not
> put filters in my requests, but related objects.
>
> So I have paths such as /api/Classname/instanceId/relation_name/instanceId/...
>
> Relations are, in my case, introspected from sqlalchemy, and translated to
> database joins.
>
> Each object obtained through the relationship has its canonical URL as
> /api/OtherClassname/instanceid, but the indirect path has further properties:
> An object creation through POST will populate the relationship, e.g. with
> association tables.
>
> On the query side, we do not have generic queries as you propose, but we have
> a named "view specification" that specifies fields given. It is possible in a
> view specification to refer to another view specification for sub-objects.
>
> I'd be glad to discuss it more, but the main ideas are here:
>
> https://github.com/assembl/assembl/blob/develop/assembl/views/api2/__init__.py
>
> https://github.com/assembl/assembl/blob/develop/assembl/view_def/__init__.py
>
> Some of this is terribly ad hoc, but I'd love to discuss ways to expand REST
> in > this direction in a more regular fashion.
>
> Best,
> Marc-Antoine
