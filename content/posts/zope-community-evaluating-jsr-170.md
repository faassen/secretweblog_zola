+++
title = "Zope community evaluating JSR-170"
date = 2005-07-20
slug = "zope-community-evaluating-jsr-170"

[taxonomies]
tags = ["zope", "standards"]
+++

[JSR-170](https://jcp.org/en/jsr/detail?id=170) or the Java Content Repository
API, appeared on my radar somewhere early in 2004. JSR-170 is interesting to
creators of content management systems because it promises a common API for
accessing and manipulating CMS content. Implementing this API in a CMS could
bring a number of potential benefits to it, such as interoperability,
learnability, not reinventing the wheel, and so on. I go deeper into possible
reasons for adopting any specification in my previous article [Criteria for
evaluating specifications](@/posts/criteria-for-evaluating-specifications.md).

JSR-170 has some counts against it. For starters, it's huge. When I
first looked at it, its design was also somewhat shaky (and it was even
huger), but in the recent versions I did notice large improvements.
Finally, from the perspective of the Python world, not the Java world, a
Java-based API has some counts against it. Implementing a Java API on
top of a Python-based system is not easy if you want the
interoperability benefits.

That said, I still think there are possible benefits, so I mentioned it
a few times in the Zope world for evaluation. This has been happening
recently:

- Stefane Fermigier has been posting about it on [his
  blog](http://blogs.nuxeo.com/sections/blogs/fermigier/2005_06_25_jsr_170_java_content).
- Tres Seaver has been playing with an implementation on top of Zope 3,
  and also [posted about
  it](http://palladion.com/home/tseaver/obzervationz/jsr170_doodling_20050711).
  He also mentions the impendence mismatch between Python and Java in
  the design of APIs.

I think it is an excellent development that members of the community
looking outwards like this -- the Zope community has had a tendency to
look inward in the past. Even if we choose not to adopt JCR or anything
else we look at, at least our choice will have been considered and we
will have learned something. This openness is also not unattractive to
outsiders looking in at the Zope community.
