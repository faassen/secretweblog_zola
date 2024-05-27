+++
title = "I Was a 1980s Teenage Programmer Part 2: Olivetti M24"
date = 2022-07-21
slug = "teenage-programmer-olivetti-m24"
description = "Part two in a series about my teenage adventures learning about computers and programming in the 1980s."

[taxonomies]
tags = ["programming", "history"]
+++

This is Part 2 of a [series](@/posts/teenage-programmer-alphatronic.md).

# The Olivetti M24

When I was about age 11, around 1984, my father's office got a new
computer: an Olivetti M24. Olivetti, like Triumph-Adler, started out as
a typewriter manufacturer, this time an Italian one instead of a German
one. And like Triumph-Adler, and IBM long before it, computers were just
more office equipment.

The [Olivetti M24](https://en.wikipedia.org/wiki/Olivetti_M24) was an
IBM PC clone and it had a good reputation. It was IBM compatible but had
a faster Intel 8086 8 MHz CPU instead of the 4.77 MHz in the IBM PC. I
realized that back then; my father talked about it.

Here's an ad for the M24.

![Ad for m24 with dog and bowler hat](/img/olivetti-m24-poster.jpg)

I think the black bowler hat in the picture is a sly hint towards IBM PC
compatibility, as the IBM ads at the time featured a Charlie Chaplin
tramp lookalike.

![Charlie Chaplin ad for IBM PC](/img/charlie-ibm.jpg)

Unlike the ad, we didn't have a color screen though, it was light blue
on black:

![Light blue on black screen](/img/olivetti-screen.jpg)

# RANDOMIZE TIMER

I continued my BASIC programming sessions. I had seen computer games at
my uncle, who at some point had upgraded to a Commodore C64. The
Olivetti M24 also had a few simple games available, written in BASIC. My
goal was to create a computer game. My goal throughout my teenage years
remained to create computer games. I was never very successful, but on
this quest I learned about programming.

One of the great problems I had was how to generate random numbers. In
my mind, games had to involve randomness, otherwise the enemies would
behave the same each time you played the game. I learned that I could
use `RANDOM` in BASIC to get a random number, but it got me the same
sequence each time I started the program, which frustrated me. I learned
about the `RANDOM SEED`, but that required you to either hardcode a
number (leading to the same problem) or asking the user for one each
time the program started up, which for some reason was unacceptable to
me.

One day I joined my father on a business trip to a software developer in
another town in the Netherlands, and this resulted in a breakthrough. I
presented my problem to a programmer there, and he suggested I try
`RANDOMIZE TIMER`. This was the first professional programmer I ever
talked to in my life.

This sounded absolutely baffling to me - I realized `TIMER` had
something to do with time, but how in the world would that fix my
problem? But back at the office again I tried it out and it did. The
magic worked!

I was elated! I am not sure when I put together that computers have a
built-in clock and that this time taken as a number was arbitrary enough
that it could serve as a seed for a random number generator.

# User Guide

It's interesting to reflect on the fact that I barely spoke any English
at this point. I had been exposed to English-spoken television with
subtitles in Dutch, but I couldn't really read English.

The Olivetti M24 came with manuals in English. I would browse through
them to try to learn more about the possibilities of programming.

I knew books; I read lots of them from the local village library. The
covers had a title and the name of the author. The manuals had, I
thought, the name of the author on it as well. The M24 manuals had
titles, like "MS GW-Basic Interpreter under MS-DOS". Since the Olivetti
brand was Italian, I assumed "User Guide" was the name of the Italian
author. "User Guide" kind of sounded Italian to me. My parents were
amused when they found out about this creative interpretation. I'm still
amused to this day.

![Manual by famous Italian author "User Guide".](/img/m24-user-guide.jpg)

# Information Space

Computers were magic, but if I cracked the magic I might be able to
create a game. Some of the incantations I understood, and some remained
a mystery.

The information space I was in was very limited. Obviously no internet.
No BBSes either; no network of any kind. At some point later in the
1980s I saw Wargames on TV, but the notion of being able to dial into a
distant computer was still science fiction to me. My interformation
space about computers the early days mostly consisted of my father and
the User Guide.

# More Olivetti Stories

As to the M24, my father bought more of them for the office. He also
acquired a second hand "luggable" computer a few years later, the
[Olivetti
M21](http://www.computinghistory.org.uk/det/43175/Olivetti-M21/), at
some point. I played [Space
Quest](https://en.wikipedia.org/wiki/Space_Quest) on it. The hard drive
was flaky -- sometimes it would audibly spin down, which would block
scene transitions form loading in the game. A good slap on the top would
cause the drive to spin up again, and the game would continue.

In the early 1990s I went off to college and I was gifted an old M24 for
me to use. I remember running a LISP interpreter on it; by that time I
was able to copy programs off the Internet to run on it.

# Next time...

Thanks for reading part 2! Next time, we'll go into when I got an actual
home computer.
