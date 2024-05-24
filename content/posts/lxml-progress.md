+++
title = "lxml progress"
date = 2005-01-14
slug = "lxml-progress"

[taxonomies]
tags = ["lxml"]
+++

Since some people seem to be actually reading this and some progress has
been made, I thought I'd give a report of what's been happening with
lxml.

- Since last week, I've added a lot more of the ElementTree API, such as
  the .find() function and friends, by directly using the code from
  ElementTree.

- I actually am running the ElementTree and cElementTree test suites
  now. I still need to disable some tests, but a significant fraction is
  indeed running.

- I've improved the way libxml2's parser functionality gets used, in
  order to implement libxml2's top-level parse() function.

- I've added XPath support to lxml.etree! An example of what you can do:

      >>> from lxml import etree
      >>> tree = etree.parse('ot.xml')
      >>> tree.xpath('(//v)[5]/text()')
      [u'And God called the light Day, and the darkness he called Night.
       And the evening and the morning were the first day.\n']

  or, say, this, modifying the elements returned:

      >>> result = tree.xpath('(//v)[5]')
      >>> result[0].text = 'The day and night verse.'
      >>> tree.xpath('(//v)[5]/text()')
      [u'The day and night verse.']

- I've added the start of XSLT support to lxml.etree. An example:

      test.xslt

      <xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:template match="*" />
        <xsl:template match="/">
          <day><xsl:value-of select="(//v)[5]" /></day>
        </xsl:template>
      </xsl:stylesheet>

      >>> from lxml import etree
      >>> style_xml= etree.parse('test.xslt')
      >>> style = etree.XSLT(style_xml)
      >>> ot = etree.parse('ot.xml')
      >>> result = style.apply(ot)
      >>> style.tostring(result)
      u'<?xml version="1.0"?>\n<day>And God called the light Day, and the
      darkness he called Night. And the evening and the morning were the
      first day.\n</day>\n'
      >>> result.getroot().tag
      u'day'

A note about performance. I've been in a mail discussion with Fredrik
Lundh, the originator of ElementTree, over the past week, doing some
performance comparisons.

libxml2 is fast, but a bit of my thunder was stolen away by Fredrik when
he released cElementTree. cElementTree is certainly no slacker either,
and in some cases even beats the snot out of lxml. Fredrik deserves
plenty of kudos for that. A bit of a bummer for me though. :)

In my measurements (your mileage may vary), cElementTree's parsing is
about as fast as lxml at parsing jobs. This on the same benchmark
Fredrik's been using. cElementTree is more memory efficient though,
though lxml.etree is still better than ElementTree and many other
Python/XML tools.

Somewhat to my disappointment, cElementTree and even ElementTree are
right now a _lot_ faster at .find() and friends than lxml.etree. Since
they all use the same Python implementation, this means that
lxml.etree's implementation of the ElementTree API is in some ways quite
a bit slower than Fredrik's Python implementation! Thinking about it
more, this is not a big surprise, as lxml.etree does a lot of heavy
lifting to make sure the underlying libxml2 tree is exposed with an
ElementTree API, and in addition has to worry about doing memory
management with these structures.

All is not lost however; lxml has xpath! libxml2's xpath is pretty fast;
while more slow than (c)ElementTree's .findall() in some cases, it's a
lot more powerful as well, being a full xpath implementation.

Finally, XSLT seems pretty fast. In a simple test program, I can do a
1000 XSLT transformations in a few seconds, including a reparse of the
XSLT stylesheet and document to transform, although granted this was
done with a small document.
