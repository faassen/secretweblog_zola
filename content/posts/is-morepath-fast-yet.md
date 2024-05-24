+++
title = "Is Morepath Fast Yet?"
date = 2016-09-21
slug = "is-morepath-fast-yet"

[taxonomies]
tags = ["morepath", "reg", "planetpython", "python"]
+++

[Morepath](http://morepath.readthedocs.io) is a Python web framework.
But is it fast enough for your purposes?

# Does performance matter?

**Performance is one of the least important criteria you should use when
you pick a Python web framework.** You're using _Python_ for web
development after all; you are already compromising performance for ease
of use.

But performance makes things seem easy. **It boils down the whole choice
between web frameworks to a single seemingly easy to understand
variable: how fast is this thing?** All web frameworks are the same
anyway, right?
([Wrong](http://morepath.readthedocs.io/en/latest/compared.html)). We
don't want the speed of our application be dragged down by the web
framework. So we should just pick the one that is fastest. Makes total
sense.

It makes total sense until you take a few minutes to think about it.
Performance, sure, but performance doing what? Performance is
notoriously difficult to measure. Sending a single "hello world"
response? Parsing complex URLs with multiple variables in them? HTML
template rendering? JSON serialization? Link generation? What aspect of
performance matters to you depends on the application you're building.
Why do we worry so much about performance and not about features,
anyway?

**Choosing a web framework based on performance makes no sense for most
people. For most applications, application code dominates the CPU time
spent.** Pulling stuff out of a database can take vastly more time than
rendering a web response.

# What matters

So it makes sense to look at other factors when picking a web framework.
Is there documentation? Can it do what I need it to do? Will it grow
with me over time? Is it flexible? Is it being maintained? What's the
community like? Does it have a cool logo?

Okay, I'm starting to sound like someone who doesn't want to admit the
web framework I work on, Morepath, is atrociously slow. I'm giving you
all kinds of reasons why you should use it despite its performance,
which you would guess is pretty atrocious. **It's true that the primary
selling point of Morepath isn't performance -- it's flexibility. It's a
micro-framework that is easy to learn but that doesn't let you down when
your requirements become more complex.**

# Morepath performance

I maintain a very simple benchmark tool that measures just one aspect of
performance: how fast a web framework at the Python WSGI level can
generate simple "hello world" responses.

<https://github.com/faassen/welcome-bench>

I run it against Morepath once every while to see how we're doing with
performance. I actually care more [about what the framework is
doing](http://plope.com/whats_your_web_framework_doing) when Morepath
generates the response than I care about the actual requests per second
it can generate. I want Morepath's underlying complexity to be
relatively simple. But since performance is so easy to think about I
take advantage of that as a shortcut. I treat performance as an
approximation of implementation complexity. Plus it's cool when your
framework is fast, I admit it.

The current Morepath development version takes about 5200 ms per 100,000
requests, which translates to about 19200 requests per second. Let's see
how that compares to some of the friendly competition:

    ms     rps  tcalls  funcs
    django       10992    9098     190     85
    flask        15854    6308     270    125
    morepath      5204   19218     109     80

So at this silly benchmark, Morepath is more than twice as fast as
Django and more than three times faster than Flask!

Let me highlight that for marketing purposes and trick those who aren't
reading carefully:

**Morepath is more than 2 times faster than Django and more than 3 times
faster than Flask**

Yay! End of story. Well, I gave a bit of a selective view just now. Here
are some other web frameworks:

    ms     rps  tcalls  funcs
    bottle        2172   46030      53     31
    falcon        1539   64961      26     24
    morepath      5204   19218     109     80
    pyramid       3920   25509      72     57
    wheezy.web    1201   83247      25     23

I'm not going to highlight that Bottle is more than two times faster at
this silly benchmark nor that Falcon is more than three times faster.
Let's not even think about wheezy.web.

I think this performance comparison actually highlights my point that in
practice web framework performance is usually irrelevant. People aren't
flocking to wheezy.web just because it's so fast. People aren't ignoring
Flask because it's comparatively slow. **I suspect many are surprised
are surprised Flask is one of the slowest frameworks in this benchmark,
as it's a lightweight framework.**

**Flask's relatively slow performance hasn't hurt its popularity. This
demonstrates my point that web framework performance isn't that
important overall.** I don't fully understand why Flask is relatively
slow, but I know [part of the reason is
werkzeug](/posts/morepath-from-werkzeug-to-webob.html),
its request/response implementation. Morepath is actually doing a lot
more sophisticated stuff underneath than Flask and it's still faster.
That Pyramid is faster than Morepath is impressive, as what it needs to
do during runtime is similar to Morepath.

Let's look at the `tcalls` column: how many function calls get executed
during a request. **There is a strong correlation between how many
Python function calls there are during a request and requests per
second. This is why performance is a decent approximation of
implementation complexity.** It's also a clear sign we're using an
interpreted language.

# How Morepath performance has changed

So how has Morepath's performance evolved over time? Here's a nice
graph:

![Morepath performance over time](/img/morepath_performance.png)

So what does this chart tell us? Before its 0.1 release when it still
used werkzeug, Morepath was actually about as slow as Flask. After we
switched to webob, Morepath became faster than Flask, but was still
slower than Django.

By release 0.4.1 a bunch of minor improvements had pushed performance
slightly beyond Django's -- but I don't have a clear idea of the
details. I also don't understand exactly why there's a performance bump
for 0.7, though I suspect it has to do with a refactor of application
mounting behavior I did around that time -- while that code isn't
exercised in this benchmark, it's possible it simplified a critical
path.

I do know what caused the huge bump in performance in 0.8. This marked
the switch to Reg 0.9, which is a dispatch library that is used heavily
by Morepath. Reg 0.9 got faster, as this is when [Reg switched to a more
flexible and efficient predicate dispatch
approach](/posts/punctuated-equilibrium-in-software.html).

Performance was stable again until version 0.11, when it went down
again. In 0.11 we introduced a measure to make the request object
sanitize potentially dangerous input, and this cost us some performance.
I'm not sure what caused the slight performance drop in 0.14.

And then there's a vast performance increase in current master. What
explains this? Two things:

- We've made some huge improvements to Reg again. Morepath benefits
  because it uses Reg heavily.
- I cheated. That is, I found work that could be skipped in the case no
  URL parameters are in play, as in this benchmark.

Skipping unnecessary work was a legitimate improvement of Morepath. The
code now avoids accessing the relatively expensive `GET` attribute on
the webob request, and also avoids a `for` loop through an empty list
and a few `if` statements. **In Python, performance is sensitive to even
a few extra lines of code on the critical path.**

But when you _do_ have URL parameters, [Morepath's
feature](http://morepath.readthedocs.io/en/latest/paths_and_linking.html#type-hints)
that lets you convert and validate them automatically is pretty nice --
in almost all circumstances you should be glad to pay the slight
performance penalty for the convenience. **Features are usually worth
their performance cost.**

# So is Morepath fast yet?

Is Morepath fast yet? Probably. Does it matter? It depends. What
benchmark? But for those just skimming this article, I'll do another
sneaky highlight:

**Morepath is fast. Morepath outperforms the most popular Python web
frameworks while offering a lot more flexibility.**
