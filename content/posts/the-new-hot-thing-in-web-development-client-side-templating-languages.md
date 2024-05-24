+++
title = "The New Hot Thing in Web Development: Client-side Templating Languages"
date = 2011-11-18
slug = "the-new-hot-thing-in-web-development-client-side-templating-languages"

[taxonomies]
tags = ["templating"]
+++

# The New Hot Thing in Web Development: Client-side Templating Languages

Back in 2003 I found myself at a sprint (a hackaton) to help build a web
framework. But that's not what I'm talking about right now.

For some reason I was messing around with JavaScript. This was before
JavaScript was cool. Let's give an impression of this era.

JavaScript was this abomination of a language used only by front-end
designers. Horrible code was written in it. The term AJAX hadn't been
coined yet - that was years into the future. We didn't really have the
browsers for it anyway, at least on Linux. Netscape 4.5 was the state of
the art; Firefox had barely been born and was still called Phoenix. It
was that dark moment in net history where it looked like Internet
Explorer might have won the browser wars for good.

So I was messing around with JavaScript. Zope, which I was using, had
this then fairly new template language called ZPT. I was wondering
whether I could implement ZPT in JavaScript and do templates in the
browser. I told other developers about it, and they all asked "why?" My
answer was something like "I don't know man, it's just cool!". I
remember I even worked on implementing unit tests for it in JavaScript.
But I *genuinely* didn't know what I'd use it for; how was I even going
to get data into it? JSON as a concept didn't exist yet either so I
probably was thinking about using XML.

The project went nowhere, of course. The idea was way ahead of its time;
so far ahead it was in fact still a crazy idea. I'm sure many people had
thought of it; even back in 2003 people had been doing crazy things with
JavaScript for years.

We flash forward to 2009. I was working on a project that involved a web
application that needed a dynamic search interface. It involved
JavaScript. I had noticed this client-side templating language called
[JSON-Template](http://json-template.googlecode.com/svn/trunk/doc/Introducing-JSON-Template.html).
I had already used its server-side Python implementation for another
project to provide customizable email templates in an application. I
figured we could write a little JavaScript framework to make it easy to
use JSON-Template. So we did that. And we built the user interface, and
it worked quite well, and the code for it was pretty easy to follow too,
so that was good.

The idea wasn't crazy anymore: client-side templating languages were now
useful! Over the course of the last year and a half a bunch of us
refined the ideas of this browser-side framework some more, and this
resulted into the creation of [Obviel](http://www.obviel.org) (which
does much more than just support client-side templates).

Many client-side templating languages, JSON-Template included, are
minimalistic. You combine a JSON object with a text file that has some
templating instructions in it to render a template. JSON-Template
doesn't even feature an expression language.

JSON-Template is a *push* only template language. Many templating
languages (but not JSON-Template) are *pull*: allow you to embed calls
to bits of application code within the template:
`some_object.get_something()`. But `get_something` could do *anything*;
call the database, raise exceptions, take a long time to execute, etc.
If you write templates that call into the application's API, you can
easily create a fairly tight coupling between application and template.
This means the template becomes harder to test and debug and change; the
bits of the application used by the template need to be available as
well during testing and debugging. It also means the application becomes
harder to change, because who knows what methods are being called by
templates?

A push-only template language doesn't have such a problem. But how do
you use such a minimalistic template language for complex scenarios
where all sorts of decisions need to be made and data needs to be
massaged? You can't do it in the template. Instead, you do the work in
advance, in JavaScript or Python or Ruby or whatever language you are
using. This means the logic is written in a full-featured programming
language which was designed to implement complicated logic, instead of
in a template language. It also means this logic is easier to test and
debug in isolation, without the template language being involved. Loose
coupling is awesome that way!

In fact, I believe many of the benefits of minimalistic push-only
template languages exist on the server as well as the client, and would
encourage people to write push-style templates also when writing
server-side templates.

Let's go through some benefits of minimalistic push-only templates:

- they can be more secure, as there's no application code called from
  the template.
- they're more easy to test in isolation. The stuff going *into* the
  template is also more easy to test in isolation.
- you end up with less complicated templates that are easier to
  maintain. I don't think that means the complexity simply moves to
  another place -- complexity is actually reduced. This is because a
  full featured programming language will let you express complex logic
  better than a template language can; better often means simpler.
- since templates are sandboxed, you can let non-programmers edit
  templates in some cases, without them needing to know about your
  application's API. This is helpful if you have a customizable
  application.
- the template language can be made to be very fast indeed as the
  language hardly has to do anything.
- they can be run on the client (in the web browser) too, not just on
  the server.

Running a template language on the client instead of on the server has
some important benefits as well:

- In this modern age, we build a lot of dynamic client-side
  applications. Templates can be very handy in helping to structure
  them, avoiding hard to maintain blobs of HTML-generating JavaScript.
- You almost *have* to use push strategies for templates, as you can't
  really avoid it - the data has to get to the client from the server.
  So doing things on the client can encourage more loose coupling in
  your codebase, and loose coupling is good.
- The performance of the template language becomes less important.

I'll go into the last statement a bit more deeply. It's a bit of a
paradox: while minimalistic push-only template languages can render
templates very quickly, running them on the client means they don't
really have to be that fast after all.

On the server, if you have a thousand users, a thousand users are
exercising your server-side template language engine. It can become a
bottleneck.

On the client, there's only ever one user: the user of the web browser.
If the template language is fast enough for that user, you're done. Your
server-side application may have a thousand users more, but the template
language performance is no longer a bottleneck. (Your JSON serializer
is. but JSON serializers can be *very* fast)

So can we exploit that? Since our language doesn't need to be blazingly
fast, can we do neat things that might take a bit more time? I think so.
I've been thinking for a while now about a template language much like
JSON-Template that would work with the HTML DOM as opposed to being text
based like JSON-Template is. This would likely make it slower, but we
can make it fast enough for a single user for sure. And then we can do
"live" binding between the JSON object being rendered and the DOM tree
rendered by the template. That would allow:

- update your data object and have the rendered template update in
  place, without re-rendering.
- imagine you're rendering an array of objects in your JSON, as some
  kind of HTML list or table. Each `li` or `tr` in fact is associated
  with an object in array. Now if you're setting up an event handler for
  each item in HTML, it's useful to know what underlying JSON object was
  used there, so you can use data that is in that object but not
  rendered in the event handler; an example of such data is a URL.

I'm sure I wasn't the first person to have such an idea, and I'd like to
hear about implementations of it if you know any. (in fact, I created a
hack based on JSON-Template back in 2009 that could do the second bit).
I hope to eventually integrate such a templating language into Obviel.
If you're interested in talking more about this, I hope to talk to you
in the comments or on the [Obviel mailing
list](http://www.obviel.org/en/0.-0/community.html)!
