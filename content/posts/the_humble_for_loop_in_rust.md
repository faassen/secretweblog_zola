
+++
title = "The Humble For Loop in Rust"
date = 2024-12-11T16:05:00
slug = "humble-for-loop-rust"

[taxonomies]
tags = ["programming", "rust"]

[extra]
mastodon_comment_id = 113634857942755008
+++

Rust has some really nice functional programming facilities built in, all
around an iterator concept. Rust being focused on performance and low level
control makes it possible to use this without paying a performance cost.
Sometimes I still prefer to use the humble `for` loop though. In quite a few
cases, it combines high performance with high readability. I thought I'd
motivate why. 

<!-- more -->

I've written previously (um, well, _today_) about [the humble `for` loop in
JavaScript](@/posts/the_humble_for_loop_in_javascript.md), and I think
heuristics involved carry across languages that have collection data structures
like vectors and hashmaps (JavaScript arrays, object/HashMap, Python lists and
dictionaries). Let's see how this works out in Rust. But even if you're not an
expert in Rust you should be able to follow most of it, as I explain Rust
concepts along the way.

This being about Rust, I'm going to give some performance numbers in this
article. The precise details of these numbers don't really matter. They will be
different depending on what data you're working with. For the purposes of this
article, whenever there's merely a percentage difference in performance, that's
relatively unimportant. Where it gets interesting is when I start to talk about
3, 10, or a 100 times faster, as these demonstrate real algorithmic differences
that hold up in many contexts, and therefore can help guide our behavior.

### Map

Let's consider a transform loop first.

```rust
let mut result = Vec::new();
for entry in list {
    result.push(transform(entry));
}
```

It's almost identical to examples you'd see in JavaScript or Python. `Vec` is
an expandable array in Rust, like a JavaScript array or Python list.

The simple loop has good performance, but this is actually faster, by about 30%
for a bunch of i32 numbers [^1]:

```rust
let mut result = Vec::with_capacity(list.len());
for entry in list {
    result.push(transform(entry));
}
```

The way `Vec` works (just like in Python and JS) is that it preallocates space
in advance, so that every `push` does not require a memory reallocation (which
requires copying the data, which is expensive). But since it doesn't know how
big the final array will be, it may not be able to avoid reallocation entirely.

Here we avoid reallocations altogether by giving it the final amount right away
using `with_capacity()`; we know it's going to be identical in length to the
input list.

Now let's look at `map()`. 

```rust
let result: Vec<i32> = list.into_iter().map(transform).collect()
```

A few explanations are in order:

* `into_iter()` turns the original vector into an iterator. The `for` loop uses
  `into_iter()` too, but implicitly.

* `map()` does not return a vector, unlike in Javascript where it produces an
  array. Instead it returns an iterator (that has the mapping operation
  built-in). Calling `map()` does not actually take much time at all as it's
  constructing an iterator, not executing it.

* `collect()` takes an iterator and turns it back into a vector. This is going
  to do the actual work.

I think we can agree that `map()` in Rust is pretty readable. While there are a
few more concepts invovled that you don't need to understand when you use a
`for` loop, these concepts are so fundamental to Rust you're going to have to
learn them anyway. So `.map()` wins in being more declarative.

Surprisingly enough, `map()` can also be a lot faster. On a loop of 10000
integers it's 6 times faster on my machine! 

Why is `map` so much faster? I am not sure. I suspect with the `map()` option
the Rust compiler figures out it can avoid allocations altogether by simply
writing over the original vector, while with the loop it can't. Or maybe it's
using SIMD? I tried to look in the [compiler
explorer](https://godbolt.org/z/fKEPaTdTv) but I'm not competent enough yet to
figure it out. Maybe someone else can explain! [^2]

This is a great argument to use functional programming patterns when they're
simple! More declarative *and* more fast? Let's use it!

### Fold (Reduce)

In JavaScript we saw that a `for` loop for constructing a new collection was
orders of magnitude faster than using `reduce`, but does the same apply to
Rust? After all, `map()` is so good! Does this mean that with Rust we should
use `fold` (which is the equivalent of `reduce` in Rust) rather than a `for`
loop too? 

Let's look at implementing flatten, the example I also used in my JavaScript
post. Here's the simple `for` loop:

```rust
let mut flat = Vec::new();
for entry in list_of_lists {
    flat.extend(entry);
}
```

`extend()` a way to push a whole lot of items at once, like you have in Python.
[^3]

Note that we can't really do much with preallocated capacity here as we don't
know the total length of the flattened list in advance, so we don't bother.

Here's the `fold` version closest to the one we used in JavaScript:

```rust
let flat = list_of_lists.into_iter().fold(Vec::new(), 
  |accumulator, list| [accumulator, list].concat()
);
```

Let's pick this one apart: 

* We use `fold()`. Rust does have a `reduce()` but `fold` is the closest
  equivalent to JavaScript `reduce`. It doesn't matter in performance.

* `|accumulator, list| ...` is a closure, a function we pass in much like we do
  in JS.

* `[accumulator, list].concat()` is a way to add two vectors together to create
  a new vector.

The simple `for` loop is about 180 times faster for this approach (for a list
of 50,000 items after flattening).

If you're a Rust developer, you might object. This approach is terrible! It
allocates memory all over the place, no wonder it's slower.

But in Rust we can avoid instantiating vectors all over place as we have
iterators. Let's try this on the iterator level:

```rust
let flat = list_of_lists.into_iter().fold(Vec::new(), |accumulator, list| {
    accumulator.into_iter().chain(list).collect()
});
```

What's going on here? We use `.chain()` to combine the `accumulator` iterator
with the `list` iterator, and then we collect it.

Does this help? Not really -- it's faster than the `concat` version by only 20%
or so; not even close to the `for` loop.

Whoah, wait. We're still actually constructing vectors all over the place here,
as we collect inside the closure!

Can we avoid this and just create iterators and finally collect them in the end?

```rust
let iter: Box<dyn Iterator<Item = i32>> = Box::new(std::iter::empty());
let flat = list_of_lists.into_iter()
    .fold(iter, |accumulator, list| Box::new(accumulator.chain(list)))
    .collect()
```

Yes we can, but we can already see this is a lot harder to read, and it
actually makes it more than 10 times slower! I'm not entirely sure why -
apparently the overhead of constructing chained iterators and heap allocation
kills performance.

If you're new to Rust, sorry. The `Box<dyn Iterator<Item = i32>>` stuff is to
tell Rust to use dynamic dispatch so I can combine the empty iterator we start
with iterators based on the `chain`. These have different types in Rust and
this is the way to make them go together.

Is there then no declarative way in Rust to express this and still have
performance? I mean, besides `.flatten()` which Rust has as well? We can use 
`flat_map`:

```rust
let flat = list_of_lists.into_iter().flat_map(|list| list).collect()
```

`flat_map` lets you map but also produce structure, which then immediately gets
flattened. This is a lot faster than our `concat` approach, but still 4 times
slower than the `for` loop. [^4]

So the pattern holds: the humble `for` loop, even in Rust, is worth your
consideration. Use `fold()` if it makes your code easier to write, not because
it's necessarily faster.

### Errors and map

It's common in code for an operation to fail and we want to handle such
failures. Instead of using exceptions like many programming languages, Rust has
 a very nice system for propagating error values just like you propagate any
return value. I won't go into the details here, but hopefully you can follow
along.

Let's consider `map()` again, but with errors.

```rust
struct Error;

fn transform(entry: Entry) -> Result<Transformed, Error> {
    // do stuff to create a Transformed from Entry. It might fail
}

fn transform_list(list: Vec<Entry>) -> Result<Vec<Transformed>, Error> {
    let mut result = Vec::with_capacity(list.len());
    for entry in list {
        result.push(transform(entry)?);
    }
    result
}
```

We can see that the `transform` function returns a `Result`, which is either a
`Transformed` object (success!) or or an error (some object describing the
error).

Since transform is fallible, `transform_list` is also fallible and thus needs
to return `Result` too. We either get a list that was successfully transformed,
or an error. 

As soon as we have an error, we want to bail out with it. That's what the `?`
operator after `transform(entry)?` does; it is equivalent to an if statement
that checks whether the value evaluated is an error, and if so, it immediately
returns from the function using the error value.

What does this look like with `map()`?

```rust
fn transform_list(list: Vec<Entry>) -> Result<Vec<Transformed>, Error> {
    list.into_iter().map(transform).collect()
}
```

This is functionally equivalent to the above, believe it or not. First we turn
the list into an iterator, so we can iterate through all the values in it. Then
we use the `functional` map with the `transform` function. Then we collect it
back into a vector. You'd expect that to be `Vec<Result<Transformed>, Error>`;
a list of results - either values or error objects. 

But since we have declared the return value of the function to be
`Result<Vec<Transformed>, Error>` a *different* `collect` is selected that
short-circuits and bails out with an error as soon as the first one is found,
just like in the `for` loop.

And what about `with_capacity`? We don't need it, because the implementation is
smart enough to ask the iterator whether it has a size hint for that, and since
it's based on a vector with a known length, it has one.

So we get a lot of cleverness for free.

## More complex error handling

Again we learn that `map()` is great! Use `map()`! Sometimes however the `for`
loop makes error handling a lot more convenient. Some things are just difficult
to capture in a pattern that's both efficient and declarative. Let's consider a
fallible flatten.

```rust
pub fn fallible_flatten(list_of_lists: Vec<Vec<Result<i32, Error>>>) -> Result<Vec<i32>, Error> {
    let mut flat = Vec::new();
    for entry in list_of_lists {
        for j in entry {
            flat.push(j?);
        }
    }
    Ok(flat)
}
```

We're flattening a list of lists, but each entry in the list may be an error.
If we encounter such an error during flattening, we want to bail out
immediately. We can't use `extend` here but it's pretty straightforward
otherwise. [^5]

How about writing this with `fold`? If we do, the brilliant Rust clippy
immediately suggest we use `try_fold` which is designed for error handling.

```rust
pub fn fallible_flatten_fold(
    list_of_lists: Vec<Vec<Result<i32, Error>>>,
) -> Result<Vec<i32>, Error> {
    list_of_lists
        .into_iter()
        .try_fold(Vec::new(), |accumulator, entry| {
            let mut result = accumulator.clone();
            for j in entry {
                result.push(j?);
            }
            Ok(result)
        })
}
```

If we ignore the performance difference which is inherent to folding over a
collection like this, I'd still argue the `for` loop is easier to read and
write in this scenario.

## Conclusion

It's hard to go wrong with `map()` if what you're doing is transforming a
collection.

But `fold` is a lot more tricky. Does that mean `fold` is useless? Not at all.
I use `fold` in complex scenarios building up structures where a declarative
route really pays off. Sometimes going up a level of abstraction allows you to
do algorithmic improvements that blow even the performance of the `for` loop
completely out of the water. But the humble `for` loop still has a lot of
things going for it.

`for` loops have `break`. You can `return` from the middle of a `for` loop too.
Complex error handling is expressed with a little `?`. 

To avoid `for` I could scratch my head a lot and go through a bigger catalog of
concepts, and stretch my mathematical reasoning abilities. While there is
definitely a time and place for that, in many cases the trade-offs for both the
writer and reader of the code are in favor of the humble `for` loop, in Rust,
as well. Let that inform the heuristics we use as programmers.

## Update

I've published [the project](https://github.com/faassen/flatten-rust) I used to
do these measurements so others can replicate and criticize them.

[@dinskid@mastodon.social](https://mastodon.social/@dinskid) had an interesting
comment that got me thinking again. They asked about this:

```rust
let flat = flatten.into_iter().fold(Vec::new(), |mut accumulator, list| {
    acc.extend(list);
    acc
});
```

This is the same speed as the simple `for` loop. I had originally excluded this
option as I had handled it in my [JavaScript
article](@/posts/the_humble_for_loop_in_javascript.md) as strictly worse: even
though the performance is fine, mutating an argument is difficult to reason
about, and it's not really functional anymore.

I didn't realize however that Rust changes these trade-offs as accumulator is a
moved `Vec` and we *know* it's safe to modify it, as nothing else could
possibly be referencing it. Yay for Rust! And thank you @dinskid@mastodon.social!

I still think the `for` loop is slightly easier to reason about, and it's
somewhat easier to modify for the case of error handling. But there's not much
to say *against* this option either.

[^1]:
 
I've used simple `i32` integers for all experiments, and your performance
*will* be different with different data types. Your results will vary depending
on what you're looping through and what you're producing. Simple integers are
the simplest for machines to handle.

[^2]:

When transforming a `i32` to an `f64` `.map()` is still a lot faster. When
turning `i32` into `String` the performance difference goes away.

[^3]:

Incidentally using `extend` was almost double the speed on my benchmark
compared to an inner loop where stuff is manually pushed in an inner loop. 

```rust
let mut flat = Vec::new();
for entry in list_of_lists {
    for j in entry {
        flat.push(j);
    }
}
```

Still super fast compared to the alternatives, but slower.

[^4]:

When you try `flat_map(|list| list)` the Rust linter (Clippy) springs into action
suggesting you use `flatten()` instead. Bizarrely enough the `flat_map`
approach on this simple benchmark is actually 30% *faster*.

[^5]:

Here's a way to use `extend`:

```rust
let e = entry.into_iter().collect::<Result<Vec<_>, _>>()?;
result.extend(e);
```

I suspect it's not faster as we have to instantiate the vector with `collect()`
in order to filter out errors, but I haven't measured it.