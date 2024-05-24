+++
title = "The borderland between content and software"
date = 2005-12-15
slug = "the-borderland-between-content-and-software"

[taxonomies]
tags = ["cms", "zope", "silva", "plone"]
+++

# The borderland between content and software

Paul Everitt
[writes](http://radio.weblogs.com/0116506/2005/12/15.html#a380):

> In the early days of Zope, you could design content "TTW" (through the
> web). You could answer questions about structure and suddenly, you had
> new kinds of content -- YOUR content -- that could be added to folders
> in the system. No programmers were involved, no special login
> permissions on the server, no database schemas to update.

First, a somewhat snarky question: Paul, if the olden days were so
great, why did the Zope community move on from them? I'll go into what I
see as some reasons why.

Anyway, I agree that this is a scenario we should support. I also am a
software developer with many years of experience developing with Zope,
so I know the trouble that this scenario can cause.

Paul is talking about the interesting dividing line between content and
software, and between content authors and programmers. Let's keep it
clear and call this the *borderland*, as calling it just *software* or
just *content* warps our perspective -- we need to see it as both.

Paul also writes:

> Alas, later in the history of Zope, the component folks decided that
> TTW was grotty and should be banished. There were good reasons for
> this...from their perspective.

I think these reasons are important to make explicit, and should not be
swept under the rug, so let me describe some reasons from my personal
perspective.

Paul attributes this development to the "component folks". I could be
considered one of them, and they're Paul's favorite group of programmers
that make his life complicated, but I think Paul will agree that the
trend away from TTW was far broader than that. I think that this trend
away from TTW to Product development is clear in Zope 2 as a whole,
component folks or not, for the last five years or so. The question I
asked in the beginning again applies again. Why did this happen? Why'd
we move away from the apparently paradisical state Paul describes?

At Infrae, we have a lot of experience with people, end users and
scripters writing software/content through the web, using facilities in
Zope, Silva, and Formulator. While this is indeed very empowering for
the end-user or scripter, it can also lead to an *enormous* increase in
maintenance burden.

This gets noticed by the software developers and system administrators
who will have to do the occasional maintenance (such as upgrades). They
will have to deal not only with Silva and Zope (or Plone and Zope), but
also the software/content that grew around it. This increases the
complexity enormously. We can't do away with this extra code that grew
around it; it's *necessary* for deployment of the software in that
particular production setting. But we'd sure as hell wish it'd been more
maintainable.

Programmers have tools and patterns to manage the complexity of software
development and deployment. Editors and IDEs, test driven development,
version control systems, release numbering, deployment tools, the works.
These things help manage the complexity if an experienced programmer is
using them, but a non-programmer or scripter doing development will not
use them, and the programmer does often end up having to maintain code
created that way.

As a side-discussion but exemplifying the pain: these tools work with
the filesystem, but typically don't work with code developed through the
web, such as in the ZODB. In the Zope community we've seen lots of
attempts to make through the web work together with filesystem tools,
with varying success, but I think nobody denies that this is a major
pain. A general trend was to develop this stuff as code on the
filesystem, as that made life a lot easier. Through the web development
helps a class of users, but it can also be seen as a *hindrance* to the
adoption of Zope as a software development platform by software
developers. This is also an important audience to us.

So, letting users, customers, develop software as content is an
extremely powerful concept. It's one we should support. It's also very
dangerous.

The challenge is in reconciling the two. How do we empower users to
develop things on the borderland of software and content, while not
creating maintainability nightmares? People administrating large
systems, as well as professional software developers, as many of us are
in the Zope community, need a solution that answers that question.

I don't want to have to deal with solutions anymore that don't, as
they're not complete solutions to me. They tend to shift or even
increase the complexity on the longer term, something my company may end
up paying for, as how do you explain this to a customer? The website
works, right? Why is maintaining it so costly?

Let's try to figure this out. It'll likely take some smaller, careful,
steps. Ideas are welcome.
