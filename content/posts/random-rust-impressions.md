+++
title = "Random Rust Impressions"
date = 2022-11-07
slug = "random-rust-impressions"

[taxonomies]
tags = ["rust", "python", "javascript", "typescript", "planetpython", "programming"]
+++

I have been using Rust for some years now for hobby projects. Recently I
also had the opportunity to use it professionally for a while. My
background is mostly in dynamically typed languages like Python and
JavaScript, though I have played with various other languages over the
years. I thought I'd share some of my impressions of Rust.

# Learning Rust

I'd had my eye on Rust for years until I decided to give it more serious
attention in 2019. I used it for various hobby projects; I created half
of an [artificial life](https://en.wikipedia.org/wiki/Artificial_life)
simulation that never got anywhere. I played around with the
[Bevy](https://bevyengine.org/learn/book/getting-started/ecs/) game
engine and the [Rapier](https://rapier.rs/) physics engine. I wrote a
[little driver](https://github.com/faassen/rust-it8951) that can send
images to an e-paper display over USB. I wrote a
[plugin](https://github.com/faassen/i3-autonamer) for the
[i3](https://i3wm.org/) window manager that uses async Rust and Tokio;
it's complete overkill and could just as well be sync Python, but it's
cool that it uses almost zero CPU or memory.

This year I wrote an artificial life simulation that actually does work:
[Apilar](/posts/apilar-an-alife-system/). I
made it run on multiple cores, and hooked it up with a web frontend
written in TypeScript using [Axum](https://github.com/tokio-rs/axum).

Then I delved into making it even faster by generating machine code
using LLVM in a project called
[Aleven](https://github.com/faassen/aleven); while Aleven works it's far
from integrated into an artificial life simulation yet.

Finally I was paid to work professionally on
[Iroh](https://github.com/n0-computer/iroh) for a little while, which
really deepened my understanding of several aspects of Rust, especially
in the areas of async and testing.

So based on that experience, here are some impressions.

# A Long Strange Trip Through Type Systems

I was exposed to static types in the 1990s through Pascal, C and C++.

Then I learned Python in 1998 and with it the joy of dynamic types.
Dynamic typing has great benefits: it's often less verbose and it allows
software to be very malleable. During test driven development, dynamic
typing is really useful when you write [test
doubles](https://scribe.rip/m/global-identity?redirectUrl=https%3A%2F%2Fblog.pragmatists.com%2Ftest-doubles-fakes-mocks-and-stubs-1a7491dfa3da).

Around 2018 I went back into the world of static types again with
TypeScript, which has amazing features like [mapped
types](https://www.typescriptlang.org/docs/handbook/2/mapped-types.html).
Though I had played a bit with Haskell, TypeScript was the first modern
type system I used in the real world and I enjoy it a lot. I haven't
used Python's gradual type system a lot yet, though in the little
experience I've had with it, it feels similar to TypeScript.

Just like I had discovered that writing tests and writing documentation
can sharpen my thinking and the code I design, I now discovered that
writing down types explicitly can do so too. And having static types
really helps various development tools, too.

Even when writing code in a dynamically typed language like Python I was
thinking in types; running a little type system in my head. But that
doesn't let the computer help you, and sometimes that help can be quite
nice.

But TypeScript's type system offers an escape. You don't have to make it
work perfectly; you can smuggle in an `any` here or there. With Rust
there is no `any`. With Rust there is no escape.

That leads to a particular game I call Type Whack-A-Mole.

# Type Whack-A-Mole

> The term "Whac-a-mole" (or "Whack-a-mole") is used colloquially to
> depict a situation characterized by a series of repetitious and futile
> tasks, where the successful completion of one just yields another
> popping up elsewhere.
> ([Wikipedia](https://en.wikipedia.org/wiki/Whac-A-Mole))

Rust's intricate type system, control over memory, and lifetime rules
induce sessions of whack-a-mole:

- You write some code or try to adjust some existing code.
- Rust complains you can't do that.
- You change things.
- Rust complains you can't do that either!
- Repeat for quite a while, until you finally get it to compile.
- Once it compiles, it often works.

Often the outcome is quite reasonable code, but I also frequently ended
up with code that was less satisfying: overly complex, too much
repetition, or a feeling some more further efficiency could be gained.

Now the "further efficiency" feeling is one I think you should usually
ignore; avoiding the use of dynamically allocated memory for instance is
not really a thing you should worry about too much unless you know the
code you're writing needs maximum performance. You just get that feeling
because it's explicit in Rust.

And in part the reason the code isn't always as pretty as it could be is
definitely on me -- I'm still learning how to structure my Rust code.

But in part, I fear, this friction I feel is on Rust. It's a price you
pay for the efficiency and control. Whether you should pay that price
gladly depends on who you are and what you're working on.

Type Whack-A-Mole can be strangely addictive. It think this is because
there's a quick feedback loop from the tooling; in this it's quite
similar to test driven development. I've also experienced type
whack-a-mole with TypeScript, but less frequently: in TS it's more about
getting the _ergonomics_ of the types right, deriving types from each
other to make the user of the API have the best feedback possible. With
Rust it's more about getting stuff to work, though the rules of Rust
definitely push you into certain design patterns.

# Tooling and Ecosystem

The Rust tooling is great: Cargo does a lot, Rust analyzer works in
complex setups, autoformat works, and Clippy gives good suggestions and
sometimes can even refactor automatically. The defaults are good!

In fact I think the Rust tooling is the best of any programming language
I've used so far. The JS and Python ecosystem has good tools available
too, but you always find yourself assembling a set of tools to use for
each project and waste a lot of time tweaking things. If you install
Rust with `rustup` a lot is just there from the start: the compiler,
autoformatter, Rust analyzer, Clippy.

Rust has a lot of libraries and frameworks available. Rust packages
(called crates) are easy to find online, though sometimes I find myself
going between `docs.io`, `crates.io` and a project's github page a bit
often. Sometimes you can find things in the github page that you can't
find in the docs or vice versa. But it's typically easy to find the
documentation. You also get some decent clues to evaluate Rust libraries
for popularity and maintenance; I really struggled with that when
evaluating Haskell libraries.

The documentation quality is mixed. Some Rust libraries have great
narrative documentation. Sometimes you have to make do with examples in
a directory (which does have Cargo support so is in a standard place).
Too often I find myself staring at API docs and wishing for more
examples and narrative docs. Surprisingly often I actually figure it out
even with such minimal documentation: the type system helps a lot in
figuring out how pieces can go together.

There are a lot of high quality Rust libraries available. There is also
quite a wide breadth in what the library ecosystem offers, something I
appreciate about the Python ecosystem, which really excels at this.

# Compile-time Magic: Retuning my Intuitions

I've been programming for a long time. I think that experience gives me
a good set of intuitions I use day to day during development. I know
when it's time to refactor, and I have a storehouse of patterns for
organizing code to make it more testable, configurable, performant, and
so on.

Rust requires me to retune those intuitions. The aforementioned static
type checking is one important reason why my intuitions don't always
work out of the box, but the other reason is what you can do at
compile-time.

In dynamic programming language compile-time features are typically
almost absent. With Rust, there is a _lot_. Here's an incomplete
grab-bag:

- constants are evaluated at compile-time. This means you can't use
  dynamic memory allocation to construct a constant without special
  measures.
- compile-time features allow you to conditionally compile code.
- macros. These come in a lot of different varieties; you have things
  that look like function calls followed by a `!` (like `println!`) that
  actually transform and generate code during compile-time. You can also
  can annotate any `struct`, function and such in code with special
  attributes to mark them for transformation.

A good example of where my intuitions weren't quite right for Rust were
my struggles with [test
doubles](https://scribe.rip/m/global-identity?redirectUrl=https%3A%2F%2Fblog.pragmatists.com%2Ftest-doubles-fakes-mocks-and-stubs-1a7491dfa3da).

Test driven development helps you design code with clear and minimal
contracts between subsystems that you compose together. The [Polly wants
a Message](https://www.youtube.com/watch?v=XXi_FBrZQiU) talk by Sandi
Metz is a great introduction to some of the ideas involved. If you want
to test a subsystem that depends on something else, you compose it
together with a fake implementation that provides just enough behavior
to let you test your own code.

This is why in a dynamic language like Python and JavaScript I usually
don't use mocking libraries when I write tests. Mocking libraries helps
you create a fake implementation of something for testing purposes. I
typically don't find it cumbersome to create the fake implementation by
hand, and doing so makes the dependencies really clear.

Moreover some mocking libraries have the ability to override code in
_existing libraries_ with mocked versions during runtime. This is really
powerful. It allows you to create tests for more tightly and implicitly
coupled code. This is the opposite of making dependencies in code
explicit and minimal so I actively avoid doing using that feature when I
can.

But Rust isn't a dynamically typed language. You can't just create
another fake implementation for a Rust `struct` and its methods. If you
want an explicit interface in Rust you can have one with its `trait`
feature, but traits have drawbacks too, and creating a trait just for
testing purposes is overkill.

So in Rust you do more often want to use a mocking library to create
your fake implementations. I've used
[mockall](https://docs.rs/mockall/latest/mockall/). This uses fancy
macros to let you create a mocked implementation of a trait, and even a
`struct` even though Rust's `struct` was not designed for
replaceability.

By itself `mockall` doesn't get you out of introducing traits in the
code that consumes the mocked code. So another insight that took a long
time coming is that you can then use conditional compilation to make the
mocked code available during tests, and the real implementation during
production.

Rust uses macros and conditional compilation to solve problems
dynamically typed languages solve during runtime. The application of
compile-time magic can be powerful, like the amazing
[Serde](https://serde.rs/) framework for serialization and
deserialization.

Even with macros available, often, but not always, you end up with more
verbose code in Rust than you do in a dynamically typed language, but
Rust, as a systems programming language, has different constraints.

# Sync Rust ergonomics

Rust has a bunch of mechanisms for high level abstraction, but it's
still more verbose than a dynamic language. This is inevitable given its
constraints.

That said, I've found writing plain synchronous Rust code to be a
pleasant experience. You have to worry about a lot more details than you
do when you write, say, Python, but it's not too taxing. The tooling
really helps -- the messages emitted by the Rust compiler and the Rust
analyzer often contain helpful hints about what your problem is and how
to solve it.

Some retuning of intuitions is necessary though. Here are a few I
encountered on my way:

- If in doubt, use `enum` match over dynamic dispatch. Rust supports
  dynamic dispatch, but when you use it life can get complicated really
  fast because everything, including memory allocation, is explicit.
- You also want to avoid references in a `struct` if you can. References
  are fine as function arguments, but once you use one in a `struct` you
  need to start worrying about lifetime annotations. And even if you get
  that to work, you still won't be able to make circular references
  unless you start worrying far more about memory allocation than you
  typically want to. For referential data structures you may be better
  off constructing references out of array indexes. This feels like a
  betrayal of the static type system, but it's a lot easier.
- Another area where Rust is different from most other languages in its
  error handling. Rust wants you to be very explicit about returning
  errors, and it wants you to handle those errors. I believe that Rust's
  design makes error handling better in a variety of ways, especially in
  a systems programming language, but it does put extra cognitive load
  on the developer. The `?` operator helps a lot. In most code, the best
  advice is to use `?` and to avoid a lot of custom error types, but
  instead to use the [anyhow](https://docs.rs/anyhow/latest/anyhow/)
  crate. With that, error handling in Rust is fairly ergonomic.

# Async Rust

Async Rust is another story. The basics of async in Rust are all right.
`async` and `await` are built into the language.
[Tokio](https://docs.rs/crate/tokio/latest), a popular library for
constructing async systems, works well and is well documented.

Here are a few stumbling blocks I ran into over time:

- You communicate between async tasks using channels. It took me a while
  to realize that to have multiple producers in a [multi producer single
  consumer
  channel](https://docs.rs/tokio/latest/tokio/sync/mpsc/index.html) I
  needed to clone the producer to stop the type system from complaining,
  but having such compile-time checks is actually pretty great.
- Sometimes you do really want to share state between workers. It took
  me a while to figure out to use `Arc<Mutex<T>>` for this use case, but
  I figured it out. You now have a significantly increased risk of
  deadlocks, so you need to organize things carefully.

Then came async in traits. Traits are like interfaces in other
languages. Traits can be used without dynamic dispatch, but you need
then when you want it. Traits, for [various complex reasons I don't
fully understand
yet](https://rust-lang.github.io/wg-async/welcome.html), don't support
`async` methods.

Macros to the rescue! There's this macro provided by the
[async-trait](https://crates.io/crates/async-trait) crate that does
allow you to use them anyway. But that macro is a leaky abstraction and
it can interact with other macros, like the one provided by
[mockall](https://docs.rs/mockall/latest/mockall/) to help you mock a
trait. You don't want to end up in that situation, but I did. Macros are
powerful, but they can have significant downsides.

Then there are async streams. Async stream iteration isn't built into
the language yet, but that's not a big problem because a
<span class="title-ref">while</span> loop works well to consume a
stream. _Generating_ an async stream is a lot trickier. It would be made
a lot easier by a <span class="title-ref">yield</span> statement,
something that Rust doesn't support yet. Unless you use more macro
magic: the
[async-stream](https://docs.rs/async-stream/latest/async_stream/) crate
allows you to use the <span class="title-ref">yield</span> statement
anyway! If you want to use _recursion_ when you generate an async stream
you have to worry about memory allocation, or alternatively use a crate
called
[async-recursion](https://docs.rs/async-recursion/latest/async_recursion/)
with another macro.

You can avoid the use of these macros by making everything explicit, but
that requires understanding of more details, like how dynamic memory
location comes in. And since these abstractions are leaky, you probably
need that understanding anyway. I've found
<span class="title-ref">async-trait</span> not to be very friendly
towards async streams, for instance. So I needed to understand that I
needed to use
[BoxStream](https://docs.rs/futures/latest/futures/stream/type.BoxStream.html);
the `Box` bit means that you're using dynamic memory allocation, which
also allows you to use dynamic dispatch which you may need to when you
want to mock a fake stream in a test, for instance.

Rust isn't very ergonomic yet when you need to write complex async code.
The various macros help and hurt at the same time; because their
abstraction is inevitably leaky you need to understand the complex
underpinnings anyway.

The people working on this are [fully aware of
this](https://rust-lang.github.io/wg-async/vision/submitted_stories/status_quo.html).
I'm confident that life will incrementally get better. But for the time
being, beware.

# Conclusions

It took a while to get used to it, but I am now fairly proficient at
writing plain synchronous Rust code. I wrote
[Apilar](/posts/apilar-an-alife-system/) in a
48 hours programming contest, and it included a new stack-based
programming language with assembler and disassembler, a CLI and
text-based visualization.

And by now I bashed my head against async Rust enough to be dangerous
too.

Rust is one of the biggest and hardest languages I have learned. Why did
I persist in learning it? Because I didn't have a systems programming
language in my toolbox anymore -- most of my C and C++ experience is
decades in the past. Compared to these languages I think Rust offers
better ergonomics, in the areas of security, abstraction, and tooling.
It also has an ecosystem full of really smart developers doing clever
stuff.

Sometimes I want systems programming; it's useful when I really care
about performance. High performance can sometimes make a qualitative
difference too -- if you can do something _a lot faster_ or with _a lot
less memory_ you might start to use it in new, creative ways.

Moreover, computers are devices that use a lot of energy. It would be
nice if we could write more efficient software, to use a bit less.

Rust is not a language for all jobs or all programmers. I have no
regrets in learning it at all though. I'd like to do some more with it
in the future.

Thanks for reading; I hope it was interesting and useful to you!
