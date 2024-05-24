+++
title = "Modern Client-Side Times"
date = 2013-01-30
slug = "modern-client-side-times"

[taxonomies]
tags = ["planetpython", "python", "javascript", "framework", "django", "rest"]
+++

## Introduction

Reinout wrote [a blog
post](http://reinout.vanrees.org/weblog/2013/01/30/defense-of-django.html)
about the client side and what it means for server-side web development.
Lots of it is very interesting to me, so I'm going to give some feedback
here.

One of the central questions Reinout covers is whether the server-side
web framework will become merely a system that serves up an API
(presumably RESTful, or at least not so RESTful HTTP, or perhaps web
sockets). A rich client-side application written in JavaScript then does
the actual UI presentation. Does this mean current web frameworks such
as Django, or the people using the server-side paradigm, such as
Reinout, are becoming obsolete?

(By the way, I prefer the term "web service" to API, but the difference
is at best subtle. A web service promises some discoverability (using,
say, hyperlinks) that an API perhaps does not. A RESTful web service
leads to resource-oriented modeling, which is subtly different from
traditional OOP API design.)

Since I've been doing a lot of work on client-side single-page user
interfaces that talk to RESTful (or web socket) backends in recent
years, I figure I'd comment. I've been working on and with
[Obviel](http://obviel.org), and I've mostly worked with Grok-based
RESTful + JSON backends.

## The new way obsoletes the old?

So, back to Reinout's question: is the new paradigm going to obsolete
the old? Does the rich client-side user interface approach obsolete
server-side web frameworks?

Reinout disagrees, and I do too. There is a huge area where server-side
rendered HTML is the way to go. Not all web sites are single-page web
applications, nor should they be. Not all rich web applications are
single-page either.

I do find rich client side web applications a very _interesting_ part of
web development. I think much innovation takes place here. I am
attracted to areas of innovation as I like being creative. I think the
client-side paradigm can, when used well, lead to improved application
design, with better separation between UI and backend code.

I'll also note that _the old way informs the new_: I've found it
extremely useful to think about Obviel as a _web framework_ and think
about what server-side web frameworks do and what this might look like
in the client. Your knowledge of server side web development is not
obsoleted even if you develop in the client-side paradigm.

## What goes and what stays?

With a single-page rich client application, the server-side web
framework has to do less. What tends to go away from the server side?

- server-side templates (templates are now client-side).
- form generation (at least with Obviel; though form-definition
  generation is still there)
- sessions (a single-page web app doesn't need a session; it can store
  whatever it likes between requests to the backend service)

What remains is still significant, however:

- serving up JSON on URLs with hyperlinks to other URLs
- processing POSTs of JSON content (this may include parts of form
  validation)
- traversal or routing to content
- integrating with a database (SQLAlchemy in this case)
- authentication - who are you?
- authorization - who can access this URL?
- serve up an initial web page pulling in a whole bunch of static
  resources (JS, CSS)

The client web framework (such as Obviel) gains some features that are
traditionally done on the server-side:

- templating
- form generation and part of validation
- routing (though this is in _addition_ to any routing done by the
  server - it's to allow URLs for different aspects of a single page
  application)
- i18n (if your client side web framework can do it)

Saying that the server side becomes "just an API" is an overstatement, I
think. Much of what was useful to a server side web framework is still
useful. The main thing that changes is that what goes over the wire from
server to client isn't rendered HTML anymore. This is a major change
that affects everything, but much does stay the same nonetheless.

## Random extra points

Reinout makes a few assorted extra points, and I'll respond to some:

- _"I do want to use APIs and javascript a lot, I just don’t want the
  user interface to be king."_

  I try to design web services where the web service in itself makes
  sense, independent of user interface. I haven't gotten this 100% right
  yet, but I do notice that I can develop the back-end and the
  client-side rather independently from each other. I don't find myself
  switching from client-side to server-side and back again the whole
  time when developing a new feature or fixing a bug; usually the
  problem is isolated in one place or another.

  Ideally, the web service isn't the servant of one UI; doing so will
  create a service that is purely ad-hoc and doesn't expose clean
  resources. The web service should be designed in a clean way
  independent of particular UIs. In the real world of course there are
  compromises, but if you just go into this direction a little the UI
  will be brought down from its kingship and become a proper citizen.

- _"i18n is easier to manage in Python/Django than in Javascript."_

  For most JavaScript web frameworks this appears to be true. But not if you
  use use Obviel! [Obviel's i18n
  system](http://www.obviel.org/en/latest/i18n.html) is on-par with best of
  breed server-side i18n, and in some points stronger (pluralization). Obviel
  builds on babel (in Python) and you can extract translatable strings from
  JavaScript, Obviel Templates (client-side) and Python code.

  (Obviel still needs a kick-ass localization system for things like
  dates and such - want to help?)

- _"We haven’t tested a single line of javascript in the three years
  \[of development\]..."_

  Reinout here implies that if you move functionality to JavaScript you won't
  test it. It's certain possible to do extensive test coverage for JavaScript
  code, and there are high-quality tools: I've used
  [Buster.JS](https://busterjs.readthedocs.io/en/latest/) and
  [Sinon.JS](https://sinonjs.org/) for Obviel, for instance. Tools like
  Selenium let you write automated tests for complex user interfaces too.

  While it may be true that you have experience with writing Python
  tests _now_ and not with writing tests for client-side JavaScript
  code, it is possible to do this for client-side code just fine.

- _"The core of the new html+javascript+api approach sounds to me like
  'I want to build a modern web interface with html+javascript+api'.
  There isn’t much 'data source' or 'customizations' or 'quick
  modification in a subclass' in the core of that approach. It sounds
  like it is aimed at building one single individual great website."_

  I'm not entirely sure what this is about. Server-side web development
  doesn't go away, and you can do whatever you want with data sources
  and customization there. The main difference I see is that when you
  need to display the results in a UI, you don't use a server-side
  template but serve up JSON and use client-side templates instead. I'd
  also say the concept of a data source can become _more_ explicit if
  it's also served up under a URL.

  Perhaps this is therefore also about user interface customization. The
  way this is done would have to move, at least in part, from the server
  to the client, but that is certainly possible (Obviel offers one way
  to do that, and you can drive UI construction from the server).

- _"Repeatability, rebuildability, customizability."_

  Reinout has a great deal of experience with creating repeated builds
  of complex Python applications. He wonders what the state of the art
  is for JavaScript applications.

  It's not as good as the Python world, I think.

  While there are a whole bunch of tools available for JavaScript, it's
  scattered all over the place. You can package a JavaScript library and
  manage its dependencies, but the problem is that often _you_ have to
  do such a thing instead of simply using packaging by the original
  authors. Common approaches are in the works, but they're not very
  mature yet, at least on the client-side.

  For Python projects we created a static resource packaging solution called
  [Fanstatic](https://pypi.org/project/fanstatic/), by the way. But it's one
  way of many.

## Conclusions

Server-side web applications aren't going to go away. Server-side
concepts often apply to the client side. These things will exist in
parallel. So: you are not obsolete.

Client-side web development is trendy, and trends tend to bring in hype,
and hype is overstated. Let's not throw away our server-side wisdom just
because new ways of doing things have emerged.

Solid, client-side development can be done, but it's not as mature as
with Python. A corollary to that: there is a lot of creativity on the
client side, and that is fun!

And a plug for [Obviel](http://obviel.org): Obviel is a client-side web
framework that you can adopt incrementally, and it's informed by
server-side concepts.

## Preserved Comments

### Balazs Ree

> I agree with your conclusion: our server side applications will not go away,
> at least not today. I can also see natural points in real life web apps where
> the two technologies can connect with each other.
>
> Regarding unit testing front-end JavaScript: "Untested code is broken code",
> this actually applies in the same way to JS as to say, Python. But while we
> have a culture which says that a Python code is immediately rejected if there
> are no tests, we don't yet have the same culture for JS. But the culture will
> arrive, because the modern testing environments make it easy to do Test
> Driven Development with JS, and even run the tests automatically on each
> supported browser whenever you save a new version of the source in your
> editor. I am using BusterJS for that, and this has already become my daily
> practice.
>
> Part of the story of testing JS, that when you start unittesting your code,
> you realise that you have to develop modular code. If you have no components,
> just a blob of JS in an HTML page, you will not be able to test your units,
> as you have no units.
>
> In my experience, the easier part of JS testing is to learn is how to write
> your test. The more difficult part to learn is, how to write modular JS that
> is testable. This means that unittesting will be your teacher to write better
> code, once you take the effort to do it.

### Martijn Faassen

> That's a good point; there are habits to write proper modular JS code just
> like there are habits to do the same for Python, and one way to learn them is
> to do testing.
