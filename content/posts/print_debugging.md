+++
title = "Don't Look Down on Print Debugging"
date = 2024-11-22
slug = "print-debugging"
description = "Print good, not bad!"

[taxonomies]
tags = ["programming"]

[extra]
mastodon_comment_id = 113527996081665381
+++

People tend to look down on print debugging as it's not using sophisticated
tools at all. You're not using debuggers, fancy loggers, or profilers.

You're just using the humble print statement. Or `print()` function. or
`console.log()`, or `println!()` or whatever your language calls it.

Print debugging is awesome and you should feel no shame in using it! It's the
tool that works for all languages [^1]. It's easy to understand and easy to
implement. It focuses the mind on thorough reading and understanding of code,
rather than getting lost in a forest of data.

Print debugging is really effective in many cases. 

Print debugging is not the same as logging. You put in the print when you try
to figure out what went wrong, and you take it out again once you figured it
out, preferably before you commit! 

## A bad practice?

People feel print debugging is a bad practice. 

The internet is full of advice to avoid print debugging in favor of other
things. I'll throw in some random headlines without linking, to demonstrate the
vibes: 

* "why you should not use console.log( ) for debugging"

* "Do not use Print. Master Python Logging"

* "STOP using simple console.log in JavaScript. Try this instead"

* "Stop using Print, and start Debugging"

* "Stop Using 'Print' and Start Using 'Logging",

* "No-Print Python. Stop using print to debug"

* "Stop console.log(). There are better ways!".

I'll grant some of these articles try to get you to adopt some library that
introduces a smarter print which adds debugging output. I'm all for it, though
there's still a huge benefit to print just being there. [^2]

**We should instead label print debugging a good practice**[^3].

## Print Debugging Workflow

So to be absolutely clear, here's the workflow:

* Discover problem
* Add in print statements in strategic locations where you want to check your
  assumptions. 
* Look at what happens. Are your assumptions correct? Change prints around for a while. Think.
* Fix the problem.
* Take out all the print stuff again.
* Done

## The Power of print

You can use expressions to process data! You can format data for readability!
You can use if statements and loops and whatever you want! Even just a dumb
`print(here!)` is good enough to see whether something gets called at all. And
it's all in the programming language you already know.

## Even More Power

You can write automated tests for some fraction of your codebase [^4]. You
might even write them before you write your code!

Now you isolate your problem as a failing test. Figure out how to use your test
runner to isolate it so you run just that one.

Then use the print debugging workflow for just one test, not the whole program!
So if your test is only exercising part of your behavior, or better yet, only
touching part of your codebase, you know that any printed output is because of
that test only, which is extremely helpful in finding the bug.

I suspect part of the reason people go for a debugger more often is because
they don't build up automated tests along with their codebase. Then in the end
you have to debug something very complicated all at once. If you build up
tests, you debug most things as you write them. It's much easier when you know
you broke stuff in the few new lines of code you added or changed rather than
everything everywhere all at once.

## Wait

Before this somehow morphs into a [deadly best
practice](@/posts/question_best_practices.md), I'm not saying that using more
sophisticated tools is bad. Use them if they're there and you they fit your
goals. Just don't dismiss print.

## P.S. Not the first

I'm not the first person to point out print is good:

> “The most effective debugging tool is still careful thought, coupled with judiciously 
> placed print statements.” — Brian Kernighan, “Unix for Beginners” (1979)

Many are apologetic or mixed up about it though:

I sourced that Kernighan quote from [this
article](https://tedspence.com/the-art-of-printf-debugging-7d5274d6af44) which
does go on to conflate it with logging.

And [this
article](https://buttondown.com/geoffreylitt/archive/starting-this-newsletter-print-debugging-byoc/)
goes into why print debugging can be so good, but then has to buy into the
shame by saying:
 
> I'm not saying that print debugging is the best end state for debugging
> tools, far from it. I'm just saying that we should reflect deeply on why
> print debugging is so popular, beyond mere convenience, and incorporate those
> lessons into new tools.

I am however saying print debugging works so well that while new tools may be
able to add value, they inevitably are less universal and less simple, a great
benefit of print debugging. **Maybe print debugging is actually an optimum for
a whole lot of scenarios?**

The article ["The Evolution of Debugging: From Print Statements to Modern
Tools"](The Evolution of Debugging: From Print Statements to Modern Tools) has
a good analysis of the trade-offs, and even though the title implies print
debugging is an antiquated, primitive tool, it ends with "Don't dismiss
traditional debugging methods".

And here we are, an unbashedly unapologetic article like mine: ["'Print' Is the
Only Debug Tool You
Need"](https://shubhamjain.co/2022/06/27/print-is-the-only-debug-tool/). Just
to show I'm not being original.

[^1]:

Even Haskell, which frowns on side effects, has an impure function called
`traceShow`.

[^2]:

Like in Rust, for which I can find few articles agitating against `println!`.
There's [this
one](https://blog.knoldus.com/are-you-still-using-println-in-rust-for-debugging/)
which steers you towards using `dbg!()`, which *is* built-in and very useful,
but I still use `println!()` as well as I can control the output better and
it's less noisy.

[^3]:

Or a best practice, but that's [a problematic
term](@/posts/question_best_practices.md), I think.

[^4]:

It helps to have decoupled code. Like, you split your codebase up into parts
that you can understand and debug independently. But even for a huge fraction
of your codebase print debugging can still be useful.

[^5]:

Some testing tools are helpful in that they don't print out anything for tests
that succeed, only the failing one, though sometimes that's annoying and you
have to learn how to disable it.

