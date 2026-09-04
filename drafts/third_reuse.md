# Pattern Reuse: the Third Reuse

In software development we have multiple form of code reuse:

- reuse by abstraction.

- copy & paste code.

Let's go over these.

## Reuse by Abstraction

This sounds fancy, but in its simplest form it's just calling a function. If you
want to do the same thing multiple times, you define that as a function and then
call it multiple times.

It can get a bit fancier: you can create, or find, a bundle of reusable
functions. We call this a library. If you distribute this library so others can
use it too, the reuse is beyond the scope of a single application.

You can get fancier still: you can invert control. Instead of calling a
function, you instead have the reusable system call your functions. There's a
gray area, but we're moving into software framework territory now. One benefit
of the framework approach is that it helps structure your application, and can
separate concerns in a way that a library cannot do. If you're interested in
more of my thoughts about this, I invite you to read [framework patterns] and
[roll your own frameworks].

We have other forms of abstraction reuse: programming languages, operating
systems, protocols, even low level CPU architecture. The fancier the reuse, the
more they tend to disappear into the background. 

That's in fact one benefit of abstraction reuse: it allows you to forget about
the details.

## Reuse by Abstraction Failure Modes

Abstractions can be leaky - details of the underlying system leak into a place
where you suddenly need to worry about them. Abstractions can also be
ill-fitting. This can be because you're using the wrong tool for the job, but it
can also be more subtle; it's in fact the right tool for the job, until your
application, in certain areas, starts to grow outside of its assumptions and
constraints.

Building abstractions risks overengineering. You can spend quite a while
building a solution for something that's ultimately ill-fitting. It's tricky to
distinguish this from spending a while building the right solution - an
important difference is experience with the problem domain, but even that isn't
sufficient; see [ second system syndrome].

## Copy & Paste Reuse

Copy and pasting code doesn't need too much description. We see some code in the
existing codebase, or elsewhere, that does more or less what we want. We copy
it, and adjust it to make it fit. Sometimes people use more sophisticated ways
to reuse code snippets, built into their editor. And (non-AI) autocomplete can
be seen as a form of copy & paste as well, focused mostly on names.

Experienced software developers often frown on copy & paste. It risks violating
DRY - don't repeat yourself! Often the better approach is to build an abstraction.

But copy & paste is nonetheless with us, and it's useful. Abstractions are often
overkill. And we learn from examples! A bit of repetition in code should be
accepted; it's often essential lubrication.

So I can be brief about the failure mode: we risk creatining code that's
difficult to maintain because of lack of abstractions. We risk underengineering.
Continuous refactoring a good remedy against this.

## A silly example

Let's consider going through a list of items and accumulating a value. We could
write it like this:

```python
sum = 0
for item in list:
   sum += item.value 
```

Now this is a very short idiom that is so fast to type there is no real reason
to use copy & paste [^language]. But you can easily imagine it's a little bit
more involved, and you want to also do this behavior. Then you copy & paste and
tweak the code until it does what you want is useful.

We can also reuse by abstraction. We could imagine a function `sum_by` that is
given the list and how to get the value to sum:

```
sum_by(list, lambda item: item.value)
```

Now whenever we want to accumulate, we can write it in one line.

## The Third Reuse: Pattern Reuse

Using AI to program adds a new form of reuse to programming: pattern reuse. It
can be seen as sitting somewhere between reuse by abstraction and reuse by copy
& paste.

It's like copy & paste in the sense that new code is generated; you don't reuse
by abstraction. The AI just generates code for you.

It's like reuse by abstraction in that *patterns* are involved. The AI has been
trained on many patterns and idioms in source code, has generalized these
patterns far enough so that they can be used again in a new context.

This is most obvious when AI autocomplete is used. But it also applies to
agentic systems; the reuse of patterns there goes beyond just patterns in code
to patterns in how to edit code, test code, and think about code. Reuse by
abstraction is part of these patterns as well!

## We always had pattern reuse

We of course always had pattern reuse. It's just that the pattern was in the
head of the developer, rather than in the neural network of a large language
model. 

Now we can reuse patterns with a shortcut. Developers who do not know a pattern
can use the pattern, perhaps even without understanding it. Is that bad?

It depends. Abstraction reuse and even copy & paste already allowed developers
to reuse without understanding all the details.

## Pattern Reuse Failure modes

The failure mode of pattern reuse by AI is that of entropy, and the local
maximum. It's similar to a programmer typing and copy & pasting wildly and
tweaking endlessly until it works, rather than worrying about abstractions along
the way. You can get very far that way. AI can get you a lot further still, as
it does know about abstractions and can apply them.

But if you keep doing this, without stopping to think and reconsider once every
while, you're climbing a hill, and might get stuck on top of one, looking at the
mountain peak that's nearby yet so far.

You can go very fast for a while, and then fly into the wall of jello where
everything is slow. This wall of jello has not disappeared.

AI coding can also support managing that wall of jello. AI knows a lot of
patterns, and some may just work. You can automate a lot of tedious refactoring.
But AI is not at the point where it can do this by itself, and without the sense
of direction and deep context humans can create I don't think it can fully get
there.

[^language]: it helps that our programming language already has a strong
iteration abstraction, so we don't need to worry about array indexes.
