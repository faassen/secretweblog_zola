+++
title = "lxml findall and xpath performance"
date = 2005-01-13
slug = "lxml-findall-and-xpath-performance"

[taxonomies]
tags = ["lxml"]
+++

# lxml findall and xpath performance

Update: lxml got quite a bit faster since this entry, see [here](/posts/lxml-performance-progress/).

I've been testing `findall()` performance on etree versus
ElementTree/cElementTree. cElementTree and even ElementTree are quite a
bit faster than lxml.etree at this stage. Possible causes of performance
loss:

- lxml.etree has to maintain proxy objects over the underlying libxml2 C
  tree.
- lxml.etree uses a weak value dictionary to maintain weak references to
  all proxies in use. This seems particularly slow.
- There's also a lot of UTF-8 to unicode conversion involved, as libxml2
  uses UTF-8 strings throughout, and Python uses double-byte unicode
  strings.

Unfortunately the Python profilers don't profile C functions called in
the extension module, which makes my measuring job somewhat harder.

Anyway:

    findall('//v') on ot.xml

    ElementTree: 0.13 s
    cElementTree: 0.11 s
    lxml.etree: 1.9 s

Whoah, not good for lxml.etree to lose out to pure Python that badly!

I also tested libxml2 xpath, which I added to lxml.etree today, and even
this is quite a bit slower at simple operations like (`//v`), somewhat
more to my surprise:

    xpath('//v')

    lxml.etree: 0.76 s

I think in part the large result set slows it down, as Element proxies
have to be created for all elements in it.

As an example of that, this is actually faster (as it only makes
strings):

    xpath('//v/text()')
    lxml.etree: 0.34

Of course, xpath is not only about raw performance, but also about
features, like this:

    >>> t = parse('ot.xml')
    >>> self.t.xpath('(//v)[5].text()')
    [u'And God called the light Day, and the darkness he called Night.
       And the evening and the morning were the first day.\n']

This happens in about 0.25 seconds, and is not something cElementTree
can do with its `findall()`, though I expect the cElementtree Python
equivalent of that would be quite a bit faster, I expect.\<

Oh well, it was a bit of a bummer that Fredrik released something
insanely much faster just as I was finally getting somewhere with
lxml.etree.. :)
