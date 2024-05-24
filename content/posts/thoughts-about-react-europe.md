+++
title = "Thoughts about React Europe"
date = 2015-07-06
slug = "thoughts-about-react-europe"

[taxonomies]
tags = ["react", "javascript", "python"]
+++

Last week I visited the React Europe conference in Paris; it was the
first such event in Europe and the second React conference in the world.
Paris like much of the rest of western Europe during this early July was
insanely hot. The airconditioning at the conference location had trouble
keeping up, and bars and restaurants were more like saunas. Nonetheless,
much was learned and much fun was had. I'm glad I went!

React, in case you're not aware, is a frontend JavaScript framework.
There are a lot of those. I wrote one myself years ago (before it was
cool; I'm a frontend framework hipster) called
[Obviel](http://obviel.org). React appeals to me because it's component
driven and because it makes so many complexities go away with its
approach to state.

Another reason I really like React is because its community is so
creative. I missed being involved with such a creative community after
my exit from
[Zope](/posts/my-exit-from-zope), which
was due in large part as it had become less creative. A lot of the web
is being rethought by the React community. Whether all of those ideas
are good remains to be seen, but it's certainly exciting and good will
come from it.

Here is a summary of my experiences at the conference, with some
suggestions for the conference organizers sprinkled in. They did a great
job, but this way I hope to help them make it even better.

# Hackathon

When I heard there would be a hackathon the day before the conference, I
immediately signed up. This would be a great way to meet other
developers in the React community, work on some open source
infrastructure software together, and learn from them. Then a few days
before travel I learned there was a contest and prizes. Contest? Prizes?
I was somewhat taken aback!

I come from the tradition of sprints in the Python world. Sprints in the
Python community originated with the Zope project, and go back to 2001.
Sprints can be 1-3 day affairs held either before or after a Python
conference. The dedicated sprint is also not uncommon: interested
developers gather together somewhere for a few days, sometimes quite a
few days, to work on stuff together. This can be a small group of 4
people in someone's offices, or 10 people in a converted barn in the
woods, or 30 people in a castle, or even more people in a hotel on a
snowy alpine mountain in the winter. I've experienced all of that and
more.

What do people do at such sprints? People hack on open source
infrastructure together. Beginners are onboarded into projects by more
experienced developers. New projects get started. People discuss new
approaches. They get to know each other, and learn from each other. They
party. Some sprints have more central coordination than others. A sprint
is a great way to get to know other developers and do open source
together in a room instead of over the internet.

I previously thought the word hackathon to be another word for sprint.
But a contest makes people compete with each other, and a sprint is all
about collaboration instead.

Luckily I chatted a bit online before the conference and quickly enough
found another developer who wanted to work with me on open source stuff,
turning it into a proper sprint after all. We put together [this little
library](https://github.com/faassen/reselect) as a result. I also met
Dan Abramov. I'll get back to him later.

When I arrived at the beautiful Mozilla offices in Paris where the
sprint was held, it felt like a library -- everybody was quietly nestled
behind their own laptop. I was afraid to speak, though
characteristically that didn't last long. I may have made a comment that
I thought hackathons aren't supposed to be ibraries. We got a bit more
noise after that.

I thoroughly enjoyed this sprint (as that is what it became after all),
and learned a lot. Meanwhile the hackathon went well too for the three
Dutch friends I traveled with -- they won the contest!

React Europe organizers, I'd like to request a bit more room for
sprint-like collaboration at the next conference. In open source we want
to emphasize collaboration more than competition, don't we?

# Conference

The quality of the talks of the conference was excellent; they got me
thinking, which I enjoy. I'll discuss some of the trends and list a few
talks that stood out to me personally; my selection has more to do with
my personal interests than the quality of the talks I won't mention,
though.

## Inline styles and animations

Michael Chan gave a talk about Inline Styles. React is about
encapsulating bits of UI into coherent components. But styling was
originally left up to external CSS, apart from the components. It
doesn't have to be. The React community has been exploring ways to put
style information into components as well, in part replacing CSS
altogether. This is definitely a rethinking of best practices that will
cause some resistance, but definitely very interesting. I will have to
explore some of the libraries for doing this that have emerged in the
React community; perhaps they will fit my developer brain better than
CSS has so far.

There were two talks about how you might define animations as well with
React. I especially liked Cheng Lou's talk where he explored declarative
ways to express animations. Who knows, maybe even unstylish programmers
like myself will end up doing animation!

## GraphQL and Relay

Lee Byron (creator of
[immutable-js](https://facebook.github.io/immutable-js/)) gave a talk
about GraphQL. GraphQL is rethinking client/server communication
originating at Facebook. Instead of leaving it up to the web server to
determine the shape of the data the client code sees, GraphQL lets that
be expressed by the client code. The idea is that the developer of the
client UI code knows better that data they need than the server
developer does (even if these are the same person). This has some
performance benefits as well as it can be used to minimize network
traffic. Most important to be me is that it promises a better way of
client UI development: the data arrives in the shape the client
developer needs already.

Lee announced the immediate release of a [GraphQL
introduction](https://github.com/facebook/graphql), [GraphQL draft
specification](http://facebook.github.io/graphql/) and a [reference
implementation in JavaScript](https://github.com/graphql/graphql-js),
resolving a
[criticism](/posts/graphql-and-rest) I
had in a previous blog post. I started reading the spec that night (I
had missed out on the intro; it's a better place to start!).

Joseph Savona gave a talk about the Relay project, which is a way to
integrate GraphQL with React. The idea is to specify what data a
component needs not only on the client, but right next to the UI
components that need it. Before the UI is rendered, the required data is
composed into a larger GraphQL query and the data is retrieved. Relay
aims to solve a lot of the hard parts of client/server communication in
a central framework, making various complexities go away for UI
developers. Joseph announced an open source release of Relay for around
August. I'm looking forward to learn more about Relay then.

Dan Schafer and Nick Schrock gave a talk about what implementing a
GraphQL server actually looks like. GraphQL is a query language, not a
database system. It is designed to integrate with whatever backend
services you already have, not replace them. This is good as it requires
much less buy-in and you can evolve your systems towards GraphQL
incrementally -- this was Facebook's own use case as well. To expose
your service's data as GraphQL you need to give a server GraphQL
framework a description of what your server data looks like and some
code on how to obtain this data from the underlying services.

Both Dan and Nick spent the break after their talk answering a lot of
questions by many interested developers, including myself. I spoke to
Dan myself and I'm really grateful for all his informative answers.

The GraphQL and Relay developers at Facebook are explicitly hoping to
build a real open source community around this technology, and they made
a flying start this conference.

## Flux

All this GraphQL and Relay stuff is exciting, but the way most people
integrate React with backends at present is through variations on the
[Flux pattern](https://facebook.github.io/flux/docs/overview.html).
There were several talks that touched upon Flux during the conference.
The talk that stood out was by Dan Abramov, who I mentioned earlier.
This talk has already been released as an online video, and I recommend
you [watch it](https://www.youtube.com/watch?v=xsSnOQynTHs). In it Dan
develops and debugs a client-side application live, and due to the
ingenious architecture behind it, he can modify code and see the changes
in the application's behavior immediately, without an explicit reload
and _without having to reenter data_. It was really eye-opening.

What makes this style of development possible is a more purely
functional approach towards the Flux pattern. Dan started the
[Redux](https://rackt.github.io/redux/) framework, which focuses on
making this kind of thing possible. Instead of definining methods that
describe how to store data in some global store object, in Redux you
define pure functions instead (reducers) that describe how to transform
the store state into a new state.

Dan Abramov is interesting by himself. He has quickly made a big name
for himself in the React community by working on all sorts of exciting
new software and approaches, while being very approachable at the same
time. He's doing open source right. He's also in his early 20s. I'm old
enough to have run into very smart younger developers before, so his
success is not _too_ intimidating for me. I'll try to learn from what he
does right and apply it in my own open source work.

The purely functional reducer pattern was all over the conference; I saw
references to it in several other talks, especially Kevin Robinson's
talk on simplifying the data layer, which explored the power of keeping
a log of actions. It has its applications on both clients and servers.

The React web framework already set the tone: it makes some powerful
functional programming techniques surrounding UI state management
available in a JavaScript framework. The React community is now mining
more functional programming techniques, making them accessible to
JavaScript developers. It's interesting times.

## Using React's component nature

There were several talks that touch on how you can use React's component
nature. Ryan Florence gave an entertaining talk about you can
incrementally rewrite an existing client-side application to use React
components, step by step. Aria Buckles gave a talk on writing good
reusable components with React; I recognized several mistakes I've made
in my code and better ways to do it.

Finally in a topic close to my heart Evan Morikawa and Ben Gotow gave a
talk about how to use React and Flux to turn applications into
extensible platforms. Extensible platforms are all over software
development. CMSes are a very common example in web development. One
could even argue having an extensible core that supports multiple
customers with customizations is the mystical quality that turns an
application into "enterprise software".

# DX: Developer Experience

The new abbreviation DX was used in a lot of talks. DX stands for
"Developer Experience" in analogy with UX standing for "user
experience".

I've always thought about this concept as usability for developers: a
good library or framework offers a good user interface for developers
who want to build stuff with it. A library or framework isn't there just
to let developers get some done, but to let them get this stuff done
well: smoothly, avoiding common mistakes, and not letting them down when
they need to do something special.

I really appreciated the React community's emphasis on DX. Let's make
the easy things easy, and the hard things possible, together.

# Gender Diversity

This section is not intended as devastating criticism but as a
suggestion. I'm not an expert on this topic at all, but I did want to
make this observation.

I've attended a lot of Python conferences over the years. The gender
balance at these conferences was in the early years much more like the
React Europe conference: mostly men with a few women here and there. But
in recent years there has been a big push in the Python community,
especially in North America, to change the gender balance at these
conferences and the community as a whole. With success: these days
PyCons in North America attract over 30% women attendees. While
EuroPython still has a way to go, last year I already noticed a definite
trend towards more women speaking and attending. It was a change I
appreciated.

Change like this doesn't happen by itself. React Europe made a good
start by adopting a code of conduct. We can learn more about what other
conference organizers do. Closer to the React community I've also
appreciated the actions of the JSConf Europe organizers in this
direction. Some simple ideas include to actively reach out to women to
submit their talk and to reach out to user groups.

Of course, for all I know this was in fact done, in which case do please
do keep it up! If not, that's my suggestion.

# Conclusions

I really enjoyed this conference. There were a lot of interesting talks;
too many to go into here. I met a lot of interesting people. Mining
functional programming techniques to benefit mere mortal developers such
as myself, and developer experience in general, are clearly major trends
in the React community.

Now that I'm home I'm looking forward to exploring these ideas and
technologies some more. Thank you organizers, speakers and fellow
attendees! And then to think the conference will likely get even better
next year! I hope I can make it again.
