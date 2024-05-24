+++
title = "The Story of None: Part 3 - Handling It"
date = 2013-01-31
slug = "none_03_handling_it"

[taxonomies]
tags = ["python", "patterns", "pythonic", "planetpython"]
+++

# The Story of None: Part 3 - Handling It

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)

## Last time...

In [part 1](@/posts/none_01_the_beginning.md) of the Story of None we've seen this validation function:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

We've determined `start_date` and `end_date` may be `None`. In [part
2](@/posts/none_02_recognizing.md) we've seen that we can recognize this case by using `is None` or
`is not None`.

So:

- we _should_ consider whether `None` is possibility.
- we should use `value is None` or `value is not None` to check.

Once we know that we're not out of the woods yet though: we still need
to decide what to _do_ when either of the arguments is `None`. This will
need to be thought about and depends on the circumstances.

## Requirements

So what would make sense in this case? If either `start_date` or
`end_date` are `None`, does it make sense to validate this at all? What
does an omitted `date` mean in this case? This depends on the
application's requirements.

For the sake of the example I will make up a few simple requirements
here:

- Let's say that in this application the start and end dates define a
  period when a product is on the market.
- If a `start_date` is `None`, we don't have a start date, and we'll
  interpret this as _as far as we know now, the product has been in the
  market from the indefinite past, until the end date_.
- If an end date is `None`, we interpret this as _as as we know now, the
  product will be on the market from the start date until the indefinite
  future_.
- If both are `None`, we assume the product has been on the market from
  the indefinite past to the indefinite future.

Something like that. The specification doesn't have to be perfect and it
often won't be. If it isn't clear it'll be your job to find out what it
should be, generally by asking someone (and perhaps giving them a few
suggestions).

## `start_date is None`

Given these requirements, how would we handle `None` for `start_date`?
If the `start_date` is in the indefinite past, we don't have to check
whether `end_date` is earlier than it, because we'll say the indefinite
past is _always_ earlier. (If you're not sure about this, ask someone,
but in this case we are sure as we make it up ourselves.)

Let's express that in code:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if start_date is None:
        return
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

## `end_date is None`

If `end_date` is `None`, it's in the indefinite future. `start_date` can
not be later than a date in the indefinite future, so we don't need to
check then either. Let's express this in code too:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if start_date is None:
        return
    if end_date is None:
        return
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

## `start_date is None and end_date is None`

Now what if both `end_date` and `start_date` are `None`? A date in the
indefinite past is always earlier than the indefinite future, so we're
safe too and don't need to compare dates either. We can express this in
code too:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if start_date is None and end_date is None:
        return
    if start_date is None:
        return
    if end_date is None:
        return
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

It turns out the last bit was superfluous as turn out to handle this
case correctly already anyway. That's fine and will often be the case,
but not _always_ so we do need to briefly think about this case before
we stop worrying about it.

[Next time](@/posts/none_04_guard_clauses.md)
we'll talk about what this pattern really is.

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)
