+++
title = "lxml should now compile with gcc 4.0"
date = 2005-06-17
slug = "lxml-should-now-compile-with-gcc-4-0"

[taxonomies]
tags = ["lxml"]
+++

Recently I started getting reports that lxml does not compile with gcc
4.0. Investigating this an issue with Pyrex was quickly identified -- it
generates C code that is in fact illegal, was accepted by older gcc
versions, but gcc 4.0 refuses to.

Now we're going to see open source cooperation in action. The issue with
gcc 4.0 was first reported by Mikhail Sobolev, who is bravely running
Ubuntu Breezy, which apparently switched over to using gcc 4.0 for its
build environment. Just after the release I got a second report by
Olivier Grisel (from the company Infrae does a lot of work with, Nuxeo),
saying it also didn't work on Fedora Core 4, which apparently also uses
gcc 4.0.

As a result of this, I installed gcc 4.0, and went to the Pyrex list to
see whether anyone had already reported the same thing. Yes, there was,
John Palmieri of Red Hat reported the issue (mentioning in actual
earlier report by Jeremy Katz) and actually included a patch to solve
this, though to an older version of Pyrex, 0.9.2.1.

It did however apply cleanly to 0.9.3 as well. Applying this patch, I
discovered I still would get compiler errors, though less so, and they
looked more like the ones reported by Mikhail and Olivier. In some
further communication, it turned out that FC4 as well as Ubuntu breezy
already have this patch to Pyrex applied. Meanwhile I also learned that
Mac OS X Tiger is shipping with a gcc 4.0 build environment as well,
further spreading the amount of platforms on which lxml won't work.

Not really expecting I'd get anywhere, I started looking through the
Pyrex compiler code to see whether I could fix the remaining issue.
Since I knew what kind of bogus C code was being created, I could track
down the code that did this fairly easily. I then made a small change,
not guided by any actual knowledge of the Pyrex compiler. It does
however, seem to work.

I reported this back to the Pyrex and lxml mailing lists. Mikhail had
some trouble applying my patch, and said it was already there. Some
confusion arose; had the Ubuntu people produced the exact same patch as
I did, line for line? Surprising, but since it was only a few lines, not
impossible.

Olivier did get everything working though and produced a cumulative
patch for Pyrex 0.9.3. Mikhail's problem was finally resolved when
Andrew Bennetts from Canonical (the Ubuntu developers) popped in on the
lxml mailing list (wow!) and pointed out my mistake -- I accidentally
had produced a patch file that was in reverse, _removing_ my fixes.

After this was clarified, it all worked for Mikhail too. I updated the
lxml web pages and installation notes to include this info for those
compiling with gcc 4.0. You can find them here:

<http://codespeak.net/lxml/installation.html>

Thank you everybody!
