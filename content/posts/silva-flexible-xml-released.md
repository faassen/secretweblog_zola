+++
title = "Silva Flexible XML released"
date = 2005-05-02
slug = "silva-flexible-xml-released"

[taxonomies]
tags = ["xml", "silva"]
+++

# Silva Flexible XML released

I'm happy to have released today a new Silva extension, [Silva Flexible
XML](http://www.infrae.com/download/SilvaFlexibleXML). Silva Flexible
XML combines a lot of the interests and themes of my technical life in a
single package. It's an extension to the Silva CMS that allows the user
to create and manage XML content. The important part is XML standards
support: the XML content can be configured to be checked by a Relax NG
schema or transformed to XHTML using a particular XSLT stylesheet.

Silva Flexible XML builds on a lot of other things. It integrates with
[Silva](http://www.infrae.com/products/silva), the CMS I helped build.
It extensible using [Five](http://codespeak.net/z3/five), the Zope 3
integration layer for Zope 2 that I helped create. Through
[lxml](http://codespeak.net/lxml), a Python-binding I created (I hope
soon I'll be able to say "helped create" too for it) it makes use of the
powerful XSLT and Relax NG facilities of libxml2 and libxslt.

Silva Flexible XML is not finished yet; it needs better XML error
reporting for instance, which will need some work in the lxml layer.
Infrae is putting Silva Flexible XML out there now in the hope that
someone likes the concepts and wants to help us (by work or funding) to
develop this further.

The amount of XML technology exposed by it, and the way you can easily
integrate your own, is in my opinion quite impressive. We haven't seen
anything like it in other Zope-based CMSes. What's interesting about
this is that it does not by a thick layer of Silva-specific code, but
mostly by leveraging Five and lxml, general libraries which have nothing
to do with Silva, and in the case of lxml, nothing to do even with Zope.
That is, we're not building much that is very Silva or even Zope 2
specific.

The release of Silva Flexible XML is therefore also a message about
something else I helped build: [Infrae](http://www.infrae.com). If you
need one or more of the following:

- content management/document management expertise
- XML expertise
- Python expertise
- Zope expertise (Zope 2, Zope 3, and Zope 2 + Zope 3)

..then Infrae wouldn't be a bad place to start looking. We'll throw in
client-side development ("Ajax") skills too; we had more than a little
to do with [Kupu](http://kupu.oscom.org). We're innovators, head in the
sky but our feet firmly on the ground: we know to leverage existing
standards and software where possible, but also know how to build new
stuff where needed. I'm quite proud of Infrae, both the team and the
software we created. We'd love to build more so don't hestitate to
contact us!
