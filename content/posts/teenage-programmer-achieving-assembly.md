+++
title = "I Was a 1980s Teenage Programmer Part 5: Achieving Assembly"
date = 2024-06-26
slug = "teenage-programmer-achieving-assembly"
description = "Part five in a series about my teenage adventures learning about computers and programming in the 1980s: achieving assembly"

[taxonomies]
tags = ["programming", "history", "msx", "assembly"]
+++

This is the last part; Part 5 of a
[series](@/posts/teenage-programmer-alphatronic.md).

## The Book

At some point I obtained the book "MSX - Programmeren in Machinetaal" (That's
Dutch. In English that would be "MSX - Programming in Machine Language").

I still have it:

![The book.](/img/msx-programmeren-in-machinetaal.png)

The cover said "Complete cource on programming in machine language. Everything
about the Z80 processor and the internal life of the MSX computer".

One problem with this book was that it only covered the MSX-1. But the bigger
problem is that it was difficult to read. I hate to say this about a book that
was the only book I had about a topic that intrigued me: it wasn't a good book
for beginners at all.

The book consisted of a long section about the Z80 which was completely
generic, and a shorter section about the MSX computer specifically. So no cool
graphics stuff in the first section of the book at all.

As an example of how the book didn't really help, it quickly dived into topics
on how to use [Binary Coded Decimals
(BCD)](https://en.wikipedia.org/wiki/Binary-coded_decimal). I didn't care about
BCD. Nobody cares about BCD. I wanted to make _games_.

I'm sure I must have _tried_ to read it. I was a voracious reader. But I must
have gotten stuck pretty quickly. The book explained the various features of
Z80 assembly extensively without actually placing them into context: why would
you want it? So even though the book tried to explain the fundamentals, in
reality it assumed far too much previous understanding that I didn't have. I
think I would understand it a lot better today, but I still have little desire
to read it.

## The bug in the book

I showed my friend my previous blog posts about the MSX, and he related an
anecdote to me that I had forgotten. Somewhere in this book there was an
assembly routine for copying data. But when we tried it, it didn't work. We
then identified a bug in it, and fixed it. Some form of off by one error.

My friend pored over the book step by step, but there it was: a bug in black
and white, in a printed book!

## PC

I still used a PC at times as well. At some point a PC, I think equipped with
[VGA graphics](https://en.wikipedia.org/wiki/Video_Graphics_Array), became a
fixture in the same home office where we had the MSX.

I'd read some book from the local library which had a description of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life). I used
the PC and QuickBasic to create a simple, slow implementation.

I also used the PC to play with
[Fractint](https://en.wikipedia.org/wiki/Fractint), a fractal generation tool.
I was amazed that this tool was available for free. I remember reading the
creators' ["Stone Soup"](https://en.wikipedia.org/wiki/Stone_Soup) description
of how they had created Fractint, which described the process of contributions
by a range of people that we'd now call open source.

In the 1990s the PC was to regain prominence in my computing life. It had games
like [SimCity](https://en.wikipedia.org/wiki/SimCity), and later Civilization
and Railroad Tycoon, that really captured my interest.

## The MSX upgrade

The MSX had a 3.5 inch 360 kilobyte built-in disk drive. But a friend in my
village knew how to upgrade the MSX's disk drive. One evening he came over and
replaced the disk drive with a double-sided 720 kilobyte model. It also
required the replacement of a ROM chip. It was a scary surgery, but it worked.
Now we had double the storage capacity!

![Some 3.5 inch floppies. Interesting they say 0.5 MB, which is an exaggeration](/img/msx-floppies.jpg)

There was a protection system so you couldn't accidentally format a disk meant
for 360 kilobytes as a 720 kilobytes: there was an extra hole in the disk to
indicate this increased capacity. And 720 kilobyte disks were more expensive.

My younger brother, a big user of the MSX computer as well, at some point
obtained a special hole punching tool. He now had the power to turn a 360
kilobyte disk into a 720 kilobyte disk! Storage capacity for free!
Unfortunately it was a game of Russian roulette; some disks just broke down
entirely when the tool was applied. Many disks were destroyed in the process.

Things ended up well for my disk-destroying little brother. He's still a big
tech guy. He was the first in our family to have a computer with more than a
terabyte worth of storage capacity. He now has a tech [YouTube
channel](https://www.youtube.com/c/IntermitTech) and designs LED controller
hardware.

## The Power of Assembly

My friend and I did eventually somehow learn how to control MSX-2 graphics from
assembly. After several attempts that went nowhere, but were undoubtedly very
educational, we created a game we called Matrix. It was based on this idea I
had inspired by the Game of Life.

The rules of Matrix are simple. It takes place on a grid of squares that fills
the screen. Each square could be empty or contain a block.

There are two players, blue and red, so blue and red blocks. Each player
controlled a cursor and could use it to move blocks to an adjacent square. The
goal was to destroy the other player's blocks, though I don't think we ever
programmed the detection of the victory condition.

You could create a new block by orienting four existing blocks around an empty
square:

![Create a new block](/img/matrix-create.png)

You could destroy an enemy block by surrounding it with at 3 squares. This
was actually quite difficult to accomplish and not a very effective way to
attack the other player:

![Destroy a block](/img/matrix-destroy.png)

Sometimes creating a new block would create a special block: a bomb block, a
laser block and a trigger block. Each had a special symbol. A bomb block, when
touching an enemy block, would explode and destroy a certain amount of squares
around it. A laser block would destroy either a horizontal or vertical line
depending on where the trigger block touched it.

I've wanted to come back to this game concept for many years, but I haven't
yet. It's a good excuse to dive into [Bevy](https://bevyengine.org/) again.

## Beep!

We had done it. We'd written a game in assembler. It worked! It was copying the
blocks graphics. It was implementing rules. It was fast! Even on a Z80,
machine language is very fast!

It was too fast. The cursors moved far too fast. It wasn't a usable game.

So as a temporary hack we introduced a system call issue a system _beep_ sound
to slow things down. It worked, though we would have to turn the volume off
while playing this game, otherwise it was a horrible racket. We didn't have any
sound effects or music for the game anyway, so that was okay.

We never fixed the temporary hack.

## Leaving the MSX behind

It was the early 90s. The Berlin Wall had fallen. The Soviet Union was falling
apart. I went to university. I had discovered the Internet. It was a different
world.

At university I learned about computer language expressions, which you could
visualize as a tree.

In the summer holiday after the first year, I had an idea. Writing assembly
language was really hard. What if I had some kind of expression subsystem to
make life easier? I could model the expressions in memory, using addresses to
compose a tree. I wrote a simple evaluator, on the MSX, in Z80 assembly. I used
a memory monitor tool to help debug it. It was a really primitive
implementation. I realized that besides simple arithmetic, I could model
conditionals as expressions too. And for loops.

University started again. I had a course on the [Lisp programming
language](<https://en.wikipedia.org/wiki/Lisp_(programming_language)>). Some
other students struggled to get it, but not me. I realized I had reinvented
(badly) bits of Lisp.

I think it was the last thing I ever programmed on the MSX, and with Z80
assembly.

## Conclusion

We're crossing into the early 1990s, in which I eventually left my teenage
years. Therefore this concludes my
[series](@/posts/teenage-programmer-alphatronic.md). on my early experiences
with computers. The early Internet became important to me in my late teens, but
that's another story.
