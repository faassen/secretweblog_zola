+++
title = "lxml performance progress"
date = 2005-01-17
slug = "lxml-performance-progress"

[taxonomies]
tags = ["lxml"]
+++

Such progress a few days can bring. Just last week the lxml.etree
performance figures on ElementTree operations like `findall` lost out
badly to pure Python code. So badly, it was pretty embarassing:

    findall('//v') on ot.xml

    ElementTree: 0.13 s
    cElementTree: 0.11 s
    lxml.etree: 1.9 s

All three here are using the same `findall` implementation (in Python)
by the way, and they are throughout these tests. The dismal performance
shows the slowness of aspects of the lxml.etree implementation as of
last week.

After a refactoring of the way node proxies are maintained and a dumping
of the whole weak reference idea in favor of a libxml2 to python
backpointer approach, things are looking a lot better:

    lxml.etree: 0.25 s

This is actually following an idea by Jim Fulton in a real life
conversation in Vienna a few months back. It'd be depressing to know all
these smarter people if it wasn't so much fun. :)

My figure is still not as good as (c)ElementTree, but it shows the
overall API has sped up by quite a bit.

So,I just managed to speed up lxml.etree find operation by over a factor 7. I suspect the remaining factor 2 or so will be a lot harder, but it's
at least reasonable now.

As a side effect, xpath overhead has also gone down quite dramatically.
Recall that the other day it was this:

    xpath('//v')

    lxml.etree: 0.76 s

Not bad, but could be a lot better. After the work of the last few days,
this is the new figure:

    xpath('//v')

    lxml.etree: 0.21

still not as good as even non-C ElementTree on this operation, but the
full power of XPath is available.

Somehow my general work today also sped up other things. I'm still
figuring out why this is faster, as wrapper overhead is hardly involved
at all:

    xpath('//v/text()')

    lxml.etree: 0.34

And now it's 0.25 seconds!

Finally, to the parse + xpath overhead combined:

    >> t = parse('ot.xml')
    >> self.t.xpath('(//v)[5].text()')
    [u'And God called the light Day, and the darkness he called Night. And the evening and the morning were the first day.\n']

This used to take about 0.25 seconds, 3+ meg parse included. Now it's
0.21 seconds. :)

So, while I'm sure things can be improved somewhat more, lxml.etree
doesn't need to be embarassed about performance anymore. Perhaps we can
embarass Uche Ogbuji into happily eating this statement:

    > I know that folks are working on better libxml2
    > wrappers, but familiar as I am with the C code,
    > I honestly don't believe they can produce
    > anything truly Pythonesque without losing all
    > the performance gains.

Found on his weblog here: <http://www.oreillynet.com/pub/wlg/6224>
