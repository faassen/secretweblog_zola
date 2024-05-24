+++
title = "Changing the Python default encoding considered harmful"
date = 2005-08-02
slug = "changing-the-python-default-encoding-considered-harmful"

[taxonomies]
tags = ["python", "unicode", "silva"]
+++

Ian Bicking [complains about unicode in
Python](http://blog.ianbicking.org/do-i-hate-unicode-or-do-i-hate-ascii.html)
and wants to [change the default
encoding](http://blog.ianbicking.org/illusive-setdefaultencoding.html)
in his Python application, and wonders why Python makes it so hard to
change it.

It's very tempting to change the default encoding, and I messed around
with it too when I first explored Python unicode issues a few years ago.
However, I now think that changing the default encoding in a Python
application is not the right way to go. If you do so, you run the risk
of writing applications or libraries that aren't going to work correctly
on any other system.

For a slightly involved example take the case of Silva and
PlacelessTranslationService.

Silva (a Zope-based CMS) a few years ago went through a painful
transition to use unicode inside throughout. The ZPublisher can be
configured to encode any unicode response to UTF-8. For input, we make
sure everything is decoded into unicode.

This all worked pretty well, though of course we did find 'leaks' once
every while due to oversights in not doing the right encoding bit. The
leaks are aggrevated by the fact that Zope 2 isn't very unicode pure as
a framework.

Then we installed PlacelessTranslationService. This had been developed
for Plone, which does not use unicode the Python way. Instead, as I
understand it, it stores its content as UTF-8, and then the codebase has
a numer of hacks to make it deal with unicode strings too. Not by
changing the default encoding, but by overriding an important StringIO
that gets used by the Zope Page Template engine to do something very
similar -- encode to UTF-8 any unicode that gets passed to the page
template engine.

Suddenly we were again in a mire of unicode-related bugs. Our assumption
that the output of a page template was a unicode string was broken by
PlacelessTranslationService, and this caused things to break in subtle
ways. Desperate hacking ensued... (Five 1.1's i18n support should
eventually fix this)

Changing the default encoding is tempting, but you're really going to be
in trouble if you're going to give code that does string concatenation
to anyone else. Imagine you've written an XML processing library and you
happily concatenate UTF-8 strings with unicode strings in its internals
-- it'd almost certainly not work correctly as soon as I use it in my
application, unless I change the default encoding as well.

The best way to deal with unicode is to make sure that everything that
enters your application (from the filesystem, from the web, or a
database) is decoded into unicode, and everything that leaves your
application is encoded (preferably to UTF-8).

Thinking it was easier before unicode came along is probably slightly
deceptive -- you would've run into worse problems as soon as your system
had to deal with more encodings than latin-1. String encoding issues
just are _hard_.

That's not to say the situation with Python's unicode support isn't
frustrating. I've thought long and hard about this when I suffered
through this, but I couldn't really think of a better solution than the
route Python took. If Python didn't have to worry about backwards
compatibility I'd suggest making all strings unicode such as Java did,
and introducing a separate for storing bytes, but that wasn't possible.

I do agree that life might've been easier if the default encoding of
Python had been set to UTF-8 instead of to ascii. On the one hand this
is catching more errors. If you're willing to break the ease of
backporting code to older Python versions, I believe if, say, Python
2.5, shipped with a default encoding of UTF-8, it wouldn't actually
_break_ anything. But if I did it for _my_ Python, I'd have problems
soon as I gave my code to someone else.
