+++
title = "Apilar: An Alife System"
date = 2022-08-01
slug = "apilar-an-alife-system"

[taxonomies]
tags = ["alife", "rust"]
+++

A week ago I participated in the
[langjam](https://github.com/langjam/langjam) weekend. This was a
weekend full of coding dedicated to the creation of a programming
language. I had various ideas before it started, but I threw them all
overboard once the theme was announced: "Beautiful Assembly". I could
only work on one thing; something I had been thinking about for many
years. I'm glad I did. I created
[Apilar](https://github.com/faassen/apilar), an artificial life system.

# Artificial Life

Let's first sketch the context: [artificial
life](https://en.wikipedia.org/wiki/Artificial_life), or _alife_. This
is a fairly obscure topic that has interested me for a long time.

Biological life is marvelously creative -- evolution has thrown up all
sorts of fascinating creatures, and their behavior individually and in
the aggregate leads to yet more interesting phenomena.

The idea of alife is to learn more about biological life by examining
simulated life. Going beyond relatively simple simulations, alife is
interested in topics like open ended evolution and emergent properties.
Can we create artificial systems that display various interesting
properties of life?

# Tierra

So how might one do that? There are many approaches. Back in 1991, an
ecologist named Thomas Ray had a brilliant idea: he created a computer
program he named
[Tierra](<https://en.wikipedia.org/wiki/Tierra_(computer_simulation)>).
This modeled a virtual computer, with memory and an imaginary assembly
language. In this language he wrote a replicator: a program that would
copy itself in memory. To this he added mutation: sometimes random
memory locations would be modified to random different instructions.

This sets up the preconditions for evolution:

- replication - the programs can copy themselves
- inevitably, some replicator programs are more "fit" -- they replicate
  and survive in memory better than others, for instance in being able
  to replicate themselves faster. So there's a form of selection -- and
  this selection is inherent in the system, not an external algorithm.
- mutation - a way to generate new versions of programs.

Fascinating stuff started to happen when Tierra runs. The original human
designed replicator was optimized by evolution and faster replicators
took over. A form of viral parasitism evolved where some replicators
would use the copying procedure of others to make copies of themselves.
This leads to predator/prey dynamics.

# Cielo

All this fascinated me, so in the mid 90s I set out to create a
simulation of my own inspired by it. I named it Cielo. I've long since
lost the C++ source code.

In Cielo, replicators live on a 2d grid. Each location on the grid has
its own memory. The assembly language I designed allowed programs to
move in the grid, split into two programs (one goes into a neighboring
location), and merge with a neighboring replicator. Multiple processors
could exist in a single locations.

There was also a notion of resources where resources would need to be
harvested from the environment in order to grow, and dying replicators
would be turned back into resources.

I saw interesting things emerge: replicators would quickly evolve to
move around to graze for resources, replicators became more efficient,
and evolved new looping code to help with moving around and harvesting
resources.

# Avida

I never did anything with Cielo, but other people did take the idea of
Tierra much further and implemented a system called
[Avida](https://alife.org/encyclopedia/digital-evolution/avida/) and
published a lot of academic research on it, including in prestigious
journals like Nature. I'm happy to be acquainted with one of the
creators of Avida: [Charles
Ofria](https://en.wikipedia.org/wiki/Charles_Ofria).

# Langjam and Apilar

Over the years, the idea of Tierra-like systems never let go of me. I
kept tinkering with half-baked simulations based on the idea, leaving
them half-finished. I would get stuck in ambition usually, and then move
on to another hobby project in my spare time.

So langjam was a great way to become less ambitious and actually finish
something. I had 48 hours. Go!

Apilar ("stack" in Spanish) is a Tierra-like system that's based around
the concept of a stack machine. There are no registers, and instead
instructions operate on the stack. So, for instance this apilar program
calculates `(5 + 7) * 8`:

```
N5
N7
ADD
N8
MUL
```

Besides the basics of arithmetic, logic and control flow, Apilar has a
bunch of instructions to help with replication: reading from memory and
writing to it, starting up new processors and splitting a computer into
two.

And I did it. I got it all working in 48 hours (with sufficient sleep!
sleep is important). At the end Apilar had simple text-based graphics, a
command-line UI, it regularly dumped the whole simulation to disk for
analysis.

# An Apilar replicator

Before the langjam was over I wrote (and extensively debugged) my first
replicator and let it go in the simulation:

```
# This is a full-on replicator that can be used
# to see the simulation. It replicates itself,
# tries to grow memory, splits into two

# startup delay, because the stack of the copy
# will have the wrong start address without it
NOOP
NOOP
NOOP
NOOP
NOOP
NOOP  # delay so we take the right address after SPLIT

# take the address of the start, adjusting it for the delay
ADDR  # s
N6
SUB   # adjust s for delay
DUP   # s c
DUP   # s c c
N8
N8
MUL
ADD   # s c t target is 64 positions below start
SWAP  # s t c

# start copy loop
ADDR  # s t c l
EAT   # do some eating and growing while we can
GROW
SWAP  # s t l c
ROT   # s l c t
DUP2
ADD   # s l c t c+t
ROT   # s l t c+t c
DUP   # s l t c+t c c
READ  # s l t c+t c inst
ROT   # s l t c inst c+t
SWAP  # s l t c c+t inst
WRITE # s l t c
N1
ADD   # s l t c+1
ROT   # s t c+1 l
SWAP  # s t l c+1
DUP   # s t l c+1 c+1
ADDR  # end
N7
N3
MUL   # 21
ADD   # s t l c+1 c+1 end
LT    # s t l c+1 b
ROT   # s t c+1 b l
SWAP  # s t c+1 l b
JMPIF # s t c+1

# done with copy loop
DROP  # s t
OVER  # s t s
ADD   # s s+t
DUP   # s s+t s+t
START # s s+t spawn processor into copy
# now split memory just before it
N2
SUB   # s s+t-2 split_addr
RND   # random direction
SPLIT # split from s+t-2
JMP   # jump to first addr
```

And in a text-mode view of the world, I saw this:

![A replicator that has grown into a blob on a 2d map](/img/apilar.png)

It was working!

Every `#` is a computer, with one or more processors on it. The rest
(`.`, `x`) are indicators of free resources in the area without
computers. What you see here is a replicator that has managed to spread
to quite a few new locations, starting to fill the map.

After a while, due to mutations, new behavior would emerge and the
evolutionary process would be off into an unknown direction.

# Langjam Results

Apilar wasn't a langjam winner. Here's a
[video](https://www.youtube.com/watch?v=g_dBJW8q7QA) of who did win, a
lot of neat stuff. My congratulations to the winners!

And I got Apilar, prize enough. So what happened next?

# The introduction of death

I started to explore Apilar runs in more depth, letting it run for a
while. I noticed that simualtions would tend to peter out and
replication stopped. What happened?

I speculated that it was due to overcrowding: it was too hard for a
computer to die. When the map had filled up, replicators would be locked
in place unable to place copies of themselves in neighboring locations.
After a while they would all be mutated out of functioning, and that
would mean the end of the evolutionary process.

**So paradoxically in order to have life, I needed to introduce death.**
I introduced a simple measure where randomly some computers would be
wiped out. This would create enough space for replication to sometimes
succeed. After this modification, simulations would continue to run
indefinitely, so I think my hypothesis was correct.

# Early optimization

It turns out my original replicator sucks. Those 6 NOOP instructions in
the beginning for instance were quickly dropped. Substracting 2 in the
end before split also turned out to be unnecessary.

# Neat stuff: obligate multiple processors

An Apilar computer in the default configuration supports up to 10
processors. Each update of a computer would run all the processors at
the same time, so there was strong selective pressure to use this CPU
time for useful purposes.

Eventually a descendant evolved that would grow much more quickly than
before. My 10 year old son Marcus watched the simulation and asked what
would happen with it if I restricted the maximum amount of processors
to 1. I knew that would fail -- 2 is the minimum for it to work. I tried
with 2 processors, but it turns out the replicator did not grow. I then
went to 3; still this descendant was a dud. 4 processors; still nothing.
_I had to go all the way up to 9 processors_ for it to be viable. So not
only could it use all those processors, it _had to_. Cool! Thanks,
Marcus!

I don't know why; the evolved code was clearly based off my original
replicator and some regions were highly preserved, but somehow it had
evolved some complex choreography that made use of it.

# Read/write heads

My original simulation had a problem: addresses are stored on the stack.
When a `SPLIT` instruction breaks a computer in two, all addresses on
the stack that point below the split point would be incorrect. Similarly
with `MERGE` a processor could find its stack suddenly corrupted if it
was on the second half of the merge. Evolution could handle that, but I
wanted `SPLIT` and `MERGE` to be more equitable.

So over this weekend, I went back to an idea I implemented in Cielo:
read/write heads. Addresses are no more stored in the stack but in
special variables. These variables are pointers to the stack that the
processor could use to `READ` and `WRITE` as well as move them `FORWARD`
and `BACKWARD`. When a `SPLIT` or `MERGE` occurs, the simulation now
automatically adjusts all the read/write heads to remain correct. Here's
the [instruction set
documentation](https://github.com/faassen/apilar/blob/main/doc/language.md).

The same logic was also very handy to introduce insert mutations where a
new random instruction is inserted into the memory, instead of the
simple overwrite mutations I had before. It turns out insert mutations
are very beneficial to evolution.

Here's the new starting replicator I wrote:

```
ADDR    # h0 has start of replicator
N1
HEAD
N0
COPY    # h1 has start too, used to READ in replication loop
N2
HEAD
N0
COPY   # h2 also has start
N8
N8
MUL    # 64 on stack
DUP
FORWARD # move h2 down 64, used to WRITE in replication loop
DUP
ADD     # 128 on stack
N3
HEAD
N2
COPY   # h3 at same address as h2
N4
HEAD
ADDR   # h4 is at start of replication loop
N8
N8
MUL
EAT    # try to eat 64 resources
N1
GROW   # try to grow 1 resource
N1
HEAD
READ   # read instruction onto stack
N1
FORWARD # move read head forward
N2
HEAD
WRITE  # write instruction at h2
N1
FORWARD # move write head forward
DUP     # 128, 128 on stack
N3
DISTANCE # read distance between h2 and h3
SWAP
LT      # if distance is less than 128...
N4
HEAD
JMPIF   # jump back to start of replication loop
N3
HEAD
START   # start new processor on offspring
N2
BACKWARD # jump back 2
RND
SPLIT   # split offspring at this point
N0
HEAD
JMP     # jump back to start of replicator
```

It's 57 instructions long.

# More evolution

The whole "copy 128 instructions" business was hopelessly inefficient
and quickly evolved away due to a point mutation. The jump backward 2
before the split point also was not very useful and would evolve away.

I watched the map undergo fascinating transitions: at some point half of
the map was sparsely populated and the other half densely populated.
Disassembly of replicators on the sparsely populated area found use of
the `MERGE` instruction, which suggests a form of predation where
replicators exploit neighbors by merging with them first.

Here's one of those evolved replicators that uses `MERGE`, with
speculative comments by me:

```
ADDR     # start of replicator
MERGE    # merge with neighbor - what's on the stack here?
N1
HEAD
N0
NOOP
NOOP
ADDR
MERGE   # try to merge again
N1
HEAD
N0
COPY
# any 0..255 value that doesn't have an instruction is interpreted as noop
NOOP # 89
N2
HEAD
N0
NOOP # 216
COPY
N8
N8
MUL
DUP
FORWARD # still move 64, highly preserved
NOOP # 60
HEAD
SPLIT   # try a split for good measure
NOOP # 170
NOOP # 170
NOOP
N4
HEAD
ADDR
ADDR  # start of replication loop
EAT   # eat - what's on the stack here as the amount to eat?
N1
GROW  # grow 1 instruction
N1     # read & write section here, highly preserved
HEAD
READ
N1
FORWARD
N2
HEAD
WRITE
N1
FORWARD
RND   # no more use of distance, just a random 0..255 number?
N4
HEAD
JMPIF # jump back if the number isn't 0, good chance
NOOP # 120
N8
NOOP # 140
NOOP # 140
HEAD  # head 8, which is really head 0 due to clamping
START # start a new processor at h0
NOOP # 241
NOOP # 134
NOOP # 173
RND
SPLIT # try to split
# don't jump back, the processor is either going to die here if
# no offspring emerged, or run on offspring. Does it jump back somewhere below?
```

Interestingly it's 63 instructions long, longer than my original
replicator.

The area of different sparsely and densely populated areas of the map
lasted for quite a while. But a while later when I came back to it, the
simulation had filled up with replicators completely. I think the prey
had evolved a too effective way to counter predation -- disassembly
found evidence of the use of the `SPLIT` instruction in the middle of a
tight copying loop.

# A longer run

I took the `MERGE` replicator I showed before and restarted the map. It
was viable. In time it evolved into a map with some sparse and some
dense areas like I've seen before. I let it run overnight. I came back
to a fairly sparsely populated fast moving world:

![A more sparsely populated map.](/img/apilar-longrun.png)

I disassembled one of the evolved replicators. I checked -- it's viable
and when I seed a world with it, it results in a similar sparsely
populated dynamic map. It was very long as stuff was going on I don't
understand, but I managed to extract a shorter piece that seems to work.
Let's try to read it.

First a word about stack underflows in Apilar: I don't know whether the
stack is always empty but it certainly starts empty. If the stack
underflows, then unsigned 64 `MAX` is placed on the stack.

If we try to get a value from the stack with a certain maximum, it's
clamped to the range it wants using the remainder operator. For
instance, there are 4 directions. Stack underflow clamped to 4 happens
to be 0, which is the direction north.

```
ADDR    # h0 to start
MERGE   # try to merge with direction west (stack underflow)
HEAD    # h7 due to stack underflow, starts empty
EAT     # try to eat 127 resources
NOOP
NOOP
NOOP
NOOP    # 244
NOOP
EAT     # eat 127
NOOP
EAT     # eat 127
N7
N8
COPY    # copy h0, start into h7, [7] on stack
NOOP
NOOP    # 182
N8
N7
N2      # [7 8 7 2] on stack
HEAD    # h2 [7 8 7] on stack
COPY    # copy h7 (start) into h2, [7 8] on stack
NOOP    # 83
MUL     # [56 on stack]
FORWARD # move h2 forward 56, so 56 below start
START   # start a new processor there
HEAD    # h7 (due to stack underflow)
SPLIT   # try to split at h7, before start
N4
HEAD    # h4
EAT     # eat stack underflow, 127 resources
ADDR    # h4 to this address
GROW    # grow stack underflow, 127 resources
HEAD    # h0
READ    # read
N1
FORWARD # move h0 forward 1
N2
HEAD
WRITE   # write again at h2
OR      # 1 due to stack overflow
FORWARD # forward h2 forward 1
RND     # random number 0..255 on stack
N4
HEAD    # h4
JMPIF   # jump to start of replication loop if random number is not 0
N0
DUP     # [0 0]
HEAD    # h0, [0]
SPLIT   # split at h0, direction 0 so north
START   # start new processor at h0
JMPIF   # jump with underflow, so jump to h7
```

This replicator has evolved a new startup section before the replication
loop, and it uses it to try to merge with neighbors and then split from
them again. It doesn't eat in the replication loop anymore, only grows.
It's also shorter than my original replicator, 52 instructions long.

It's interesting that evolution has even modified the central copying
loop quite significantly: no more use of `DISTANCE` or `LT`, no more
`EAT`, and the use of head 4 which was never in my original replicator.

The amount of use of stack underflow is interesting. If a processor runs
this code _with_ something on the stack, something else may happen
entirely. I don't see any code that makes use of this, but I may be
misreading it. And mutation or other replicators could definitely cause
such rogue processors to appear.

# Apilar futures

I have a lot of ideas for Apilar. Here's a few.

I've been working on an improved web-based user interface for it so it's
easier to explore.

I also want to introduce the notion of multiple islands -- instead of
the world being a single grid, the world consists of loosely connected
islands. Each island could have a different configuration, with
different amounts of resources and more fundamental settings such as
maximum of processors and update rules.

If you're interested in Apilar, please let me know! I'm on
[Twitter](https://twitter.com/faassen),
[email](mailto:faassen@startifact.com) and there's also the [Apilar
issue tracker](https://github.com/faassen/apilar/issues).

# Side-effect: learning

Whenever I do a hobby project, I challenge myself to learn a lot of new
things.

I wrote Apilar in Rust. I learned a lot of new things about Rust and its
various libraries along the way. To support the new web UI I've used
[Axum](https://github.com/tokio-rs/axum) and [Tokio](https://tokio.rs/)
for instance. And for the web frontend (in TypeScript with SolidJS) I've
used [PixiJS](https://pixijs.com/).

So I now consider myself more proficient in Rust as a side-effect.
