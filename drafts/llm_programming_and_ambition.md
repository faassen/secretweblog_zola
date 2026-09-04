# Retuning My Ambition in the Face of LLMs

I like creative hobby programming. Toys, tools, games, artificial life
simulations, whatever strikes my fancy. I like it for the outcomes but also for
what I learn along the way, both about the problem domain and about
programming. This is _play_, which I highly recommend for its own sake, and not
to worry about outcomes too much. Play is not grind.

But here I'm going to talk a bit about the outcomes of play anyway. I do this
because I've been busy retuning my ambition, because using AI to program,
agentic AI, LLMs, vibecoding, whatever you choose to call it, has been having
interesting effects.

## LLM programming

LLM programming gives one several interesting abilities:

- Refactoring is much easier. I like to refactor early and aggressively and LLM
  agents can do it for me.

- Porting code is much easier. LLM agents are good at taking code in one
  language and porting it to another.

- You can do things you knew already more quickly.

- You can do things you previously didn't know how to do.

I have all kinds of things to say about each of them but I'm going to focus on
doing things you didn't know here.

## Doing things you didn't know

I don't know how to write a GPU shader. LLMs can write a GPU shader. There are
many things LLMs can do that I don't know how to do. Now I can do them too, and
get into trouble.

I'll note that doing things I didn't know how to do in programming is not
_new_: I've happily used many libraries and tools that let me do things I don't
personally know how to implement.

But LLMs let you remix that stuff much more wildly.

## Ambition

You might think my play projects would be my least ambitious ones, but in many
ways they're _more_ ambitious. It's fun to play with things that challenge you.
And LLMs let me try things I wouldn't even start doing without them! This is
dangerous stuff.

And thus my play projects tend to turn into research projects. They already did
before, but it gets worse.

Let me give you some examples.

## Earth-like cloud cover

I wanted to procedurally generate an Earth-like cloud cover of a planet, as
seen from space. We can procedurally generate lots of things - plants, and city
scapes, and so on and so on. So a cloud cover that looks decent shouldn't be
that hard, right?

Turns out that while there _might_ be some proprietary systems that can do
this, there's very little about this in the open in the scientific literature
or game programming lore.

We can do a realistic looking Earth-like cloud cover with a full-on weather
simulation, but that's extremely expensive. This was supposed to be a graphics
toy, not a weather model.

We can procedurally render clouds as seen from the ground - there's tons of
stuff on that. We can do _unrealistic_ cloud covers of an Earth-like planet
seen from orbit easily enough. We can do a realistic looking cloud cover of
_Jupiter_ and there are actually papers on how to do it published back in the
1980s as it turns out they used computer models to do the Jupiter special
effects in the movie "2010: The Year We Make Contact", the sequel to "2001: A
Space Odyssey". Amazing stuff!

What most people do when they want to render a realistic Earth cloud cover as
seen from space is to take a texture of clouds from the real Earth and wrap it
around their planet.

But I was naive. I tried. I came up with various procedural models and then
used evolutionary strategies to explore the parameter space, but in the end I
gave up. I say "I" but I really mean the LLM did a lot of this. The LLM said
all kinds of things, but much of it was probably correct, but I don't know
enough about procedural modeling or weather simulation to judge.

##
