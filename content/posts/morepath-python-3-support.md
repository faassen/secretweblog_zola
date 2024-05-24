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

## Preserved Comments

### Alec Munro

> Happy to contribute. I was trying to pick a framework for a new project, and
> I really wanted to use Python 3. After a brief experimentation with Morepath,
> it seemed very promising, but then I noticed the lack of Python 3 support,
> and almost switched back to Flask.
>
> Curiousity got the better of me, thankfully, and I thought at least I should
> look and see what was missing to support Python 3. Running the hello world
> app under python 3, it turned out to be a half-dozen mostly trivial things in
> the framework code (direct references to 'unicode', urlencode and cookiejar
> moving, etc.). After fixing those I grabbed Tox and confirmed that I hadn't
> broken anything for 2.7.
>
> Then I added 3.4 to the tox.ini, which revealed quite a lot of failing tests
> under 3. A very significant portion of these were simply due to webob's
> request.body being a byte string, and most of the others were similar. There
> were one or two pieces where I think the solution is a bit on the ugly side
> to keep it running in 2 and 3, but hopefully we can clean those up.
>
> I really appreciate what you've got going on with Morepath, and I've
> benefited hugely from your other contributions throughout the years, so it
> feels very good to be able to give back a bit. It's especially cathartic
> since I managed to avoid making any contributions during the PyCon sprints
> this week.

### Martijn Faassen

> I'm glad curiosity got the better of you! You're the first person who
> actually did something significant with the Morepath source code besides
> myself that I know of. So I'm curious to hear more about your experiences.
> Also I hope Morepath works out for your project!

> If you're on IRC, there's a #morepath channel on freenode we hang out on.
> (that invitation applies to anyone interested in Morepath of course)
