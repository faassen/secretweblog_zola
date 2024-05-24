+++
title = "Brief Python 3000 thoughts"
date = 2007-06-20
slug = "brief-python-3000-thoughts"

[taxonomies]
tags = ["python3", "python"]
+++

# Brief Python 3000 thoughts

Briefly, some of my Python 3000 thoughts. I see quite a bit of
enthusiasm in some other blogs. I'm not very enthusiastic. While I
understand the need to be able to break backwards compatibility, I am
worried about Python forking into two parallel versions (2.x and 3.x)
for many, many years. Such a fork can't be good for the Python
community.

Why do I worry about Python forking? Because porting code to Python 3
will be hard. The porting instructions discuss the need for a good unit
test suite before getting started. This is very wise. In practice of
course, while I write unit tests for code all the time, lots of the code
I work with doesn't have a great test coverage. There's lots and lots
and lots of valuable Python code like that out there. What is going to
happen to it? How is it going to be ported?

Even with test coverage, porting over code is going to be a massive
amount of work for larger code bases. Considering that Zope 3, a clean,
modern, extremely well-tested code base (one of the best test coverages
in the Python world) is still on Python 2.4 as it takes time and effort
to port to Python 2.5, what is going to happen with Python 3? What does
this say about codebases with far less tests?

The result in many cases is that people will put off porting code, as
it's too costly. It won't be easy to motivate a customer to pay for
porting activity that will bring no new features to them whatsoever.
People will therefore continue to run this code on Python 2.x. Since
Python 2.x code doesn't work on Python 3.x, it won't be accessible to
people who made the jump. Since Python 3.x code doesn't work on Python
2.x, it won't be accessible to those with existing code bases who can't
make the jump any time soon. As a result, two Python communities for a
period of what I expect to be 5 to 10 years.

I realize there are no answers to these worries beyond those that have
already been given. Breaking backwards compatibility may be necessary.
It just doesn't make me have a "birthday feeling", as I saw described in
another blog. Python 3 is a serious risk to the Python community. Not by
far as much as, say, Perl 6, is to the Perl community, but a significant
risk nonetheless.

(I also am worried that Abstract Base Classes are throwing away some key
benefits of zope.interface, but that is not really a blocker - at least
zope.interface can be made to work on Python 3).
