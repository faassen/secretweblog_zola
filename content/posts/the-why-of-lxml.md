+++
title = "the why of lxml"
date = 2005-08-05
slug = "the-why-of-lxml"

[taxonomies]
tags = ["lxml"]
+++

Today I read [an article about
libxslt](http://www.xml.com/pub/a/2005/08/03/libxslt.html) on O'Reilly's
xml.com. It demonstrates the power of libxslt; it's a cool library. It
also demonstrates why I wrote [lxml](http://codespeak.net/lxml): writing
Python code that correctly uses libxml2/libxslt's bindings directly is
difficult.

The example in the article goes like this:

    # xsltprocs.py: send an XML source document through a
    # pipeline of multiple XSLT stylesheets.

    import sys
    import libxml2
    import libxslt

    args = len(sys.argv)

    if args <  3:
        print "Pipeline an XML document through a series "
        print "of XSLT stylesheets. Usage:\n"
        print "  xsltprocs.py infile.xml stylesheet1.xsl   [stylesheet2.xsl...]"
        sys.exit(0)

    sourceXMLFile = sys.argv[1]
    sourceDoc = libxml2.parseFile(sourceXMLFile)

    for xsl in range (2,args):
        # Read in stylesheet.
        styleDoc = libxml2.parseFile(sys.argv[xsl])
        style = libxslt.parseStylesheetDoc(styleDoc)
        # Apply stylesheet to sourceDoc, save in result.
        result = style.applyStylesheet(sourceDoc, None)
        # Result becomes new sourceDoc in case we send it
        sourceDoc = result   # through another stylesheet.

    print result

    style.freeStylesheet()
    sourceDoc.freeDoc()

What it does is pipe a single XML document through multiple phases of
XSLT transformation. It works, though with my version of libxml2 think
the last line should say:

    print result.serialize()

as otherwise you don't get the proper XML output as expected. Better
yet, it should be serialized through the last XSLT sheet's serialization
functionality as it may have things to say about the serialization
process.

It however has a memory bug. It doesn't matter in this context, as it's
just a script, but it might start to matter quickly in a long-running
process. What happens is that at the end of the script, the document and
the XSLT sheet are cleaned up manually, but the _intermediate_ results
or stylesheets never are.

It's an easy mistake to make. Python programmers aren't supposed to have
to worry about manual memory management. I rewrote the script to use
lxml:

    # xsltprocs.py: send an XML source document through a
    # pipeline of multiple XSLT stylesheets.

    import sys
    from lxml import etree

    args = len(sys.argv)

    if args <  3:
        print "Pipeline an XML document through a series "
        print "of XSLT stylesheets. Usage:\n"
        print "  xsltprocs.py infile.xml stylesheet1.xsl [stylesheet2.xsl...]"
        sys.exit(0)

    sourceXMLFile = sys.argv[1]
    sourceDoc = etree.parse(sourceXMLFile)

    for xsl in range (2,args):
        # Read in stylesheet.
        styleDoc = etree.parse(sys.argv[xsl])
        style = etree.XSLT(styleDoc)
        # Apply stylesheet to sourceDoc, save in result.
        result = style.apply(sourceDoc)
        # Result becomes new sourceDoc in case we send it
        sourceDoc = result   # through another stylesheet.

    print style.tostring(result)

This doesn't look much simpler than the pure libxml2/libxslt example
(more involved examples would), but as you see the memory management
logic is gone, as lxml takes care of this automatically. Moreover, the
memory management logic is _correct_, or that's a bug in lxml.
