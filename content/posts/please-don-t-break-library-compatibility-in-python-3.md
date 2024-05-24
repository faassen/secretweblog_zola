+++
title = "Please don't break library compatibility in Python 3"
date = 2008-03-05
slug = "please-don-t-break-library-compatibility-in-python-3"

[taxonomies]
tags = ["python3"]
+++

**Update**: Guido appears to [share my opinion on
this](http://www.artima.com/weblogs/viewpost.jsp?thread=227041).

I've heard murmurs from a bunch of projects over time concerning their
transition plans to Python 3.0. These transition plans are naturally
vague at this stage. There's one theme I've heard a few times in these
murmurs that worries me enough to speak out on it.

People sometimes reason that since Python 3 is going to break people's
code anyway, now is a good time to make backwards compatible changes in
their libraries too. The reasoning is understandable: people are facing
a big change anyway with Python 3, so why break backwards compatibility
for them once then, and then another time for your library? Better do it
at the same time and make people suffer only once.

There are other reasons that drive projects to break backwards
compatibility at this point. As far as I understand, the Python C API
will change with Python 3, so that means projects that bind to C
libraries need to be adjusted anyway. This might tempt people to make
larger scale changes.

I just heard that the current WSGI spec isn't entirely compatible with
Python 3. If that is so, and a new version of the spec is needed, then
that might give some frameworks that use WSGI an opportunity to clean up
some things and break backwards compatibility.

While very understandable, the negative consequence of all this is that
the Python 2 to 3 conversion script strategy stops working for code that
depends on these libraries and frameworks. This official transition
strategy aims to make the transition between Python 2 and Python 3
easier by offering a script that convert your Python 2 code to Python 3
code automatically.

If lots of important libraries and frameworks however _also_ break
backwards compatibility in their Python 3 versions, this means that any
converted code that depends on them has no chance of working. Instead
the developer would need to track all the API changes and make
adjustments there too before the code would work again: a much harder
task.

So my advice to library and framework maintainers would be: please do
_not_ use this opportunity to break backwards compatibility in your
library or framework too. I'd like to ask you to resist this temptation.
The language changes already make this a major transition for everybody,
and you'd make it that much harder by taking away people's ability to
automatically convert their Python codebases.
