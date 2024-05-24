+++
title = "JSConf EU 2013 impressions"
date = 2013-09-17
slug = "jsconf-eu-2013-impressions"

[taxonomies]
tags = ["javascript", "python"]
+++

Yesterday I returned from JSConf EU in Berlin. I enjoyed the conference
and I'll share some of my impressions here. It's not going to be a
complete report; I met a lot of people and had a lot of conversations.

This was my first JSConf. I've been to a lot of Python conferences in
the past. I was a bit nervous as for the first time in years I was going
to a conference where I didn't really know anybody, but that is also an
important reason *why* I was going - since a large part of what I do now
in web development is JavaScript, I wanted to engage with its community.

# Travel to Berlin

It turns out it's really easy to travel to Berlin from where I live in
the Netherlands; go to the small (and thus less stressful) airport
Eindhoven nearby by train, fly for an hour, and land in Berlin.

Since I had a bad experience with delayed check-in luggage earlier this
year and it was just a weekend trip this time I decided to I travel very
light; just my laptop backpack with clothes stuffed in.

The plane was very full, many with maximum-size carry-on luggage. I was
in the plane early so had my backpack stowed already. Until a lady who
absolutely did not want her suitcase to be put in the hold pulled out my
backpack and tried to fit it into a space elsewhere too small for it,
and then gave it to me, putting her suitcase in the now open space.
Problem solved!

This attempt to saddle me with my backpack and her problem wasn't really
appreciated by me, and I had to insist she take her suitcase out again.
Later on she was still arguing with the flight crew.

In the taxi ride from the airport to the hotel I had a little chat with
the taxi driver, in German. I understand German pretty well, but my
spoken German is pretty broken. I have no idea how it came up, but
suddenly the driver asked:

"So do you think the Americans landed on the moon?"

Being a fan of scientific skepticism had prepared me for this sudden
question, and I explained that they had left a mirror on the moon that
you could bounce lasers off, and that faking the moon landings would
have had to have been a conspiracy of monumental proportions with
professionally-interested-in-the-truth scientists and engineers and the
Soviet Union both being involved.

"So they did land on the moon then," he said quietly, seeming to marvel
at the thought. And it is a marvel.

My broken German had been up to the job, which amazes me still. Next he
asked me what programming languages I used!

# Talks: overall

The choice of talks was interesting; many of the talks were not so much
about JavaScript technology and discussed other human topics associated
with it -- art, ethics, creativity, design, usability. This led to a
mixture that helped the whole being more inspirational than if all the
talks had just been about tech all the time.

I will discuss some of the talks that stood out of me. This is
necessarily going to be selective - there were plenty of great talks I'm
not going to mention, and many more that I missed altogether as there
were two parallel tracks.

I've tried to put in links to slides where I could find them. Videos
should also eventually appear on the [JSConf EU youtube
channel](https://www.youtube.com/user/jsconfeu).

# Talks and People: Day 1

## Parsing, Compiling and Static Metaprogramming - Patrick Dubroy

Patrick discussed some basic principles of parsing and discussed two
projects:

- [esprima](http://esprima.org/), a JavaScript parsing library that I
  had become aware of because of my explorations of the
  [Polymer](http://www.polymer-project.org/) project, which uses it in
  its implementation of the MDV templating system. It was very helpful
  to see Patrick present a few examples of how it can be used.
- [PEG.js](http://pegjs.majda.cz/), a parser generator (along the lines
  of yacc or bison) for JavaScript. I hadn't been really aware of this
  project before, but from the examples it looks like it's really easy
  to construct parsers with it. I'll enjoy adding this as a tool to my
  toolbox.

I had a few interesting conversations with Patrick afterward throughout
the conference. Thanks!

[slides](https://speakerdeck.com/pdubroy/parsing-compiling-and-static-metaprogramming)

## A comparison of the two-way binding in AngularJS, EmberJS and KnockoutJS - Marius Gundersen

This talk was of particular interest to me because of my interest in
client-side web framework design in general, and my interest in adding
two-way binding to [Obviel](http://www.obviel.org) in particular.

He compared approaches in various ways:

- Observable properties (versus dirty checking)
- Asynchronous response to changes
- Computed properties
- Dynamic dependencies (recomputation only happening when needed)
- Performance (each has different tradeoffs)

Marius is Norwegian by the way; I kept meeting friendly Norwegians at
this conference - they seemed particularly well represented.

[slides](http://projects.mariusgundersen.net/JSconf2013/#/title)

## Security talks

I saw three security related talks at this conference. I need to read
some of the references the speakers give in their slides, and maybe you
should too:

- Towards a post-XSS world - Mike West
  ([slides](https://speakerdeck.com/mikewest/towards-a-post-xss-world-jsconf-eu-2013))
- JavaScript crypto. Ugly ducking with good reason? - Martin Boßlet
  ([slides](https://github.com/emboss/prez/tree/master/jsconfeu%202013))
- Security First - Adam Baldwin (can't find the slides yet) (this was on
  day 2 actually)

## UXing without a UXer - Chrissy Welsh

I had the pleasure to chat with Chrissy during the sunday night party.
It reminded me that again how much usability in UIs is related to doing
good API and protocol design (and also language design), which after all
is also in a large part a usability exercise.

Chrissy's text to hang on the wall: "what is the one thing you want your
product to do well" is also a relevant question to library and framework
authors. Even if we're handling multiple use cases.

When doing API design I benefit from years of experience and also from
being one of the intended users myself, a benefit that I don't have for
many of the application UIs that I helped to develop. Chrissy's tips
help with that.

[slides](http://www.slideshare.net/chrissywelsh/hitchikers-guide-to-uxing-without-a-uxer)

## The web experience in the autistic spectrum - Natalia Berdys

This talk made the case for having people with Asperger's syndrome do
your web site usability testing for you, or at least to think about them
when you design a web site. The usability issues that confuse a person
with Asperger's are in fact also usability issues for everybody else; it
can just be experienced more intensely. This talk was a nice change of
perspective on a topic that everybody is familiar with in one way or
another: how usable web sites are.

(can't find the slides yet)

## `/be`

There was a talk somewhat mysteriously marked `/be` in the schedule of
day 1. This turned out to be a talk by Brendan Eich, creator of
JavaScript!

He very, very rapidly discussed various upcoming new features in
JavaScript. High time to have a module system and standard sugar for
prototype-based class definition!

He followed it up with an asm.js demo. This involves running various
first-person C++ 3d shooters within the web browser. Even though I was
already aware of this before, it's still a totally amazing
demonstration.

Besides making for cool demos and running C++ code in your browser, I
expect the asm.js technology to have an enormous impact on client-side
development in the longer term. One thing that it might do is open up
the browser platform for other programming languages besides JavaScript;
another thing it might do is to let browsers move more and more of their
implementation from C++ into JavaScript - how much native code will be
left in the long term?

[slides](http://www.slideshare.net/mobile/BrendanEich/js-resp)

# Talks and People: Day 2

## Plight of the butterfly - everything you wanted to know about Object.observe() - Addy Osmani

Day two for me started with Addy Osmani's talk about `Object.observe()`,
one of the most exciting technologies coming to JavaScript.

`Object.observe()` provides a way to observe changes in JavaScript
objects from the outside - a technology that in the future will provide
the foundation for a wide range of technologies such as two-way binding
to templates, persistence technologies (Addy demonstrated a simple
JavaScript object database) and server interaction (a topic I'm also
very interested in).

I was vaguely familiar with Addy's name from my explorations of the
Polymer project, but I realize now he also wrote several books and is
behind the [TodoMVC](http://todomvc.com/) project. Addy's talk was a
rapid-fire discussion of a lot of interesting aspects of
`Object.observe()` that I certainly will want to refer back to in the
future. I chatted with Addy about some framework design issues later on.
I hope I was coherent at all, and I appreciate his time.

(can't find the slides yet)

## Promises and Generators: control flow utopia - Forbes Lindesay

I'm finally quite familiar with promises; after having heard about them
in Twisted years ago and never bothering to wrap my head around them,
and again in [MochiKit](http://mochi.github.io/mochikit/) (a pioneering
JavaScript client-side library), I finally started using them in the
context of AJAX, using the implementation in jQuery.

I thought I was familiar with generators from Python, but I hadn't
thought about their implications for async programming at all (even
though I knew the Twisted folks had). During this talk I also realized I
needed to understand yield *expressions* (as opposed to just the yield
statement) better, in both Python and JavaScript!

A very enlightning talk that prodded me into the realization that I
don't even understand all about generators in Python yet either. I have
certainly been coming to async development the long away round!

[slides](http://pag.forbeslindesay.co.uk/#/)

## Acceptable in the 80s - Revisiting Microworlds - Jason Frame

This was an extremely interesting exploration of some important older
ideas in UIs that we have lost somewhat since the 1980s.

Jason showed off a prototype desktop environment implemented in a web
browser that allows you to construct ad-hoc applications from smaller
components visually; he could throw an editor and a file loader together
into an editor for instance by throwing some lines here and there. It
involves building blocks that are larger than GUI widgets but smaller
than applications that can be combined by non-programmers.

I think many of these ideas could also be applied to web application
development as well, and I need to ponder this more.

(I'm not sure there were slides; it was a long demo, really. Wait for
the video!)

## Make world less shit. NOW. - Natalia Buckley

Natalia Buckley gave an essay-like (no slides, articulate) presentation
(wonderfully titled) about the interactions between software and ethics.
She discussed unintended consequences of unexplored human bias in
software, and how software and culture interact both ways. It was
welcome reminder to continue to examine my own biases and how they can
affect the software I create, and others through it.

(no slides, I hope she will post an essay somewhere)

## Building Live HTML and Omniscient Debuggers in Brackets - Kevin Dangoor & Peter Flynn

Kevin Dangoor and Peter Flynn came to JSConf EU in a relaxed mood: they
were going to attend the conference and didn't need to do any
presentations.

This turned out to be a misunderstanding. Preparing for a talk at the
last minute is a rather stressful activity, but the talk went very well.

[Brackets](http://brackets.io/) is web code editor project by Adobe with
some very interesting features.

This is a tool that has a huge range of exciting technologies under the
hood that I definitely need to explore: live updating of rendered HTML
as you edit, an an omniscient debugger (a debugger that knows a lot more
about your program than the state of it at your break point), type
inferencing JavaScript to help with command-line completion, and a lot
more. Very cool!

I had a number of very pleasant and also informative conversations with
Kevin Dangoor at the conference. Kevin has been doing (and influencing)
JavaScript for years but I know him from the old days as the creator of
the TurboGears web framework in Python. After a chat with Kevin late
sunday night I finally started grokking those generator expressions I
mentioned before. And also thanks for the reference to the very
interesting [frb](https://github.com/montagejs/frb) binding library!
Also a shoutout to Peter Flynn, the other speaker; I had fun chatting
during relax.js yesterday.

(no slides yet, perhaps wait for the video as it is also a demo)

## I have a dreamcode: build apps, not backends - Alex Feyerke

Alex Feyerke gave a talk discussing technologies that let you develop
rich-client JavaScript applications *without* having to develop the
backend for them. It turns out there's a lot of activity in this space -
turn-key generic backends that you can start building front-end apps on
immediately. I definitely need to look into this more. (I've been wildly
speculating for a while about going one step further: applications
without servers at all, just peer to peer between browsers.)

[slides](https://speakerdeck.com/espylaub/i-have-a-dreamcode-build-apps-not-backends-jsconf-dot-eu-2013)

## Stop breaking the web - Tom Dale

This was a wide-ranging and amusing talk about making URLs work for
single-page web apps.

It also touched upon a few interesting client-side framework issues from
the perspective of [Ember](http://emberjs.com/). Each time I learn
something about another client-side web framework I recognize parallel
evolution in Obviel, which helps validate the concepts in Obviel.
Everybody does it all slightly differently, with different tradeoffs.
That's where it gets interesting and where we can learn from each other.

(can't find the slides yet)

## Rethinking best practices - Pete Hunt

Pete Hunt (who it turns out remembers me from the Grok days long ago,
woohoo!) had a very thought-provoking talk from the perspective of the
new [React](http://facebook.github.io/react/index.html) client-side web
framework. His arguments against the use of templating in web frameworks
are interesting but do not yet convince me. His description of how React
side-steps the whole data binding issue by doing something more like a
real-time 3d engine does, in particular gaining efficiency by
re-rendering components but only sending *diffs* into the real browser
DOM were extremely thought-provoking.

I like to have my thoughts in this area provoked, so I want to thank
Pete for doing so.

Incidentally, the Brackets environment does this diffing of the HTML DOM
as well in an interesting case of parallel evolution.

## 1024+ seconds of JS wizardry - Martin Kleppe

I only caught the tail end of this entertaining talk, but I still want
to mention it, as it was a lot of fun and I'm going to look up the video
when it's posted to see the it all. Martin was trying to write write the
shortest code possible and still do amusing and interesting things. It
was "crazy", which is a compliment in this context. It already made it
onto [hackernews](https://news.ycombinator.com/item?id=6390328).

## People First - Adam Brault

The closing keynote to close the conference was by Adam Brault;
high-impact, emotional, sometimes, in fact, to me, uncomfortable in its
emotion. JSConf EU seems to be wearing its heart on its sleeve a bit
more than Python conferences are - different.

The talk was about putting people first (in small ways as in big ways);
it's good to be reminded of that in a world of technology.

The talk made me think about the personal and the emotional and how it
could fit in my own talks.

I shouldn't do these things, and certainly not disclose it here, but I
pulled off a successful heckle ("hey, we're the ones that stayed here!")
when Adam tried to share blame for bad stuff in early North America with
present-day Europeans. Adam was very gracious about it.

(And in all seriousness, I agree Europeans actually do share in the
blame anyway, as much as anyone in the present day can share in the
blame for acts before they were born.)

(Historically speaking, us Europeans that stayed in Europe managed to
screw up our own continent just fine; no moral superiority there.)

By the way, given that Adam Baldwin (Security First talk) and Adam
Brault (People First talk) are both from the same company (&yet), how
are we going to put *both* people and security first, guys? Are you both
part of [OM](https://en.wikipedia.org/wiki/Operation_Mindfuck) or
something?

[slides](https://speakerdeck.com/adambrault/people-first-with-notes)

# JSConf as a community event

JSConf people really like to party; perhaps even more so than the Plone
community does, if that is possible. By the time I arrived there already
had been one party the night before. I appreciated that the noise level
was kept low enough so that you could have a conversation with people. I
also really appreciated the relax.js brunch on the morning after the
conference.

JSConf organizers clearly understand that a conference is about more
than just talks, but is also a way to create, sustain and celebrate
community. Much appreciated.

One thing I must mention here is that I'm glad the conference was
deliberately kept small. The rather difficult procedure to buy a ticket
initially made me think that the attendance would be huge, but instead I
found a cozy conference where it was easy to interact with people,
including speakers, and find them again later. I was very happy about
that; I've experienced a PyCon in the US with huge attendance before and
it was just too hard to find people there. I heard that in recent years
the attendance at EuroPython has grown. That makes me happy for the
health of the Python community in Europe, but it's a bit regretful the
conference might lose some of its charm due to the scale.

The crowd at JSConf was pretty diverse, but still younger than what I'm
used to at Python conferences. I'm used to seeing a wider mix of ages
around. I found myself being the guy dating myself by telling stories
about the olden days. I didn't mind, and I've been telling stories since
the olden days anyway. Turns out that I did know a few of the people at
the conference, and others recognized me from the Python community.
Nice, but it was easy to make new connections too.

I liked the length of the conference at 2 days. I was rather horrified
to see that EuroPython is now *5* days of talks. That's just too much
for me; after 3 days I'm totally done with talks. I think the JSConf
approach of being very selective about talks is better.

There are two Python conference traditions that I missed: lightning
talks and sprints.

Lightning talks are fast (5 minute) talks in very quick succession.
Talks are submitted during the conference itself by the attendees, until
there are not more slots; there is no selection process. If someone is
boring that's okay, as they're gone in 5 minutes. It's a good way to get
a quick message across, draw attention to a project, or just entertain.
Doing a lightning talks track would probably not fit in a 2 day
conference though.

A "sprint" is a slightly Python specific term for "hackathon". After a
conference interested people can stay around for up to three days more
and hack with others on open source projects they find interesting. It's
a great way to learn more about a project and get to know other
developers better.

# Travel back

After the first Berlin taxi driver raised my expectations high, the taxi
driver on the way back to the airport yesterday turned out to be very
disappointing. He was on the headset in the phone speaking Turkish (I
think) with a friend all the time.

One last story. I was in the Berlin Tegel airport restrooms doing my
business. Then I heard someone call out "Is anybody there?" in English,
with an American accent. I wasn't sure he was talking to me, though the
place was otherwise empty. He called out again: "Can anybody help me?"

"What's going on?" I asked, wary.

"I'm stuck in this stall. Can you help me open it?"

I went to his stall and opened the door. I had expected that to be
difficult, but it wasn't locked and just opened like any other door.
Turns out that the door handle on the inside was missing, making the
door, once closed, as good as locked for the guy inside.

"Thanks!"

"No problem."

"Really thanks, man, I would've been in there forever."

I smiled. "No problem."

Sometimes you can help by just opening a door for someone.
