+++
title = "Python 3 worries: feedback"
date = 2007-06-22
slug = "python-3-worries-feedback"

[taxonomies]
tags = ["python3"]
+++

I've received a lot of feedback to [my previous blog
entry](@/posts/brief-python-3000-thoughts.md). I stated there that I'm worried
about the costs of breaking backwards compatibility in Python 3, and its cost
to the Python community. I'm glad I received this feedback, because the topic
bears a bit of attention.

There was a whole series of comments saying the transition cost wouldn't
be as high as I estimated. More in the range of switching from Python
2.4 to Python 2.5, perhaps, someone said. I'm not sure what to say to
that, just that I am surprised by this statement. Since Python 2.5 aims
to be backwards compatible, and indeed most Python software previously
written runs fine on Python 2.5, and this is explicitly not so with
Python 3, it's like comparing apples and oranges to me.

I've also seen people say that we have been there in the past, during
the transition of Python 1.x to Python 2.x, and that this turned out
fine. I am not sure whether the people saying that were there at the
time, but I was. Python 2.x did not break backwards compatibility with
Python 1.x, and the transition between 1.5 and 2.0 in was smaller than
some we have seen afterwards (new style classes in, if I have it
correctly, 2.2).

My reference to the Perl 6 transition drew some voices from the Perl
community. I was assuming Perl 6 was going to break backwards
compatibility with Perl 5 in a bigger way than Python 3 is going to
break backwards compatibility with Python 2, since their language is
changing so much. That's only partially true: while the language
changes, the plan has apparently always been to produce a runtime that
runs both Perl 5 and Perl 6 code and provide module-level
interoperability. I do not know how far this plan is along. It does make
the Perl 6 transition less risky in that respect compared to Python 3.

I still figure the Perl 6 transition is very risky simply because it's
been taking so very long, which is likely driving people to look for
other languages in the mean time. Python 3, being less ambitious,
hopefully is finalized more quickly than that.

I wonder whether a dual-runtime model is something that was considered
for Python 3. You could then upgrade one module at the time. The
maintenance burden to the language developers would be increased for a
longer period. Since the language developers are increasing the
maintenance burden of all developers _using_ Python with Python 3,
perhaps I am not too concerned about making the maintenance burden of
the core developers a bit higher. :)

Now to respond to [some points made by Brett
Cannon](http://sayspy.blogspot.com/2007/06/responding-to-peoples-reactions-to.html\)
in response to my worries:

"In the end it all doesn't matter. Python 2.x is not going anywhere, so
even if Py3K turns out to be a flop Python will live on. But if Py3K
does do well (and I expect it will in the end), Python will be better
for it."

I am not worried about Python 3 turning out to be a flop. I'm worried
about the disruption and costs it will cause to the community, flop or
not.

I disagree strongly with the statement that "in the end it all doesn't
matter". It _does_ matter that all the Python code in the world is going
to be broken on Python 3. It _does_ matter that all Python developers
are going to have to invest time and effort in transition. The risk that
we end up with two python communities for a significant period, with all
the confusion surrounding it, _does_ matter.

There is a significant cost in doing this. I think the Python community
can bear this cost. I am not sure whether the cost is worth the gain,
but Guido thinks it's a good idea, and he does have enough credit with
me to trust his judgement. I understand the attraction of cleaning up
the language in a backwards incompatible fashion.

You, the core developers, are causing a huge risk to the Python
community by splitting it asunder for a period of years, and increase
the code maintenance costs of all Python developers significantly due to
this transition. What I don't want to hear is "in the end it all doesn't
matter". I want to hear is that you are aware of the trouble you're
putting us all through and that it _does_ matter. I want to hear that
getting the transition plan right weighs heavily on your hearts.

The core developers should be fully aware of the very heavy cost of
their plans. I hope they're going to do their utmost best to reduce this
cost to a minimum. An expression of understanding of the gravity of the
situation will put me far more at ease than saying the transition plan
is "pretty damn good" and that you can simply continue to use Python 2.x
for as long as you like anyway.
