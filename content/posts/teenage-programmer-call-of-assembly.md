+++
title = "I Was a 1980s Teenage Programmer Part 4: The Call of Assembly"
date = 2024-05-31
slug = "teenage-programmer-call-of-assembly"
description = "Part four in a series about my teenage adventures learning about computers and programming in the 1980s: the call of assembly language."

[taxonomies]
tags = ["programming", "history", "msx", "assembler"]
+++

This is Part 4 of a [series](@/posts/teenage-programmer-alphatronic.md).

## Creating games with BASIC

Me and my friend were on a quest to develop games for the MSX-2. Creating
"real" games seemed more in reach back then - the graphics were simple, there
was no 3D, so we had the hope we could do it. Our skills weren't great, and
BASIC was too slow for this purpose, but we had fun and learned many things.

MSX BASIC had a lot of high level commands to do graphics (and sound too). You
could draw a line and a circle, you could define and move around sprites, you
could copy bitmapped graphics to other areas of the screen.

Using `POKE` and `PEEK` to directly change and access memory was possible, and
some other platforms like the Commodore 64 required that to do anything cool,
but to me, `POKE` and `PEEK` remained a mystery and weren't really necessary to
know about. I knew that if I POKEed the wrong place it would crash the machine.

## Elite

At some point my friend and I obtained the game Elite, which was released on
the MSX. This game was wildly different: unlike a 2d game with a fixed, simple
action-oriented mission, like almost all other games on the platform, it was an
open world 3d game where you were a space trader and you could roam a giant
universe of stars trading your wares and fighting.

It was different. It was an extremely impressive game to us then. I'm even more
amazed by it today and if you're a software developer, you will be as well
if you watch this video:

{{ youtube(id="lC4YLMLar5I")}}

No matter how ambitious I and my friends were about creating real games on the
MSX, I don't remember we ever had any ambition to create something like Elite.
We knew it was beyond us.

## Vertical scrolling: the VDP(24) breakthrough

My friend and I knew the MSX could do smooth vertical scrolling. We'd seen
games do it. But we didn't know how to do it from BASIC. There was no command.
Until one day my friend had made a major discovery: the magical "VDP(24)"
command. I don't know anymore how he had learned about it, but it changed our
world. Suddenly we had access to a whole new ability!

Many years later I learned that `VDP` stands for `Video Display Processor` and
that `VDP(24)` controlled register 23 (but BASIC started to count at 1 for
this). This was like `POKE` and `PEEK`; a feature not fully exposed to BASIC.

Many years later as well, on a whim, I googled how to do vertical scrolling on
the MSX-2. Even though this platform by then was very obsolete, I immediately
found many resources that described how to do it. You still can. What was such
a breakthrough for us was a trivial search away in the internet era.

## Horizontal scrolling on the MSX-2

Smooth horizontal scrolling on the MSX-2 was not possible with an equivalent
VDP command.

Many side-scrolling games existed on the MSX, such as the famous _Nemesis_
series made by Konami (more commonly known as
[Gradius](<https://en.wikipedia.org/wiki/Gradius_(video_game)>) was named on
the MSX), but they all used character-tile based scrolling, which wasn't
smooth:

{{ youtube(id="-TB3j8rlQrU")}}

Yet in 1989 we saw a new game in the Gradius genre, [Space
Manbow](https://en.wikipedia.org/wiki/Space_Manbow), also made by Konami, that
had smooth horizontal scrolling. But we knew there was no hardware support for this. How did they do it?

{{ youtube(id="gcZJ64PgtgA")}}

We figured it out, and it was pretty insane:

There was a special VDP register that let you adjust the horizontal and
vertical centering of the whole screenThis is Part 3 of a [series](@/posts/teenage-programmer-alphatronic.md).. It was actually exposed with a proper
BASIC command, called `SET ADJUST`. You could recenter the screen from -7 to +8
pixels both horizontally and vertically.

Space Manbow adjusted the screen horizontally for 16 pixels, so scrolling was
smooth, and then do a tile-based "jumpy" scroll after that, at the same time
setting the adjust back to the extreme other end. This way each tile could
scroll smoothly. It used black sprites to mask over the left and right sides of
the screen, so you couldn't see the edge shifting.

## BASIC KUN

A temporary reprieve arrived in the form of [MSX-BASIC
KUN](https://konamiman.github.io/MSX2-Technical-Handbook/md/KunBASIC.html),
also known as X-BASIC. This was a BASIC compiler, but it didn't come in the
shape of a compiler. There wasn't a program to translate your BASIC into
machine code. Instead you gained a new BASIC command, `CALL TURBO ON`, which
would enable this magic. You could surround your BASIC code with `CALL TURBO
ON` and `CALL TURBO OFF` blocks and that code would be a LOT faster; online I
read from 15 to 100 times faster. There were a few restrictions to the BASIC
you could write in a turbo block. But it was like sorcery. We had no real idea
how it could even work, but it did.

## Lightbulb

But we knew that to write REAL games we'd have to learn assembly. But I just
didn't get even the fundamentals.

At one point at school I talked to a guy who had done assembly. I asked him how
I could do an `IF` in assembly (a conditional statement). He gave me the
revelation: you'd first execute an arithmetic instruction, like substract. Then
if the result of this operation was zero, the `Z` flag would be set. Then you
used a conditional jump instruction, that would only jump if `Z` was set (or
the inverse, when it wasn't set).

A lightbulb went off over my head. So _that_ is how you do it!

I think still remember where I was when I was talking to him, on the ground
floor of the school near where the coat hangers were, though I don't remember
his face or name.

## Next time...

Thanks for reading part 4 of this
[series](@/posts/teenage-programmer-alphatronic.md)! Next time we'll discuss
more experiences with the MSX and assembly.
