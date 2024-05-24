+++
title = "Morepath Python 3 support"
date = 2014-04-17
slug = "morepath-python-3-support"

[taxonomies]
tags = ["planetpython", "python", "morepath", "python3"]
+++

Thanks to an awesome contribution by [Alec
Munro](https://github.com/fudomunro),
[Morepath](http://morepath.readthedocs.org), your friendly neighborhood
Python micro framework with super powers, has just gained Python 3
support!

Developing something new while juggling the complexities of Python 2 and
Python 3 in my head at the same time was not something I wanted to do --
I wanted to focus on my actual goals, which was to create a great web
framework.

So then I had to pick one version of Python or the other. Since my
direct customer use cases involves integrating it with Python 2 code,
picking Python 2 was the obvious choice.

But now that Morepath has taken shape, taking on the extra complexity of
supporting Python 3 is doable. The Morepath test coverage is quite
comprehensive, and I had already configured tox (so I could test it with
PyPy). Adding Python 3.4 meant patiently going through all the code and
adjusting it, which is what Alec did. Thank you Alec, this is great!

Morepath's dependencies (such as WebOb) already had Python 3 support, so
credit goes to their maintainers too (thanks Chris McDonough in
particular!). This includes the [Reg](http://reg.readthedocs.org)
library, which I polyglotted to support Python 3 myself a few months
ago.

All this doesn't take away from my opinion that we need to do more to
support the large Python 2 application codebases. They are much harder
to transition to Python 3 than well-tested libraries and frameworks, for
which the path was cleared in the last 5 years or so.

\[update: this is still in git; the Morepath 0.1 release is Python 2
only. But it will be included in the upcoming Morepath 0.2 release\]
