+++
title = "Seven Years: A Very Personal History of the Web"
date = 2017-01-25
slug = "seven-years-a-very-person-history-of-the-web"

[taxonomies]
tags = ["python", "planetpython", "javascript", "react", "morepath", "zope"]
+++

# Introduction

Humans are storytellers. As anyone who knows me can confirm, I
definitely enjoy the activity of telling stories. We process and
communicate by telling stories. So let me tell you all a story about my
life as a web developer the last 7 years. It may just be
self-reflection, but hopefully it's also useful for some others. Perhaps
we can see my story as a highly personal history of the web.

I always say that what pulls me to software development most is
creativity. I am creative; I can't help myself. I enjoy thinking about
creativity. So this is also going to be about my creative trajectory
over the last 7 years.

Why 7 years? Because in early 2010 I decided to withdraw myself from a
software development community I had been involved in for about 12 years
previously, and I took new paths after that. It is now early 2017; time
to take stock.

**Letting go of an intense involvement with a software development
project, up to the point where it became part of my identity, was
difficult. Perhaps that's a geeky thing to say, but so it is. I needed
to process it.**

# Life after Zope

Zope was a web framework before that concept existed. The modern web
framework only materialized sometime in the year 2005, but Zope had been
ahead of its time. I was involved with the Zope community from when it
was first released, in 1998. I learned a lot from Zope and its
community. I made many valued connections with people that last until
this day.

Zope helped shape who I am and how I think, especially as a web
developer. In 2013 I wrote a
[retrospective](/posts/my-exit-from-zope.html)
that went into the history of Zope and my involvement with it.

**But I did not just process it by writing blog posts. I also processed
it creatively.**

# Frameworks

So I am a web developer. Back in 2010 I saw some people argue that the
time of the web framework had passed. Instead, developers should just
gather together a collection of building blocks and hook it up to a
server using a standard API (WSGI in the case of Python). This would
provide more flexibility than a framework ever could.

In a "X considered Y" style post I argued that [web frameworks should be
considered
useful](/posts/older/web-frameworks-considered-useful.html).
Not that many people needed convincing, but hey, why not?

I wrote:

> The burden of assembling and integrating best of breed components can
> be shared: that's what the developers of a framework do. And if you
> base your work on a pre-assembled framework, it's likely to be less
> work for you to upgrade, because the framework developers will have
> taken care that the components in the framework work together in newer
> versions. There is also a larger chance that people will write
> extensions and documentation for this same assembly, and that is very
> likely something you may benefit from in the future.

I follow the [ReactJS](https://facebook.github.io/react/) community. The
React community definitely is a community that lets you self-assemble a
framework out of many parts. This gives that ecosystem flexibility and
encourages creativity -- new approaches can be tried and adopted
quickly. I like it a lot.

But figuring out how to actually _start_ a React-based project had
become a major effort. To get a good development platform, you needed to
learn not only about React but also about a host of packaging and build
tools: CommonJS and Webpack and npm and Babel and so on. That's quite
intimidating and plain work.

So some React developers realized this and created
[create-react-app](https://github.com/facebookincubator/create-react-app)
which makes it easy to start a working example, with minimal boilerplate
code, and with suggestions on how to expand from there. It's a build
framework for React that gathers good software in one place and makes it
easy to use. **It demonstrates how frameworks can make life easier for
developers. It even goes a step further and allows you to opt out of the
framework once you need more control. Now that's an interesting idea!**

# Client-side JS as Servant to the Server UI

So frameworks are useful. And in late 2010 I had an idea for a new one.
But before I go into it, I will go on a digression on the role of
client-side JavaScript on the web.

This is how almost all JavaScript development used to be done and how
it's still done today in many cases: the server framework generates the
HTML for the UI, and handles all the details of UI interaction in
request/response cycles. But sometimes this is not be enough. More
dynamic behavior on the client-side is needed. You then write a little
bit of JavaScript to do it, but only when absolutely necessary.

This paradigm makes JavaScript the ugly stepsister of whatever server
server programming language is used; a minor servant of Python, Ruby,
Java, PHP or whatever. The framework is on the server. JavaScript is
this annoying thing you have to use; a limited, broken language. As a
web developer you spend as little as time possible writing it.

In short, in this paradigm JavaScript is the servant to the server,
which is in charge of the UI and does the HTML generation.

But JavaScript had been gathering strength. The notion of HTTP-based
APIs had attracted wide attention through REST. The term AJAX had been
coined by 2005. Browsers had become a lot more capable. To exploit this
more and more JavaScript needed to be written.

jQuery was first released in 2006. jQuery provided better APIs over
sucky browser APIs, and hid incompatibilities between them. Its core
concept is the selector: you select things in the web page so you can
implement your dynamic behavior. Selectors fit the server-dominant
paradigm very well.

# Client-side JS as Master of the UI

By 2010, the notion of single-page web application (SPA) was in the air.
SPAs promised more powerful and responsive UIs than server-side
development could accomplish. The backend is a HTTP API.

**This is a paradigm shift: the server framework lets go of its control
of the UI entirely, and client-side JavaScript becomes its new master.
It encourages a strong separation between UI on the client and business
logic on the server. This brings a big benefit: the unit of UI reuse is
on the client, not spread between client and server. This makes reuse of
UI components a lot easier.**

By 2010, I had [played with client-side template languages
already](/posts/older/the-new-hot-thing-in-web-development-client-side-templating-languages.html).
I was about to build a few large web applications, and I wanted them to
be dynamic and single page. But client-side JavaScript could easily
become a mess. I wanted something that would help organize client-side
code better. I wanted a higher-level framework.

# The idea

**So there we finally get to my idea: to create a client side web
framework, by bringing over concepts from server frameworks to the
client, and to see what happens to them. Cool things happen!** We
started with templates and then moved to MVC. We created a notion of
[components](/posts/the-core-of-obviel.html)
you could [compose
together](/posts/powerful-composition-with-obviel-data-render.html).
We created a client-side [form
library](http://www.obviel.org/en/1.0/form.html) based on that. In 2011
we released this as
[Obviel](/posts/older/obviel.html).

**For a little while in 2010, early 2011, I thought I was the only one
with this cool idea of a client-side web framework. It turns out that I
was not: it was a good idea, and so many people had the same idea at
about the same time.** Even before we released Obviel, I started to hear
about Backbone. Ember and Angular soon followed.

I continued working on Obviel for some time. I created a [template
language](http://www.obviel.org/en/1.0/template.html) with a built-in
[i18n system](http://www.obviel.org/en/1.0/template_i18n.html) for it,
and a [client-side router](http://www.obviel.org/en/1.0/traject.html).
Almost nobody seemed to care.

In 2011 and 2012 we built a lot of stuff with Obviel. In the beginning
of 2013 those projects were done. Obviel didn't get any traction in the
wider community. It was a project I learned a lot from, so I don't
regret it. I can claim deep experience in the area of client-side
development.

# React

I went to my first [JS
conference](/posts/jsconf-eu-2013-impressions.html)
in September of 2013. I had originally submitted a talk about Obviel to
it, but it wasn't accepted. _Everybody_ was promoting their shiny new
client-side framework by that time.

So was Facebook. Pete Hunt gave a [talk about
React](https://www.youtube.com/watch?v=x7cQ3mrcKaY). This was in fact
only the second time React had been introduced to a wider audience.
Apparently it went over a lot better than the first time. It certainly
made an impression on me: there were some fascinating new ideas in it.
The React community became ferment with fascinating new ideas. At the
conference I talked to people about another idea I'd had: a client
framework that helps coordinate client/server communication; maybe sort
of like a database, with transactions that commit UI state to the
server? Nobody seemed to know of any at the time. Uh oh. If _nobody_ has
the idea at the same time, then it might be a bad one?

Then from the React community came Flux and Redux and Relay and Mobx. I
let go of Obviel and started to use React. There is a little irony
there: my move to client-side frameworks had started with templates, but
React actually let go of them.

# The Server in Modern Client-side times

In early 2013 I read an interesting blog post which prompted me to write
[Modern Client-Side
Times](/posts/modern-client-side-times.html),
in which I considered the changed role of the server web framework if it
was to be the servant to JavaScript instead of its master.

I wrote a list of what tasks remain for the server framework:

> What remains is still significant, however:
>
> - serving up JSON on URLs with hyperlinks to other URLs
> - processing POSTs of JSON content (this may include parts of form
>   validation)
> - traversal or routing to content
> - integrating with a database (SQLAlchemy in this case)
> - authentication - who are you?
> - authorization - who can access this URL?
> - serve up an initial web page pulling in a whole bunch of static
>   resources (JS, CSS)

I also wrote:

> Much of what was useful to a server side web framework is still
> useful. The main thing that changes is that what goes over the wire
> from server to client isn't rendered HTML anymore. This is a major
> change that affects everything, but much does stay the same
> nonetheless.

**I didn't know at the time of writing that I would be working on just
such a server web framework very soon.**

# On the Morepath

In 2013 I put some smaller pieces I had been playing with for a while
together and created [Morepath](http://morepath.readthedocs.io), a
server Python web framework. I gave an [over-long keynote at PyCON
DE](https://www.youtube.com/watch?v=9A5T9C2OBB4) that year to describe
the creative processes that had gone behind it. I gave a [more focused
talk](https://www.youtube.com/watch?v=gyDKMAWPyuY) at [EuroPython
2014](/posts/my-visit-to-europython-2014.html)
that I think works better as an introduction.

I [announced Morepath on my
blog](/posts/on-the-morepath.html):

> For a while now I've been working on Morepath. I thought I'd say a bit
> about it here.
>
> Morepath is a Python web micro-framework with super powers. It looks
> much like your average Python micro-framework, but it packs some
> seriously power beneath the hood.

One of the surprises of Morepath was the discovery that a web framework
that tries to be good at being a REST web server actually works very
well as a server web framework as well. That does make sense in
retrospect: Morepath is good at letting you build REST services,
therefore it needs to be good at HTTP, and any HTTP application benefits
from that, no matter whether they render their UI on the client or the
server. Still, it was only in early 2015 that Morepath [gained official
support for server
templates](/posts/server-templating-in-morepath-010.html).

2014 was full with Morepath development. I announced it at EuroPython.
It slowed down a little in 2015, then picked up speed again in 2016.

I'm proud that Morepath is micro in implementation, small in its
learning surface, but macro in power. The size of Morepath is another
surprise: Morepath itself is currently a little over 2000 lines of
Python code, but it does a _lot_, helped by the powerful
[Reg](http://reg.readthedocs.io/) (\<400 lines) and
[Dectate](http://dectate.readthedocs.io) (\<750 lines) libraries.
Morepath offers composable, overridable, extensible applications, an
extensible configuration system, an extensible view dispatch system,
automated link generation, built-in powerful permission rule system, and
lots more. **Morepath is like Flask, but with a nuclear fusion generator
inside. Seriously. Take a look.**

# The Future?

Over the last few years Morepath has become a true open source project;
we have a small team of core contributors now. And in late 2016 Morepath
started to gain a bit more attention in the wider world. I hope that
continues. Users that turn into contributors are invaluable for an open
source project.

There was a mention of Morepath in an [Infoworld
article](http://www.infoworld.com/article/3133854/application-development/5-wicked-fast-python-frameworks-you-have-to-try.html),
I was interviewed about it for
[Podcast\_\_init\_\_](https://www.podcastinit.com/episode-91-morepath-with-martijn-faassen/),
and was also interviewed about it for an upcoming episode of [Talk
Python to Me](https://talkpython.fm/).

Ironically I've been writing some Django code lately. I'm new to Django
([sort of](http://reinout.vanrees.org/weblog/2011/06/07/zope.html)). **I
have been reintroduced to the paradigm I started to leave behind 7 years
ago. With standard Django, the server rules and JavaScript is this
adjunct that you use when you have to. The paradigm works, and for some
projects it may be the best approach, but it's definitely not my
preferred way to work anymore.** But I get to help with architecture and
teach a bit so I'll happily take the Django on board.

The Django management UI is cool. It makes me want to implement the
equivalent for Morepath with PonyORM and React and Mobx. Or something.
Want to help?

I've been itching to do something significant on the client-side again.
It's been a little while since I got to do React. I enjoyed attending
[React Europe
2015](/posts/thoughts-about-react-europe.html)
and [React Europe
2016](/posts/impressions-of-react-europe-2016.html).
I played with React Native for a bit last year. I want to work with that
stuff again.

The space where client and server interacts is fertile with creative
potential. That's what I've found with Obviel and React on the client,
and with Morepath on the server side. While GraphQL replaces the REST
paradigm that Morepath is based around (oops!), I'd enjoy working with
it too.

**Where might the web be going? I like to think that by being creative I
sometimes get to briefly peek into its near future. I hope I can
continue to be creative for the next 7 years, as I really enjoy it.**

I'm a freelancer, so the clients I work for in part shape my creative
future. Hint. [Let me know if you have something interesting for me to
work
on](/posts/looking-for-new-challenges.html).
