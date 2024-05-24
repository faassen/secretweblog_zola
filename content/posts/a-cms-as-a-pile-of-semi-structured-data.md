+++
title = "A CMS as a pile of semi-structured data"
date = 2005-03-02
slug = "a-cms-as-a-pile-of-semi-structured-data"

[taxonomies]
tags = ["cms", "xml", "standards"]
+++

Paul Everitt and I have long been communicating about the role of XML in
the CMS world. Recently, he posted the following [blog
entry](http://radio.weblogs.com/0116506/2005/03/02.html#a290) and asked
for my opinions per email. I started writing a mail back to him, but
then I realized I have a blog now too...

Firstly, I want the UdellCMS too. :) Infrae has been trying to [build
one](http://www.infrae.com/products/silva) for a while, staggering along
the way.

Now as to some comments to Paul's vision. Within Infrae I have the
reputation of being a devil's advocates, and I've done it to Paul
before, so here goes with my comments.

Paul mentions, referring to the demo he links to, that:

> it isn't a "programming language" (though it sure looks like one)

This one is never going to fly. It's a programming language all right,
though a highly declarative one. It's going to take someone with
programming skills to write these. The advantage, similar to SQL, is
reporting: you do not need to know a lot of APIs in order to extract
data out of the system.

Now to what Paul and I both agree is the more interesting bit:

> What's more interesting, IMO, is the effect this has on CMS design. It
> totally changes your approach to navigation. Instead of thinking very
> hard about folder structures or topic structures, you just throw
> everything into a big pile and let stored semi-structured and
> full-text queries create smaller piles. This allows numerous
> approaches to site navigation.

I think that this approach opens more possibilities than some
traditional CMS approaches have been taken, because of its non-API
oriented query/reporting nature. This also ties in to various content
repository projects, such as Infrae's
[Railroad](http://www.infrae.com/products/railroad) and content
repository APIs like
[JSR-170](http://jcp.org/aboutJava/communityprocess/pfd/jsr170/index.html).

But, I also think that you cannot just give up (up-front) thinking about
things like folder structures or topic structures, or structured
document content, for a number of reasons.

While the files in the referenced demo are perhaps in one big pile,
these files contain a _lot_ of structure that can be exploited. It's
just not represented as folders and topics. Someone has to put this
structure in there.

How will you get (non-computer-savvy) people to produce such structured
content? I.e. how do you get enough consistency to actually be able to
do smart queries like the ones demonstrated? Jon Udell alone can be
trusted to produce semantic XHTML, but a whole organization? With Silva,
we took a lot of care so that we get _some_ semi-structured content out
of it all (Silva XML).

In addition, organizations use structuring techniques like folders and
(mandatory) metadata to have something to hold on to and some coherence
in the produced content. You can use folders for authorization, for
instance. You also need some uniformity in the topics used by people,
and often organizations want to mandate this.

So, some structuring facility seems unavoidable in a CMS. Wikipedia has
shown that even minimal facilities can lead to grand things, though, but
wikis aren't right for all use cases.

Where the real merit lies is in giving up some APIs and going more to
declarative data. In one way that's just moving the problem. But in
another way, what you can gain is that you can move some CMS-style tasks
away from a potentially limiting set of APIs to a more powerful query &
reporting model. In order words, you manufactor serendipity; you make it
easier to reuse content in new ways. It all being done in a standardized
way (the host of XML standards) is cool of course.

We've been doing things like this at Infrae and with Silva for quite a
while now, and we're trying to open it up more. It's not easy and the
benefits are sometimes hard to see, but we're trying. But we can extract
PDFs and Word documents from Silva, and with custom apps on top of Silva
we can expose and relate data in a lot of interesting ways. When you
start turning it into a real applicat And we'd like to do more in the
future, as we're opening up Silva to accept more kinds of XML content.
