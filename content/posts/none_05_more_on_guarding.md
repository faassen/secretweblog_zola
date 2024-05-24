+++
title = "The Story of None: Part 5 - More on Guarding"
date = 2013-02-04
slug = "none_05_more_on_guarding"

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

[Last time](@/posts/none_04_guard_clauses.md)
in the Story of None we've discussed the concept of a _guard clause_.
This is simply an `if` statement at the beginning of a function that
returns early if a certain condition is true.

The guard clause pattern is applicable to more than just the `None`
scenario. We could be writing a function where we need a specific
treatment if an integer value is `0`, for instance. A guard clause often
does more than just a bare boned `return`. Instead, it could return a
value or raise an exception.

So let's discuss some other brief examples of guard clauses.

## Raising exceptions

Raising an exception is good when the input really should be considered
an error and the developer should know about it:

```python
  def divide(a, b):
      if b == 0:
          raise ZeroDivisionError("Really I don't know, man!")
      return a / b
```

In this case you know that the way to handle `b` being `0` is to _not_
handle it and instead to loudly complain that there is some error, by
raising an exception.

Complaining loudly is important: it is tempting to make up some return
value and let the code proceed. We'll go into this in more detail later
on.

## Dictionary `.get` guard clause

Let's say we want to implement dictionary `.get` as a function
ourselves, with a guard against a missing dictionary key:

```python
def get(d, key, default=None):
    if key not in d:
        return default
    return d[key]
```

This guard clause returns a default value if the guard clause condition
is true. As you can see here the guard clause can be dependent on
multiple arguments, in this case `d` and `key`; if the function in
question is a method, it can be dependent on object state as well.

Complain loudly for possible input that you cannot handle; it makes
debugging easier.

## Guard clauses in recursion

Guard clauses often occur in
[recursive](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29)
functions, where they guard against the _stopping criterion_.

Let's consider this rather contrived (as there are much better
implementations without recursion in Python) example where we
recursively add all numbers in a list:

```python
def add(numbers):
    if len(numbers) == 0:
        return 0
    return numbers[0] + add(numbers[1:])
```

The main part of the function says: the sum of all the numbers in a list
`numbers` is the first entry in that list added to the sum of the rest
of the entries in the list.

But what if the list of numbers is empty? We cannot obtain the first
entry in that case, so we need some kind of guard clause to handle this.
We know that the resulting sum of an empty list should be `0`, so we can
simply return this. This is also the stopping criterion for the
recursion, because we cannot recurse further into an empty list.

## Don't be paranoid

Don't overdo it, and put in guard clauses that guard against cases where
you don't actually _know_ they can happen, or where you don't know how
to _handle_ them. Guard against _exceptional_ forms of _expected_ input,
not against input that is _unexpected altogether_. Guarding against the
expected is sensible, but guarding against the unexpected is paranoia.

So, in the case of `None`, we don't want to clutter our code with lots
of guard clauses just to make sure that the input wasn't `None` if we
don't even know that the input can be `None` in the first place.

Python tends to do the right thing in the face of the unexpected: its
core operations tends to fail early with an exception if asked to do
something which they cannot handle: dividing by zero, comparing a date
with None, getting a non-existent key from a dictionary. Rely on this
behavior, be happy Python is eager to tell you something is wrong, and
avoid clutter in your code.

Other languages like JavaScript instead of failing sometimes continue
even in the face of the unexpected: they let you add a string to a
number, and if a property is missing you don't get an exception but a
value `undefined`. This makes JavaScript in my experience harder to
debug than Python. But I still don't clutter my JavaScript code with all
kinds of paranoid guard clauses, because I _still_ don't expect these
cases, and I don't want to clutter up my code.

In statically typed programming languages such as Java you have to
specify exactly what type of input arguments to expect, and the system
will fail loudly if you do something that isn't expected. Languages like
that are a bit paranoid by nature and you'll have to follow their rules.
What they do in the case of failure is correct: fail loudly as early as
possible. In dynamically typed languages such as Python or JavaScript
you don't specify types for the sake of less cluttered, more generic
code.

## If you feel paranoid

We all feel paranoid sometimes. Sometimes we think we need to handle
some type of input. If you feel inclined to handle something but aren't
sure what to do, here is a list of things to consider:

- Don't return from the function early. This is the worst thing you can
  do.

  If you handle an unexpected value by returning something you make up,
  you really are creating a bug. Made-up data is now propagating further
  through the codebase. You either end up with an exception deeper down
  in call chain where it becomes harder to debug, or you end up with
  something worse: a seemingly functional program which delivers bogus
  data.

  You may think you can avoid returning something made-up by using a
  plain `return` statement. But if you do that in case of a function
  that really needs to return a result, you are implicitly returning
  `None` (in Python) or `undefined` (in JavaScript). This is the same as
  returning made-up value: this value will likely be used later on, and
  you'll either get a harder to debug error later on, or bogus results.

  It might seem like we did such a plain return in case of the date
  validation function; we got a `None` and we handled it by returning
  early.

  But in the case of the date validation function, `None` was according
  to our requirements _expected_ input, just an _exceptional_ case where
  the normal case was date input. And a validation function like this
  has no return value at all, and can stop validating right away as soon
  as the input is judged valid, so returning early is fine.

- Don't overuse `print` statements.

  You could use a print statement to print out arguments, so you can see
  whether they are unexpected by reading the output.

  Using `print` is a totally legitimate debugging strategy, but make
  sure the print is removed from your code after you're done debugging!

  You don't want to clutter up your code with a lot of print statements.
  You'll get a _lot_ of output that will be hard to understand.

  While print is quick and appropriate sometimes, do consider learning a
  debugger tool for your language as it can help a lot for more complex
  cases. For Python the built-in debugger is `pdb` for instance.

- Don't log everything.

  Logging for debugging purposes is the advanced form of using `print`
  statements. At least it doesn't clutter the standard output. But
  logging is still clutter in the code. And if you fill log files with a
  lot of debugging information, it will still be hard to find out
  whether, if anything, is really wrong.

  Logging is very useful, but I prefer logging to be
  application-appropriate, not to help debug the program flow. If I want
  to debug program flow I use a debugger or a bunch of throw-away print
  statements.

  Of course there are exceptions to this rule; you might for instance
  want to log debugging information if a bug is hard to find and turns
  up in production. But use it in moderation, only when necessary.

- Don't print or log and _then_ return early with a made up value.

  You can print or log some diagnostic information (the value of
  arguments, say) and then return early with a made-up value.

  The impulse to want to get diagnostics is correct. The impulse to stop
  going further is _also_ correct. But returning with a made-up value is
  still _wrong_ -- and you aren't really stopping your program anyway.

  If you return with a made-up value, your program will continue and
  will likely log some more information. But since you've returned a
  made-up value, everything logged after this case is nonsense; there's
  no point in continuing.

  You could instead print diagnostics and do an early exit (`sys.exit()`
  in Python). Instead, if your language lets you do it, just throw an
  exception.

- Throw an exception.

  If you feel you need to handle an unexpected case, throw an exception.
  In Python you can throw a basic exception like this:

  ```python
  if value == 0:
    raise Exception("Something went wrong")
  ```

  But of course it makes sense to use more specific exceptions when you
  can:

  ```python
  if not isinstance(value, basestring):
      raise TypeError("Expected string, not %r" % value)
  ```

  Sometimes you need to make up new exceptions specific to your library
  or application as none of the built-in ones is appropriate:

  ```python
  class WorkflowError(Exception):
    pass

  # ...

  if invalid(workflow_state):
      raise WorkflowError("Invalid workflow state: %s" % workflow_state)
  ```

  Exceptions do the right stuff automatically:

  - bail out early when you can't handle something.
  - give diagnostic information in the form of a message and a traceback
    of the function call chain.
  - allow you to handle them after all if you want.

- Do nothing.

  Doing nothing is often the right impulse.

  In the case of unexpected input, I can often rely on the language to
  fail with an exception anyway in the appropriate spot.

[Next time](@/posts/none_06_avoiding_it.md)
we'll consider a way to avoid having to scatter guard clauses throughout
our codebase: normalization.

[part 1](@/posts/none_01_the_beginning.md)
[part 2](@/posts/none_02_recognizing.md)
[part 3](@/posts/none_03_handling.md)
[part 4](@/posts/none_04_guard_clauses.md)
[part 5](@/posts/none_05_more_on_guarding.md)
[part 6](@/posts/none_06_avoiding_it.md)
