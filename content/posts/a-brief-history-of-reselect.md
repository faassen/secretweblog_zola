+++
title = "A Brief History of Reselect"
date = 2015-10-12
slug = "a-brief-history-of-reselect"

[taxonomies]
tags = ["javascript", "open source", "redux", "react", "reselect", "zope", "sprints"]
+++

# Introduction

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

[Reselect](https://github.com/rackt/reselect) is a library with a very
brief history that until a few days ago was sitting on my personal
Github account. What does it do? It's not very relevant for this blog
post, as I'm more interested in its history as an open source project.
But briefly: it's a JavaScript library. It lets you automatically cache
expensive calculations in a client-side web application.

Reselect was born in early July of this year. Since then, in less than
four months, it gained more than 700 stars on Github. To compare: I have
another project that I spent a few years working on and promoting. I
blogged about it, spoke about it at two conferences, and at a meetup or
two. It has less than 200 stars.

So I thought it might be instructive and amusing to trace the brief
history of this little library.

# Context: JavaScript

Reselect is a JavaScript library. JavaScript has been a very fast moving
space these last few years. The JavaScript community moves so quickly
people make jokes about it: new JavaScript MVC frameworks get invented
every day. I actually created my own way back before it was cool; I'm a
JavaScript MVC framework hipster.

Tooling for both client and server JavaScript changes very quickly. In
the last year have we seen the emergence of ES6, also known as ES2015,
which only got formally ratified as a standard last June. It's a huge
update to the JavaScript language.

JavaScript is in the interesting position of being a lingua franca: it's
a language _many_ developers learn, coming from a wide range of
different programming communities. Ideas and values from these different
programming communities get adopted into JavaScript. One of the most
interesting results of this has been the adoption of functional
programming techniques into JavaScript.

I actually find myself learning about more advanced functional
programming techniques now because I am writing a front-end web
application. This is cool.

# Context: React

React is a JavaScript library that came out of Facebook. It lets you
build rich client-side web applications. It's good at doing UI stuff. I
like it.

The React community is very creative. React rethought how client-side
UIs works, and now people are rethinking all kinds of stuff. Some of
these new thoughts will turn out to be bad ones. That's normal for
creativity. We're learning stuff.

When you have a UI you have to manage the UI state: UI state has to be
kept in sync with state on the server somehow. A UI may need to be
updated in several places at once.

Last year Facebook presented this new way to managestate they called
Flux. It's inspired by some functional programming ideas. Interestingly
enough they didn't release code at first, just talked about the basic
idea. As a result in typical JavaScript fashion a thousand Flux
implementations bloomed.

Then in May of this year, Dan Abramov announced on Twitter "Oh no am I
really writing my own Flux library".

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">Oh no am I really writing my own Flux library</p>&mdash; Dan Abramov (@dan_abramov) <a href="https://twitter.com/dan_abramov/status/604356871722569728">May 29, 2015</a></blockquote>

# Context: Redux

A few words about Dan Abramov. He's smart. He's creative. He's
approachable. He's intimidatingly good at open source, even though he's
been around for only a short time. He connected to everybody on Twitter,
spreading knowledge around. He built very useful libraries.

So in a few short months, at typical JavaScript speed, Redux turned from
"yet another Flux library" to what's probably the most popular Flux
implementation around today. Dan rethought the way Flux should work,
applied some more functional programming concepts, created awesome
tooling, and people liked it.

I give it away early, but the rise of Redux explains why Reselect became
so popular so quickly: it's riding the coattails of Redux. Dan Abramov
promoted it with his Twitter megaphone, and included a reference to it
in the Redux documentation as a way to solve a particular class of
performance problems.

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">Reselect lets you compose nested state selectors with memoization a la NuclearJS: <a href="https://t.co/d5uFyxDjI9">https://t.co/d5uFyxDjI9</a> <a href="http://t.co/Qiv6YLrxV8">pic.twitter.com/Qiv6YLrxV8</a></p>&mdash; Dan Abramov (@dan_abramov) <a href="https://twitter.com/dan_abramov/status/619531111996223488">July 10, 2015</a></blockquote>

# Reselect prehistory

So how did Reselect come about?

In early June, [the problem was
identified](https://github.com/rackt/redux/issues/47) in the Redux issue
tracker.

In late June Robbert Binna came out with a [pull
request](https://github.com/rackt/redux/pull/169):

# The birth of Reselect

In the beginning of July, the first React Europe conference was held in
Paris. I had signed up to the Hackathon to be held one day before the
conference. I was almost more excited about this than the conference
itself, because I have very good experiences with collaborative software
development meetups. You can really get to know other developers, learn
a lot, and build cool new open source infrastructure stuff. It lets you
get out of the details of your day to day project and step back and
solve deeper problems in a good way.

But a few days before my departure I learned to my dismay that this
Hackathon was supposed to be a contest for a prize, not a collaborative
hacking session. I grumbled about this on the Redux chat channel. I
asked whether anyone was interested in hacking on infrastructure stuff
instead.

Luckily Lee Bannard (AKA [ellbee](https://github.com/ellbee)) replied
and said he was! So we arranged to meet up.

So on the day of the Hackathon the two of us sat outside of the main
room where everybody was focused on the contest. Lee had the idea to
work on this calculation caching issue. I was a complete noob about this
particular problem, so he explained it to me. He had experience with how
NuclearJS tackled the problem, and knew about the pull request for
Redux.

We also met Dan Abramov there, so we could talk to him directly. He was
reluctant to add new facilities to Redux itself, especially as we were
still exploring the problem space. So we decided to create a new library
for it that could be used with Redux: Reselect.

We sat down and carefully examined the pull request. At first I was
"this is all wrong" but the longer we looked I realized the code was
actually quite right and I was wrong: it was elegant, doing what was
needed in a few lines of code.

We refactored the code a little, making it more generic. We cleaned up
the API a bit. We also added automated tests. Along the way we needed to
check it in somewhere so I put it on my personal Github page. At the end
of the day we had a pretty nice little library.

I enjoyed the conference a lot, went home and wrote a
[report](@/posts/thoughts-about-react-europe.md).

# Reselect afterwards

I got busy with work. While I glanced at Reselect once every while I had
no immediate use for it in my project. I quickly gave Lee full access to
the project so I wasn't going to block anything. Lee Bannard proved a
very capable maintainer. He also added a lot of documentation. Dan used
his megaphone, and Reselect got quite a few users quickly, and a lot of
small contributions. The official Redux documentation points to
Reselect.

And as my work project progressed, I found out I did have a use case for
it after all, and started using it.

# I did not create Reselect

Since it was on my Github account, people naturally associated me with
the project, and assumed it was mine. While that's very good for my name
recognition, it didn't sit right with me. I spent a day helping it into
existence, and a few hours more afterwards, but more credit should go to
others. It's very much a collaborative project.

I brought this up with Lee a few times. He insisted repeatedly he did
not mind it being on my Github account at all. Now I think he's awesome!

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">To build reselect was <a href="https://twitter.com/leebannard">@leebannard</a>&#39;s idea. It was based on a proposal by speedskater. Me, I helped out a bit. :)</p>&mdash; Martijn Faassen (@faassen) <a href="https://twitter.com/faassen/status/652132110124322816">October 8, 2015</a></blockquote>

# To Rackt

But last week, as people told me explicitly "hey, I use your Reselect
library!" I figured I should do something about it. Redux had already
moved into the [Rackt](https://github.com/rackt/) project to make it a
true community project. Rackt is a kind of curated collection of React
libraries, and a community group that maintains them. Technically there
is not much difference to hosting the project on my Github account, but
such details do matter: if you want community contributions in an open
source project, it helps to show that it's a genuine community project.

So I [proposed](https://github.com/rackt/reselect/issues/51) we should
move Reselect too, and people agreed it would be a good idea. It turned
out the Rackt folks were happy to accept Reselect, so a few Tweets later
the deed was done and Reselect now lives in its new home.

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">Very happy to have the reselect team join rackt! <a href="https://t.co/HW3rtxBvW7">https://t.co/HW3rtxBvW7</a> Welcome <a href="https://twitter.com/faassen">@faassen</a> and friends :)</p>&mdash; Michael Jackson (@mjackson) <a href="https://twitter.com/mjackson/status/652554478571270144">October 9, 2015</a></blockquote>

# Thoughts

What lessons can we learn from this?

Collaborative hacking sessions are a good thing. They're common in the
Python world and called "sprints". They're regularly organized in
association with Python conferences. At React Europe we had a micro
sprint: just two people, myself and Lee, working on infrastructure code,
with a bit of encouragement from Dan. Imagine what could be accomplished
with a larger group of people?

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">If a mini hackathon of 2 people can create reselect, who knows what else can happen? see also: <a href="http://t.co/dGkAqySec8">http://t.co/dGkAqySec8</a></p>&mdash; Martijn Faassen (@faassen) <a href="https://twitter.com/faassen/status/652132745217380352">October 8, 2015</a></blockquote>

I admit the circumstances were special: Lee picked an idea that was
ready and could be done in a day. It also might have helped I have
previous sprint experience. Not every sprint has the same results. But
at the very least people get to know each other and learn new things. I
think a collaborative goal works better for this than a contest. One
major reason we go to open source conferences after all is to meet new
people and see old friends again, and a sprint can help with that. I've
made life-long friends through sprints.

The React Europe organization already picked up on this idea and is
planning to do a sprint for its conference next year. I already got my
tickets for 2016 and I'm looking forward to that! I hope more people in
the JavaScript lingua franca community pick up on this idea.

The other lesson I learned is more personal. I used to be part of a
larger open source community centered around Zope. But for various
reasons that community stopped being creative and is slowly fading out;
I wrote a blog series about [my exit from
Zope](@/posts/my-exit-from-zope.md). I was a
large player in the Zope community for quite a few years. In contrast
I'm a bit player in the React community. But I greatly enjoy the
community's creativity and the connections I'm making. I missed that in
my open source life and I'm glad it's coming back.
