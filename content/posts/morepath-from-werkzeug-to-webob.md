+++
title = "Morepath: from Werkzeug to WebOb"
date = 2014-03-04
slug = "morepath-from-werkzeug-to-webob"

[taxonomies]
tags = ["planetpython", "python", "morepath"]
+++

Today I changed over Morepath to use [WebOb](#webob) instead of
[Werkzeug](http://werkzeug.pocoo.org/) as its request and response
implementation.

[Morepath](http://morepath.readthedocs.org) is your friendly
neighborhood Python web micro framework with super powers.

In this post I'd like to explain what lead me there.

Having had now quite a bit of experience with both Werkzeug and WebOb I
will offer some points of comparison and feedback that may be useful to
improve Werkzeug and WebOb both, but I have done that in [a followup
post](http://blog.startifact.com/posts/webob-and-werkzeug-compared.html).

# Performance Testing

Two weeks ago I gave a talk about Morepath in Singapore, for the Python
Singapore User Group. When preparing the talk I ran into a blog post
describing a performance comparison between web frameworks called
[Python Fastest Web
Framework](http://mindref.blogspot.nl/2012/09/python-fastest-web-framework.html).

Now Morepath is not striving to be Python's fastest web framework. It's
striving to be fast enough, and offer a lot of power and flexibility to
developers in a small package. Morepath offers some [special
features](http://morepath.readthedocs.org/en/latest/superpowers.html)
such as linking and application reuse.

A performance comparison between web frameworks implies functional
equivalence between them, but they are not: some web frameworks like
Morepath have powers that others don't have. Using those powers may
allow you to build applications more quickly, and also organize them in
ways so that they are faster end than is easy to accomplish with other,
less versatile frameworks.

In addition we know that real world web applications typically have so
much overhead doing other things (such as dealing with databases) that
simple things like request handling are a minimal contribution to
performance in the end.

All that aside, I still wondered how Morepath did compared to other web
frameworks. Of course I did! It's nice to be able to say your web
framework is fast. More subtly benchmarking can also say something about
the amount of work a web framework does to serve a request, and the less
work, arguably the easier it is to understand the web framework and to
debug it.

So I plugged Morepath into the "hello world" page benchmark and found
Morepath was about as fast as Flask, but that Flask was one of the
slower of the lot compared:

    msec    rps      tcalls funcs
    django       10605   9430     183     89
    flask        14611   6844     257    119
    falcon        1355  73825      29     25
    morepath     15967   6263     314    122
    pyramid       3417  29269      64     48
    tornado      10073   9928     188     67
    wheezy.web    1222  81847      25     23

`msec` here is the amount of milliseconds to run all 100,000 requests in
the benchmark, `rps` is amount of requests per second, `tcalls` is the
total amount of function calls to handle a single request, and `funcs`
is the amount of different functions called during request handling.

Morepath in this benchmark is about the same speed as Flask. Morepath is
slower at this benchmark than Django, Tornado. Pyramid does pretty well
too, which is not a surprise due to its focus on performance. Morepath
is hopelessly slower at this benchmark than speed monsters such as
Falcon or wheezy.web. wheezy.web, the web framework by the author of the
blog entry.

That evening when I gave my presentation someone actually referenced
this benchmark and wheezy.web and asked how fast is Morepath. Having
done my research I could answer him Morepath is about as fast as Flask,
and also gave the caveats concerning performance above.

Still, could Morepath not do better? Morepath is about as fast as Flask
in this benchmark. Perhaps the Werkzeug library that both Morepath and
Flask used was the common factor dragging performance down?

# wheezy.http

wheezy.web is fast, so I took a look at this. I discovered wheezy.web is
built on [wheezy.http](https://pypi.python.org/pypi/wheezy.http), which
is a library that abstracts request and response from WSGI much like
WebOb and Werkzeug do.

After coming back from Singapore to the Netherlands, I looked up the
author of wheezy.web and wheezy.http up on IRC, and had a nice
conversation with him. He pointed out that his benchmarking system has a
knob that shows profiler statistics. I turned it on and this is what I
saw:

    31200017 function calls (29700017 primitive calls) in 25.958 seconds

    Ordered by: internal time
    List reduced from 134 to 10 due to restriction <10>

    ncalls  tottime  percall  cumtime  percall filename:lineno(function)
    1700000    1.728    0.000    5.079    0.000 lookup.py:136(all)
    800000/300000    1.530    0.000   16.120    0.000 mapply.py:5(mapply)
    900000/400000    1.036    0.000   18.370    0.000 lookup.py:104(call)
    1000000    1.015    0.000    6.367    0.000 lookup.py:54(component)
    900000/400000    0.934    0.000   19.425    0.000 generic.py:44(wrapper)
    1000000    0.853    0.000    1.147    0.000 compose.py:83(all)
    1000000    0.853    0.000    1.606    0.000 generic.py:29(get_lookup)
    3100002    0.851    0.000    0.851    0.000 {isinstance}
    100000    0.685    0.000    3.577    0.000 wrappers.py:733(__init__)
    200000    0.628    0.000    5.895    0.000 core.py:37(traject_consume)

Lots of this stuff I recognize as the internals of
[Reg](http://reg.readthedocs.org/en/latest/), the generic function call
library that Morepath is built on and that is already a known candidate
for optimization efforts, but that will have to wait until later. We
care about the request/response implementation now.

Werkzeug shows up twice in the top 10. First there's response object
generation:

    100000    0.685    0.000    3.577    0.000 wrappers.py:733(__init__)

Second, and harder to recognize, is this one:

    3100002    0.851    0.000    0.851    0.000 {isinstance}

This is an enormous amount of calls to `isinstance()`. I recognized this
as due to Werkzeug as the profile for Flask showed the exact same number
of calls (`3100002`), strongly suggesting Werkzeug as the cause.

I bit the bullet and experimentally changed Morepath to use wheezy.http
as its request/response implementation instead of Morepath. This caused
the request/response implementation to completely disappear from the top
10 most expensive functions. The `isinstance` stuff was gone too.

Morepath was 47% faster on helloworld now than with Werkzeug!

Armin Ronacher responded to this result on Twitter, and said the
`isinstance` business is likely a performance regression due to Python 3
compatibility in Werkzeug...

# Switching to wheezy.http?

I wondered now whether I should switch Morepath to wheezy.http. It is
certainly an attractive library, along with some of the other wheezy.\*
libraries.

My main trouble with it is that wheezy.http has seen much less
real-world battle testing than either Werkzeug or WebOb. Looking at its
source code the request and response wrappers were very simple indeed,
which made them a lot easier to read than the equivalent implementations
in Werkzeug and WebOb. That is certainly attractive. But they also
seemed to do rather little with encodings. And later I heard from Chris
McDonough that wheezy.http will have trouble dealing with non-ascii
URLs.

# WebOb

There was an obvious candidate sitting around that I hadn't tried yet:
WebOb.

I had initially deliberately avoided using WebOb for Morepath for two
reasons:

- when I had to do some other WSGI work I found that Werkzeug had a
  nicer lower-level API exposed that let me work with raw WSGI better.
- Pyramid is already using WebOb, and I figured since Morepath was
  already similar enough to Pyramid anyway I could try Werkzeug for a
  change. Perhaps using it would benefit Morepath in some ways I could
  not foresee.

The second reason wasn't very good, except for one thing: I learned more
about Flask and could model aspects of the Morepath documentation after
it. Otherwise Werkzeug and WebOb are pretty interchangeable. And I'm
confident Morepath is different enough from Pyramid anyway.

Now I had a strong reason to try WebOb: performance. I know that Chris
McDonough had been working on WebOb a lot and that he cares a lot about
performance, so I figured I should give it a shot.

So I swapped in WebOb and tried the benchmark again. The first result
was disappointing:

    msec    rps      tcalls funcs
    flask        14638   6832     257    119
    morepath     15089   6627     289     95

Morepath was only a little bit faster, and *still* flower than Flask.
What's going on here? Turning on the profiler showed me what was going
on:

    ncalls  tottime  percall  cumtime  percall filename:lineno(function)
    1700000    1.829    0.000    5.270    0.000 lookup.py:136(all)
    800000/300000    1.495    0.000   13.850    0.000 mapply.py:5(mapply)
    800000    1.047    0.000    1.980    0.000 request.py:1405(__setattr__)

WebOb's request.py `__setattr__` was showing up at number 3. I
discovered that WebOb's request object has some magic that observes
attributes. I also discovered that WebOb has a `BaseRequest` that
doesn't include this magic.

# WebOb: the results

So I tried things again using `BaseRequest` instead:

    msec    rps      tcalls funcs
    flask        14741   6784     257    119
    morepath     12236   8173     245     92

That makes Morepath 30% faster with WebOb than with Werkzeug *and*
faster than Flask.

Not as good as with wheezy.http, but using a much more battle-tested
framework, so not bad. This gets Morepath closer to Django and Tornado
at this. Once I optimize Reg I think I can get closer still.

Also see that the amount of functions called during a request dropped
from 314 to 245, and the amount of functions used drom and used has
dropped from 122 to 92.

# Switching Morepath to WebOb

If I wanted to switch something as big as a request/response
implementation, now was the time: before a Morepath release. So I made
the switch.

It wasn't difficult; the APIs are very similar. The most work was
actually porting the Morepath tests, but that got a lot easier once I
discovered the [webobtoolkit](https://pypi.python.org/pypi/webobtoolkit)
library.

Another benefit of switching to WebOb is that it may eventually allow
more code sharing between the Morepath and Pyramid ecosystems. I suspect
the easier candidate for code sharing would be
[Tweens](http://morepath.readthedocs.org/en/latest/tweens.html), as
Morepath and Pyramid now have the same basic Tween API.

I've followed up this post with [some feedback about Werkzeug and WebOb
in
general](http://blog.startifact.com/posts/webob-and-werkzeug-compared.html).
