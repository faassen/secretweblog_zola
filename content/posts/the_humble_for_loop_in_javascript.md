
+++
title = "The Humble For Loop in JavaScript"
date = 2024-12-11
slug = "humble-for-loop-js"

[taxonomies]
tags = ["programming", "javascript"]

[extra]
mastodon_comment_id = 113634461555912896

+++

I've seen some programmers try to avoid the humble `for` loop at all costs, in
favor of more functional abstractions. I'm going to argue that the `for` loop
is sometimes simply the best option. That doesn't mean you should always use it
-- far from it -- but it does mean you should give it due consideration. The
goal is to help develop some intuitions about this topic.

I talk about readability of code in this post, but I also talk about
performance. My argument will be that there are cases where the `for` loop
combines readability with performance.

I'm focusing on JavaScript as the example language, but it can stand in for
many languages with similar characteristics like Python and Ruby. But the
culture of JavaScript leans more towards functional programming patterns than
these other languages, so I think it's the appropriate language to highlight.

<!-- more -->

### Map

Functional programming patterns have been in vogue in the JavaScript world for
a long time. And for good reason, as:

```javascript
let result = [];
for (let entry of list) {
    result.push(transform(entry));
}
```

where we say we want to make a new array from an original one where each entry
has been transformed using the `transform` function, is more involved and less
declarative than:

```javascript
let result = list.map(transform)
```

where we express the same. So using `.map()` is cool!

### Reduce

I've run into JavaScript programmers who insist on using functional patterns in
all cases, even though at the same time they struggled with implementing them.
Maybe functional programming was considered a [best
practice](@/posts/question_best_practices.md) by them?
Perhaps being able to figure it out is considered to be a badge of being a good
developer?

Let's look at `reduce`. `.reduce()`, if you're not familiar with it, takes in
some collection of things and condenses it down to something else. Summing all
the numbers in a list can be implemented as `reduce`:

```javascript
let sum  = list.reduce((total, current) => total + current, 0);
```

This says "in order to get the sum, we add the total of everything else in the
list to the value of the current item". And we start the sum with 0.

Reduce is cool, reduce is very functional, but reduce in JavaScript isn't the
best fit for all purposes. Consider this one:

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

For me, and I think for a lot of developers, the `for` loop is easier to
understand. While I can see that for some `reduce` might be superior in
readability, I think we all can agree that the `for` loop is very readable.

What is more important is that the `for` loop version is far more efficient. In
my experiment the `for` loop version was about 200 times faster on a large list
of about 10,000 entries. The implementation with `reduce()` constructs arrays
all over the place, whereas the `for` loop version modifies the accumulator
in-place. For small lists that doesn't matter much, but if you expect larger
lists, it's going to matter in both processing time and memory usage. And even
with very small lists the `for` loop version is still faster.

You could of course cheat in the reduce version and modify the accumulator in
place too, just like the `for` loop does:

```javascript
let flat = list_of_lists.reduce((accumulator, list) => {
    accumulator.push(...list);
    return accumulator;
}, []);
```

This code has indeed about the same performance as the `for` loop, but it
destroys the "but this code is declarative" argument. It becomes more difficult
to understand what's going on. Mutating the argument could in fact risk
breaking the algorithm, and reasoning about that takes mental effort I don't
want to be spending. 

So, the `for` loop is a clear winner over this one from a readability
perspective, and it's a little bit faster too, so the `for` loop wins.

### The lesson

I think we can generalize this into a heuristic: whenever you are constructing
a collection (like an array or hashmap) out of another collection, the `for`
loop is worth your consideration, as it may have favorable trade-offs in both
readability and performance. This heuristic applies to many programming
languages. [^2]

I don't want people to take home the wrong lesson, however. What we examined
here was a case where the `for` loop version is easy to understand and
implement, and I'm arguing you should give it serious consideration in this
case.

In other contexts using `reduce` makes complex code a lot more easy to
implement and understand. And objects (when not used as a hash table) are
really easy to combine, as long as you don't mutate them. Even if a `for` loop
version were a lot faster, that very well may not be worth it in your context.

## Conclusion

Consider the `for` loop, as in quite a few cases it results in code that's just
as readable if not more so, and has better performance. The performance aspect
is not surprising, given that `for` loops and mutability are a relatively low
level constructs, and computers like those, but the readability benefits are
sometimes ignored.

The intuition that `for` loops are sometimes plain better carries across to
many other programming languages. What are the trade-offs for the humble `for`
loop in Rust? [Here is another article for your reading
pleasure](@/posts/the_humble_for_loop_in_rust.md). You should be able to
follow along even if you don't know Rust. 

[^1]:

Yes, I know
[`flat`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flat)
exists. I'm using flattening as an example of a task where you're constructing
a structure (like an array, object or hashmap) out of another structure.

[^2]:

In a language like Haskell the culture is to use linked lists to express lists
rather than arrays. These have different properties: linked lists can be
combined cheaply but random access (`list[i]`) is linear rather than constant
time, and iteration is going to somewhat more slowly than in arrays too. 

This kind of easy to combine data structure is a [Persistent data
structure](https://en.wikipedia.org/wiki/Persistent_data_structure). You can
use these in other languages too, including JavaScript. Objects can be used
like this, as long as you don't mutate them. For lists and hashmaps using
persistent data structures is far less common in JavaScript. A consideration is
whether breaking with built-in data structures and cultural traditions in APIs
is worth it for your purposes.

