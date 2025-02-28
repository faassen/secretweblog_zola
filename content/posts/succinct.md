+++
title = "Succinct data structures"
date = 2025-02-28
slug = "succinct"
description = "An overview of a class of data structures I didn't know about!"

[taxonomies]
tags = ["computer science", "xml", "rust"]
+++

## Introduction

A few months ago, searching for ideas on how to make some code faster, I found
myself reading a bunch of computer science papers. I don't pretend to be good
at this - but I don't mind some confusion or being overwhelmed, and I'm okay to
admit my ignorance. [^learning]. I ran into this 15 year old paper [^paper]
that introduced several concepts entirely new to me. I struggled to understand
them.

So what do you do then? You look for more papers to help explain things. This
is a risky endeavor, because they might confuse you even more, but it cannot be
avoided. I discovered a paper for a relevant data structure that mentioned
source code on a website. The source code was in C++ and I am working in Rust,
but I figured I'd take a look anyway. But when I went to the website the
resource wasn't there. So I mailed the owner of the website, who happened to be
a computer science professor.

This professor was very friendly and immediately mailed me back [^mailing].
Only during our conversation did I realize I was seeing his name on a *lot* of
papers in the field. Turned out I had stumbled into talking to one of the world
experts the field of succinct data strucures, within a few days of my discovery
they even existed. Ignorance can bring you far.

So what are succinct data structures? If you've taken computer science courses
in recent decades you might have, but I didn't run into them before as a
programmer, or if I did, I immediately forgot. But now I think they're data
structures with fascinating properties. 

We all use arrays, and [hashmaps](https://en.wikipedia.org/wiki/Hash_table)
[^hashmaps], and various trees are common too. We don't have to fully
understand how they work in order to be able to leverage their properties
effectively. Now I found msyelf wondering why people don't use these succinct
data structures more often.

So I figured I'd talk a bit about them.

## Succinct Data Structures

To introduce succinct data structures it's useful to compare them to
compression. You use compression to shrink the size required to represent this
data. Compression can be useful to save disk space, or transmit less data over
the network, or to save memory. But to do anything useful with compressed data,
such as access it or query it, you first need to uncompress it again. Then
afterwards if you want to save space, you need to compress it again.

Succinct data structures are different: they store their content in a compact
fashion like compression, but the compact form of the data has useful
properties. You can still use it!

This is a field that seems to have emerged in computer science relatively
recently; many of the important data structures were invented in the last 25
years.

In this article I going to give a tour of some of the succinct data structures
I have run into. I do not claim any expertise in this area at all - I only have
the vaguest notion of how many of these data structures work. Heck, I only
discovered they existed a few months ago! But as I said, you don't need to know
how they work in order to use them.

## Rust

In systems programming one cares more about the particular characteristics
(memory, performance) of data structures than usual. It strikes me there are
quite a few potential applications for them in this field. Much of the original
research work with compact data structures was done with C++. I myself like to
use Rust for my systems programming, so I looked for implementations in Rust.
I'm going to share what I found in the hopes other developers who use Rust find
them interesting. But the general overview is not limited to Rust in any way,
so if you're not interested in Rust I invite you to read on as well.

## Bit Vectors

Consider a vector (array) of bits. For instance `[0, 1, 0, 1, 1, 0, 1, 0]`

Let's consider a bit vector for a moment. What I'm going to say is pretty
obvious, but I think it's useful to highlight anyway. The bit vector above is 8
entries long. This means it fits into a single byte of memory.

On a 64 bit computer, 64 bits fit in a single native integer. That's a bit
vector of 64 entries fitting inside 8 bytes, which is quite a lot if you
consider that a normal array takes that many bytes for a *single* integer
value. Even a bool in Rust takes a byte of storage.

Bit vectors themselves aren't succinct data structures. In the end computer
memory is a giant array of bits. But succinct data structures try to make every
bit count.

It's also important to note that a data structure might present itself as a bit
vector but actually stores the information inside in some special way that
makes certain operations fast. That's what we're going to see next.

## Rank/Select Bit Vector

The rank/select bit vector is a core succinct data structure that many others
are built on. When I was hunting for source code I had only just realized that
these weren't just plain bit vectors but supported special operations, `rank`
and `select`.  

Let's look at our bit vector from before: `[0, 1, 0, 1, 1, 0, 1, 0]`.

We give each entry an index (from 0 to 8, not inclusive).

The *rank* operation, given an index, counts how many bits have been set before
it in the array:

So, `rank(0)` is 0 as no bits have been set at this position yet, `rank(1)` is
1, `rank(2)` is 1 as well (there's a 0 in that location, so no more bits have
been set). `rank(3)` is 2. `rank(7)` is 4.

The *select* operation is the inverse of rank. You can give it a rank and get
the index where that bit was set.

So `select(1)` is 1, `select(2)` is 3, `select(3)` is 4, and `select(4)` is 6.
Just the subsequent indexes where you see a `1`.

A succinct implementation of a rank/select bit vector can do these operations
in constant time. Only a little bit more data than is taken up by the bit
vector itself is required to support these operations.

### Use cases

So what are the use cases for this? Let's consider a simple one.

Let's say you have a big string that is actually composed of lots of little
strings. You want to track where all of these strings start. Now there are many
data structures you could use for this, and often they might be better, but
let's use a rank/select bit vector.

Here's string with positions under it:

```
Hello$I am a string$I'm amazing$Traditional banana
01234567890123456789012345678901234567890123456789
0         10        20        30        40
```

Note the special `$` markers. These could be encoded as `\0` in practice.

So, this big string has 4 substrings, which we can view as an array: 

```
["Hello", "I am a string", "I'm amazing", "Traditional banana"]
```

We can identify each substring with a number that is the index to this array:

```
Hello$I am a string$I'm amazing$Traditional banana
0    1             2           3                  
```

Now let's consider a rank/select bit vector. For the points in this string
where the substring starts, at each location you have an `$`, you set a bit in
it.

So you get this:

```
Hello$I am a string$I'm amazing$Traditional banana
00000100000000000001000000000001000000000000000000
     5             19          31
```

Now when you have any position in this you can efficiently determine which
sub-string it belongs to using `rank` - you get a substring identifier. For
instance, position 12 is in "I am a string" and `rank(12)` gets me `1`.


If you add 1 to an identifier you get the next substring identifier - a useful
property.

You can turn the substring identifier back into a position using `select`. For
instance `select(1)` gets you `6`, the position of the first `$` in the string,
i.e the start of `"I am a string"`. Add 1 to that and you have the start of the
next substring. So if you want to find the end of a string, you can add 1 to
the substring identifier and do a select on that.

This allows you to maintain unique identifiers for slices in a block of data in
a compact way.

With a normal rank/select bit vector you'd use 1 bit times the length of the
string as overhead, plus a little. For a string a megabyte long, that's 128
kilobytes extra, and some change. But if the set bits are relatively uncommon
you can use a *sparse* rank/select bit vector to store this additional
information very efficiently, in far less space than would be required for the
original bit vector.

### Rust

In Rust I've really enjoyed working with
[`vers`](https://crates.io/crates/vers-vecs) which has both excellent
performance and very minimal overhead over the original bit vector. The author
is very responsive and is working a range of exciting new features.

Another worthwhile library is [`sucds`](https://crates.io/crates/sucds). Of
particular interest is its implementation of `SArray`, which is a sparse
implementation. `vers` in my opinion however has a better design for efficient
construction of these data structures than `sucds` does. I'm therefore glad to
report that `vers` is in the process of adding a sparse implementation as well.

## Wavelet Matrix

A *wavelet matrix* sounds like something out of science fiction. "Doc, the
wavelet matrix is out of sync! We cannot get back to 1985!". Related other
structures are *wavelet trees*, including the *quad wavelet tree* which also
has a pretty cool scifi name.

What these data structures do is generalize rank/select over "arbitrary
alphabets". The alphabet of a bit vector consists of 0 and 1, but many
real-world data has a bigger alphabet. Of particular interest in the succinct
data structure space is DNA, which has the alphabet of its nucleotides "G",
"C", "A" and "T", size 4. Another very common alphabet is text. If you use
UTF-8 and store its bytes its alphabet is of size 256. [^unicode]

Generally the smaller the alphabet, the better: the data structures need less
space and can be faster.

So let's consider the string "banana" in some text alphabet like ASCII.

```
banana
012345
````

We can now rank and select particular symbols in the alphabet. Let's consider
the letter (symbol) `a`:

```
banana
 1 2 3
```

`rank(0, 'a')` is 0, as there are no `a`s yet at index 0. But `rank(5, 'a')`
gets you rank 3. Similarly `select` lets you find the index of a symbol in the
string: `select(2, 'a')` gets you index 3, the index of the second `a`.

The implementation of a wavelet matrix uses rank/select bit vectors underneath.

### Rust

In Rust the [`vers`](https://crates.io/crates/vers-vecs) crate also has an
implementation of the wavelet matrix data structure.

## FM-index

An FM-index is data structure that lets you store text (any vector of symbols)
in a compact way, but still allows important query operations. It doesn't use
much more space than the original text (or in some cases, less).

The important queries here are:

- `count(pattern)` which counts how many occurrences of a certain pattern
  (substring) exist in the stored text. 

- `locate(pattern)` which gives the index for each occurrence of the pattern in
  the original text

The ability to load up a huge string of DNA data into memory and then being
able to find substrings in it fast is extremely useful in bioinformatics. But
any use where you have a lot text against which you want to support search
operations could potentially benefit from an FM-Index.

### Rust

In Rust the [`fm-index`](https://crates.io/crates/fm-index) crate provides this
functionality. 

Originally the `fm-index` crate used the
[`fid`](https://docs.rs/fid/latest/fid/) crate (by the same author) for its
underlying rank/select bit vector. But I've recently ported `fm-index` over to
use `vers` instead, which boosted the performance of `fm-index` considerably.

I've been working with the wonderful author of `fm-index` to improve its API
and functionality, and a lot more is coming in this space, including support
for storing and searching large strings consisting of multiple substrings.

## Balanced parentheses

Let's consider a tree of data, where each node can have arbitrary amounts of
children. These are very common structures in programming. Both XML and JSON
can be represented by trees like this; so can programming language ASTs.

If you want to allow arbitrary navigation within the tree, you need the
following operations on nodes in the trees:

- `parent(node)`: gives the node that this node is a child of

- `first_child(node)`: gives the first child node of a node

- `next_sibling(node)`: gives the next sibling of a node (within its parent)

- `previous_sibling(node)`: gives the previous sibling of a node (within its
  parent)

And often this is how these trees are represented in memory. Along these lines:

```rust
struct Node {
   parent_idx: Option<usize>,
   first_child: Option<usize>,
   next_sibling: Option<usize>,
   prev_sibling: Option<usize>
}
```

This is quite a bit of information per node: on a 64 bit operating system this
node clocks in at 32 bytes, or 256 bits. A balanced parentheses tree allows the
same operations but takes only 2 bits per node! Well, there's a little overhead
too used by the rank/select bit vector underneath, and a bit more in a
management data structure, but it's still impressively tiny.

How does it do this? In a very brief sketch, it basically encodes a tree as a
series of parentheses. Let's consider a single tree with a root node `a` and
two child node `b` and `c`:

```
    a
  /  \
 b    c
```

This can be represented as "(()())". 


```
(()())
ab c
```

The outer parentheses encode the root node `a` and the two inner `()` pairs
encode its child nodes. Since we have only an opening parenthesis `(` and a
closing parenthesis `)`, this information can be stored in a rank/select bit
vector, with 1 for open and 0 for close. 

```
(()())
110100
```

And thanks to various clever operations using `rank()` and `select()` and a bit
of supplementary information it can support all of the navigation I mentioned
above, and quite a few operations more.

### Rust

The amazing author of `vers` is working on a Rust implementation on the
`dev-bp` branch of the `vers` crate. I've been using it a lot in my own work
and it's looking great!

## Building on these structures

You can use these and other succinct data structures to build new functionality
with very interesting properties.

I'm working on XML processing in Rust [^xml-rust], and the paper I mentioned in
the beginning described a way to store XML data using succinct data structures.

It use a balanced parenthesis tree to store the XML tree. This does not allow
one to attach information to nodes such as the XML tag information (i.e. the
`p` in `<p>` and `</p>`). But you can attach attach information to each node by
maintaining a spare rank/select bit vector for each tag that marks the relevant
parenthesis with additional information.

This rank/select bit vector then allows fundamental new operations: you can
"jump" to the first descendant node with a particular tag without having to
traverse the intervening nodes!

XML also contains text nodes. These can be attached to the tree by tracking
which opening parenthesis have the text node tag. The paper also uses an
`FM-Index` to store the text nodes and allow fast queries over them.

While XML is perhaps a rather quaint application for these techniques, imagine
a programming language that stores its AST in such a way. Huge ASTs could be
stored relatively compactly but still support interesting search operations,
which might open up new ways to implement programming language compilers.

## Conclusion

Now that I've discovered these data structures I'm left wondering where they
were in all my programming life. I suspect there's a lot of untapped potential
in them for general computing. While data structures that use a lot more memory
can generally do many of these operations more efficiently, the ability to use
less memory has performance implications all of its own. And until last
December I had no idea they even existed! I'm sure there are a lot of
developers out there that could find interesting uses for them.

[^learning]: Accept the confusion and ignorance. Accept feeling overwhelmed.
    This is how you learn new stuff.

[^paper]: You're going to ask which paper. It's [Fast in-memory XPath search
    using compressed
    indexes](https://repositorio.uchile.cl/bitstream/handle/2250/133086/Fast-in-memory-XPath-search-using-compressed-indexes.pdf)

[^mailing]: I've recently mailed a few more, with the same very positive
   results! Mailing computer science professors is now my new hobby/super
   power. These are generally people who are driven by curiosity and are eager
   to share what they've found. They're awesome! But don't you all start doing
   it, they're busy people and they're all mine!
   
   The experiences I've had recently with professors, as well as the open
   source developers in the Rust succinct space, give me some badly needed new
   faith in humanity.

[^hashmaps]: I've actually run into surprisingly many programmers who don't use
    them. Then during review I find code that loops through the entire array in
    order to look up one value, easily leading to quadratic performance. Use
    hashmaps, folks.

[^unicode]: Depending on your application you may need an alphabet size the
    size of unicode itself. It's best if you can avoid that.

[^xml-rust]: Yes, it's the old with the new!