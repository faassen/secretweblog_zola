+++
title = "Grok: the Idea"
date = 2013-11-28
slug = "grok"

[taxonomies]
tags = ["python", "zope", "grok", "planetpython"]
+++

It's been a month since I posted an entry in this ongoing series, but I
got positive feedback and the story is not over yet, so here's a new
entry! I hope you enjoy it!

# Lost at CERN

In the summer of 2006 I went to the EuroPython conference, which that
year was held in CERN, Switzerland. There was to be a Zope sprint ahead
of the conference, so I came a few days earlier.

I got there in the evening. The next morning I tried to look for likely
Python programmers. Normally this is not a difficult task: programming
geeks tend to have a special look about them. But at CERN this doesn't
work: many people at CERN look like they could be a programmer, and many
of them of course are, but they were not there for EuroPython.

I got slightly lost in the complex, and was given directions by some
gentlemen. They could've been janitors or Nobel prize winners, I will
never know. CERN is a special place.

I finally concluded I had planned things a bit wrong, and had arrived at
CERN one day earlier than everybody else. So I had a day to kill.

I remember the weather was gloriously sunny and warm. I was hanging out
in the cafetaria for a while. I started thinking about my experiences
with the new Zope, and its frustrations, and what it would take to turn
it into a web framework without these frustrations. A web framework that
I would like to use myself and would hopefully also be a bit less
intimidating to beginners. Zope was starting to have a problem
attracting new people -- the old Zope was out of date, and the new Zope
was too intimidating.

# The Idea of Grok

I decided to call this new framework Grok, as one has to give things a
name. Grok is a term originally from _Stranger in a Strange Land_, a
science fiction novel by Robert Heinlein, and is supposed to be a
martian verb for "to understand/to become one with/to drink in". From
there the word had made it into programming jargon.

Ruby on Rails had made popular the idea of "convention over
configuration"; if you just use some conventions (naming, placing in
modules, etc) for the entities in your system, the framework will know
what they are without you having to explicitly and verbosely having to
tell it. Since the new Zope had a problem with verbose configuration, I
figured we could apply convention over configuration to make things more
succinct.

In Grok you can use base classes (`grok.View`, `grok.Model`, etc) to
signal what type of class you're definining, and the system will deduce
from that how to register them with the Zope configuration system. Just
base classes by themselves aren't enough though -- many configuration
actions need parameters. We solved this with Grok directives.

For an example of a directive, You could associate a view with a model
using the `grok.context()` directive. Grok directives are special calls
you could make inside your class definition, like this:

    class MyView(grok.View):
        grok.context(MyModel)

`grok.context` would magically apply to the class it is called in, in
this case `MyView`, and set some information on it. These days we'd use
a class decorator for this instead, but Python didn't have those yet
then.

So far not much convention over configuration was going on. What I had
done was found a way to integrate configuration information directly
into Python classes so that you wouldn't have to maintain separate XML
files anymore for configuration. Convention over configuration came in
because you could _leave out_ `grok.context` and it would then
automatically associate the view with a model that happened to be
defined in the same module.

It turned out later that convention over configuration in Grok was not
as important as I had thought it was then. Some of the magic, even
created very deliberately and layered over a worked-out configuration
system, intimidated people and sometimes (though rarely) lead to
unexpected behavior. The reduction of verbosity by doing configuration
in Python near the code being configured was the main win; reducing that
configuration further was less important.

When the other sprinters arrived at CERN, I explained some of these
ideas to them and received some useful feedback. But it all remained
just an idea.

After the Python conference, I was lucky enough to get to see the first
web server (the web having been invented at CERN), and the Large Hadron
Collider, which, they told us, was going to collide hadrons Real Soon
Now.

This blog entry is a part of a [series on
Zope](/posts/my-exit-from-zope) and my
involvement with it.
[Previous](/posts/the-new-zope-as-a-web-framework).
[Next](/posts/implementing-grok).
