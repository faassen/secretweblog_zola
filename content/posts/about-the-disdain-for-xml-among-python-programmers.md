+++
title = "About the disdain for XML among Python programmers"
date = 2005-01-30
slug = "about-the-disdain-for-xml-among-python-programmers"

[taxonomies]
tags = ["python", "xml", "standards"]
+++

# About the disdain for XML among Python programmers

Last december Phillip Eby (PJE) posted a [a nice
rant](http://dirtsimple.org/2004/12/python-is-not-java.html). It was
[widely](http://www.plope.org/Members/chrism/why_not_xml)
[quoted](http://www.pycs.net/users/0000075/weblog/2004/12/03.html) in
other Python-oriented weblogs; people liked especially the rant against
XML. It was indeed a very nice rant. It still rankled a bit with me,
though, even though I've seen similar things before. This disdain for
XML technologies is very common among Python programmers. I posted [my
own rant in response](http://www.plope.org/Members/chrism/why_not_xml)
in a comment on another weblog, hardly a place where it will be seen.
So, I'll post a new, edited version of my rant in my shiny new weblog,
where it has at least a bit more chance to be read. What's the good of
ranting if nobody hears you, after all?

I think a lot of the disdain for XML from Python programmers is nothing
more than elitism. *Misguided* elitism. Another part that I suspect
plays a role for some people is finding an excuse not to learn more
about it. "See, XML sucks, Python is superior, so me not knowing a lot
about it is fine". Finally, it's ignoring that there is more than one
way to do the same thing, and each have their own benefits and
drawbacks. There are drawbacks to using XML, and there are drawbacks to
using pure Python. Yes, there are misapplications of XML; there are
probably very many. There is a lot of chaff. That doesn't mean it isn't
applied successfully in very many cases.

The only reasons to use XML according to PJE are:

"If you're not implementing an existing XML standard for
interoperability reasons, creating some kind of import/export format, or
creating some kind of XML editor or processing tool, then Just Don't Do
It."

and

"The only exception to this is if your target audience really really
needs XML for some strange reason. Like, they refuse to learn Python and
will only pay you if you use XML, or if you plan to give them a nice GUI
for editing the XML, and the GUI in question is something that somebody
else wrote for editing XML and you get to use it for free. There are
also other, very rare, architectural reasons to need XML."

The tone of the text gives the impression that the set of problems
listed is a small class of problems that can safely be ignored by smug
and superior Python programmers. Nothing could be further from the truth
-- the class of problems described here is in fact huge.

A large fraction of IT problems has to do with interoperability;
solutions very frequently involve tieing a number of systems together.
Like it or not, XML is used in a lot of cases where interoperability
between disparate systems is required. There are strategic investment
concerns (is my data future-proof? Can I hire experts?) and decoupling
concerns (I want this Java system to work with this data, and this
Python system too, oh, and there's this browser-based Javascript
application too). XML can be helpful in these areas and deciding to use
it is in many cases an eminently sensible decision, not a "strange
reason".

XML is standardized, cross-platform, cross-framework, and
cross-programming language. Many of the surrounding specifications are
well-implemented in a diversity of programming languages. Using XML,
like using the architecture of the web, is a way to [manufacture
serendipity](http://radio.weblogs.com/0101679/stories/2002/03/13/manufacturedSerendipity.html#ManufacturedSerendipity),
to speak with Jon Udell. If your data is in XML, suddenly you can apply
query languages, validation frameworks and transformation tools that you
couldn't do if you hadn't thought about XML representations. Suddenly
you can use your data in ways you couldn't use before.

I can list a few other architectural places where the use of XML can
make sense that seem to fall outside of PJE's description, though he
intelligently covered himself up by saying there are other rare cases
where it might make sense. Here are some possible reasons:

Having a standard, neutral content representation like XML can make
sense when you need to decouple parts of your application from each
other, because you have either different teams implementing the
different parts, or you're implementing the different parts in very
different platforms, or both. In addition, making the content
representation explicit in the form of XML may aid comprehensibility of
the system, as suddenly the data flow becomes a lot more clear and can
be treated as something separate.

An example: visual template designers take the XML output of some
processing component of the application developed by quite different
programmers. They do not need to learn any APIs that may call deep into
the backend application and could be used the wrong way; they only need
to worry about extracting the information they need for presentation
from an XML structure.

Another place where XML can make sense is if you need a domain specific
language. These often make sense -- it can force people to think
declaratively about a problem instead of finding dirty ad-hoc ways out
all the time. Using XML can make your life easier, as the parser is
already available, along with many other possible tools. Of course
sometimes designing your own grammar from scratch may be worth doing,
but many cases it's not necessary and XML is good enough. It's a useful
tool in the toolbox in that case.

*Of course* you could do anything you can do with XML with Python
datastructures, and anything you do with XSLT with custom Python
transformation code, and so on. You could even build a framework to do
so. It would also be a lot of work. And you'll lose out on all the
interoperability advantages though, and you're betting your own mind
against that of a lot of experts who spent years thinking about this set
of problems, and your software against a massive installed base. In
certain cases going your own way is still worthwhile (someone will have
to improve the world), but in many cases it's not.

So, Python people, resistance is futile. Be assimilated by the XML
collective. Feel free to be smarter about it than many: stay sensible
and stay critical, to where XML makes sense and where it doesn't, but
throw out the disdain that makes you unable to see valid opportunities
for its use. *Learn* from XML technologies.

PJE is very smart. I am sure his view of it all is actually a bit more
nuanced than his tone. Looking at Chandler source code (as I suspect he
was doing) explains the outburst pretty well. But don't let it fool any
Python programmer into thinking they can safely ignore XML because it is
not worth considering by someone with a superior programming language
like Python. Most likely, he cannot ignore it, and he shouldn't.
