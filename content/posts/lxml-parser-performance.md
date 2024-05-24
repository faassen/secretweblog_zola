+++
title = "lxml parser performance"
date = 2005-01-12
slug = "lxml-parser-performance"

[taxonomies]
tags = ["lxml"]
+++

# lxml parser performance

In a discussion with Fredrik Lundh about his (c)ElementTree parser
performance benchmarks on the lxml.etree implementation.

On my work linux/athlon box, with Python 2.3, I get the following
figures:

    library              time       space
    -------------------------------------
    ElementTree 1.2.4    1.3 s      14000k
    cElementTree 0.8     0.12 s     5500k
    etree (trunk)        0.12 s     11200k
    readlines            0.08 s     4300k

The memory usage of cElementTree and ElementTree on my box are in the
same range as Fredrik's benchmarks. lxml.etree obviously runs behind
quite a bit, and little I can do about it as it's mostly libxml2 memory
usage.

Note that these only measure parser performance, not anything else. One
benefit that cElementTree gets here is that it constructs Python objects
right away, while lxml.etree only does this later. This makes Fredrik's
figures of course even more impressive. lxml.etree will have to compete
in other areas than parser performance...
