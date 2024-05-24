+++
title = "Implementing Grok"
date = 2013-12-02
slug = "implementing-grok"

[taxonomies]
tags = ["python", "grok", "zope", "planetpython"]
+++

# Towards the First Grok Sprint

I got the idea for Grok in the summer of 2006. In the fall I still
hadn't done anything yet about it. Then I gave [a talk at a German Zope
User Group (DZUG)
conference](/posts/older/dzug-keynote.html)
(the video of that now appears to have sadly disappeared off the
internet; if it's still somewhere I'd appreciate to get the link!). This
was the series of conferences that a few years ago got broadened into
the wider [PyCon.DE](https://2013.de.pycon.org/) (German PyCON)
conferences. I chatted about Grok with Christian Theune of Gocept. He
suggested we hold a sprint to build Grok at the Gocept offices.

So later on that fall I and my wife Felicia flew to Berlin and from
there were taken by Christian to the Gocept offices in Halle. There were
four of us at the sprint: myself, Christian, Philipp von Weitershausen,
and Wolfgang Schnerring. The first three were very familiar with Zope
both old and new. Wolfgang was new to it all, but had experience with
Ruby on Rails, so could offer us an interesting different perspective.

# Quadruple Programming

This sprint, we didn't do the pair programming that was pretty standard
in Zope sprints, but quadruple programming. How did that work?

We used a video projector to project the screen of somebody's laptop
onto the wall. The person at the keyboard was mostly either Philipp or
Wolfgang. The rest would look at the projection and give directions.
Christian made sure we didn't forget test cases by writing them down on
a whiteboard. I sat or paced around and just talked. People who know me
know I do that a lot anyway. I actually did not edit a single line of
code during the entire weeklong sprint myself, but I'd seen all of it
and was thoroughly familiar with it when I went home afterwards.

After a week of sprinting we got Grok from a design document to a
working implementation. We built the traditional wiki application with
it to try it all out in the end.

Starting Grok in a sprint like this made it a community project straight
from the start. This was beneficial when we went home and had to
cooperate online.

I wrote a
[report](/posts/older/grok-or-what-i-did-on-my-holiday.html)
about the sprint and Grok to my blog back then; it may be interesting
reading for some.

# Grok the Caveman

None of the other sprinters liked my proposed name 'Grok' for the
project. It was too nerdy, too obscure. Perhaps, it was proposed, we
should name it something like "Easy Zope" (I forget the exact name
proposed, but 'easy' was part of it). I protested and formulated what
Philipp later dubbed "Faassen's law":

> Don't use the name 'easy' or 'simple' in software, as it likely won't
> be and people will make fun of it.

Somehow during dinner we were discussing and imitating "Hulk talk", i.e.
"Hulk smash". People are silly like that, especially people like me. I
suddenly hit on the idea that Grok was actually a caveman, and that he
talked like this: "me Grok smash ZCML". Everybody immediately liked this
idea, as it had a sense of fun and fit the theme of Grok simplifying the
new Zope.

We had the luck that my wife Felicia was there. She's a graphics
designer, so we asked her Grok the Caveman, so we would have a mascot
for the project. She made several drawings and showed them to the group.
One of them was everybody's favorite. "But that one looks like me!" I
protested. "Exactly," they said, grinning. And thus Grok the caveman was
born.

Having a friendly caveman as a mascot/logo for your project actually
helped attract people to it. Having such a character gives a project a
face and gives people something to relate to. The web site theme was
inspired by it, and even a stand-up wooden version of the caveman was
made and used at various open source conventions.

I've been toying for a while with the idea of creating an elf character
for the [Obviel](http://www.obviel.org) project...

While I did mention cave women in my original blog post on Grok, I
wonder now whether our slogan "now even cavemen can use Zope 3" was
sufficiently inclusive of women, given all the attention given to
gendered language now... The word "cavepersons" would take away a bit of
the charm of the ridiculously ahistorical but familiar caveman concept.

# Grok Innovation

After I'd gone home from the first Grok sprint I could immediatetely
pick up the code and continue working with it. I factored out a library,
which contained what I think now was the most important innovation of
Grok. This was the notion of scanning Python modules for things
(classes, instances, decorators) that needed to be registered with the
system. This, we discovered, allowed us to do metaclass-like things with
Grok without the need for using actual metaclasses --particularly
picking up and registering relevant classes with the Zope configuration
system. Avoiding metaclasses is good if you can get away with it, as
they can lead to other unexpected behavior in subclasses. I called the
library [Martian](http://pypi.python.org/pypi/martian), to fit the
'grok' theme.

When Chris McDonough started what later became the Pyramid project he
used Martian to pick up configuration. Later on he reimagined Martian
and he created the [Venusian](http://pypi.python.org/pypi/venusian)
library, which I'm using today in Morepath. But that's another story.

# Grok as an Open Source project

Grok as an open source project was moderately successful. A little
community of people formed. It managed to attract a few people
unfamiliar with Zope technology, and also made the new Zope technology
more appealing to people who _were_ already familiar with Zope. We got
quite a few contributions, too.

We had regular Grok sprints that helped push Grok forward. We also
participated in the Google summer of code for a few years, under the
wider banner of the Zope project.

I was lucky enough that quickly after the initial creation of Grok I
could start using Grok in my professional life on customer projects.
I've been using it as the underpinnings in several large web
applications since then.

Various contributors also refactored Grok technology so it could be
plugged into the old Zope. From there the Plone community started using
it; it's still widely used there today. This whole old Zope
compatibility project was entirely pushed by contributors who weren't
part of the original group -- a sign of open source success.

# Grok and Zope

Grok was built on the new Zope. This gave Grok a running start and a
built-in community to draw from, and this was definitely part of Grok's
success. But many other Zope developers were not interested in Grok, and
quite satisfied with the original ways of doing things. Grok could not
have worked as a project to improve Zope itself -- there was
insufficient consensus. To create something new, we had to go around the
center.

Grok was successful at least for me personally: it made it possible for
me to use the new Zope technology without much of the pain. But was Grok
successful in being attractive to beginners? We certainly attracted
some. But there were problems.

While Grok was simple enough on the surface, its learning curve was not
as smooth as we'd have liked. Grok was too much like an iceberg; beneath
the surface lurked the vast codebase of the new Zope. If we wanted to
make Grok smaller and more comprehensible all the way down, we would
need to fix this.

This blog entry is a part of a [series on
Zope](/posts/my-exit-from-zope.html) and my
involvement with it.
[Previous](/posts/grok.html).
[Next](/posts/back-to-the-center.html).
