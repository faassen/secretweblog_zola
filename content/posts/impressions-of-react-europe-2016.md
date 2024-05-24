+++
title = "Impressions of React Europe 2016"
date = 2016-06-07
slug = "impressions-of-react-europe-2016"

[taxonomies]
tags = []
+++

Last week I went to the [React Europe
conference](https://www.react-europe.org/) 2016 in Paris. It was a lot
of fun and inspirational as well. I actually hadn't used React for about
6 months because I've been focusing on server-side stuff, in particular
[Morepath](http://morepath.readthedocs.io), but this really makes me
want to go and work with it again ([I'm
available](http://startifact.com)). I especially enjoy the creativity in
the community.

In this post I want to give my impression of the conference, and
highlight some talks that stood out to me. There are actually too many
to highlight here: I thought the talk quality of this conference was
very high. I also appreciated the wide range of topics -- not everything
was about React directly. More of that, please!

# Travel

I was quite worried about travel this year. I'm in the Netherlands, so
it all should be so easy: hop in a train to go to Rotterdam, a 45 minute
ride. Then take the Thalys that speeds from Rotterdam to Paris in about
3 hours. In total it takes about 4 hours. Awesome.

But it's strike season in France. Railway strikes were threatened. And
then there was a railway strike in _Belgium_, through which the train
passes, on the day I was to travel. Uh oh. I already got some warnings
in the days in advance about possible train cancellations due to the
strikes. But my train was still going.

But travel in the Netherlands at least wasn't disrupted, so I wasn't
worried about that. I made it in time to the normal intercity train that
brings me from my home town, Tilburg, to Rotterdam. Found a comfortable
seat. All ready to go. Then an announcement: please leave the train as
it can go no further. A cargo train had broken down ahead of us. Argh!

In the end I managed to get to Rotterdam and catch a later Thalys, and
made it to Paris, just 2 hours later than I'd planned.

I was also worried about announced strikes in the Paris metro system on
the day of the conference. Getting around in Paris is very convenient
with the metro, but not if it isn't going. In the end the metro wasn't
affected.

What I did not anticipate was the whole flood situation, to the point
where they had to move parts of the inventory of the Louvre. But Paris
is a big city and the floods did not affect me.

So in the end what I worried about never happened and stuff happened
that I didn't worry about at all.

# Hackathon and MobX

Like last year there was a hackathon one day ahead of the conference at
the Mozilla offices in Paris.

Last year's hackathon was special: I met up with Lee Bannard and we
worked on reselect, which became quite a popular little library for use
with Redux. You might enjoy [my story on
that](/posts/a-brief-history-of-reselect.html).

I was very happy to see Lee again at this year's hackathon. We didn't
create any new code this time; we spent most of our time learning about
[MobX](https://mobxjs.github.io/mobx/index.html), which I first heard
about that day. We met Devin Pastoor at the hackathon. He already had a
little app that used MobX that he wanted to work on together. Lee and
myself helped a little with it but then got distracted trying to figure
out how MobX's magic works.

MobX is a state management library, typically used with React, that
takes a different approach than the now dominant library for this,
Redux. Mobx lets you use normal OOP style objects with state and
references in your client-side model. Unlike Redux is does not require
you to normalize your state. MobX observes changes to your objects
automatically and is very clever about only updating the parts of the UI
that are affected.

This gives MobX different tradeoffs than Redux. I haven't used MobX in
practice at all, but I would say MobX is less verbose than Redux, and
you get more performance out of the box automatically. I also think it
would be easier for newcomers to adopt. On the other hand Redux's focus
on the immutable state constraint simplifies testing and debugging, and
opened up a rich ecosystem of extensions. Redux's implementation is also
a lot simpler. People want a simple answer to "what is better", but
these really are tradeoffs: which way is the right way for you and
applications depends on who you are and what you are working on.

Sorry folks, Lee and I created no thing new this time. But we had fun.

# Dan Abramov: The Redux Journey

Dan Abramov, one of my open source heroes, gave a very interesting talk
where he talked about the quick and wild ride Redux has been on since
last year. Redux was indeed everywhere at this conference, and people
were building very cool stuff on top of it.

Dan explained how the constraints of the Redux architecture, such as
reducers on immutable state, also lead to its stand-out features, such
as simple debugging and persisting and sharing state. He also spoke
about how Redux's well-defined minimal contracts help its extension and
middleware ecosystem.

Dan's talk is interesting to anyone who is interested in framework
design, even if you don't care about React or Redux at all.

[Watch "The Redux Journey"](https://www.youtube.com/watch?v=uvAXVMwHJXU)

# Eric Vicenti: Native Navigation for Every Platform

This talk was about using a Redux-style approach to manage navigation
state in mobile apps, so that the app can react appropriately to going
"back", and helps with links within the app as well as it responding to
links from other apps. Web folks have deep experience with links and is
an example of how bringing web technology to mobile app development can
also help make mobile app development easier.

[Watch "Native Navigation for Every
Platform"](https://www.youtube.com/watch?v=dOSwHABLvdM)

# Lin Clark: A cartoon guide to performance in React

Lin Clark gave a great talk where she explained why React can be fast,
and how you can exploit its features to help it along. Explaining
complex topics well to make them seem simple is hard, and so I
appreciated how well she accomplished it.

If you are new to React this is a really good talk to watch!

[Watch "A cartoon guide to performance in
React"](https://www.youtube.com/watch?v=-t8eOoRsJ7M)

# Christopher Chedeau: Being Successful at Open Source

Christopher described what strategies Facebook uses when they open
source stuff. I especially liked the question they made sure to ask:
"What did you struggle with?". _Not_ "what do you want?" as that can
easily devolve into a wishlist discussion, but specifically asking about
_problems_ that newcomers had. One fun anecdote: the way to make a FAQ
go away was not writing more documentation but changing an error
message.

I also liked the clever "fake it until you make it" approach to making a
community appear more active than it is in the early stages, so that it
actually becomes active. One trick they used is to ask people to blog
about React, then publish all those links on a regular basis.

As an individual developer who occasionally open sources stuff I must
point out rule 0 for open source success is "be a huge company with lots
of resources like Facebook". Without those resources it is a much bigger
struggle to build an open source community. (It also doesn't help that
with [Morepath](http://morepath.readthedocs.io) I picked a saturated
space: Python web frameworks. It's hard to convince people it's
innovative. But that was the same problem React faced when it was first
released.) (UPDATE: of course Facebook-level resources are not
_required_ for open source success, there are a lot of counter examples,
but it sure helps. The talk mentions a team of multiple people engaging
the community through multiple routes. A single individual can't
replicate that at the start.)

Nevertheless, open source success for React was by no means guaranteed,
and React helped make _Facebook's_ reputation among developers. They
made the React open source community really work. Kudos.

[Watch "Being Successful at Open
Source"](https://www.youtube.com/watch?v=nRF0OVQL9Nw)

# Dan Schafer: GraphQL at Facebook

I liked Dan Schafer's talk: a nice quick recap of why GraphQL is the way
it is, some clear advice on how to deal with authorization in GraphQL,
then a nice discussion on how to implement efficient queries with
GraphQL, and why GraphQL cache keys are the way they are. Clear, focused
and pragmatic, while still going into to the _why_ of things, and
without overwhelming detail.

[Watch "GraphQL at
Facebook"](https://www.youtube.com/watch?v=etax3aEe2dA)

# Jeff Morrison: A Deepdive into Flow

This talk was about the implementation of Flow, which is a type checker
for JavaScript code. This is a _very_ complex topic involving compiler
technology and type inferencing, and was still amazingly clear. The talk
gave me the nice illusion I actually understand how Flows works. It also
makes me want to try Flow again and integrate it into my development
tool chain.

Flow is a general JavaScript tool. It comes out of Facebook but is not
directly connected to React at all, even more so than something like
GraphQL. I really appreciated that the organizers included talks like
this and mixed things up.

[Watch "A Deepdive into
Flow"](https://www.youtube.com/watch?v=VEaDsKyDxkY)

# Cheng Lou: On the Spectrum of Abstraction

This talk, which isn't about React, really stood out for me, and from
what I heard also resonated with others at the conference. It tied
neatly into the themes Dan Abramov already set up in his opening talk
about Redux. Dan told me later this was not actually coordinated. The
ideas are just in the air, and this speaks for the thoughtfulness of the
React community.

Cheng Lou's talk was a very high level talk about the benefits and the
costs of abstraction. This is something I care about a lot as a
developer: how do I avoid over-engineering and under-engineering (I've
[written about it
before](/posts/older/under-engineering-over-engineering-right-engineering.html)),
and solve problems at the right level? Software has many forces on many
levels pulling at it, from end-users to low-level details, and how do
you balance out these forces? Engineering is _so_ much about dealing
with tradeoffs. How do you even communicate about this?

The next day I had an interesting chat with Cheng Lou about his talk,
where he discussed various things he had to cut out of his talk so it
wouldn't be too long. He also mentioned [Up and Down the Ladder of
Abstraction](http://worrydream.com/LadderOfAbstraction/) by Bret Victor,
so that is now on my reading list.

I highly recommend this talk for anyone interested in these topics.

[Watch "On the Spectrum of
Abstraction"](https://www.youtube.com/watch?v=mVVNJKv9esE)

# Preethi Kasireddy: Going from 0 to full-time software engineer in 6 months

This was a 5 minute lightning talk with a personal story: how
overwhelming software development is to a newcomer and how it can
nonetheless be learned. During the talk I was sitting next to someone
who was relatively new to software development himself and I could see
how much this talk resonated with him.

Preethi Kasireddy also encouraged more experienced developers to mentor
newcomers. I've found myself that mentoring doesn't have to take a lot
of time and can still be hugely appreciated. It's fun to do as well.

A new developer is often insecure as there are just so many things to
grasp, and experienced developers seem to know so much. Ironically I
sometimes feel insecure as an older, more experienced developer as well,
when I see people like Preethi learn software development as quickly as
they do. I certainly took more time to get where they are.

But I'm old enough to have gotten used to intimidatingly smart younger
people _too_. I can keep up. The Internet overall helps with learning:
the resources on the Internet for a new developer may be overwhelming,
but they are also of tremendous value. Preethi called for more
intermediate-level resources. I am not sure [this series I
wrote](/posts/none_01_the_beginning.html)
counts; I suspect Preethi is beyond it, but perhaps others will enjoy
it.

(Video not up yet! I'll update this post when it is.)

# Jonas Gebhardt: Evolving the Visual Programming Environment with React

This was another one of those non-React talks I really appreciated. It
is related to React as it is both inspired by functional programming
patterns and component-based design, but it's really about something
else: a UI to construct programs by connecting boxes with arrows.

There are many of these around. Because these don't seem to ever enter
the daily life of a programmer, I tend to be skeptical about them.

But Jonas Gebhardt acknowledged the prior art, and the approach he
described is pragmatic. An open world approach in the web browser,
unlike many of the "we are the world" sandbox implementations from the
past. Annotated React components can serve as the building blocks. He
even sketched out an idea on how to connect UI input and output to
custom user interfaces in the end.

So I came away less skeptical. This approach has potential and I'd like
to see more.

[Watch "Evolving the Visual Programming Environment with
React"](https://www.youtube.com/watch?v=WjJdaDXN5Vs)

# Bonnie Eisenman: React Native Retrospective

I really like retrospectives. This was an excellent talk about the
history of React Native over the course of the last year and a half.
React Native is the technology that lets you use JavaScript and React to
develop native iPhone and Android apps. Bonnie Eisenman also wrote [a
book about it](http://shop.oreilly.com/product/0636920041511.do).

React Native is a potential game changer to me as it lets people like me
use our deep web development experience to build phone apps. The talk
made me excited to go and play with React Native, and I'm sure I wasn't
the only one. In a chat afterwards, Bonnie confirmed that was a goal of
her talk, so mission accomplished!

[Watch "React Native
Retrospective"](https://www.youtube.com/watch?v=-vl57brMWNg)

# Phil Holden: subdivide and redux-swarmlog

Phil Holden gave a 5 minute lightning talk, but _please_ give him more
space next time. He discussed
[Subdivide](https://github.com/philholden/subdivide), an advanced split
pane layout system for React, and then _also_ discussed another
mind-blowing topic: using WebRTC to create a peer to peer network
between multiple Redux frontends, so that they share actions. This lets
users share data without a server being around. This he packaged as a
library in a package called
[redux-swarmlog](https://github.com/philholden/redux-swarmlog).

I've been thinking about peer to peer serverless web applications for
some years as I believe they have the potential to change the web, and
Phil's talk really reignited that interest. Peer to peer is hard, but
the technology is improving. Later that day, I had the pleasure of
having a brief chat with Phil about such wild topics. Thanks Phil for
the inspiration!

(Video not up yet! I'll update this post when it is.)

# Andrew Clark: Recomposing your React application

Andrew Clark is Internet-famous to me, as he created Flummox, the Flux
state management framework I used before switching to Redux (Andrew in
fact co-created Redux). In this talk he discusses
[recompose](https://github.com/acdlite/recompose), a library he wrote
that helps you do sophisticated things with pure, stateless function
components in React. I need to play with it and see whether it fits in
my React toolbox. Andrew also described the interesting techniques
recompose uses to help reduce the overhead of small composed functions
-- this highlights the properties you gain when you stick to the pure
function constraint.

[Watch "Recomposing your React
application"](https://www.youtube.com/watch?v=zD_judE-bXk)

# Jafar Husain: Falcor: One Model Everywhere

When multiple development teams have a similar idea at about the same
time, that may be a sign the idea is a good one. This happened to me
when I came up with a client-side web framework few years ago, thought I
was onto something new, and then Backbone emerged, followed by many
others.

Jafar Husain in this well-done talk described how Falcor and GraphQL
were a similar solution to similar problems. Both Falcor and GraphQL let
the client be in control of what data it demands from the server. He
then highlighted the differences between Falcor and GraphQL, where he
contrasted Falcor's more lightweight approach to GraphQL's more powerful
but involved focus on schemas. It's tradeoffs again: which fits best
depends on your use cases and team.

[Watch "Falcor: One Model
Everywhere"](https://www.youtube.com/watch?v=nxQweyTUj5s)

# Laney Kuenzel & Lee Byron: GraphQL Future

This was a wide-ranging talk that went into various issues that GraphQL
team at Facebook is trying to solve, mostly centered about the need to
receive some form of immediate update when state on the server changes.
Laney and Lee presented various solutions in a various states of
readiness, from mostly untested ideas to stuff that is already deployed
in production at Facebook. Very interesting in you're interested in
GraphQL at all, and also if you're interested in how smart people tackle
problems.

[Watch "GraphQL Future](https://www.youtube.com/watch?v=ViXL0YQnioU)

# Constructive feedback

In my blog post last year I was clear I enjoyed the conference a lot,
but also engaged in a little bit of constructive criticism. I don't
presume that the React Europe organizers directly responded to my
feedback, but let's see how they did anyway and give a bit more feedback
here. My intent with this feedback is to do my bit to make a great
conference even better.

## Temperature

Last year the conference was in early July in Paris and it was 40
degrees Celsius. The React Europe team responded by shifting conference
a month earlier. It was not too hot: problem solved.

## Hackathon

Last year the hackathon assumed people were going to compete in a
contest by default instead of cooperate on cool projects. This year they
were very clear that cooperation on cool projects was encouraged.
Awesome!

Still, I found myself walking around Paris with a friend on Friday night
trying to find a quiet place so we could look at some code together. We
enjoyed the conversation but we didn't find such a place in the end.

This is why I prefer the approach Python conferences take: a 1-3 day
optional sprint for people to participate in _after_ the conference has
ended. Why I like afterwards better:

- You can get involved in cool projects you learned about during the
  conference.
- You can get to know people you met during the conference better.
- Since there is no pressure it's a good way to wind down. Speakers can
  participate without stressing out about a talk they will be giving
  soon.

## Facebook speakers

Many of the speakers at this conference work for Facebook. They gave
excellent talks: thank you. I understand that having a lot of speakers
from Facebook is natural for a conference on React, as that's where it
originated. (and Facebook hires people from the community). But this
_is_ an open source community. While I realize you'd take on more
unknown quantities and it would be more difficult to keep up the quality
of the talks, I would personally enjoy hearing a few more voices not
from Facebook next year.

## Gender diversity

Last year I spoke about a bit gender diversity at the conference. This
year there were more female speakers than last year (keep it up!), but
male voices were still the vast majority. Women speakers are important
in helping women participants feel more welcome in our conferences and
our community. We can still do a lot better: let's learn from [PyCon
US](https://twitter.com/jessicamckellar/status/737299461563502595).

# Back home

The train ride back home on Saturday morning was as it should:
uneventful. Left the hotel around 9 am the morning, was back home around
2:30 pm. I came home tired but inspired, as it should be after a good
conference. Thanks so much to the organizers and speakers for the
experience! I hope you have enjoyed my little contribution.
