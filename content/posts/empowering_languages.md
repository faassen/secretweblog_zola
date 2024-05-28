+++
title = "Empowering Programming Languages"
date = 2024-05-27
slug = "empowering-languages"

[taxonomies]
tags = ["python", "rust", "programming", "history"]
+++

I think, for me, becoming enamored by a programming language requires a sense
of empowerment by that language. "Now I can build all the things!" It also
requires a certain sense of conceptual unity; it can't be too messy. It also
cannot be too low level: it needs the ability to do abstraction. And I need to
be actually using it a lot for real world tasks; it can't _just_ be for toy
problems.

In my developer life there are two languages I have become truly enamored by.
Python in 1998 and Rust, a few years ago. I have appreciated other languages
but this is more.

<!-- more -->

## Python

Back in 1998 I learned the Python programming language. This was in the now
difficult to imagine era where you needed to explain to other programmers that
Python was a programming language that exists. The [RustNL
conference](https://2024.rustnl.org/) I went to recently had about the same
amount of people there as the first Python conference I went to in January of
2000, about 300 people, but that Python conference was the only one in the
world.

I initially picked up Python as I wanted a scripting language to help me
automate some tasks around my alife simulation C++ codebase.

**I fell into my first Python job a few weeks after I learned the language**.
They hired me to rewrite a piece of failing DOS batch files that drove some
database task. "Can I use Python?" I asked during the interview. "Is that a
readable language? It's really important that it's readable." I answered yes. I
was reading the Python newsgroup a while later at work, and it was full of
people yearning to be able to use Python at work. And there I was.

It became a joke at work that I would offer to solve any random problem with
Python. I was passionate about Python. Why?

Python empowered me. I had been developing in C++ (and Delphi) in the years
previously. Python brought back some joy I had lost since I used BASIC.
Compared to C++ especially, Python was concise, very malleable, supporting
quick iterative development.

**Python was good to me**. I made friends with other people who used Python. We
built a CMS in Python (and [Zope](@/posts/my-exit-from-zope.md)) and a little
business around it. The second developer we hired explicitly wanted to be hired
as a _Python developer_, so thrilled he was that he could use the language for
work.

I learned web development, test driven development, and many other things with
Python. I had fun with it. I even made a
[game](https://github.com/faassen/dambuilder) with Python once.

I wrote the first emails that kicked off the EuroPython conferences. The first
email I sent was to Guido van Rossum, hey, we're organizing a European python
conference, can I tell people you're coming? He answered yes [^1], and then I
mailed a lot of other people that we were organizing a conference and Guido was
going to be there. Then, thankfully, others did most of the work in organizing
it.

Python has also hurt me, when I was critical about choices made by the
developers of the language. When you care about something, it can hurt you. But
that pain is insignificant compared to the many good things Python has brought
me.

## Rust

**Rust is the first programming language since Python where I feel a similar
sense of empowerment.** In a bit of irony as it brings back what I lost when I
gave up C++ all those years ago. Control over the machine. Performance. Static
types.

I use it to implement high performance algorithms, programming languages,
simulations. I wrote an alife simulation in C++ years ago and [an alife
simulation](@/posts/apilar-an-alife-system.md) helped to bring me to Rust.

Surprisingly enough, as I have been using Python for these purposes for years,
I build command line tools and REST web services in Rust too. That seems
strange. When you have a hammer, everything looks like a nail, right? That's
probably part of it. But there is also good reasons to use Rust for such
purposes. **Rust's type derived, macro-based techniques for doing things like
(de)serialization and parsing command line arguments are that powerful.** (See for
instance [serde](https://serde.rs/),[^2] [clap](https://docs.rs/clap/latest/clap/).)

**There is also the great blessing of the Rust tooling.** Even if Rust were a
completely different language, its tooling would help to make it attractive.
You get a compiler, autoformatter, test runner, dependency manager, type
checker, linter, documentation generator, editor integration, all without
having to mess around with dependencies and setting up config files. It just
works right away. It's awesome!

C++ I gave up on because of mental overhead. Too many details, too many
crashes, slow iteration time. **Rust gives me back the power of that language
with less load on my brain, fewer nagging worries.** It's more demanding than
Python in some ways, and certainly not easy to learn, but surprisingly, often
it actually taxes me less. The robust type checker, borrow check and analyzer
really give a lot of peace of mind. You can do a giant refactor and have some
confidence that once it compiles, it works. Runtime bugs are rare.

It's funny to see the feeling "oh this software was written in <insert
language here>, it must be cool!" get replaced with a new language. And that
makes me rather suspicious of that feeling. I do think there are legitimate
reasons to feel this way[^2], but it's not all rational for sure.

Rust is a lot more popular already than when I started with Python, but just
like with Python, I see people wistful about being able to use Rust at work.
I've been working with professionally for almost two years now. After I
realized I could build an alife simulation in Rust over a weekend, I figured I
was competent enough, and started to look for opportunities to use it
professionally. And I'm going to say, you may have more power to shape your
work environment than you think.

So here I am again, with another language that makes me think I can conquer the
world. Or at least do cool things.

**Of course this is a personal journey; other languages empower others. I hope
one gives you that feeling.**

[^1]:

This is not likely going to work today. Guido has become a lot busier. It
was a different era.

[^2]:

Legitimate reasons to think so:

- "this is written by someone in a small self selected community of
  enthusiasts." Was true for Python once. For Rust, still is more true

- "It has the quality of being easy to read". More true for Python though the
  language is more complex than it used to be, with Rust it's an acquired
  taste.

- "It has the quality of being efficient." More true for Rust, never really
  true for Python.
