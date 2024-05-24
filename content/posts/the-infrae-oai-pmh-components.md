+++
title = "the Infrae OAI-PMH components"
date = 2006-08-25
slug = "the-infrae-oai-pmh-components"

[taxonomies]
tags = ["python", "xml", "standards", "silva"]
+++

# the Infrae OAI-PMH components

Since these components are little known I'd like to give a brief
introduction of the great set of open source OAI-PMH components that
[Infrae](http://www.infrae.com) has developed.

What is OAI-PMH? It's the Open Archives
Initiative Protocol for Metadata Harvesting. This is an XML and HTTP
based protocol for harvesting large amounts of metadata from so-called
data providers. Data providers are sites on the web that are interested
in exposing some metadata collection to the world. Other systems can
then harvest this information and do something with it; analyze it,
index it, present it, and so on.

While its potential uses are many, the main use of OAI-PMH is by many
academic libraries in the world. Universities have large amounts of
papers written all the time, and this is a way for the university
library to publish information on the papers (the title, who wrote it,
where to get it, and so on).

Infrae has been working for some years to build a great set of OAI-PMH
tools. We have the following:

- a Python library called [pyoai](https://infrae.com/download/oaipmh), building
  on [lxml](https://lxml.de). It implements the harvesting protocol, allowing
  easy access to OAI-PMH servers using a simple Python API. Moreover since
  version 2.0 it also implements the server protocol. If you implement the same
  Python API as you use for harvesting yourself, you can expose your own
  datasets as OAI-PMH easily without worrying about the details of the
  protocol. This library can be deployed by any Python application that needs
  OAI-PMH support.
- A Zope 2 extension called [OAICore](https://infrae.com/download/oaicore).
  This takes care of OAI-PMH harvesting from Zope, using the pyoai library. The
  data is harvested into the ZODB, and indexed using the Zope catalog. There
  are also components for presenting this information in a web page. It's
  pluggable with new metadata definitions that control the way the metadata is
  indexed and displayed.
- A [Silva](https://infrae.com/products/silva) extension called
  [SilvaOAI](https://infrae.com/download/oai/silvaoai). This extends OAICore
  and offers various facilities to display harvested metadata in the Silva CMS,
  integrating tightly into the Silva user interface.

I can confidently say that if you need anything done with OAI-PMH,
especially in a Python or Zope environment, this set of tools (together
called the [OAI Pack](http://www.infrae.com/products/oaipack)) is a good
base to start from. And let Infrae know if you need help!
