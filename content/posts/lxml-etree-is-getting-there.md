+++
title = "lxml.etree is getting there"
date = 2005-01-08
slug = "lxml-etree-is-getting-there"

[taxonomies]
tags = ["lxml"]
+++

# lxml.etree is getting there

The lxml.etree implementation of ElementTree, on top of libxml2, is
getting there now. It features automatic memory management and quite a
bit of ElementTree compatibility. Not all of the ElementTree API has
been implemented yet, but enough for many use cases.

I did discover in the process of debugging that you need a recent
version of libxml2 to make it all work without memory errors; apparently
earlier ones, like the version in my debian unstable (2.6.11), contain
some bugs still.

I'm testing with libxml2 version 2.6.11 myself, so you may want to try
that one too if you want to play with this code. You'll have to modify
setup.py to make it use your installation of libxml2 -- the variables to
modify are on the top.

So, check out out (svn co <http://codespeak.net/lxml/trunk> lxml),
compile it, and do a 'make test'. And tell me whether the tests pass on
your machine!
