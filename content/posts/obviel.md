+++
title = "Obviel"
date = 2011-11-02
slug = "obviel"

[taxonomies]
tags = ["obviel"]
+++

# Obviel

## Introduction

This document is an introduction to Obviel from the perspective of how
it was developed. For those impatient with history, you can just go to
<http://www.obviel.org> and read the documentation there, however.

## Genesis

A few years ago I worked on a dynamic web user interface on a project
for [Gocept](http://gocept.com/), using JavaScript of course. There I
invented a somewhat unusual approach to do:

- use [JSON
  Template](http://json-template.googlecode.com/svn/trunk/doc/Introducing-JSON-Template.html)
  to do client-side templating
- the server would return a JSON object and the client side template
  would then be used to render it.

## Callback Complexity

In the fall of 2010, I working on a few related customer projects to
create complex web applications that needed a good UI. As they were
applications, not web sites, I decided to create those UIs using a
single-page approach. The server would just present a single web page
with JavaScript to build and update the UI.

We decided to use [jQuery](http://jquery.com/) for those projects.
jQuery is very popular, with a vibrant community with a lot of
components choose from. It would mean we would have to do more
integration than we would need if we chose a more integrated framework
such as [YUI](http://developer.yahoo.com/yui/), which I also have
experience with, but I was a bit tired of big frameworks. And jQuery's
terse and powerful way to express things is attractive. And you just
have to make a choice to see what happens at some point, right?

The JavaScript code in those applications was quickly growing out of
control. We were trying to do proper
[REST](http://en.wikipedia.org/wiki/Representational_state_transfer):
the client would just start with a single URL, which would resolve to a
JSON object that would have links to other JSON objects on the server,
which would in turn have links to other JSON objects. Proper REST is
nice: you can decouple your client from the server more, because your
client code doesn't depend on the specific URL structure of your server
-- instead it just follows links.

But doing proper REST with JavaScript without taking special measures
tends to result in endlessly nested callbacks in callbacks in callbacks.
The code was too tightly coupled and hard to follow.

This made me think about the stuff I did at Gocept again. I felt there
was quite a bit of potential in those patterns, potential I hadn't
explored fully yet. So I added it to one of our projects and started to
rewrite the UI to use it, to try to clean things up.

## People

At this stage more people started to be involved. Ideas tend to get
better with good input, and with usage by a larger group of people. I
will forget some of the people involved in this project, for which I
apologize, but I'm going to drop some names now.

The original idea was born at Gocept. I was doing the work for Christian
Zagrodnick there, and I had some good conversations with him about it
then. He also used the early code in a few of his own projects later on.
Just as I had checked in the view stuff into the new project I was doing
I found myself in Germany at Gocept again, and had further productive
conversations with him about it. Thanks
[Zagy](http://twitter.com/#!/zagy)!

Going to Germany, where Gocept is based, from where I live, the
Netherlands, means a train ride, and in the train I had the opportunity
to bounce ideas off Jan-Wijbrand Kolman (and him ideas off me),
something I always enjoy tremendously. The biggest thing that came out
of that was [Fanstatic](http://www.fanstatic.org), but that's the topic
for another discussion. It also helped me think through what later
became Obviel. Thanks JW!

The idea developed around this time was that the JSON returned by the
server to JavaScript should have a type marker to describe what kind of
JSON we are dealing with then. In Obviel we call this type marker an
*iface*, short for interface. On the client, we could then hook up
*views* to ifaces. This way if the client is confronted with some
unknown JSON, it would know what to do with it by looking up the
appropriate view for that iface. This helps with REST and therefore with
loose coupling: the client code not only doesn't need to know what
resources the server is presenting, but also would be able to know what
resources are on what URLs; the resources would disclose this
themselves. In this, "JavaScript views" (as we were calling it at the
time) resemble dynamic view lookup like practiced in the [Zope Component
Architecture](http://www.muthukadan.net/docs/zca.html) (don't you all
run away now, though!).

## Practice

New approaches get better when you try to actually use them in practice.
You learn a lot. The customer projects I was doing were too big to do on
my own, I was working with [Izhar Firdaus](http://blog.kagesenshi.org/)
on them. Izhar gave me a lot of invaluable feedback and improvements and
came up with new patterns of using these "JavaScript views" (as we were
calling them) throughout the projects that use Obviel; I had great
pleasure working with him for over a year.

I think I already rewrote the system halfway back then, and I remember
Izhar doing something similar. Eventually after some experience I sat
down and started to write a document describing how I wanted this
JavaScript views thing to work. So I got [Guido
Wesdorp](http://debris.demon.nl/) involved. This meant Izhar and I were
freed up to build more application specific code and gain experience
with it.

Working with Guido in this way was a new experience: I had designed a
framework but Guido was implementing it. Guido focused on making the
code solid. I, Guido and Izhar together came up with various new
approaches.

## Forms

The projects we were working on needed a number of complex web forms. I
have a lot of experience with server-side form libraries. Some time
before I had been in a rich-client project with Jasper Op de Coul and he
suggested creating a JavaScript form library instead. This would offer
some benefits, such as inline validation for everything by default, and
web-framework neutrality. While we didn't implement the idea at the
time, it did stick in my mind.

Here we needed lots of complex forms again, and server-side validation
with errors didn't really fit well in a rich client UI. So I sketched up
a way to do JavaScript forms using a new technology [jQuery
datalink](http://api.jquery.com/category/plugins/data-link/). The
concept of Obviel forms is to maintain a JavaScript object with the form
contents in parallel to the HTML form (an earlier conversion with
Antonin Amand helped me develop this concept). When the user modifies
the form, the JavaScript object is automatically updated. A form
submission then simply submits that JavaScript data object as JSON to
the server.

I had Guido go ahead and start building the form library for us.

## Rewrites

"JavaScript views" had already gone through a few incarnations. I'd
rewritten it at least once, Izhar had given it another shot, and Guido
had rewritten it again.

Meanwhile [Sylvain Viollon](https://twitter.com/#!/thefunny42) at
[Infrae](http://www.infrae.com) had started using Obviel as well. He had
decided to do its own rewrite, to my chagrin at the time, as now we had
two parallel versions. But it turned out for the good: he had introduced
some new ideas into his version that were very useful: when a view was
rendered, it would be bound to the object it had just rendered, and the
element it was rendered on. These bound views would allow a better
structuring of view code than passing this information along as
parameters all the time.

We kept learning however, and after a while, when Guido had already
moved on from the project, several things in Obviel forms in particular
started to be frustrating.

So I decided to rewrite Obviel forms cleaning it up. Among new things
introduced were composite sub-forms and a generic repeat widget to allow
the user to enter repeating sub-forms as well, and a way to maintain the
inline error messages as a datalinked object as well. Govert Buijs, who
had started to work on the projects with us, also helped work out
advanced form validation scenarios.

On a roll, I decided to rewrite the Obviel core as well, introducing
Sylvain's ideas about bound views. Along the way I also started using
the new jQuery deferreds in its implementation (Sylvain then turned out
to have done so in his version as well, in parallel).

## Documentation

Now it is time to attract more people to Obviel. It's been battle tested
in a number of big projects.

To attract people to a project you not only need good code. We do have
good code I think: it's unit tested and coverage tested. But you also
need great documentation. Along the way I and Guido had written bits of
documentation about Obviel. It took me months of stops and start to get
this documentation in the state it is now, so that newcomers to Obviel
aren't lost.

So, if you are curious about Obviel and want to find out more, go to
<http://www.obviel.org>

And give us [feedback](http://www.obviel.org/en/latest/community.html),
please!
