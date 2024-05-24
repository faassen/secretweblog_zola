+++
title = "The Emerging GraphQL Python stack"
date = 2015-09-28
slug = "the-emerging-graphql-python-stack"

[taxonomies]
tags = ["javascript", "python", "planetpython", "graphql", "relay"]
+++

GraphQL is an interesting technology originating at Facebook. It is a
query language that lets you get JSON results from a server. It's _not_
a database system but can work with any kind of backend structure. It
tries to solve the same issues traditionally solved by HTTP "REST-ish"
APIs.

# Some problems with REST

When you do a REST-ish HTTP API, you expose information about the server
on a bunch of URLs. These URLs each return some data, typically JSON.
You can also update the server using HTTP methods, such as `POST`, `PUT`
and `DELETE`. The client-side code needs to know what URLs exist on the
system and construct URLs based on what it wants to know. If your
REST-ish HTTP API is also a proper REST API (aka a hypermedia API), you
make sure that all information can actually be accessed without
constructing URLs but by following links (or doing search requests)
instead -- this is more loosely coupled but also more difficult to
implement.

But REST-ish HTTP APIs have some problems:

spamminess  
Imagine you have person resources and address resources. If you have a
UI on the client that shows a person's address, you will have to access
both resources on separate URLs. This can easily add up to a lot of
requests from the client to the server. This not only causes network
traffic but can also make it harder to program the client, especially if
you can only do a new request based on information you got in another
response.

You can reduce this problem by embedding information -- a person
resource has address information directly embedded in it. But there's no
standard way to control what gets embedded and this makes the next issue
worse.

too much information  
In a HTTP API, you want to send out as much information about a resource
as possible, even if a particular UI doesn't need it. This means that
there is more network traffic, and possibly more work done on the server
to generate the data even though it's not needed.

too little information  
There is typically rather little machine-readable metadata that
describes what the information on the server really exists. Having such
information can really help with tooling, and this in turn can help
avoid bugs. There are emerging specifications that tackle this, but
they're not commonly used.

REST will be here to stay for the foreseeable future. There is also
nothing inherent in REST that stops you from solving this -- I wrote
about this in a [previous blog
entry](/posts/graphql-and-rest.html). But
meanwhile GraphQL has already solved much of this stuff, so at the very
least is interesting to explore.

# GraphQL

GraphQL introduces a query language that lets the client express what it
really wants from the server. A single request with this query goes to
the server, and the server comes back with a complete structure with
everything that's needed for a particular state of the UI. To get person
information with its address information embedded, you can write
something like:

    {
      person(id: 101) {
        fullname,
        address {
          street
          number
          postalCode
          city
          country
        }
      }
    }

You get back JSON like:

    {
      "person":
        "fullname": "Bob Lasereyes',
        "address: {
          "street": "Laserstreet",
          "number": "77",
          "postalCode": "XYZQ",
          "city": "Super City",
          "country": "Mutantia"
      }
    }

Check the [GraphQL
readme](https://github.com/facebook/graphql/blob/master/README.md) for
much more.

This solves the issues with RESTish HTTP APIs:

less spamminess  
To represent a single UI state you can typically get away with doing
just a single request to the server specifying everything you need. The
server then gives you a single response.

the right amount of information  
You only get the information you ask for, nothing more, nothing less.

enough meta information  
The server has a schema (which tools can introspect) that describes
exactly what kind of data you can access.

# Relay

If you use GraphQL with the React UI library there's another project
from Facebook you can use with it:
[Relay](https://facebook.github.io/relay/). Relay lets you declare what
data you want (using GraphQL), co-locate GraphQL snippets with the bits
of UI that need it, so your UIs are more composable and can be
rearranged more easily, and has a sophisticated system to help with
mutations, so that you display the updated information in the UI as
quickly as possible without re-fetching too much data.

It's cool, it's just new, I want to explore it to see whether it can
tackle some of my use cases and make life easier for developers.

# On the server side

So Relay and GraphQL are interesting and cool. So what do we need to
start using it? To use React with Relay on the client side to build UIs,
we need a Relay-compliant GraphQL server.

Facebook released a reference implementation of GraphQL, in JavaScript:
[graphql-js](https://github.com/graphql/graphql-js). It also released a
library to help make a GraphQL server Relay compliant, again in
JavaScript:
[graphql-relay-js](https://github.com/graphql/graphql-relay-js). It also
released a server that exposes GraphQL over HTTP, again in JavaScript:
[express-graphql](https://github.com/graphql/express-graphql).

That's all very cool if your server is in JavaScript. But what if your
server is in Python? Luckily the Facebook people anticipated this and
GraphQL is not bound to JavaScript. See the [GraphQL draft
specification](https://facebook.github.io/graphql/) and the [GraphQL
Relay
specification](https://facebook.github.io/relay/docs/graphql-relay-specification.html).

# The Python GraphQL stack

Last week I started exploring the state of the GraphQL stack in Python
on the server. I was very pleased to find that it was in good shape
already:

- [graphqllib](https://github.com/dittos/graphqllib): this is an
  implementation of GraphQL by Taeho Kim with contributions by an
  emerging open source community around it. Lots of contributions are by
  Jake Heinz, who was also very helpful in discussions on the Slack chat
  (<span class="title-ref">\#python</span> at
  <https://graphql-slack.herokuapp.com/>).
- [graphql-relay-py](https://github.com/syrusakbary/graphql-relay-py):
  an implementation of <span class="title-ref">graphql-relay-js</span>
  for Python by Syrus Akbary, so we can make our GraphQL Relay server
  more compliant.

The piece that was missing was actually using this stack as a backend
for a React + Relay frontend. Was it mature enough to do this? I figured
I'd give it a try. So I set out to port the one missing piece to Python,
the HTTP web server. So I took
<span class="title-ref">express-graphql</span> and ported over its code
and tests to Python + WSGI using WebOb. The result is
[wsgi_graphql](https://github.com/faassen/wsgi_graphql), a WSGI
component that offers the same HTTP API as
<span class="title-ref">express-graphql</span>.

It was a fun little exercise. I found a few issues in
<span class="title-ref">graphqllib</span> while doing so, and they're
fixed already. I even found a minor bug in
<span class="title-ref">express-graphql</span> while doing so, which is
fixed as well.

So does it work? Can you use React and Relay on the frontend with Python
on the backend? I created a demo project,
[relaypy](https://github.com/faassen/relaypy), that experimentally pulls
all these pieces together. It exposes a GraphQL server with a
Relay-compliant schema. I hooked up some simple React + Relay code on
the frontend. _It worked!_ In addition, I threw in a cool
introspection/query UI that was created for GraphQL called
<span class="title-ref">GraphiQL</span>. This works too!

Should you be using this stuff in the real world? No, not yet. There are
big warning letters on the graphqllib project that it's **highly
experimental**. But while it's all very early days for these components,
but the Python support has come very far in just a few short months --
GraphQL was only released as a public project in July, and Relay is even
younger. I expect that in a short time this stuff will be ready for
production and we'll have a capable GraphQL stack in Python that we can
use with React and Relay.

# Bonus: Graphene

Emerging just last week as well was
[graphene](https://github.com/syrusakbary/graphene), which a very new
library by Syrus Akbary to make implementing GraphQL servers more
Pythonic. The API offered by <span class="title-ref">graphqllib</span>
is rather low-level, which is nice as it's very flexible, but for many
Python projects you'd like to use something more Pythonic. Graphene
promises to be that API.
