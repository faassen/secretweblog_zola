+++
title = "Python 3.0 is incompatible with Python 2.0"
date = 2008-02-01
slug = "python-3-0-is-incompatible-with-python-2-0"

[taxonomies]
tags = ["python3"]
+++

# Python 3.0 is incompatible with Python 2.0

Jesse Noller
[wrote](http://jessenoller.com/2008/02/01/i-hate-slashdot-python-3000-is-incompatible/):

> I hate slashdot: Python 3000 is incompatible?!!!

and then says:

> A sensationalist title, summary and normal slashdot commenters:
> "Python 3.0 To Be Backwards Incompatible"

I don't see how the title is sensationalist. Python 3.0 *is* backwards
incompatible with Python 2.0. Conversion scripts are supplied, but that
fundamental reality stands. The
[summary](http://it.slashdot.org/article.pl?sid=08/02/01/1624247) on
Slashdot is this:

> Organizations using Python will be affected in a major way by changes
> in store for the language over the course of the next twelve months,
> Linux.conf.au attendees were told this morning. The Python development
> community is working towards a new, backwards-incompatible version of
> the language, version 3.0, which is slated for release in early 2009.
> Anthony Baxter, the release manager for Python and a senior software
> engineer at Google Australia, said "We are going to break pretty much
> all the code. Pretty much every program will need changes." Baxter
> also added another tidbit for attendees, saying that Python accounts
> for around 15 percent of Google's code base."

I don't see anything sensationalist in this either. It's true:
organizations and communities using Python are going to be impacted in a
major way by the release of Python 3.0, and the reason they are going to
be impacted is the non-backwards incompatibility. There are significant
consequences for organizations that need to deal with this transition -
for the organizations that go ahead and make it, and also for the
organizations that wait and see and continue to use the Python 2.x
version.

I haven't read any of the Slashdot comments. I'm sure some of them are
very wrong, and very annoying; that's normal. It's just that I object to
spreading the idea that this message is sensationalist or somehow wrong.
It's not. It's the reality that one way or another the Python community
will have to deal with. Objecting to an expression of this reality
spreads the wrong message.

Recognizing that Python 3.0 is backwards incompatible makes us aware
that we are heading for something we will have to deal with one way or
another. It's a useful wakeup call for people who might not be aware of
this.

The language developers are working on a migration script and are
adjusting the Python 2.x line of Python so that we can prepare our code
bases. By all means, spread that news too *in addition* to the backwards
incompatibility news. But don't object if news sources forgo such
subtleties in spreading the main message to take home about Python 3.0:
without special action on your part, your code *will* break when you try
to run it with the new interpreter. Adopting Python 3.0 as a community
will mean an awful lot of code to transition. It'll be a process of
years, and it won't be easy.

(as an aside: I *think* I wrote a reasonable posting about Python 3.0
just now. Of course that's what I thought when I posted about this last
time, and then I had people land on my head like a ton of bricks. It
left a very unpleasant taste in my mouth. Let's hope this time will be
better. I think having an open discourse about this is important.)
