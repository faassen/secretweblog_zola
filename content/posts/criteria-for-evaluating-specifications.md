+++
title = "Criteria for evaluating specifications"
date = 2005-03-01
slug = "criteria-for-evaluating-specifications"

[taxonomies]
tags = ["standards"]
+++

# Criteria for evaluating specifications

As Andrew Tannenbaum said, "The nice thing about standards is that there
are so many to choose from." Apparently he followed this up by: "And if
you really don't like all the standards you just have to wait another
year until the one arises you are looking for."

So how does one choose? Why adopt one specification and not another?
There are many possible reasons, and this article is an attempt to
catalog some of them.

In the course of my work at [Infrae](http://www.infrae.com), I run into
many specifications that we may decide to implement or use, so having a
common vocabulary and set of questions about this is important to us.

Note that I use the word 'specification', not 'standard' in this
article, as there are far more specifications than true industry
standards. Many so-called "standards" are only aiming to become so, but
naturally many fail in this process due to a variety of reasons.

## What is specified?

Specifications fall into a number of categories. A non-exhaustive list:

- protocol (TCP/IP, HTTP, FTP, XML-RPC, SOAP, WebDAV)
- document format ('pure' XHTML, Docbook, TEI, many custom XML document
  formats)
- visual design ('pragmatic' XHTML, CSS, SVG, XSL-FO)
- metadata (RDF, Topic Maps, RSS, Dublin Core)
- query/programming language (SQL, XPath, XSLT, XQuery, C, C++, Java,
  C#, etc)
- API (DOM, SAX, COM specification for MS Office interoperability, UNO
  specification for OOo API)
- structural, foundational (XML, RDF)
- prescriptive/descriptive (DTD, XML Schema, Relax NG, RDF Schema)

## Questions to ask when encountering a new specification

### Industry adoption

How well is the specification adopted within the industry? I.e., is this
specification industry-standard or seems to be on the way to be so?
There are a lot of specifications that are really not standards.
Industry adoption has two sides to it:

- Systems that implement the specification.
- Systems that actually make us of the specification implementation to
  accomplish specific use cases.

If there are few of the former, there won't be many of the latter. An
example is SVG in browsers. Even though it is expected that the uptake
of SVG technology will be big once it is established in popular
browsers, this uptake is not taking place right now as the browsers
don't support it very well. In other areas, like the Linux desktop, SVG
is seeing some use now.

Even though systems that conform to the specification may be
implementable fairly easily, it may be that few systems exist that
actually use this for useful purposes. RDF has a problem like this; even
though it is relatively easy to produce some RDF, and tools exist that
can then take this RDF and do some analysis, there are actually few
systems that use this RDF to fulfill practical use cases. RSS is an
exception, but only a partial one, as only few RSS streams are actually
fully RDF compliant.

### Implementation quality

How well is the specification *implemented* within the industry? If a
specification is well implemented, this helps interoperability between
software. CSS is an example of a specification that is implemented
commonly by browsers, but not all to the same level of quality. The
practical result of this is that the same CSS needs to be tested on all
browsers, and pragmatic subsets and tricks are developed in order to
work around limitations in the implementation on some platforms.

The DOM specification has been implemented quite a few times in Python,
but very little Python software actually works across Python DOM
implementations, because the implementations differ a lot in quality,
supported feature set, and there is a lot of inconsistency in the
translation to Python of the various DOM APIs. In contract, because of
more rigidly defined and checked interfaces in Java, this language gains
more interoperability between its various DOM implementations. Another
example is Javascript-based browser DOMs. While many inconsistencies
exist, the browser DOM still allows cross-browser applications to be
developed.

XSLT is an example of a specification that seems to be well implemented
across many platforms, probably due to the clarity of the specification,
the limited scope, and extensive conformance test suites.

### Market demand

How much does the market (or a particular market, or a particular
client) want to adopt the specification as a standard?

Even in cases where industry adoption is still limited few
implementations exist, significant forces in the market may still very
well want implementations. They may want this for rational reasons, or
due to industry hype, or a combination of both. One good reason for
adoption of a specification is its popularity, so industry hype may in
fact be a worthwile reason to adopt a specification.

Hype may exist in limited markets. Most people for instance haven't
heard of SCORM, but it does have some buzz in the education market.

### Buzz

How much buzz is there in the industry and market? Are vendors promising
support? Are there high visibility projects? Glowing magazine articles?

### Suitability

Does the specification fit the actual problem domain? XSLT can be used
well for templating and transformations, but it's not very well suited
for writing whole applications.

Even if a specification is not optimally suited to a problem domain,
other factors may still cause it to be adopted -- increased
interoperability for instance, or reduced learning time.

### Implementability

How easy is the specification to implement? There are a whole set of
reasons why a specification would be easier or harder to implement.

- How clear is the specification? Is the specification very readable by
  a software developer?
- How complete is the specification? Are there areas essential for
  interoperability which are glossed over?
- How big is the specification? If all other factors stay the same, the
  larger specification is harder to implement.
- How conceptually pure is the specification? Does the specification
  specify a hodge-podge of features or is everything reducible to basic
  principles? The more pure a specification is, the easier it tends to
  be to implement.
- Do test suites exist to verify conformance? How extensive are these
  test suites? If these are lacking, successful implementation becomes a
  lot harder.
- Do proof of concept implementations to server as developer examples?
  Often an implementation in software actually clarifies many of the
  details that may otherwise be left undescribed.
- Does the specification have dependencies on other ones? A
  specification may have a requirement on one or more other
  specifications that are not commonly implemented.
- Is the specification tied to a particular operating environment or
  programming language? If there are many requirements before a
  specification can be implemented, this may limit the implementability.
- On the other hand, a specification that tries to be very general may
  turns out to be harder to implement as well, as it may be more
  complicated as a result.

### Interoperability

Will implementing a specification in fact increase interoperability?

There are a number of categories of interoperability:

- Interoperability between client and server, swap out server. Here the
  server implements the specification (and the client makes use of it).
  As an example, HTTP makes it easy to swap out one webserver for other
  one, while the same client (a browser) is used for both.
- Interoperability between client and server, swap out client. Here the
  client implements the specification, and the server produces something
  that fits the specification. HTML and CSS make it easier to swap out
  the client (browsers such as Mozilla, IE, Konqueror, Opera) as each
  implement HTML and CSS, even though the server may always be the same.
- Interoperability between "peers". XML makes it easier for one system
  to read basic structured information coming from another, as they can
  make use of well established XML processing tools.

The more difficult it is to implement a specification (correctly or
completely), the fewer the interoperability benefits.

### Learnability

Will the implementation specification likely make it easier for the
developer to learn the system (or learn how to interoperate with the
system)?

- If the specification is popular, it's more likely there's plenty of
  reading material about it that the developers heard about. There's
  also a bigger chance the developer already heard about it, or used it
  in the context of another system. XML is the traditional example of
  how this works. XSLT is another good example, though only in the last
  few years, now that it has been commonly implemented and much
  documentation exists.
- Implementability and learnability are related. If the specification is
  for some reason difficult to understand (difficcult to read, hugely
  complicated, badly written), it will be more difficult for a developer
  to understand it in other to use it.

### If only everybody

How much of a network effect is needed to make implementing or using a
specification useful? If first everybody needs to implement the
specification to actually make its use worthwhile, a chicken and egg
problem exists.

An example of this is the semantic web. If only everybody had their web
systems produce large amounts of semantic information in the form of
RDF, it'd be very useful in many ways and useful tools would be created
which process this information. Unfortunately nobody is doing this as
there are no tools to process the information.

## Reasons for usefulness

Specifications can be useful for a number of reasons:

- Interoperability. This is the obvious one. Your system can use another
  system that implements the specification, or vice versa.
  Implementability is the main factor that determines whether this can
  be accomplished, and popularity determines whether this is worthwhile
  (see also tool leverage).
- Attracting developers. We expect many developers to be already be
  familiar with the specification, or alternatively, there are copious
  resources for developers to familiarize themselves with a
  specification. Implementing the specification makes our system easier
  to learn and develop for. Learnability and popularity are important
  factors here.
- Reuse of design. Can we take useful ideas from a specification? Even
  if an interoperable specification is not developed, we may still be
  helped as we may not have to reinvent the wheel. Learnability is the
  most important factor here.
- Tool leverage. By implementing the specification, other existing
  toolsets and libraries can be used to extend the feature set of the
  software. Important factors here are popularity; lots of other systems
  that build on top of this specification will exist that now become
  useful.
- Marketing. Implementing the specification will provide us with
  buzzword compliant "checkbox features" for marketing. This will be
  helped by popularity (at least perceived popularity). The
  specification itself might be pure nonsense, or our implementation may
  be bad, it can still work, at least for a while until everybody finds
  out.
