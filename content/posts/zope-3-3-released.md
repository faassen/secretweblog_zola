+++
title = "Zope 3.3 released!"
date = 2006-09-27
slug = "zope-3-3-released"

[taxonomies]
tags = ["zope", "release"]
+++

[Zope 3.3](http://www.zope.org/Products/Zope3/3.3.0) is
[released](http://mail.zope.org/pipermail/zope-announce/2006-September/002016.html)!

Thanks to the hard work by many contributors, but especially by Jim
Fulton and Philipp von Weitershausen to get the release out, we now have
a fresh Zope 3.3 waiting for us.

Besides many bugfixes, one of the most important new feature additions
is a much simpler API to register local components, such as utilities.
The old APIs still work, but now issue deprecation warnings. I've
adjusted some code to Zope 3.3 already and am quite happy with the work.

Onwards now to Zope 3.4! Next year we expect we'll complete the process
of turning Zope 3 into a collection of eggs, making it a lot easier to
reuse components of Zope 3 in other Python applications, and also
changing the way we develop Zope 3 ourselves.

We'll be continuing to improve our release process. For one, I'm now the
Zope 3.3 maintainer. I'll be pushing people to be sure to apply bugfixes
on the Zope 3.3 branch, and making sure we have a Zope 3.3.1 release in
the not too distant future.

The current release was a few months later than we initially desired. We
also had some comments on improving our documention on what changed in a
release. An excellent start of this is [already
available](http://kpug.zwiki.org/WhatIsNewInZope33) for Zope 3.3! We
have some ideas for making it work better, and will be trying to
implement some of those in the next release process.
