+++
title = "The Story of None: Part 1 - The Beginning"
date = 2013-01-29
slug = "none_01_the_beginning"

[taxonomies]
tags = ["python", "patterns", "pythonic", "planetpython"]
+++

# The Story of None: Part 1 - The Beginning

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)

## Introduction

I'm going to be talking about `None` in a series of short articles. It
is intended for less experienced developers. We're going to talk about
some basic patterns that can clean up your code. Welcome!

If you're an experienced developer what I'm going to say is probably
obvious to you. Nothing I'm going to say is particularly new or
innovative, so this series of articles is probably not for you. But feel
free to follow along and comment anyway!

While I'll focus on Python as an example language, most of this stuff is
also applicable to many other programming languages as well. So if you
use, say, JavaScript, don't go away, this may be useful to you too!
Python is pretty easy to read so you should be able to follow along.

## `None`

What is `None`? Python has a special value called `None`. `None` in
Python is the standard
[sentinel](http://c2.com/cgi/wiki?SentinelPattern), though of course
other objects could also be used (and sometimes are). Other languages
use `NULL` or `null` or `nil`; JavaScript confusingly has _two_ values
along these lines, `null` and `undefined`.

So what do we use `None` for? It turns out that when we have some value
(attribute, return value, function argument), in many cases we want to
be able to signal that the value is not there at all. In other words,
the value is _maybe_ there, and maybe not. To signal this we typically
use `None` in Python.

If `None` is a possible value, it becomes important to make sure you
handle the `None` case. Handling `None` is what this is all about.

## Examples

Let's get a bit more concrete and give some simple examples of where
`None` may come in.

A form in a user interface (for instance a web form) could have some
fields that are not required to be filled in by the user. These empty
fields can be represented as `None` by the application.

`None` is also often the default fallback value when no value can be
found: the `get` method on the Python dictionary has such behavior.

Some functions have optional arguments. If they are not given, the value
is some default. Often `None` is used for this default. The function's
implementation can then detect this and deal with it accordingly.

## A detailed example

Let's look at an example in more detail. This is a validation function:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

The idea is that the function passes silently if the arguments
(`start_date` and `end_date`) are valid, but will fail with a
`ValidationError` if not.

If `start_date` and `end_date` may be omitted (for instance in a user
interface), this omission can be represented as `None`. In this case,
the function may be called with either two dates as arguments, or `None`
in either one or both of them.

But if the arguments can be `None`, the implementation of this
validation function is buggy, because we've neglected to consider the
`None` case for the arguments. If one of the arguments is `None` we'll
see this:

    TypeError: can't compare datetime.date to NoneType

That's not what we want!

So [next](@/posts/none_02_recognizing.md) we
will talk about how to recognize `None` properly in the first place.

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)
