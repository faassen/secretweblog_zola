+++
title = "Morepath 0.16 released!"
date = 2016-10-04
slug = "morepath-016-released"

[taxonomies]
tags = ["morepath", "python", "planetpython", "reg"]
+++

I'm proud to announce the release of Morepath 0.16. **Morepath\_ is a
Python web framework that is easy to use and lightweight but grows with
you when your project demands more.**

**Morepath 0.16 is one of the biggest releases of Morepath in a while**.
I want to discuss a few of the highlights of this release here.

# Reg Rewritten

Morepath uses the predicate dispatch library
[Reg](http://reg.readthedocs.io/en/latest/) for its view lookup system
and other behavior. We've rewritten Reg [once
again](/posts/punctuated-equilibrium-in-software.html).
**For most Morepath users nothing changes, except that Reg is faster
which also makes Morepath faster. If you want to use Reg directly, the
new registration API makes it easier to use.**

With Reg you can control the context in which dispatch takes place: this
allows multiple separate configurations of dispatch in the same runtime.
To control context, previously we used an implicit global `lookup`
object, or an explicit but not very Pythonic `lookup` argument. Those
are all gone. If you need multiple dispatch contexts in an application,
you can define dispatch methods which derive their context from their
class. This change allowed us to simplify Reg considerably and increase
its performance.

This work was done by Stefano Taschini in collaboration with myself.
Thanks Stefano!

# New pip-based build system

This only affects us Morepath developers, but it's a significant change,
so I want to highlight it here. We have a nice core team of contributors
now and I hope we can attract more, after all.

I've been a happy buildout user over the years, so of course I used it
for Morepath's development setup as well. But for a Python-only project
like Morepath, `pip` can now do what buildout does. **Since many more
Python programmers are familiar with pip, and we want to make it as easy
as possible for someone to start contributing, we've taken the plunge
and entirely replaced buildout with pip.** Even a buildout guy such as
myself has been appreciating the results.

We've updated [our developer
documentation](http://morepath.readthedocs.io/en/latest/developing.html)
to reflect the changes, so it's easy to find how to do common things.
The build environment for the
[Reg](http://reg.readthedocs.io/en/latest/) and
[Dectate](http://dectate.readthedocs.io) libraries were used to use pip
as well.

This work was done by Henri Hulski. Thanks Henri!

# Other significant changes

- I took a good look at Traject's routing system with an eye on
  performance and refactored it.
- We realized that the `directive` directive was a bit too magic for its
  own good. I changed Dectate so that new Morepath configuration
  directives are now defined directly on the `App` class using the
  `dectate.directive` function. This breaks some code if you define new
  directives, but it's easy to fix.
- Our [extensive documentation](http://morepath.readthedocs.io) has had
  a reorganization of its table of contents.

Look at the [detailed
changelog](http://morepath.readthedocs.io/en/0.16/changes.html) for much
more information, including upgrade notes.

# Performance increase

I benchmarked Morepath quite frequently during this development cycle.
**To make benchmarking easier, I created a new benchmarking tool called
howareyou. It can not only benchmark Morepath, but can also benchmark
other web frameworks -- Michael Merickel has in fact been using it
already to help optimize Pyramid.** You can find the howareyou tool
[here](https://github.com/faassen/howareyou) . The origins of this tool
ultimately go back to work by `wheezy.web` creator Andriy Kornatskyy.

Morepath uses [Webob](http://webob.org) for its request and response
implementation. I learned quite a lot about Webob performance
characteristics during this development cycle. This allowed me to make
performance tweaks in Morepath.

It also let me detect that Webob's development version had some
performance regressions that affected both Pyramid and Morepath. **I'm
very grateful to Bert Regeer for picking up so quickly and thoroughly on
my reports of performance problems in Webob, and the Webob development
version is currently actually slightly faster than release 1.6.1.**

I talked about Morepath's performance history recently in my article [Is
Morepath Fast
yet?](/posts/is-morepath-fast-yet.html). There
we had peaked at about 19000 requests per second (on a synthetic
benchmark) for the development version. **I am happy to announce that
we've managed to increase performance even more in our 0.16 release.
It's now more than 28000 requests per second!**

<img src="/morepath_016_performance.png" width="1000" height="600"
alt="Morepath performance over time" />

Let's compare Morepath with some other carefully selected frameworks:

<img src="/morepath_performance_compared.png" width="1000" height="600"
alt="Morepath performance compared" />

**Cool, Morepath 0.16 is actually faster than Pyramid at this point in
time!** I don't expect it to last long given that the Pyramid devs
already using `howareyou` to optimize Pyramid, but it's nice to have
such a moment. And I deliberately didn't include Falcon, Bottle or
wheezy.web in this comparison, as that would rather spoil the effect. Do
remember these are somewhat silly, synthetic benchmarks. **It's rare
indeed that Python web framework overhead is going to affect real world
performance, but at least Morepath isn't the slowest one, right?**

# Enjoy!

I hope you all enjoy the fresh new release. Do [get in touch with
us](http://morepath.readthedocs.io/en/latest/community.html)!
