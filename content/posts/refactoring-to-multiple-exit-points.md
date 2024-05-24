+++
title = "Refactoring to Multiple Exit Points"
date = 2019-08-21
slug = "refactoring-to-multiple-exit-points"

[taxonomies]
tags = ["refactoring", "python", "planetpython", "patterns"]
+++

# Introduction

Functions should have only a single entry point. We all agree on that.
But some people also argue that functions should have a single exit that
returns the value. More people don't seem to care enough about how their
functions are organized. I think that makes functions a lot more
complicated than they have to be. So let's talk about function
organization and how multiple exit points can help.

I'm going to use Python in the examples, but these examples apply to
many other languages such as JavaScript and Ruby as well, so do keep
reading.

# Starting point

Let's consider the following function:

```python
def process_items(items, bar, default):
    result = None
    if bar is not None:
        for item in items:
            if item.match == "A":
                result = item.payload
            elif item.match == "B":
                continue
            else:
                if item.other == "C":
                    result = item.override
                else:
                    result = bar
            if result is not None:
                break
    else:
        result = "No bar"
    if result is None:
        result = default
    return result
```

It's a silly function, it's a hypothetical function, but there are
plenty of functions with this kind of structure. They might not be born
this way, but they've certainly grown into it. I find them difficult to
follow. You can recognize them by one symptom already: quite a bit of
indentation. You can also recognize them by trying to trace what happens
in them; notice how your working memory fills up quickly.

# Extract function from loop body

How would we go about refactoring it? The first step I would take is to
extract the loop body into a separate function. You may say, why do so?
Objections could be:

- The loop body isn't reused in multiple places, so why should it be a
  function?
- You have to manage function parameters whereas before all was
  conveniently available in the body of `foo`.

That is all so, but let's do it anyway and see what happens, and then
get back to this in the end:

```python
def process_items(items, bar, default):
    result = None
    if bar is not None:
        for item in items:
            result = process_item(item, bar)
            if result is not None:
                break
    else:
        result = "No bar"
    if result is None:
        result = default
    return result

def process_item(item, bar):
    if item.match == "A":
        result = item.payload
    elif item.match == "B":
        result = None
    else:
        if item.other == "C":
            result = item.override
        else:
            result = bar
    return result
```

We've had to extract two parameters - `item` and `bar`. It turns out
`process_item` doesn't care about
<span class="title-ref">default</span>. We've had to convert the
`continue` to a `result = None` to keep things working properly, as now
we always run into the <span class="title-ref">if result is not
None</span> check whereas before we did not.

# Multiple exit points

We notice that result is only touched once in each code path in
`process_item`. This means we can convert the function to use multiple
exit points with the `return` statement, so let's do that:

```python
def process_item(item, bar):
    if item.match == "A":
        return item.payload
    elif item.match == "B":
        return None
    else:
        if item.other == "C":
            return item.override
        else:
            return bar
```

# Convert to guard clauses

That's still more complicated than it should be. Since we have early
exit points, we can get rid of the `elif` and `else` clauses:

```python
def process_item(item, bar):
    if item.match == "A":
        return item.payload
    if item.match == "B":
        return None
    if item.other == "C":
        return item.override
    else:
        return bar
```

Some indentation is gone, which is a good sign. And we see another
`else` we can get rid of now:

```python
def process_item(item, bar):
    if item.match == "A":
        return item.payload
    if item.match == "B":
        return None
    if item.other == "C":
        return item.override
    return bar
```

# Pay attention to None

I think the `return None` case is special, so let's move that up. That's
safe as `A` and `B` for `item.match` are mutually exclusive and this
function has no side effects:

```python
def process_item(item, bar):
    if item.match == "B":
        return None
    if item.match == "A":
        return item.payload
    if item.other == "C":
        return item.override
    return bar
```

This function is now a lot more regular. If you read it past
`return None` you can forget about the case where `item.match == "B"`,
and then forget about the case where `item.match == "A"`, and then
forget about the case where `item.other == "C"`. In the original version
that was a lot harder to see.

# Why pay attention to None?

This last reorganization of the guard clauses may seem like a useless
action. But I pay special attention to `None` (or `null` or `undefined`
or however your language may name the absence of value). If you organize
the guard clauses that deal with `None` to come earlier, it makes your
functions more regular and thus more easy to read.

It also triggers you to consider whether perhaps `item.match == "B"` is
something you can handle at the call site, which can lead to further
refactorings. Later we'll consider that further in a bonus refactoring.

Languages that have an `Option` or `Maybe` type such as Haskell and Rust
make this more obvious and have special ways to handle these cases --
the language forces you. TypeScript also tracks tracks
<span class="title-ref">null/undefined</span> in its type system. But in
many other languages, such as Python, we're on our own. But we certainly
still have to pay attention to `None`.

See also my [the Story of
None](/posts/none_01_the_beginning).

# Back to process_items

Now let's look at the `process_items` function again:

```python
def process_items(items, bar, default):
    result = None
    if bar is not None:
        for item in items:
            result = process_item(item, bar)
            if result is not None:
                break
    else:
        result = "No bar"
    if result is None:
        result = default
    return result
```

# Multiple exit points

Let's first transform this so we return early when we can:

```python
def process_items(items, bar, default):
    result = None
    if bar is not None:
        for item in items:
            result = process_item(item, bar)
            if result is not None:
                break
    else:
        return "No bar"
    if result is None:
        return default
    return result
```

# Flip condition to create a guard

We can see clearly that `"No bar"` is returned if `bar is None`, so
let's flip that condition:

```python
def process_items(items, bar, default):
    result = None
    if bar is None:
        return "No bar"
    else:
        for item in items:
            result = process_item(item, bar)
            if result is not None:
                break
    if result is None:
        return default
    return result
```

We can now see the `else` clause is not needed anymore, so let's
unindent the `for` loop. We also move `result = None` below that guard
clause for `bar is None`, as it's not needed until that point:

```python
def process_items(items, bar, default):
    if bar is None:
        return "No bar"
    result = None
    for item in items:
        result = process_item(item, bar)
        if result is not None:
            break
    if result is None:
        return default
    return result
```

So it turns out in the rest of the function we can completely forget
about `bar` being `None`. That's good. Maybe that guard can even be
removed if we can somehow guarantee the non-None nature of `bar` at the
call site. But we can't determine that in this limited example. Let's go
on refactoring this function a bit more.

# Turn loop break into early return

We take a look at the `break`. If `result is not None`, we break. Then
after that we check if `result is None`. This can only happen if the
loop never breaked. If the loop _did_ break we end up returning
`result`.

So we can just as well do the `return result` immediately in the loop:

```python
def process_items(items, bar, default):
    if bar is None:
        return "No bar"
    result = None
    for item in items:
        result = process_item(item, bar)
        if result is not None:
            return result
    if result is None:
        return default
    return result
```

Let's look at the bit of code past the end of the loop again. We know
that `result` _has_ to be `None` if it reaches there. It's initialized
to <span class="title-ref">None</span> and the loop returns early if
it's ever not <span class="title-ref">None</span>. So why do we even
check whether `result is None` anymore? We can simply always return
`default`:

```python
def process_items(items, bar, default):
    if bar is None:
        return "No bar"
    result = None
    for item in items:
        result = process_item(item, bar)
        if result is not None:
            return result
    return default
```

We have no more business setting `result` to `None` before the loop
starts. It's a local variable within the loop body now:

```python
def process_items(items, bar, default):
    if bar is None:
        return "No bar"
    for item in items:
        result = process_item(item, bar)
        if result is not None:
            return result
    return default
```

# In review

Let's look at where we started and ended.

We started with this:

```python
def process_items(items, bar, default):
    result = None
    if bar is not None:
        for item in items:
            if item.match == "A":
                result = item.payload
            elif item.match == "B":
                continue
            else:
                if item.other == "C":
                    result = item.override
                else:
                    result = bar
            if result is not None:
                break
    else:
        result = "No bar"
    if result is None:
        result = default
    return result
```

And we ended with this:

```python
def process_items(items, bar, default):
    if bar is None:
        return "No bar"
    for item in items:
        result = process_item(item, bar)
        if result is not None:
            return result
    return default

def process_item(item, bar):
    if item.match == "B":
        return None
    if item.match == "A":
        return item.payload
    if item.other == "C":
        return item.override
    return bar
```

The second version is much easier to follow, I think. (it's also a few
lines less code, but that's not that important.)

# In defense of single-use functions

So we created a `process_item` function even though we only use it in
one place. Earlier asked why you would do such a thing. What benefits
does that have?

- We could convert the function to use guard clauses, removing a level
  of nesting and letting us come up with followup refactoring steps that
  simplified our code.
- It's clearer to see what actually really matters in the loop and what
  doesn't, as it's spelled out in the parameters of the function.
- We gave what happens in the `for` loop a name. `process_item` doesn't
  say much in this case, but in a real-world code base your function
  name can help you read your code more easily.
- Maybe we'll end up reusing it after all!

It also can lead to interesting future refactorings as it's easier to
see patterns. If you do OOP for instance, you may end up with a group of
functions that all share the same set of arguments and this would
suggest creating a class with methods. But let's leave OOP be and
consider `None`.

# A possible followup refactoring

We know `bar` cannot be `None` when `process_item` is called -- see our
guard clause. If we know (or find a way to guarantee) that
`item.payload` and `item.override` can never be `None` either, we can do
this:

```python
def process_items(items, bar, default):
    if bar is None:
        return "No bar"
    for item in items:
        if item.match != "B":
            return process_item(item, bar)
    return default

def process_item(item, bar):
    if item.match == "A":
        return item.payload
    if item.other == "C":
        return item.override
    return bar
```

Which then leads to the question whether we should filter `items` with
`item.match != "B"` before they even reach
<span class="title-ref">process_items</span> in the first case --
another potential refactoring.

All of these refactorings require knowledge of what's impossible in the
code and the data -- its invariants. We don't know this in this
contrived example. But in a real code base, you can find out. A static
type system can help make these invariants explicit, but that doesn't
mean that in a dynamically typed language we should forget about them.

Yes, I'm saying the same as what I said about `None` before -- whether
something is nullable is an important example of an invariant.

# Conclusion

It's sometimes claimed that not only should a function have a single
entry point, but that it should also have a single exit. One could argue
such from sense of mathematical purity. But unless you work in a
programming language that combines mathematical purity with convenience
(compile-time checked match expressions help), that point seems moot to
me. Many of us do not. (and no, we can't easily switch either.)

Another argument for single exit points comes from languages like C,
where you have to free memory you allocated in the end before you exit a
function, and you want to have a single place where you do the cleanup.
But again that's irrelevant to many of us that use languages with
automated garbage collection.

I've hope to have shown to you that for many of us, in many languages,
multiple exit points can make code a lot more clear. It helps to expose
invariants and potential invariants, which can then lead to followup
refactorings.

P.S. If you like this content, consider following
[@faassen](https://twitter.com/faassen) on Twitter. That's me! Besides
many other things, I sometimes talk about code there too.
