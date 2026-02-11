# Thoughts on LLMs in Programming

I've been programming computers for [most of my
life](@/posts/teenage-programmer-alphatronic.md). There's a joy in making
things, and there's a joy in the act of programming itself. Often I gravitate
towards programming for programmers -
[frameworks](@/posts/roll-your-own-frameworks.md) for years, [programming
language implementation](@/posts/xee.md) more recently.

Software development has changed incredibly much during my experience with it. I
experienced the era of 8 bit computers when memory counted far below the
megabyte and CPUs that ran at a few megahertz to the current era where you have
an always connected supercomputer in your pocket. I was there when the internet
was new (though ARPANET had a significant history before then). I went from an
era where programming wisdom was spread as tidbits shared with friends, gleaned
from books and magazines, to web search at your fingertips, and now AI.

A lot has remained the same too. Much of the increasing power has been spent
making programming more convenient and easy, rather than making software faster.
[Wirth's Law](https://en.wikipedia.org/wiki/Wirth%27s_law) is with us. LLMs can
be seen as the ultimate exponent of this.

But as many others have observed, this era of LLM programming is by far the
biggest change in software development that I've seen. You may not be convinced
but I am: agentic software development by having LLMs write code and use tools
in a loop, can be astoundingly effective.

This seems to be the moment for expressing anxieties surrounding this. I'm not
sure why this cultural moment arrived today, rather than, say, a year ago. I
looked it up; I vibe coded a Rust tool that could do web scraping and had a web
UI almost a year ago, in March 2025, within a month of the invention of that
term; I am not sure I even realized that was the term when I did it. But even
the year before I had vibe coded a bunch of little tools.

So let me add a little bit to the chorus. I'll share some of my thoughts, my
anxieties and my excitement.

## Playfulness

I started programming as an expression of my curiosity, playfulness and
creativity, as a kid. This hasn't changed. Having these qualities has served me
in countless ways, as it's also how you learn. But let's not make the mistake to
only look at this in an utilitarian way -- curiosity, playfulness and creativity
are an important part of life worth living to me.

So I approached AI with curiosity and playfulness as well. I adopted AI
autocomplete. As I discussed earlier, I experimented with vibe coding even
before it had a name. I've been using agentic AI coding tools intensively for
the last half year now. I'm not at the absolute forefront of any of this, but
I'm doing all right, thanks to my inclination to play.

I see people experiment with new approaches, and that's exciting to me.
Stagnation and inertia [frustrate me](@/posts/the-centre-cannot-hold.md).
There's such much to play with here!

## Anxiety

I worry too. Software development is very rapidly changing. I'm a software
developer. Will there be a place for me, or you?

### Valuing our Ability to Adapt and Learn

It's plausible that AI is in the end is [normal
technology](https://www.normaltech.ai/p/ai-as-normal-technology) and in the long
term ends up creating more jobs than it takes. If so, there will be plenty of
room for humans.

We have a strong ability to adapt and learn, so we can adapt. In this world, we
don't write code by hand anymore, but mold systems at a different level. It
creates a lot of opportunities; I notice I can be more brave about large
refactors and experimentation. Pairing myself with an LLM can make us tackle and
understand things we couldn't do as easily before. 

There are also endless challenges. Complexity remains our greatest enemy. I keep
reminding myself I was already able to write more code I was able to communicate
about in a team context before AI. Producing code is very often _not_ the real
bottleneck to progress. What's slowing us down is coordination, communication
and quality assurance, and figuring out what we need to be doing in the first
place.

The challenge remains shared understanding. The challenge remains managing
entropy. The answer hasn't changed: we want to organize things so they remain
tractable and maintainable.

In this world, our knowledge, our ability to understand and learn, and our
creativity will retain its value and we're going to find our way.

### The Weirder Future

But what if this is truly different? What if this is not "normal technology"?

I have serious philosophical difficulties with concepts like "AGI" and
especially "super intelligence" - I think much of this stuff is more informed by
popular fiction and human anxieties than by careful thought. It's _full_ of unexamined
assumptions about intelligence and technology.

I'm not worried about a brain in a box becoming Skynet or Ironman and then
single-handedly developing science fiction technology to take over the world.
Intelligent people love to overestimate the power of their individual
intelligence and thus intelligence in general, but technological progress is a
society-level project. A society of brains in boxes and brains in skulls can do
it. No god in a box.

It might seem obvious to many people that a very intelligent AI would want to
take over the world or destroy humanity, but I suspect that concern is fully
driven by perennial human anxieties. The biggest risk here is the AI roleplaying
as an incarnation of those anxieties, which would be rather ironic.

So let's talk about other risks to society. Our information society going to
slop should discussed more. As a minor example of how insidious this can be, you
can read my [The Curious Case of Quentell](). But let's get back to software
development.

What if we can wire LLMs up in a way to take humans out of the loop more and
more in programming? People are definitely experimenting with that, and in some
domains, they're going to succeed.

And LLMs are perhaps just the beginning of a wave of cognitive technologies.
Maybe we can engineer machines that can truly outclass humans in software
engineering, and do it more cheaply. This is not at all a given. As humans we
have drives, massive context, human connection. On the other hand, humans have
been repeatedly shown to be overconfident about our special place in the
universe.

This future is weirder. 

Software development is a form of intelligent human activity involving
documents, data, and computers: it's office work. So I don't think it's boastful
to say that _if_ we can replace software developers fully with machines, we can
replace just about any office worker with a machine.

One view of this future is that business leaders then happily fire most of their
employees, and the status quo continues. I find such thinking a massive failure
of the imagination. 

Let me ask a few questions about this scenario:

- Who is going to buy anything once you fire all office workers? 

- A business leader is an office worker. Why would they be so unique in their
  abilities they cannot be replaced? 

Or wouldn't it be their ability that keeps them there, but their power? Those
with lots of power already work hard to convince others and themselves that it's
their ability that makes them deserve it; will they be able to maintain this
illusion in this scenario?

Firing everybody is a recipe for massive, disruptive social change.

This is not a problem for me or you as software developers that we should be
worrying about solving for ourselves as individuals; it's a collective concern,
like climate change. It requires different societal structures and collective
action. Let's talk about this more.

And all this is wild speculation. It's safe to say the future will be very
weird, and beyond that it gets a lot foggier.

## The positives

Plenty of risks, but I'm not going to dwell on them here. Let's consider some of
the opportunities._[^hand_written] It's a more or less random list.

- Those things I think are super important in software development but
  developers instead often hide behind the codes? Sitting back to think. Talking
  a lot about what we're doing. Looking ahead a little. Creating a shared
  understanding and direction. They become even more important.

- Boring refactors you put off; you can do them far more easily.

- Deep focus taxes mental resources. Letting an AI take over some of the more
  boring reasons this focus is required can give us the space we need to relax,
  be smart, and keep going. (I know that this goes against the grind mindset.
  People instead talk about optimizing workflows by keeping agents running at
  all times, preferably in parallel. I am suspicious of such narratives)

- Experimentation becomes a lot more easy. Experimentation is fun and useful.

- Those frustrating bugs that can take forever to track down? Sometimes an LLM
  has the answer for you much more quickly!

- Non-developers can write significant software. Who knows what they will come
  up with?

- Computer games that embrace generative AI in their core engine; entirely new
  types of games become possible. We've barely scratched the surface of this.

- An understanding of security and edge cases become more important.

- We can create badly structured out of control legacy codebases even more
  quickly than before. Someone is going to have to fix or replace these.

- Understanding and using difficult stuff, like details of low-level programming, or
  graphics programming, or (complex computer science stuff)[] formly out of
  reach becomes more accessible to the AI boosted centaur developer.

- LLM limitations make modularity and structure just as important as they
  already were for humans. Software developers like me have many insights to
  contribute in this area.

- Rewriting code from one language to another becomes a lot easier. This means
  we can port useful libraries faster. 

- We can more easily improve the performance of applications by swapping in a
  more efficient programming language for parts of it.

- I can be more ambitious building [weird artificial life simulations](@/posts/apilar-an-alife-system.md).

- One task that consistently infuriates me whenever I have to do it is
  configuring github actions. This is because of the slow feedback loop - the
  real fix is to make this feedback loop much faster. But now at least I can
  configure an AI agent to do the boring thing for me!

## Conclusion

Do I have no anxieties about this? I certainly do. But I know with mine they're
mixed up with other worries and anxieties I have about life, quite independent
from programming. What helps me manage it is to enjoy life; I grow flowers, I
write a few [poems](https://hyperstate.org), I pursue my many interests and
curiosities, and I hold my family and friends close.

[^hand_written]: Perhaps a bullet list gives people LLM vibes, but I did write
this post all on my own.
