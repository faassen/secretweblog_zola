+++
title = "benchmarks and lxml"
date = 2005-01-24
slug = "benchmarks-and-lxml"

[taxonomies]
tags = ["lxml"]
+++

The recent cElementTree release is causing some waves in the Python/XML
community. It started when Uche Ugbuji posted [The Python Community has
too many deceptive XML benchmarks](http://www.onlamp.com/pub/wlg/6291)
to his blog.

The effbot was not amused, as could be witnessed by his comment on it,
and the blog entries:

<http://online.effbot.org/2005_01_01_archive.htm#sigh>
<http://online.effbot.org/2005_01_01_archive.htm#faking-it>
<http://online.effbot.org/2005_01_01_archive.htm#faking-it-2>
<http://online.effbot.org/2005_01_01_archive.htm#faking-it-3>

The problem is that Uche unwittingly introduced a benchmark that is
rather.. deceptive. He has been testing the time taken by the whole
program, including startup and shutdown of the Python interpreter,
module importing, and the like, instead of the part where XML processing
takes place. Unless you're writing command line scripts or classic CGI
web applications, Python startup time is hardly relevant, and shouldn't
be part of the measurement.

A while back while developing lxml.etree I was curious what benchmark
Fredrik was using. I couldn't find the information on the web, but he
told me when I mailed him about it. He was using the simple, obvious
strategy which I myself had already been using:

    .. imports ..
    start = time.time() # time.clock() on windows
    .. do the actual work ..
    end = time.time()
    print end - start

To measure approximate memory usage, he puts in a pause in the program
before and after the processing, and checks the process overview on his
machine manually.

I've replicated his results with cElementTree and ElementTree fairly
well, though my machine is a bit different in its performance
characteristics due to platform differences. See other blog entries for
more info on this.

For fun, I thought I'd try Uche's benchmark against lxml.etree on this
machine. I've also tested it against cElementTree (an older version, I
can't keep up with Fredrik's releases; hm, no \_\_version\_\_ string I
can find, so don't know what 0.9.x version it is.. reminds me to add one
to lxml when the time comes for a release..).

Here's Uche's program adjusted for etree. As you can see, only the
import statement needs to change:

    import lxml.etree as ElementTree

    tree = ElementTree.parse("ot.xml")
    for v in tree.findall("//v"):
        text = v.text
        if text.find(u'begat') != -1:
            print text

I've also rewritten it to use xpath instead:

    from lxml.import etree as ElementTree

    tree = ElementTree.parse("ot.xml")
    for text in tree.xpath("//v[contains(., 'begat')]/text()"):
        print text

Since this program is printing stuff, and printing overhead can be
large, I've tried a number of tests:

1.  Unix 'time' command, print to stdout on Gnome terminal
2.  Unix 'time' command, redirect output to file
3.  time.time(), print to stdout on Gnome terminal
4.  time.time(), redirect output to file

Here are the results:

    A      B      C      D
    --------------------------
    cElementTree      1.06s  0.32s  0.9s   0.23s
    lxml.etree        1.2s   0.43s  1.1s   0.36s
    lxml.etree xpath  0.53s  0.25s  0.42s  0.17s

As you can see from the results, the type of terminal you're printing to
matters a lot. In case of the xpath tests, almost half of the time is
spent printing to the terminal, and for the other tests the overhead
seems to be even more.

Also note that at last I can claim a minor victory over cElementTree on
my machine on this particular test! lxml.etree, when using xpath to do
the task set, is faster than this version of cElementTree. Of course
most of the credit here goes to libxml2's blazingly fast xpath
implementation here.

All this shows benchmarks are nice as there are so many to choose from.
