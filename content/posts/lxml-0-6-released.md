+++
title = "lxml 0.6 released"
date = 2005-05-15
slug = "lxml-0-6-released"

[taxonomies]
tags = ["lxml"]
+++

I've released lxml 0.6. lxml is an alternative, more Pythonic binding
for the libxml2 and libxslt XML processing libraries.

lxml 0.6 contains important bugfixes, in particular better namespace
support while handling attributes, as well as a fix for what turned out
to be totally broken behavior for etree.tostring(). An upgrade is
recommended.

A great new development is that the tests that helped expose these bugs
were contributed by people working with lxml on various projects. This
really helped me track down important problems. Thank you for the
contributions!

You can download lxml 0.6 as well as find out more information at the
site:

<http://codespeak.net/lxml>
