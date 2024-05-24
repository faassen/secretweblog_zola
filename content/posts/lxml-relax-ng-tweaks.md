+++
title = "lxml relax NG tweaks"
date = 2005-01-25
slug = "lxml-relax-ng-tweaks"

[taxonomies]
tags = ["lxml"]
+++

# lxml relax NG tweaks

The Relax NG support seemed to be working for lxml, until I tried it
with a complicated case: a modularized XHTML Relax NG schema.

Turns out the approach I was taking of turning an ElementTree tree into
a Relax NG schema is only of limited use. Relax NG schemas often use
`include` to load other schemas from the filesystem or URLs as well, and
that wouldn't happen as by then any information of where the original
XML document was is lost. I could find no way in the libxml2 APIs to
retroactively supply this information -- perhaps I should lobby for its
inclusion.

To make it work now, I use a different libxml2 API to load Relax NG from
the filesystem directly. You can now supply a file object or path to the
`RelaxNG` constructor.

I suspect the same problem will arise with loading modularized XSLT. I
haven't gotten around to investigating that yet.

*Update*: After some discussions with Daniel Veillard, it turns out my
assumptions were wrong, which is good. libxml2 documents *do* retain the
context information as a URL attributes, so this means that it should be
able to include the Relax NG modules. It doesn't however, at least
sometimes. It works when I start the program in the same directory as
the modularized RNG files, but it fails if I start it a directory
higher. This may indicate a bug in libxml2 or a further lack of
comprehension on my side; I'll try to write some sample code and take it
up with the libxml2 developers.

*Update (05-01-27)*: I've now tracked this down to a bug in the libxml2
library. My [bug
report](http://bugzilla.gnome.org/show_bug.cgi?id=165424).

*Another update, 5 minutes later*: Daniel Veillard has already fixed the
bug in libxml2 CVS! It turned out that `xmlCopyDoc` was indeed not
behaving as it should.
