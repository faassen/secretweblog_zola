+++
title = "under-engineering, over-engineering, right-engineering"
date = 2007-11-01
slug = "under-engineering-over-engineering-right-engineering"

[taxonomies]
tags = ["programming"]
+++

I just ran into a post in a series called "Tools of The Effective
Developer". This one is called [Make It Work -
First!](http://www.hans-eric.com/2007/10/29/tools-of-the-effective-developer-make-it-work-first/).

The posting contains very good advice. I call the two extremes described
"under-engineering" and "over-engineering". It's in part a personality
trait as the original posting says, but in part it's also something that
changes (hopefully!) as a developer matures.

Inexperienced developers who are still learning the basics of the craft
tend to under-engineer. They're happy already when they get something
working. They frequently don't even realize there are better ways to do
it.

Under-engineering frequently results in buggy, crufty, overcomplicated
or over-verbose code that's hard to read and hard to test. It works, but
it makes developers miserable, including most likely the developer who
originated it.

More experienced developers who are comfortable with their craft
frequently end up over-engineering. This problem is compounded if the
developer is fairly isolated from having actual users. These developers
are comfortable with the details of programming, and they're aware of
(at least dogmas of) right and wrong ways of doing things. They
therefore have an interest in powerful, flexible code, and a tendency to
anticipate future features.

Over-engineering frequently results in code that overanticipates
tremendously. It's full of all kinds of _interesting_ features and
pluggability points that end up not being needed in the future at all.
On the other hand, features that may be essential to the task at hand
might not be very well done, as they got lost between all the other
ones. Frequently even the (over)anticipated features end up not working
properly should you ever need them in the future. This is because there
was no real world application to actually exercise them yet when they
were being written, causing them to be buggy, or slightly-off.

This stage is probably an essential phase that good developers have to
go through. With even more experience these developers can hopefully
reach a balance: right-engineering. This is the ability to know when to
keep things simple, and to know when not to. These developers really
understand the value of good practices like high-feedback iterations and
test-driven development. As the original post recommends, typically the
right approach is indeed to go for the solution that works first: a
simple one. I must note here that 'simple' is a relative concept - a
good developer can make things simple that are definitely complicated
for others.

I'll also note that sometimes customers affect this balance. Customers
might be of a "just make it work" mindset, leaving little time to
developers to get things right. This is a well-known phenomenon, much
complained about by developers. Less well-known is that in other cases,
customers might also overanticipate future needs, complicating the
design of a piece of software before they even run it and actually gain
more experience with their real world needs. A good developer tries to
steer both types of customers to the right place somewhere in the
middle.

Right-engineering is difficult. "Make it work first" is indeed one of
the most important ingredients to reach success. Right-engineering is
more the application of good development strategies than it is pure
coding skill. You can't "become" a right-engineer after some period of
learning and growth, resulting in you always finding the right balance
between over-engineering and under-engineering for the job. What _can_
happen is that a developer will adopt strategies that increase the
chances of finding that balance.

A developer should recognize that the right amount of engineering (and
_what_ to actually engineer) is highly dependent on how the software is
actually going to be used. The best way to find out how software is
going to be used is often to actually _use_ it: use your api in
automated (doc)tests, get the customer to use prototypes and development
versions, and get the customer to put the software in production when
it's _good enough_, instead of when it's _optimal_. Software development
is frequently software evolution. Get feedback and go back and improve
your code.
