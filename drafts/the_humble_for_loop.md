
+++
title = "The Humble For Loop"
date = 2024-12-10
slug = "humble-for-loop"
description = "Sometimes the humble for loop is what you want"

[taxonomies]
tags = ["programming", "javascript", "rust"]

[extra]
mastodon_comment_id = 113527996081665381
+++

I've seen some programmers try to avoid the humble `for` loop at all costs, in
favor of more functional abstractions. I'm going to argue that the `for` loop
is sometimes simply the best option. That doesn't mean you should always use it
-- far from it -- but it does mean you should give it due consideration.

## JavaScript

Let's start with JavaScript.

### Map

Functional programming patterns have been in vogue in the JavaScript world for
a long time. And for good reason, as:

```javascript
let result = [];
for (let entry of list) {
    result.push(transform(entry));
}
```

where we say we want to make a new array where each entry has been transformed
using the `transform` function, is more involved and less declarative than:

```javascript
let result = list.map(transform)
```

where we say the same.

### Reduce

But then we get to `reduce`. `reduce`, if you're not familiar with it, takes in
some collection of things and condenses it down to something else. Summing all
the numbers in a list can be implemented as `reduce`:

```javascript
let sum  = list.reduce((total, current) => total + current, 0);
```

This says "in order to get the sum, we add the total of everything else in the
list to the value of the current item".

Reduce is cool, reduce is very functional, but reduce in JavaScript isn't the
best fit for all patterns. Consider this one:

```javascript
let flat = list_of_lists.reduce((accumulator, list) => [...accumulator, ...list], []);
```

This flattens a list of lists into a single list. So, `[[1, 2, 3], [4, "five",
6], [7]]` becomes `[1, 2, 3, 4, "five", "6, 7]`. [^1]

Let's compare it with the `for` loop:

```javascript
let flat = [];
for (let entry of list) {
	flat.push(...entry);
}
```

Which one is easier to understand depends on what you're used to. For me, and I
think for a lot of developers, it varies. Sometimes it's the functional
pattern, sometimes it's the `for` loop. In this example, I find the `for` loop
easier to comprehend. I'd say that most people would find the comprehensibility
of the `for` loop version to be at least equal to that of the `reduce` version.

But what's more important is that the `for` loop version is more efficient. In
my experiment the loop version was about 200 times faster on a large list of
about 10,000 entries. The implementation with reduce constructs arrays all over
the place, whereas the `for` loop version modifies the accumulator in-place.
For small lists all that doesn't matter much, but if you expect larger lists,
it's going to matter in both processing time and memory usage. And even with
very small lists the `for` loop version is still faster.

You could cheat in the reduce version and modify the accumulator in place:

```javascript
let flat = list_of_lists.reduce((accumulator, list) => {
    accumulator.push(...list);
    return accumulator;
}, []);
```

This code is indeed about the same performance as the `for` loop, but it
destroys the "but this code is declarative" argument. It becomes more difficult
to understand what's going on. Mutating the argument could in fact risk
breaking the algorithm, and reasoning about that takes mental effort I don't
want to be spending. So, the `for` loop is a clear winner over this one from a
readability perspective.

Yet I've run into JavaScript programmers who, insist on using `reduce` as
somehow superior, even though at the same time they struggled with implementing
it, and even though it's less efficient. Maybe functional programming was
considered a [best
practice](https://blog.startifact.com/posts/question-best-practices/).

Use the humble `for` loop!

## Brief Haskell intermission

Now if you have a real proper pure functional programming language like
Haskell, using the reduce approach is perfectly fine. You have things like pure
functional data structures (which can be combined very efficiently, like using
a linked list with a head and a tail), and maybe a sufficiently smart compiler.

But JavaScript is not Haskell. Don't worry and use the humble `for` loop.

## Rust

Excluding languages with entirely different data structures, does this pattern
involving `for` loops versus functional approaches hold up across languages?

Rust requires JavaScript programmers to retune their intuitions, but some
intuitions stand across most programming language.

Rust has a `for` loop. Rust has some very nice functional facilities as well.
They get compiled to highly efficient code.

Rust is a language with low level control so we're going to be more finicky
about benchmarking stuff. [^2]

### Map

Let's consider our simple transform loop first:

```rust
let mut result = Vec::new();
for entry in list {
	result.push(transform(entry));
}
```

It's almost identical to the JavaScript example. `Vec` is an expandable array
in Rust.

The simple loop has pretty decent performance, but this is actually faster, by
about 30%:

```rust
let mut result = Vec::with_capacity(list.len());
for entry in list {
	result.push(transform(entry));
}
```

When the `result` vector grows, it may need to reallocate. Here we avoid
reallocations by giving it the final amount right away; we know it's going to
be identical in length to the input list.

But `map` is a lot faster. On a loop of 10000 integers it's 6 times
faster on my machine!

```rust
let result: Vec<i32> = list.into_iter().map(transform).collect()
```

A few explanations are in order:

* `into_iter()` turns the original vector into an iterator. The `for` loop uses
  it too, but implicitly.

* `map()` does not return a vector, unlike in Javascript where it produces an
  array. Instead it returns an iterator (that has the mapping operation
  built-in).

* `collect()` takes an iterator and turns it back into a vector.

Why is `map` so much faster? I am not sure. I suspect with the `map` option the
Rust compiler figures out it can avoid allocations altogether by simply writing
over the original vector, while with the loop it can't. I tried to look in the
[compiler explorer](https://godbolt.org/z/fKEPaTdTv) but I'm not competent
enough yet to figure it out. Maybe someone else can confirm my suspicion!

This is a great argument to use functional programming patterns when they're
simple!

### Reduce

Okay, so `map` is good and we should use it when we can. Does this mean that
with Rust we should use `reduce` rather than a `for` loop too, unlike in
JavaScript?

Let's look at flatten. Here's the simple `for` loop:

```rust
let mut flat = Vec::new();
for entry in list_of_lists {
    flat.extend(entry);
}
```

`extend()` a way to push a whole lot of items at once, like we have in Python.

Note that we can't really do much with capacity as we don't know the total length of the
flattened list in advance, so we don't bother.

Here's the `reduce` version closest to the one we used in JavaScript:

```rust
let flat = list_of_lists.into_iter().fold(Vec::new(), |accumulator, list| [accumulator, list].concat());
```

Let's pick this one apart: 

* We use `fold()`. Rust does have a `reduce()` but `fold` is the closest
  equivalent to JavaScript `reduce`. It doesn't matter much in performance.

* `|accumulator, list| ...` is a closure, a function we pass in much like we do
  in JS.

* `[accumulator, list].concat()` is a way to add two vectors together to create
  a new vector.

The simple `for` loop is about 100 times faster for this approach (for a list
of 50,000 items after flattening).

A Rust developer might object. This approach is terrible! It allocates memory
all over the place, no wonder it's slower. It's just like we saw in JavaScript.

But in Rust we can avoid instantiating vectors all over place. Let's try this on the
iterator level:

```rust
let flat = list_of_lists.into_iter().fold(Vec::new(), |accumulator, list| {
    accumulator.into_iter().chain(list).collect()
});
```

What's going on here? We use `.chain()` to combine the `accumulator` iterator with the
`list` iterator.

Does this help? Not really -- it's faster than the `concat` version by only 20%
or so; not even close to the `for` loop. I suspect that constructing all those
iterators is very costly too.

Surprisingly enough even the declarative `flatten` approach is not as fast as the `for` loop
for my 

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
it's necessarily faster (it may well be for your purposes; measure!).







In Rust the balance gets more complicated. Rust has a very nice system for returning error values. Let's say you have
a for loop like this:

```rust
struct Error;

fn transform(entry: Entry) -> Result<Transformed, Error> {
	// do stuff to create a Transformed from Entry
}

fn transform_list(list: Vec<Entry>) -> Result<Vec<Transformed>, Error> {
	let mut new_list = Vec::with_capacity(list.len());
	for entry in list {
		new_list.push(transform(entry)?)
	}
	new_list
}
```

We can see that the `transform` function returns a `Result`, which is either a `Transformed` object (success!) or
or a failure (some object describing the error).

Since transform is fallible, `transform_list` is also fallible and thus needs to return `Result` too. We either get a list that was
successfully transformed, or an error. As soon as we have an error, we want to bail out with it. That's what the `?` operator
after `transform(entry)?` does; it is equivalent to an if statement that checks whether the value evaluated
is an error, and if so, it immediately bails out of the function with a return using the error value.

So what's the `with_capacity` for? It's to make things more efficient - we know that `new_list` is 
going to be the same size as `list`, we don't want to have to reallocate stuff as the vector grows,
so we allocate the right amount from the start.

But we can write this more efficiently using `map`:

```rust
fn transform_list(list: Vec<Entry>) -> Result<Vec<Transformed>, Error> {
   list.iter().map(transform).collect()
}
```

This is functionally equivalent to the above, believe it or not. First we turn the list
into an iterator, so we can iterate through all the values in it. Then we use the `functional` map
with the `transform` function. Then we collect it back into a vector. Normally that would be a `Vec<Result<Transformed>, Error>`; a 
list of results - either values or error objects. But since we have declared the return
value of the function to be `Result<Vec<Transformed>, Error>` a *different* `collect` is
selected that short-circuits and bails out with an error as soon as the first one is found, just
like in the for loop.

And what about `with_capacity`? We don't need it, because the implementation is smart enough to
ask the iterator whether it has a size hint for that, and since it's based on a vector with a known
length, it has one.

So we get a lot of cleverness for free. So should you always use functional patterns in Rust, and
never use the humble for loop? Not at all. We have already seen the reduce example. Some things are just difficult to capture in an
efficient declarative, functional pattern. For loops have `break`. You can `return` from the middle of a for loop too.
Complex error handling is expressed with a little `?`. I could scratch my head a lot, look through
a vast catalog of iteration possibilities (itertools), but it will get more complicated, and your mathematical
reasoning abilities will be stretched, and while there is definitely a time and place for it, in many 
cases the trade-offs for both the writer and reader of the code go back to the humble `for` loop.

[^1]:

Yes, I know
[`flat`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flat)
exists, but not everything that involves constructing a structure does, so I'm
using it as an example.

[^2]:
 
I've used simple `i32` integers for all experiments, and your performance
*will* be different with different data types. Your results will vary depending
on what you're looping through and what you're producing. Simple integers are
the simplest for machines to handle.

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

When you try `flat_map(|list| list)` the Rust linter (clippy) springs into action
suggesting you use `flatten()` instead. Bizarrely enough the `flat_map` approach 
on this simple benchmark is actually %30 *faster*.

