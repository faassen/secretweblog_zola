+++
title = "a little bit more lxml performance tweaking"
date = 2005-01-18
slug = "a-little-bit-more-lxml-performance-tweaking"

[taxonomies]
tags = ["lxml"]
+++

# a little bit more lxml performance tweaking

Today I merged the backpointer branch with the lxml trunk, and have been
cleaning up a bit more. In particular I've cleaned up some useless extra
subclasses that were only necessary to introduce weak reference support
to the various classes. I've now removed these subclasses, which cleans
things up a bit more.

This also resulted in some performance gains! Not very spectacular ones,
but still noticable:

    nodereg  backptr  cleanups
    --------------------------

    findall('//v')      1.9 s    0.25 s   0.21 s
    xpath('//v')        0.76 s   0.21 s   0.19 s
    xpath('//v/text()') 0.34 s   0.25 s   0.25 s

Apparent element proxy creation was sped up by a notch. This explains
why the //v/text() operation was not affected, as only strings are
created as a result of that, not element proxies.

Of course cElementTree is still at 0.13 s for the findall('//v')
operation, but as you can see the lxml.etree xpath version is not that
far off anymore.
