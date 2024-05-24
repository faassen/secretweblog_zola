+++
title = "The Story of None: Part 6 - Avoiding It"
date = 2013-02-06
slug = "none_06_avoiding_it"

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

[Last
time](@/posts/none_05_more_on_guarding.md)
we've discussed guard clauses and when not to use them. We've discussed
the paranoia developers sometimes feel that causes them to write useless
or even harmful guard clauses. The best way to reduce paranoia about
`None` is to make sure it can't be there in the first place.

So let's talk about ways to accomplish this.

## Date Validator Redux

The date validator in its last incarnation looked like this:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if start_date is None or end_date is None:
        return
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

Here we want to validate two date values which may be missing, in which
case we treat `start_date` as "indefinite past" and `end_date` as
"indefinite future".

We could create special sentinel objects for "indefinite future" and
"indefinite past":

```python
INDEFINITE_PAST = date(datetime.MINYEAR, 1, 1)
INDEFINITE_FUTURE = date(datetime.MAXYEAR, 12, 31)
```

where `MINYEAR` is `1` and `MAXYEAR` is `9999`.

(Too bad datetime doesn't allow negative dates, or we could've used
[Bishop Ussher's date](http://en.wikipedia.org/wiki/Ussher_chronology)
for the creation of the universe, `date(-4004, 10, 23)`. Though that's
in the proleptic Julian calendar, and I don't care to know what that is
right now. Plus it's bogus. But it'd be amusing.)

If we can be sure that those are used instead of `None` before the
`validate_end_date_later_than_start` function is called, we can simplify
it to this:

```python
def validate_end_date_later_than_start(start_date, end_date):
    if end_date <= start_date:
        raise ValidationError(
            "The end date should be later than the start date.")
```

which is what we started out with in the first place in [Part 1](@/posts/none_01_the_beginning.md) long
ago, without any guards! Awesome!

## Edge case

This handwaves the edge case where `start_date` and `end_date` are both
equal to `INDEFINITE_PAST` or `INDEFINITE_FUTURE`, which can be argued
should not raise `ValidationError`. In software for a time machine it
might be important to get this right, but in many applications not
handling this edge case is fine.

## Really avoiding the edge cases

If we insist on making the edge case go away, we could deal with it by
subclassing the `date` class to construct these sentinels instead:

```python
class IndefinitePast(date):
    def __lt__(self, other):
        return True

    def __le__(self, other):
        return True

    def __gt__(self, other):
        return False

    def __ge__(self, other):
        return False

class IndefiniteFuture(date):
    def __lt__(self, other):
        return False

    def __le__(self, other):
        return False

    def __gt__(self, other):
        return True

    def __ge__(self, other):
        return True

INDEFINITE_PAST = IndefinitePast(datetime.MINYEAR, 1, 1)
INDEFINITE_FUTURE = IndefiniteFuture(datetime.MAXYEAR, 12, 31)
```

This is a lot more code though, and therefore in many situations this
would be overkill.

(As a puzzle for the reader in this case one could safely skip
implementing `__le__` and `__ge__` for these classes and still have it
all work for any possible date. I kept them in for clarity.)

## Normalization

So what have we done here? We've made sure that our input was
[normalized](https://en.wikipedia.org/wiki/Data_normalization) to a date
before it even reached the validation function. This way we don't have
to worry about our friend `None` when we deal with dates.

The idea is to normalize the input a soon as possible before it reaches
the rest of our codebase, so we can stop worrying about non-normalized
cases (such as `None`) everywhere else. In effect you put the guard
clauses as far on the outside of the calling chain as possible.

In the case of our date input, somewhere in the input processing we'd
call these functions:

```python
def process_start_date(d):
        if d is None:
            return INDEFINITE_PAST
        return d

def process_end_date(d):
        if d is None:
            return INDEFINITE_FUTURE
        return d
```

None of those `None`'s to worry about anymore after that!

## Drawbacks

Normalization also has some potential drawbacks. Here are some that may
apply to this case:

- to understand how empty date fields are treated in the validation
  function, we need to read normalization code that may be somewhere
  else. Our validation function that worried about None was all in one
  place.
- it's more code to understand and maintain, especially with the custom
  date subclasses.
- normalization of `None` to a date may be nice during validation, but
  it may not be what we want to store in a database; we might want to
  store None there. If we have this requirement we'd need two code
  paths: one for storage and one for validation.

It all depends on the exact details of your project. If the project is
going to compare a lot of dates in many places, it makes sense to
normalize missing values to proper dates as soon as possible, and it's a
much better approach than having to worry about `None` everywhere. But
if the project only needs a single validation rule that can handle
missing dates, then it makes more sense to write one that deals with
`None` directly.

## Conclusion

This concludes the Story of None! I hope you've enjoyed it! Perhaps
you've learned something.

Let me know if you would like to see more stuff like this -discussions
of fairly low-level patterns that happen during development.

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)
