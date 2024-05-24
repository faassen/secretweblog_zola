+++
title = "Practical experience with Zope 3"
date = 2005-09-06
slug = "practical-experience-with-zope-3"

[taxonomies]
tags = ["zope"]
+++

## Practical experience with Zope 3

Jeff Shell has posted [a very interesting blog entry on his experiences
with Zope
3](http://griddlenoise.blogspot.com/2005/09/major-zope-3-client-project-finished.html).
Here at Infrae we've also been working with Zope 3 for a few months now
and I thought this would be a good opportunity to share some of our
experiences.

### Maturity

I can affirm now from practical experience that Zope 3(.1) is mature
enough to develop real applications, and a very nice environment to work
with. It's a Pythonic system that doesn't get in the way of the Python
programmer.

That said, some pieces weren't as fully baked as we would like. Some of
these holes have been plugged by zope.formlib and zc.catalog, Zope 3
extensions both created by Zope corporation. (more particular s later).
We've been also trying to plug some other holes (query engine, smart
file upload widget) in some work we hope to release at some stage the
following months. Hopefully Zope 3.2, due for the end of this year, will
make the out of the box experience more complete.

### Must-use extensions

zope.formlib: I would very, very strongly recommend anyone developing
Zope 3 to use zope.formlib instead of the built-in form system as this
vastly improves the form experience. Ignore browser:editform and
browser:addform in zope.app.form. I recommend zope.formlib being put in
the Zope 3 core as soon as possible, though that does require Zope 3 to
run on python 2.4, which zope.formlib requires.

zc.catalog: I would also recommend looking at zc.catalog as it has nice
functionality equivalent to Zope 2's keyword index (called SetIndex).
More goodies are also in there, but I've yet to explore them. This needs
Python 2.4 as well.

### Python 2.4

Zope corporation turns out to be using Python 2.4 with Zope 3.1 for
their own developments. This works fine and you can do the same. I hope
we can do an 'official' shift to Python 2.4 with Zope 3.2, though that
will require a security review of the to-be-released Zope 2.9, which
will include 3.2... I think it would be odd that the main developers of
Zope 3 are all using Python 2.4 and we'd have to support Python 2.3 only
for Zope 2.9 compatibility.

### Security system

The Zope 3 security system is the one place where I keep tripping up.
This is a shame as the rest of the system is very nice and Pythonic.

On the one hand, I can't really blame Zope 3 too much for this, as
whenever Zope 3 security complains there indeed _is_ something wrong
with my security declarations... So, part of this this reflects more the
fundamental difficult nature of security than something wrong with Zope 3. Zope 3 just forces you to have to think about it.

That said, I still think we have a problem here. I'm very afraid the
current system turns off beginners too much, including Python
programmers coming to Zope 3 for the first time. As a small example,
right now, a beginner would have no idea how to start to debug these --
I had to ask on the mailing lists myself before I understood that I
needed to turn off suppression of unauthorized errors in the error
logging for instance. Sometimes too the errors are rather obscure; I've
had a case where an annotation returned None but only because an
underlying attribute wasn't accessible, not because it wasn't there.
This might be a bug in the annotation system -- I want an unauthorized
error.

It's also too easy to forget declarating security when you add a new
field or method, which makes for a frustrating "why do I need to be in 3
places to change this" programming experience. Since the rest of the
Zope 3 experience is pretty nice and feels Pythonic, this is a shame.

The good news is that the Zope 3 security system is replacable with
something else. I don't think "just write your own security policy" is
the answer to my complaints, as writing a security policy is hard and
most people will rely on the default, but it does make experimenting a
lot easier. I hope people will help me think about this issue.

### Pluggability

Zope 3 excels at pluggability. I could plug without having to modify
code whenever I wanted to. As I said above, even the security policy is
pluggable.

While already great, it's not perfect -- implementing your own source of
groups for instance requires you to fake implement some container API
you don't actually use. That said, a fairly easy workaround was
possible. The email message delivery system in the core also needs some
work to be as flexible as I'd like. But again, a doable workaround was
possible.

### Reusable code extraction

Jeff Shell already mentioned that Zope 3 makes it easier to build an
extensible framework while actually building something useful for a
customer; Zope 3 gives a lot of flexibility and extensibility right out
of the box without much effort for the application developer. This I
think is great news for the long term maintainability and extensibility
of Zope 3 applications.

In addition, I can say that extraction of reusable code from Zope 3
projects into reusable libraries is much, much nicer than doing it in
Zope 2. That doesn't mean it's actually easy; writing reusable code is
always hard, but it's now much more doable. This is one of the coolest
things about Zope 3.

As I already mentioned above, we now got a little library with some
improved file widgets, and a query language on top of the catalog. We
also have a little workflow engine; we know various others are being
worked on, but I was too much in a hurry to try adapting any of the
'big' ones.

Framework extraction from practical applications is often the best way
to build truly useful reusable components, so Zope 3's vastly improved
extractability of reusable components is great news. I hope that this
improved extractability of reusable components will eventually result in
a "cloud" of components that the many applications to be built on top of
Zope 3 can start sharing. I envision a process where the truly popular
and useful packages can, after a period of revision, become accepted
into various larger "framework of frameworks" or "distributions", such
as the Zope 3 core and [Z3ECM](http://www.z3lab.org).
