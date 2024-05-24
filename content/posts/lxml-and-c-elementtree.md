+++
title = "lxml and (c)ElementTree"
date = 2006-02-24
slug = "lxml-and-c-elementtree"

[taxonomies]
tags = ["lxml"]
+++

# lxml and (c)ElementTree

I saw a [blog entry by Julien
Anguenot](http://blogs.nuxeo.com/sections/blogs/julien_anguenot/2006_02_23_looking-for-fast-memory-friendly-python-xml-processing)
praising the ElementTree+ (and cElementTree in particular) XML
processing library, and also contrasted it with
[lxml](http://codespeak.net/lxml), as in "why didn't I use lxml?". Since
I created lxml, I thought I'd chip in and give my perspective on how it
relates to ElementTree, and also give some context around Julien's
statements about lxml in his blog entry.

First I'll agree fully that ElementTree and cElementTree are great! I'll
encourage anyone to use them. What's unclear from the blog entry by
Julien is that lxml is actually implementing the ElementTree API as
well. While there are differences, this essentially means that you can
write code against ElementTree and then later on move it to lxml if you
need the added features.

lxml has quite a few more added feature above plain (c)ElementTree:

- full XPath 1.0 support.
- XSLT support.
- Relax NG support
- XML Schema support.
- parsing and serialization retains namespace prefixes.

and much more. Many XML applications don't need these features. Many do.
Julien's application evidently doesn't, which is why it makes sense for
him to use ElementTree.

Now as to Julien's reasons as to why he doesn't use lxml. lxml is indeed
somewhat less mature than ElementTree, though is stable enough to use in
production applications. I'd also claim that it's *more* stable than the
Python libxml2 bindings that it replaces, as those make it extremely
easy to shoot yourself in the foot. So, if you're using those and you
need the featureset of libxml2, you might want to consider switching to
lxml.

The dependency of lxml on libxml2 and libxslt is indeed a problem,
though of course it's also lxml's greatest strength - that's where the
features come from. ElementTree and cElementTree beat it hands-down on
being easier to get started with, especially when they get bundled with
Python 2.5. Since lxml only benefits from an adoption of those XML
processing APIs I'm very happy they do get bundled - people will find
lxml when they need it.

While libxml2 and libxslt are very widespread on systems and lxml is
starting to be packaged by linux distributions (it's in Ubuntu), it's
still a huge dependency that is problematic in some circumstances. It's
not *that* hard to install a newer version of libxml2 and libxslt
somewhere if you want to deploy a server application, but it's certainly
not making life easier.

Concerning Julien's Zope 3 note. I think that there has been no decision
about Zope 3 *not* making it a dependency; in fact Zope 3 last I knew
has been looking into adopting lxml as a dependency. It hasn't done so
yet, and the libxml2 requirements are an important reason why not. Since
Zope 3 is going to turn into a component cloud that's separately
installable all this may become less relevant in a few more Zope 3
releases. The nature of what's core and what's not is going to become
more fuzzy.

I don't think it's correct to state that lxml relies on bleeding edge
revisions of libxml2 - the 0.8 release relies on libxml 2.6.16, which
was released in late 2004. Newer releases will switch to newer releases
of libxml2 eventually, but I wouldn't call our dependency in 2006 on
something released in 2004 bleeding edge. Of course, newer versions of
libxml2 may have bugfixes (especially in the XML schema validation
implementation) and installing them will make lxml benefit from them
too.

"Not memory leak free" surprises me a bit as an argument against lxml.
We've recently had a few mails on memory leaks - these are the first
reports on this that we've received so far. The leaks are plugged in
SVN. What we do need is a newer lxml release soon that has these fixes.
It's true that lxml has bugs, and it's not surprising there are some
bugs with memory as that's the hardest part of wrapping libxml2 properly
for Python users, but it's also true that any piece of software has
bugs. I hadn't considered that these recent reports were considered to
be show stoppers for people like Julien.

iterparse is indeed a very nice feature of ElementTree that I'd love to
have added to lxml. No debate about this. Contributors are welcome. :)

Considering performance, I'll be honest. Parsing speed is about
equivalent between the two. In the pure API of accessing the tree,
cElementTree is faster than lxml. Probably not going to be noticable in
most applications, but will matter in some. Then again, lxml offers
access to libxml2's blazing fast XPath implementation, so if you're
going to search into a tree lxml can keep up with cElementTree just
fine, and lxml will occasionally be faster. In general, the features
such as XSLT, directly implemented in libxml2/libxslt, are going to be
fast.

So, pick lxml if you need the features it adds above cElementTree,, and
if you need performance in those features. Don't pick it because it's
faster than cElementTree at core ElementTree operations as it's not
(though it's certainly not a slowpoke).

Another problem lxml has is that it has a lot of new features and fixes
in SVN that should be in a release. We need to get working on a release!
