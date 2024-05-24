+++
title = "The Story of None: Part 2 - Recognizing It"
date = 2013-01-30
slug = "none_02_recognizing"

[taxonomies]
tags = ["python", "patterns", "pythonic", "planetpython"]
+++

# The Story of None: Part 2 - Recognizing It

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)

## Last time...

In [part 1](@/posts/none_01_the_beginning.md) of the Story of None we've seen
this validation function:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

We've decided that `start_date` or `end_date` may be omitted (and be
`None`), and that this function is therefore buggy: we'll get a
`TypeError` if it's called with `None` as one of the arguments and a
date with the other.

## A type check?

One reaction to a `TypeError` is to do a type check to see whether the
values are really of the right types, in this case, `date`, and to only
proceed if they are. Something like:

```python
if type(start_date) == date:
    ...
```

or:

```python
if isinstance(start_date, date):
    ...
```

This works, but I think this signals the wrong thing to the reader of
the code.

The reader may start wondering whether there are code paths that
generate a `start_date` that is not a `date` but something else; we seem
to be guarding against a set of other possibilities. But in reality
we're only guarding against one possibility: `None`.

It is a bit of cognitive load for the developer to consider `None` is
what we're really checking for, and that `type(None)` is `NoneType` and
that this isn't equal to the `date` type. It's not right to make a
developer think about stuff they don't have to think about.

Let's instead be specific, and just handle `None`, and avoid type
checking.

## `if value`?

So we want to make sure that `start_date` and `end_date` are present.
That something is _there_. It's now very tempting to check for their
presence with a clause like this:

```python
if start_date:
    ...
```

This again will work, at least in this particular case, where the
arguments are dates.

But it won't work for other things, like a function where the arguments
are numbers.

Why won't it work for numbers? Because `0` in Python evaluates to
`False`. And the number `0` doesn't mean that the number is omitted. So
if we were, for example, comparing `start_age` and `end_age`, where the
ages are integer numbers, we'd be in trouble if we did something like
this:

```python
if end_age and start_age and end_age >= start_age:
    raise ValidationError("End age should come before start age")
```

`end_age` could be `0`, and `0` would definitely come before a
`start_age` of say, `10`, and we still don't raise `ValidationError`. A
bug!

We want to reduce the burden on the developer who has to reason about
this code, if we can, we should use a pattern that works for _any_ case
where `None` can be a value. Doing so will make our code be more regular
and easier to understand.

So when we can, we should explicitly compare with `None`.

## `value == None`?

Don't use `== None` either. It _will_ work but it'll be a tiny bit
slower and it's not the Pythonic convention. Plus if the `__eq__`
operator is overloaded it may dive into that, which is what you don't
really want.

Follow the convention so that other programmers will be able to read
your code more easily. In Python you compare for equality with `==` but
for identity with `is`. I won't go into the details of identity versus
equality here. Instead I'll say that you can always safely do an
identity comparison with `None`.

## `value is None`

So how do you compare with `None` in Python? You use:

    value is None

and if you want to check whether something is not `None` the idiom is:

    value is not None

In JavaScript by the way the idiom is `value === null` and
`value !== null`, as triple comparison is identity comparison in
JavaScript.

[Next time](@/posts/none_03_handling.md)
we'll apply this approach to our validation function.

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)
