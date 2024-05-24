+++
title = "lxml 0.9.1 released!"
date = 2006-04-06
slug = "lxml-0-9-1-released"

[taxonomies]
tags = ["lxml", "linux"]
+++

A bit late, but still worth a blog entry: lxml 0.9.1 was released last
week! This is a bugfix release following up on the great 0.9 release
done a bit before.

With the 0.9 release, lxml is really shaping up. It has a ton of
features resulting from the input from many people, and most importantly
includes a lot of work done by the extraordinarily cool Stefan Behnel
who has been driving a lot of lxml development for a while.

lxml 0.9 contains a lot of new stuff: performance improvements and
integration with libxml2's error reporting functionality, custom Element
classes and SAX support, and XSLT extension functions, and that's only
part of the list, most of which has been done by Stefan.

lxml 0.9 was also the first release where we worked with eggs. If you
have the right versions of libxml2 and libxslt installed on your system,
you can now use `easy_install lxml` to install the latest version of
lxml (0.9.1 right now) and start working with it. Thanks to eggs
contributed by a range of people, we've got eggs for Linux, Mac OS X and
Windows.

So, check out [lxml](http://codespeak.net/lxml)!

And here's the [lxml cheeseshop
entry](http://cheeseshop.python.org/pypi/lxml/) with the various eggs,
source code, and a windows installer as well.
