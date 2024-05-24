+++
title = "Relax NG support, C14N"
date = 2005-01-21
slug = "relax-ng-support-c14n"

[taxonomies]
tags = ["lxml"]
+++

# Relax NG support, C14N

Some progress over the last few days:

've added basic Relax NG support to lxml.

lxml.etree introduces a new class, lxml.etree.RelaxNG. The class can be
given an ElementTree object to construct a Relax NG validator:

    >>> f = StringIO('''
    ...   <element name="a"; xmlns="http://relaxng.org/ns/structure/1.0"
    ...     <zeroOrMore>
    ...       <element name="b">
    ...         <text />
    ...       <element>
    ...     <zeroOrMore>
    ...   <element>
    ... ''')

    >>> relaxng_doc = lxml.etree.parse(f)
    >>> relaxng = lxml.etree.RelaxNG(relaxng_doc)

You can then validate some ElementTree document with this. You'll get
back true if the document is valid against the Relax NG schema, and
false if not:

    >>> valid = StringIO('<a><b></b></a>')
    >>> doc = lxml.etree.parse(valid)
    >>> relaxng.validate(doc)
    1

    >>> invalid = StringIO('<a><c></c></a>')
    >>> doc2 = lxml.etree.parse(invalid)
    >>> relaxng.validate(doc2)
    0

And in addition, I've improved the c14n support so you can produce
canonical XML output for any tree:

    >>> f = StringIO('<a><b/></a>')
    >>> tree = lxml.etree.parse(f)
    >>> f2 = StringIO()
    >>> tree.write_c14n(f2)
    >>> f2.getvalue()
    <a><b></b></a>

The most awesome development so far is that there's a contributor!

He wrote a patch to support XPath extension functions. I still have to
review this, which I will try to do soon.
