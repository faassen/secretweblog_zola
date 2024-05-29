+++
title = "I Was a 1980s Teenage Programmer Part 3: MSX-2"
date = 2024-05-29
slug = "teenage-programmer-msx2"
description = "Part three in a series about my teenage adventures learning about computers and programming in the 1980s: the MSX 2 computer."

[taxonomies]
tags = ["programming", "history"]
+++

A couple of years after the first two parts, we pick up on this series again.
This is Part 3 of a [series](@/posts/teenage-programmer-alphatronic.md).

## ZX Spectrum

When I was 12, in 1985, I went to secondary school in the city nearby. I would
cycle 10 kilometers every morning, about half an hour, and back again in the
afternoon. In school I made a friend, and my friend had a [ZX
Spectrum](https://en.wikipedia.org/wiki/ZX_Spectrum). This is an intriguing
little device with rubber keys each of which had multiple modes. In the right
mode you could whole BASIC statements with one keypress, something my friend
knew how to do. After school, or even on hour-long breaks during school, we
would cycle a few minutes to his house, and play with the computer.

In January 1986 [the Space Shuttle Challenger
exploded](https://en.wikipedia.org/wiki/Space_Shuttle_Challenger_disaster). I
remember that at some point afterward my friend coded up an animation of the
space shuttle going up and exploding. Too soon? Many animations back then used
a primitive tiling system. A tile would be the bitmap of a character, but
reprogrammed to look like something else. Then you've move these characters
across the screens. The movement would be jerky, but it was cool back then.

## MSX-2

For Christmas 1986[^1] I was hoping we'd get a computer. I had seen my uncle's
Amiga and I was hoping we might get one of those, but an
[MSX-2](https://www.msx.org/wiki/MSX2) would also be very cool.

We got the computer, along with color TV that would serve as a monitor. Not an
Amiga, it was indeed an MSX-2 computer made by the Dutch electronics concern
Philips, the [VG-8235](https://www.msx.org/wiki/Philips_VG-8235). Only a few
years ago have I learned it was actually designed and manufacturered by
Japanese firm NEC and that Philips had basically just slapped a label on it.

![The VG-8235: what came in the
box](https://www.msx.org/wiki/images/7/73/Vg8235j.jpg)

The MSX-2 computer was equipped with an 8-bit [Zilog Z80A
CPU](https://en.wikipedia.org/wiki/Zilog_Z80) running at 3.5 MHz. These were
very common in microcomputers back then. I now realize that this chip design
was already 10 years old when this computer was built. In the heady days of the
1990s where PC specs were rapidly increasing it would be inconceivable that new
computer models would come out with 10 year old CPUs, but the microcomputer
revolution of the 1980s was a lot about getting 1970s chip designs to the
masses.

MSX was an interesting project to try to standardize home computers, just like
the IBM PC had created standard for office computers. It never took off in the
United States, but it was big in certain parts of the world. Japanese
electronics companies were the driving force behind it, but it also was fairly
well established in certain parts of Europe, especially the Netherlands, thanks
to Philips. The MSX-2 was the newer version of the standard, with improved
specifications for graphics, and more memory.

I learned MSX stood for "Microsoft extended" as it had a Microsoft extended
BASIC implementation; Microsoft had started out as a BASIC interpreter
implementer for microcomputers and was big in this market. Apparently there is
other lore that it stood for "Matsushita-Sony", or that it was named after the
MX missile, or that it stood for "Machines with Software eXchangeability".

## MSX Games

The MSX-2 supported many games. You would obtain games by going to your friends
and copying 3.5 inch floppy discs, which would often contain collections with
dozens of games. The whole disk was only 360 kilobytes big! The way we
exchanged disks with games wasn't legal, but that barely registered in our
minds. The MSX supported a cartridge slot and that's how games were generally
sold. But these cartridges could be ripped and saved onto disks. I never owned
a game cartridge.

My friend, who after the ZX Spectrum also had upgraded to an MSX-2, had one
game cartridge, as it came with an upgraded sound chip that could also by used
by other games.

Konami was a big publisher on the MSX-2 that made many of the best games. The
Metal Gear series of computer games was born on the MSX-2.

Here are some examples of MSX games:

### Penguin Adventure (MSX-1)

A popular Konami game from the MSX-1 era.

{{ youtube(id="05kTZArlAtI")}}

### Nemesis (MSX-1)

A side-scrolling space shooter. Nemesis was known as Gradius on other
platforms.

{{ youtube(id="-TB3j8rlQrU")}}

### Metal Gear (MSX-2)

The metal gear series of games started on the MSX. I only ever played the
MSX versions.

{{ youtube(id="SLKiBEnyzPo")}}

### Space Manbow (MSX-2)

Another side-scrolling game like Nemesis, but with more advanced graphics. I
will go into details on those graphics in the next article.

{{ youtube(id="gcZJ64PgtgA")}}

### Aleste 2 (MSX-2)

{{ youtube(id="hYL7mTbsCHM")}}

## BASIC is the world

But the MSX didn't come with any games out of the box. When you started the
computer, you got BASIC. It's interesting how BASIC _was_ computers in the
early microcomputer era. A new standard for home computers had to standardize a
BASIC right along with it. BASIC was built into the ROM of the computer -- it
was just there when you started up the computer. I don't think I really had a
conception of other programming languages -- only that BASICs could differ
slightly between computer models. I also knew that arcane tools existed on some
platforms called a "compiler" that would produce faster programs. At some point
I picked up that "assembly language" was required to make real games, basically
writing "machine code" directly.

My father had switched from Microsoft GW BASIC to Microsoft QuickBASIC around
this time on the Olivetti M24. This did away with the need for line numbers and
introduced named locations you could GOTO or GOSUB from. Wild stuff. But not on
my MSX-2. This had the conventional line-number based BASIC. The advantage of
this is that it didn't require a full-screen editor to write your program. You
booted up the computer in a few seconds and you were ready to type in `10 print
"Hello world"` to start your program.

## Programming in BASIC on the MSX

Immediately after we got the MSX I was learning from the manual, this time in
Dutch, and I started my first experiments with computer graphics instead of
just plain text. I don't even think I had any games for it yet -- that took a
trip to the older brother of a school friend, who had an MSX-2 too. MSX-2
computers contained a Yamaha V9938 video chip which supported a 256 x 212
resolution with 256 fixed palette colors. Most games used 256 x 212 with 16
colors chosen from a palette. It also supported hardware sprites - little
pieces of graphics, one color only, that could move smoothly around the screen.

## Space Avoider

I remember the first sprite-based game that I wrote. It involved spaceships.
The player spaceship was at the bottom of the screen and could move left and
right. I had no idea how to make it fire missiles, so that's all it could do. I
did manage to introduce a single alien craft, which would start on top and
slowly move down. The goal was to avoid being hit by the alien spaceship; this
was gameplay defined by my highly limited abilities.

I knew the word "space" in English; what nerd doesn't know "space"? I had heard
"Space, the Final Frontier" many times, and knew about "Space Invaders". I
asked my mother how to say "avoid" in English, and the game title _Space
Avoider_ was born.

In the first version of the game, the alien's X coordinate would be identical
to the horizontal position of the player, so it was in fact impossible to avoid
the alien; certain doom awaited the player. A later version ensured victory was
an option by making the alien space ship move slightly more slowly. I believe I
even accomplished multi-colored ships by layering mono-colored sprites over
each other, though the two sprite layers weren't always entirely in sync.

[^1]: Actually [Sinterklaas](https://en.wikipedia.org/wiki/Sinterklaas)
