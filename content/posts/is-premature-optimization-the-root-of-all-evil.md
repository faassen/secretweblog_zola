+++
title = "Is premature optimization the root of all evil?"
date = 2022-01-12
slug = "is-premature-optimization-the-root-of-all-evil"

[taxonomies]
tags = ["planetpython", "programming", "python", "javascript", "rust"]
+++

Among programmers there is a saying: **premature optimization is the
root of all evil**.

Where did that come from? In what context was it used? Does it still
apply?

<!-- more -->

# Citation needed

[Looking at sources is good](https://danluu.com/dunning-kruger/). So
let's look at the source for this one.

It's a quote by [Donald
Knuth](https://en.wikipedia.org/wiki/Donald_Knuth) from a paper named
"Structured Programming with go to Statements" from 1974.

Let's examine the title first. What does "structured programming" mean?
I use it. You use it. Everybody uses it. The irony is that "structured
programming" is dominating programming so thoroughly we don't actually
need a term to describe it anymore.

But back in the late 60s and early 70s, it was debated whether it really
was a good idea to replace the `goto` statement with higher level
structured statements such as `if` and `for` and `while`, as well as
functions. Unstructured programming with `goto`, jumping directly to a
location in a program, could be more efficient. This debate sounds
quaint now, but Knuth's paper describes structured programming as a
"revolution".

Knuth is a good writer and I'm going to quote bits from his paper that
stick out to me.

He writes:

> I write this article in the first person to emphasize the fact that
> what I'm saying is just one man's opinion; I don't expect to persuade
> everyone that my present views are correct.

That also applies to this blog entry! But concerning optimization and
evil, Knuth was definitely able to persuade people. Everyone is
repeating it.

This is still relevant as well:

> In other words, it, seems that fanatical advocates of the New
> Programming are going overboard in their strict enforcement of
> morality and purity in programs.

Programmers in various tribes still are convinced they know the Truth
and look for purity.

> (...) people are now beginning to renounce every feature of
> programming that can be considered guilty by virtue of its association
> with difficulties. Not only go to statements are being questioned; we
> also hear complaints about floating-point calculations, global
> variables, semaphores, pointer variables, and even assignment
> statements.

Let's take stock of these features in modern programming languages and
their usage, where I count as "modern" anything designed in the last 30
years or so (I acknowledge that there are many fine programming
languages older than this):

## <span class="title-ref">goto</span> statements

Gone in most modern programming languages. A decisive victory for
structured programming! Why? Compilers got better, but more importantly,
computers goso much faster that worrying about the overhead of
structured programmer ceased to matter. Most developers don't miss
`goto`.

## Floating-point calculations

They're ubiquitous. I believe there was quite a bit of progress in solid
hardware implementations in the decades after Knuth wrote about this.

## Global variables

Many modern programming languages still have them, but the consensus is
that they should be used with caution at best.

## Semaphores

I'm not an expert about multi-threaded programming, but semaphores are a
useful primitive. Modern programming environments then build on this to
provide higher level abstractions. Does this mean they're gone like
`go to`?

## Pointer variables

Raw pointers are gone from most modern programming languages, though
modern system level programming languages such as Rust still provide raw
pointers in code explicitly declared unsafe.

## Assignment statements

They're everywhere, but there is a pure functional programming movement
which advocates against their usage. Experienced developers in any
language worry about restricting mutability in a range of contexts, as
immutable values have nice properties.

# Back to Knuth

Knuth continues:

> Soon we might be restricted to only a dozen or so programs that are
> sufficiently simple to be allowable; then we will be almost certain
> that these programs cannot lead us into any trouble, but of course we
> won't be able to solve many problems.

This is hyperbole of course, but more seriously I think Knuth
underestimated how much programming can be still be done under a very
serious set of restrictions.

It's interesting to see both how much changed and how much has stayed
the same.

# The premature optimization quote

Back to our quote:

> Premature optimization is the root of all evil.

Let's look at the quote in its context:

> There is no doubt that the grail of efficiency leads to abuse.
> Programmers waste enormous amounts of time thinking about, or worrying
> about, the speed of noncritical parts of their programs, and these
> attempts at efficiency actually have a strong negative impact when
> debugging and maintenance are considered. We should forget about small
> efficiencies, say about 97% of the time: premature optimization is the
> root of all evil.

Wise words. Let's read on:

> Yet we should not pass up our opportunities in that critical 3%. A
> good programmer will not be lulled into complacency by such reasoning,
> he will be wise to look carefully at the critical code; but only after
> that code has been identified. It is often a mistake to make a priori
> judgments about what parts of a program are really critical, since the
> universal experience of programmers who have been using measurement
> tools has been that their intuitive guesses fail. After working with
> such tools for seven years, I've become convinced that all compilers
> written from now on should be designed to provide all programmers with
> feedback indicating what parts of their programs are costing the most;
> indeed, this feedback should be supplied automatically unless it has
> been specifically turned off.

So Knuth advocates that profilers are to be built into the development
environment. Profiler support is ubiquitous, but it's not typically "in
your face".

Let's read back:

> Of course I wouldn't bother making such optimizations on a one-shot
> job, but when it's a question of preparing quality programs, I don't
> want to restrict myself to tools that deny me such efficiencies.

Context matters! The tools Knuth doesn't want to miss include the `goto`
statement.

As this shows, Knuth was someone highly concerned about performance. He
literally wrote [the book on algorithm
efficiency](https://en.wikipedia.org/wiki/The_Art_of_Computer_Programming).

# The changed context

In software development, context matters. Knuth talks about it in his
paper --if he's working on a one-shot program he won't bother about
complicated optimizations.

The context has changed rather drastically since 1974. The computers of
that time were enormously resource constrained compared to the devices
we have today. Computer resources were so scarce that they were
implementing multi user computing on machines with far less computing
power than an old smartphone. Your average smartphone CPU is at a
minimum a thousand times faster than what Knuth had to share with other
people. For all I know, my dishwasher might have more computing power
too. No wonder people were obsessed about performance. They were so
obsessed with performance they worried the impact of giving up the
`goto` statement.

Do most programmers these days indeed spend enormous amounts of time
thinking about the speed of their programs?

I would argue most programmers _do not_.

You get the
[regular](https://medium.com/commitlog/electron-is-cancer-b066108e6c32)
[lament](https://macwright.com/2020/05/10/spa-fatigue.html)
[that](https://www.reddit.com/r/programmerreactions/comments/615mb6/mr_as_i_watch_bloated_electronweb_apps_slowly/)
[modern](https://tonsky.me/blog/disenchantment/)
[software](https://www.richardspindler.com/2017/02/25/modern-software-development-or-slow-as-molasses/)
[is](https://www.computer.org/csdl/magazine/co/1995/02/r2064/13rRUwInv7E)
[too](https://www.remarkablyrestrained.com/articles/-software-bloat-makes-me-sad/)
[bloated](https://www.reddit.com/r/emacs/comments/8h4shd/emacs_was_once_called_eight_megabytes_and/).

I agree it would be _nice_ if software were more light-weight, used less
CPU resources, used less memory, had fewer layers, and was more power
efficient. But as some of these articles acknowledge, there are reasons
things are the way they are: making software more efficient can take a
huge amount of effort. And even though we may feel progress has been
uneven and slow, software can often _do_ a lot more as well. People
decide, correctly or not, that the effort to make it more efficient is
not worth it.

One of the most popular programming languages in the world these days is
Python. The dominant implementation, CPython, is also one of the slowest
language implementations in the world. This is by design:

> Python is about having the simplest, dumbest compiler imaginable, and
> the official runtime semantics actively discourage cleverness in the
> compiler like parallelizing loops or turning recursion into loops.

Now this
[quote](https://books.google.nl/books?id=bIxWAgAAQBAJ&pg=PA26&lpg=PA26&dq=%22Python+is+about+having+the+simplest,+dumbest+compiler+imaginable.%22&source=bl&ots=2OfDoWX321&sig=ACfU3U32jKZBE3VkJ0gvkKbxRRgD0bnoRg&hl=en&sa=X&redir_esc=y#v=onepage&q=%22Python%20is%20about%20having%20the%20simplest%2C%20dumbest%20compiler%20imaginable.%22&f=false)
is from 2009 and things [have changed somewhat since
then](https://faster-cpython.readthedocs.io/), but my point stands.
Python is still a comparatively slow language today.

It doesn't matter for most problem domains. Computers are fast enough.
You can use fast libraries that are written in another language, which
is an important reason why Python is so popular for machine learning.
The powerful primitives built into Python also make it easier to write
high performance algorithms, and a good algorithm can count for a lot.

I remember that 30 years ago, it still was much more common to obsess
over the performance of programming languages. Around 1990 I learned Z80
assembly language because BASIC wasn't fast enough. A few years after
that, I learned C as it was the next best thing after assembler but a
bit more high level. Part of the reason for this concern for performance
was because I was an inexperienced developer. But another part was
because the computers available at the time were enormously more
resource constrained compared to the ones we have today.

Of course in some contexts it still makes sense to obsess about
performance today. It makes sense to do so in many contexts -- the inner
loop of a game engine, or a database engine, or when you're engineering
a web browser, or a simulation, or when you're implementing a
programming language. It still matters how fast a web page loads. A
change in performance characteristics can even fundamentally change our
way of working altogether, because qualitatively new things become
possible.

But overall, I think we live in an era where developers complain about
software bloat far more than they complain about developers
unnecessarily obsessing about performance.

# Performance as a marketing gimmick

But, you may say, I saw graphs comparing performance of various
frameworks just yesterday! That must mean that developers _do_ care
about performance.

Perhaps.

I think people at times care so much about the performance of frameworks
because it's easy. So performance is used as a marketing gimmick.

People say, for instance, their web Python framework is faster. I've
[done that](@/posts/is-morepath-fast-yet.md)
[myself](@/posts/morepath-016-released.md).
But let's not forget that this framework is in _Python_. If you _really_
need insanely high performance at single core low level HTTP handling, I
would suggest you take a look at other languages. In any case, when I
last checked a few years ago, Flask, one of the most popular Python web
frameworks, was one of the slowest at trivial request/response
benchmarks. Almost nobody actually cares as it's not important for
almost any use case. It's fast enough.

People market how fast their JavaScript frontend framework is at
updating the DOM, and how small the produced code is. This matters for a
section of use cases - web sites that need to load pages quickly. But
for so many web applications this barely matters -- the code size is
minimum overhead compared to loading a few images, and the overhead of
DOM updates is often insignificant compared to other factors.

People do this marketing because it's easy to compare two performance
numbers, and much harder to compare what codebases feel like after
you've used a framework for a while. Because it's difficult to compare
frameworks in more sophisticated ways, it feels like you're making a
good decision if you pick a framework based on its performance. If all
else were equal it would make sense to pick the framework that's faster,
after all. [MongoDB is web scale](https://www.youtube.com/watch?v=b2F-DItXtZs),
so you can't go wrong, right? But all else is typically not equal.

# Why can optimization be evil?

Why can optimization be evil in the first place? We go to Knuth:

- it wastes programmer time
- it has a strong negative impact on maintenance (including
  debuggability)

Thank you Knuth!

# When is optimization premature?

When it leads to evil - time wasting or harder to maintain code, which
then also wastes time.

# Premature optimization in the small

Do people optimize their own code a lot these days?

It still happens, especially in the space of (open source) libraries.
Many of us on occasion spend a bit of effort to make something really
fast, for the joy of the craft. I think it happens mostly in library and
framework code.

Does it _waste_ our time? Certainly sometimes, but not necessarily -- we
may be doing it in our free time, and even if not we may learn a few
tricks that can help us when we're in a real performance bind. A major
performance improvement could even lead to the aforementioned leap in
quality.

Does it hurt maintenance? A library tends to be a more constrained
context, often with good test coverage, and the impact on maintenance is
constrained. Users of the library aren't generally hurt by it, and may
in fact benefit.

Conclusion: some of these optimization efforts may be premature, but
usually only a bit.

What about micro optimizations in application code? Do we see
developers, say, replace one for loop construct in JavaScript with
another faster but slightly more cumbersome version everywhere in a code
base "because it's faster"? I'm sure it happens, but is it really a
problem for most development teams? Maybe I've been working with
exceptionally well balanced software developers, but I think it's not
the issue of our time.

So I'd argue premature optimization is not really a big deal in the
small these days.

# Premature optimization in the large

You may engage in pemature optimization not for your own code, but in
your selection of dependencies or your choice of architecture. You
bought into the marketing a little bit too much, and you pick a harder
to use but higher performance programming language even though your
problem can readily be solved in a performant way in a language like
Python or JavaScript. Or you decide to pick a harder to use web
framework based on performance even though you only need to handle a few
requests per second and the database dominates that by far. Or you use a
harder to manage microservice architecture even though your organization
is tiny and you don't expect a lot of users either.

This kind of premature optimization happens quite frequently: it wastes
programmer time and makes code harder to maintain and therefore we can
declare this practice _evil_. Knuth was talking about micro
optimizations, the `goto` statement, but the wisdom still applies here.

# Often optimization is not evil

But often optimization is _just fine_. We can have the best of both
worlds! We can have our cake and eat it too!

Imagine I need to look up something in a hash table, let's say a Python
dictionary. I could write this:

```python
def lookup(d, lookup_key):
  for key in d.keys():
      if key == lookup_key:
          return d[key]
  return None
```

We're definitely not optimizing here. The performance may be okay too,
if the dictionary is not too big.

The optimized version looks like this:

```python
def lookup(d, lookup_key):
   return d.get(lookup_key)
```

Here I use Python's dictionaries `get` method which finds items in
constant time, no matter how big the dictionary is.

The `for` loop is far more evil; it's much harder to follow and thus
impacts maintenance.

And it's also slower. And it doesn't scale as well.

Optimization in this case turns out to be not only only _faster_ but
also _good_. It's the opposite of wasting programming time!

You may assert that this example is ridiculous!

I admit it helps that I don't need to maintain Python's dictionary
implementation. But that's the point. Today's powerful computers can run
dependencies like Python with ease. The context was definitely different
in 1974.

So since this optimization is not evil, this optimization is not
premature. It's in fact _never_ premature -- even if this dictionary
never grows beyond 10 items and the cost of the `for` loop version was
negligible, it's _still_ better code.

This type of tradeoff can also happen in the large. I once introduced
the use of a pre-existing index component in a codebase, where
previously there was a Python for loop to filter records. We knew this
filter would be used frequently, and we knew there were potentially many
records. I was told that I shouldn't introduce an index unless I had
shown by profiling that the `for` loop was too slow.

But profiling, especially with real-world data, would have taken an
effort, the effort of the introduction of the index was comparatively
low, and the impact on maintenance was low as well. I thought the
tradeoffs were clear.

# The wisdom of the wisdom

Back to Knuth's paper. He writes about a communication to him by
Dijkstra, of [Go To Statement Considered
Harmful](https://en.wikipedia.org/wiki/Considered_harmful) fame.

> He went on to say that he looks forward to the day when machines are
> so fast that we won't be under pressure to optimize our programs;

I think we have reached this day years ago, at least for optimization in
the small; barring a breakthrough in infinite performance computing we
will never reach the point where optimization in the large becomes
unimportant.

In fact machines are now so fast the pressure may be little bit too low.
People can write doubly nested loops that could be easily avoided by
using a hash table, and get away with it for far too long.

So what of the wisdom of "Premature optimization is the root of all
evil"?

I think it's still valid in some contexts, though these contexts are
typically the opposite of the low-level optimizations Knuth was talking
about.

But we should perhaps also work to restore a bit of the good old
inclination to optimize in our community.
