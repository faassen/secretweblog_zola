+++
title = "I Was a 1980s Teenage Programmer: the Alphatronic"
date = 2022-07-20
slug = "teenage-programmer-alphatronic"

[taxonomies]
tags = ["programming", "history"]
+++

I have been programming computers for a long time; I started as a
teenager at some point in the 1980s. I thought I might reminiscence a
bit about it. That's fun for me, but it also may also be fun for others
to see a small snapshot of what programming could be like back then. For
some, of my generation or older, there may be recognition, but for
others who got into programming later this might be an unknown world.

<!-- more -->

I had a long article sitting as a draft for a few years. Today I read
[The Home Computer Generation](https://www.datagubbe.se/hcg/), and it
reminded me of it. There's quite a lot of material, so I will publish it
as a series. Here is part 1.

Here are the other parts:

- [Part 1: The Alphatronic](@/posts/teenage-programmer-alphatronic.md)
- [Part 2: Olivetti M24](@/posts/teenage-programmer-olivetti-m24.md)
- [Part 3: MSX-2](@/posts/teenage-programmer-msx2.md)

# In a Dutch Village

I grew up in a village in the south of the Netherlands. My father was an
accountant who ran his own firm from an office near my house. It was
next to the village church. A park with a some goats and deer and ducks
was next door, and primary school was right next to it. All of these
were within a few minutes walking distance, without even the need to
cross a road.

Here's a picture of the office building: ivy-clad, tower of the local
town hall next door. You can see the top of the steeple of the village
church just behind it.

![My father's ivy-clad office.](/img/office.jpg)

My perspective on programming was extremely limited compared to my
perspective now. I was a child, and I didn't speak English very well at
all, at first. There was no Internet. Information did not spread
quickly, at least not to me. The world is so different now!

Let's go back to the year 1983. I was about 10 years old.

I'm not entirely sure what the first computer was that I actually
touched. It could have been a [Commodore
PET](https://en.wikipedia.org/wiki/Commodore_PET), owned by my uncle.

![A Commodore PET computer. My uncle had one.](/img/commodore-pet.jpg)

# The Computer

I do know what the first computer was that I actually programmed -- the
Triumph Adler Alphatronic. I have tried to reconstruct the model: I
_think_ it was a P2, but may it was a P3. It was in my father's office.
I suspect I first encountered it in my house during a Christmas break as
my father took it home, but I'm not sure.

![The computer in my father's office. A Triumph Adler Alphatronic P2](/img/triumph-adler-alphatronic.jpg)

Since my father's office was near our house, sometimes he would take me
there Friday evening, when he had to work late. I would play. If I was
lucky his work didn't require the computer, and I could play with that.
If it did, I was out of luck and I had to amuse myself with other, much
more boring, office equipment. That wasn't a lot of fun; I was there for
a computer.

Note how I say "the computer"; my father had employees and there were
many desks, but there was only a single computer in the whole office.

The Triumph Adler Alphatronic P2 was a computer made by a German
typewriter and office equipment manufacturer. The Alphatronic came
equipped with an Intel 8085 CPU. This was an 8 bit CPU with a clock
speed of few megahertz. It had a monochrome screen, with amber letters
in the standard 80x24 grid. The operating system was CP/M. But back then
I had no idea what any of this meant. It was just the computer.

# BASIC

My father had a [BASIC](https://en.wikipedia.org/wiki/BASIC)
implementation for the computer on a floppy disk. He taught himself how
to program to help him to automate office tasks, like registration of
hours for invoicing. He continued automating office tasks for years,
writing ever more sophisticated software. Some of his creations were
also used by his clients. Doing this automation gave his office an edge,
but he also enjoyed technology and learning, as he still does.

![BASIC on an amber screen. I think we had a disk BASIC, not
ROM, but it must have looked much like this.](/img/amber-screen.jpg)

My father taught me how to write a few very simple programs in BASIC. I
remember we wrote a calculation program together that could do addition,
substraction, multiplication and the like. I thought it would be very
convenient for school arithmetic exercises but that it would probably be
considered cheating.

My next program that I can recall writing was an AI. You could type in a
word, and depending on whether the word was "good" or "bad", the program
would respond with an ASCII art happy or sad face. The dictionary it
understood was probably 5 words. It could respond to whole words only,
not a word in a sentence, as I didn't know how to make the program look
inside a string yet.

# Programming as Magic

Programming back then for me involved some statements that I could
understand, like `IF` and `FOR` and `GOTO` and `PRINT` and `A = 10`. If
you made a typo in your code you generally got a `Syntax Error`. As a
Dutch speaking kid I did know enough English to know that "error" meant
something went wrong. "Syntax" was just a magic word to me and would
remain one for many years to come. But I did know syntax errors were
generally easy to fix; it would just be a simple typo somewhere.

BASIC also had a bunch of magic incantations like `INSTR`. If you used
them wrong you would get the much harder to understand
`Illegal function call` or a `Type mismatch`. I had no idea what a
function call was as this old BASIC did not support creating your own
functions -- you used subroutines for that with
<span class="title-ref">GOSUB</span>. In BASIC everything was a global
variable and there was no argument passing. I did not know what a "type"
was either, or what "mismatch" meant. These were just the mysteries of
the machine and you learned to work with them.

# Next time...

Thanks for reading so far! [Next
time](@/posts/teenage-programmer-olivetti-m24.md), we'll delve into my
programming adventures with the upgraded computer in my dad's office.
