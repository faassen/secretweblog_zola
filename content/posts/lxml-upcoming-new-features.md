+++
title = "lxml upcoming new features"
date = 2005-06-09
slug = "lxml-upcoming-new-features"

[taxonomies]
tags = ["lxml"]
+++

lxml has undergone quite a bit of development since lxml 0.6. While 0.7
is not yet released, this release should be coming soon, and to whet
your appetites here's a partial list of new features:

- XMLSchema validator support
- XInclude support
- more control over namespace prefixes when generating XML

I'll talk about the least spectacular sounding feature that in fact cost
me the most time to implement: control over namespace prefixes.

I found myself generating XML quite a lot in a recent project, and
experimented with a bunch of different APIs in lxml to support which
prefixes are created for namespaces (and what the default namespace
should be).

As you may or may not know, the ElementTree API doesn't have any
official support for controlling what prefixes are outputted. This can
result in entirely correct but ugly XML with namespace prefixes like
ns0, ns17, etc.

Even though prefixes are not part of the XML infoset, some control over
what they look like in XML is frequently desirable, as the intent of XML
is to be at least somewhat human readable. It's easy to start leaning
too much into the other direction, though: one should be careful not to
offer too much control to the user either.

The W3C DOM, as usual, offers way too much API for namespace handling,
which results in all kinds of scary interactions I don't want to worry
about. I did add an attribute to _read_ prefix information, but unlike
the DOM, will not make this writeable, as this quickly gets pretty
insane, so that route towards namespace control is out.

After quite a bit of thinking, I ended up supporting a second special
argument to the Element and SubElement constructors. The first special
argument, part of ElementTree, is 'attrib', which is a dictionary to
control attributes. I added a new argument called 'nsmap', which is a
dictionary to control namespaces. The keys are the namespace prefixes,
the values the namespace URIs. A key of 'None' means set the default
namespace. If a namespace is already known higher up in the tree, that
will be reused instead.

Here's an example:

    >>> from lxml import etree
    >>> e = etree.Element('{http://ns.infrae.com/foo}bar',
    >>> ... nsmap={'foo': 'http://ns.infrae.com/foo'})
    >>> e.prefix
    'foo'
