+++
title = "Debugging strategy: easy stuff first"
date = 2007-04-14
slug = "debugging-strategy-easy-stuff-first"

[taxonomies]
tags = ["programming"]
+++

I've been writing software for quite a while now, but the software I
write still has bugs. One uses various strategies to avoid bugs, but
bugs still creep in. Bugs happens all the time. I sometimes believe only
programmers are truly aware how flawed human reasoning really is and how
many mistakes a person can make without even noticing. Us programmers
are confronted with our own mistakes every day. The real world tends to
be more forgiving of slight mistakes than the virtual world of software.

So, your software has a bug.

When you have a bug, you look for its cause. Often you have a pretty
good idea about what the problem is, and you know you can fix it
quickly. You go in and fix the code, and, perhaps, hopefully, are able
to add an automatic test so the code can't break again in the same way
in the future. Done.

Often though you have no clue what the problem is. This can happen after
you've looked at a likely cause and found out it wasn't that after all.
"That's bizarre! That shouldn't happen!" You don't know where to start
debugging. You have some ideas about likely causes, perhaps, but you
know you are going to have to sit down for this one. What to do then?

One thing that has helped me in this case is the following simple
strategy: check the things that are easy to check first. Not because
these things are likely to be the cause of the problem -- they may in
fact be quite unlikely -- but simply because they're easy to check.

Check stupid things. Perhaps you didn't save the file. Perhaps you
didn't restart your program before testing. Check whether you're really
working on the right files. Perhaps some symlinks got crossed. Are the
versions of the libraries you're using really correct? Check whether the
web application that has the bug is really actually being run by the
server you thought it was. Perhaps there's another server hanging around
serving the buggy app and all your efforts have no effect. Check whether
the API you know so very well _really_ works in the way you thought it
did. It might be just a one line program to check. Yeah, it's unlikely,
but you won't waste a lot of time, so just do it.

Why should we be checking unlikely causes for our bugs? Even if the
chance that something is the cause is very small, the chance still
exists. And since it's quick and easy to check, just make sure. If it
was the cause of the bug, you're lucky and might've saved yourself hours
of head scratching only to slap your forehead in the end. If it wasn't
the cause of the bug, at least you've not wasted a lot of time to
exclude it, and you can move on.

Don't check unlikely causes that are _hard_ to check first. You may end
up checking those anyway, as it could be them after all. But not
initially. First check the easy stuff.

Also don't check the _likely_ causes first that are _hard_ to verify.
You think it's probably a threading issue? Oh no, that's difficult to
debug! What if that wasn't the real cause for the bug after all? You've
just spent hours testing for it. What if it turned out the bug was
really caused by something you thought unlikely to be it, and you
could've excluded it with just a minute of work? You would've wished you
had spent that minute straight away. It wouldn't have been a big loss if
not, and you might've hit the jackpot.

So check the things that are easy to check first.

Of course the best way to deal with bugs is not to create them in the
first place. If you find yourself dealing with the same type of bug over
and over again, consider whether you can change your way of working to
avoid them altogether. But as we all know, there will always be bugs...
