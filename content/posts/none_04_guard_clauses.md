+++
title = "The Story of None: Part 4 - Guard Clauses"
date = 2013-02-01
slug = "none_04_guard_clauses"

[taxonomies]
tags = ["python", "programming", "pythonic", "planetpython"]
+++

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)

## Last time...

[Last time](@/posts/none_03_handling.md) in the
Story of None we ended up with this validation function:

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

So let's apply some boolean logic and rewrite all this to be slightly
shorter (but still readable):

```python
def validate_end_date_later_than_start(start_date, end_date):
    if start_date is None or end_date is None:
        return
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

## Guard Clauses

What we've written above with the `if ... return` statement is a [guard
clause](http://c2.com/cgi/wiki?GuardClaus): a check at the beginning of
a function that returns early from the function if the condition is
true.

Instead we could have written the function without guard clauses, like
this:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if start_date is not None and end_date is not None:
        if end_date <= start_date:
            raise ValidationError(
                "The end date should be later than the start date.")
```

or like this:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if (start_date is not None and
        end_date is not None and
        end_date <= start_date):
            raise ValidationError(
                "The end date should be later than the start date.")
```

I think both alternatives are a lot less clear than the one with the
guard clause in it.

With a function it's better if the main thing that it is doing, in this
case comparing `end_date` with `start_date`, is also the main unindented
block. This makes the function easier to read. If you make the main
behavior of the function be inside some other `if` clause, it becomes
slightly harder to read.

The second alternative doesn't create this second level of indentation,
but still makes the comparison between start and end date rather hidden
among the `is not None` clauses. This makes the expression a bit harder
to think about compared to the version of the function that uses the
guard clause.

## Guard and Stop Worrying

The great advantage of a guard clause is that you can _forget_ about the
stuff you're guarding against in the code you write after the guard
clause. So once we have passed the guards, we can entirely stop worrying
about `start_date` or `end_date` being `None`; we've already guarded
against those cases and handled them.

This is great! We can compare `start_date` and `end_date` freely. We can
call methods on `start_date` and `end_date` safely. We can pass
`start_date` and `end_date` to other functions and _they_ don't need to
worry about them being `None` either, unless of course such functions
can be called from somewhere else where it could be `None`.

We worry about `None` so we can _stop_ worrying about `None` when it
matters. Ah, such a relief! Thank you guard clauses!

We'll talk a bit more about guard clauses
[next](@/posts/none_05_more_on_guarding.md).

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)

## Preserved Comments

### Brutus_dmc

> What about try/except? Something like this:

```python
def validate_end_date_later_than_start(start_date, end_date):
  try:
    if end_date <= start_date:
      raise ValidationError(
        "The end date should be later than the start date."
      )
  except TypeError:
    if start_date is not None and end_date is not None:
      raise
```

### Martijn Faassen

> I wouldn't do it this way either. You have to go through extra work in the
> catch handler to make sure it's not some _other_ TypeError you are dealing
> with (of course with this particular logic that's less likely, but a real
> problem in other cases). I find the logic much harder to understand too.
> Compare a date, if there's a TypeError, then check whether the start_date and
> the end_date are not-None, then raise the error again?

> Plus this only works for guard clauses that raise exceptions. What do you do
> when a return value is in play?
