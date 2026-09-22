# The Third Reuse

In software development we have multiple form of code reuse:

- copy & paste code.

- reuse by abstraction.

AI adds a third one kind of reuse. But let's first look at the original types of
reuse, because they can help us understand AI based reuse better.

## Copy & Paste

Copy and pasting code doesn't need too much description. We see some code in the
existing codebase, or elsewhere, that does more or less what we want. We copy
it, and adjust it so it does what we want. That's all.

Sometimes people use more sophisticated ways to reuse code snippets, built into
their editor. And (non-AI) autocomplete can be seen as a form of copy & paste as
well, focused mostly on names.

Experienced software developers often frown on copy & paste. It risks violating
DRY - don't repeat yourself! Often the better approach is to build an
abstraction instead.

But copy & paste is nonetheless with us, and it's useful. Abstractions are often
overkill. And we learn from examples! A bit of repetition in code should be
accepted; it's often essential lubrication. @[repeat yourself a little]

So I can be brief about the failure mode of copy and paste: we risk creating
code that's difficult to maintain because of lack of abstractions. To make a
change, we need to be in many places, and it's easy to forget some. Everything
is fluid, nothing enforces invariants we actually care about. We engage in
underengineering @[]. Continuous refactoring is a good remedy against this.

## Reuse by Abstraction

Reuse by abstraction sounds fancy, but in the simplest form it's just a
function. If you want to do the same thing multiple times, you define that as a
function and then call it multiple times.

It can get a bit fancier: you can create, or find, a bundle of reusable
functions. We call this a library. If you distribute this library so others can
use it too, the reuse is beyond the scope of a single application.

You can get fancier still: you can invert control. Instead of calling a
function, you instead have the reusable system call your functions. If you rely
on inversion of control a lot, you get a type of abstraction we call a
framework. If you're interested in more of my thoughts about frameworks, I
invite you to read @[framework patterns] and @[roll your own frameworks].

We have other forms of abstraction reuse: programming languages, operating
systems, protocols, even low level CPU architecture. The deeper in the stack the
reuse, the more it tends to disappear into the background. The most solid
reusable pieces are the ones we stop seeing as something we reuse.

That's in fact one benefit of abstraction reuse: it allows you to forget about
the details of how they work, but reason in terms of abstractions alone.

## Reuse by Abstraction Failure Modes

Abstractions can be leaky - details of the underlying system leak into a place
where you don't want to worry about them, but you do anyway.

Abstractions can also be ill-fitting. This can be because you're using the wrong
tool for the job, but it can also be more subtle; it started out as the right
tool, until your application, in certain areas, starts to grow outside of its
assumptions and constraints.

Building abstractions risks overengineering. You can spend quite a while
building a solution for something that's ultimately ill-fitting. It's tricky to
distinguish this from spending a while building the right solution. More
experience with the problem domain tends to reduce the risk, but even that isn't
always sufficient; see [second system syndrome].

## Running ahead of your understanding

Copy and paste reuse can mean running ahead of your understanding. You just copy
and paste what works, without fully understanding it. As a developer I've always
resisted this, and try to understand what's going on, but it's probably true
that I sometimes also just went with the flow, when it was low risk.

Abstraction reuse also means using something without understanding how it works,
but the nice thing about a good abstraction is that you don't need to: if you
understand the rule of the abstraction, you can use it, without knowing how it
works inside. I don't know how my CPU does multiplication exactly, but I can
still multiply. Good abstractions allow reuse without understanding the details
with low risk.

So if you want to avoid understanding something, abstraction reuse beats copy
and paste reuse. And we do want to avoid understanding something at times, as we
only have limited time and attention.

## The Third Reuse: Pattern Reuse

Using AI to program adds a new form of reuse to programming: pattern reuse. It
can be seen as sitting somewhere between reuse by abstraction and reuse by copy
& paste.

It's like copy & paste in the sense that new code is generated; you don't reuse
by abstraction. The AI just generates code for you. This reuse is much more
powerful than reuse by copy and paste though. You can see the AI as being
inhumanly good at finding, copying and pasting and adjusting larger pieces of
code.

Another way of viewing what the AI does is that it reuses patterns. It's been
trained on many patterns and structures in a lot of source code. It's
generalized these patterns far enough so that it can use them again in a new
context. Abstraction is one type of generalization, but it's not the only type
of generalization we use: as I mentioned before, sometimes a bit of repetition
in code is essential lubricant.

AI autocomplete is reusing patterns at the level of code. But agentic AI goes a
level upward. The reuse of patterns there goes beyond reusing patterns in
application code to the reuse of patterns in how to edit code, test code, and
analyze code. This is possible because how we interact with code can be
expressed as code too (such as CLI commands to search and replace), and this
code has patterns.

## Drawbacks of AI pattern reuse

Pattern reuse shares a failure mode with copying and pasting: underengineering.
But, pattern reuse can also reuse abstractions, and even create its own. So it
can go a lot further than just copying and paste alone. How far exactly is what
we're collectively starting to learn about.

## We always had pattern reuse

We always had pattern reuse. It's just that the pattern was in the head of the
developer, or written down somewhere, say in an algorithm textbook, rather than
in the neural network of a large language model.

But AI lets developer use these patterns more conveniently, and even reuse
patterns in modifying code, and even use patterns they don't understand
themselves. Is that bad?

It depends. Abstraction reuse and copy & paste already allowed developers to
reuse without understanding. And we know that in those cases, it *can* be bad,
but doesn't have to be. It has tradeoffs, and needs to be managed. To manage it,
we need to maintain our human understanding.
