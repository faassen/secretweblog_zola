+++
title = "Announcing BowerStatic"
date = 2014-07-01
slug = "announcing-bowerstatic"

[taxonomies]
tags = ["python", "planetpython", "bowerstatic", "morepath"]
+++

I've been working on something new these last few weeks that I'd like to
share with you: BowerStatic.

BowerStatic is Python WSGI framework for easily serving and including
components that you manage by using [Bower](http://bower.io/).

Let's unpack that:

- BowerStatic serves static resources (JS, CSS, etc) for you. It makes
  sure those resources are cached when they can be, and that the cache
  is automatically busted when you change them.
- BowerStatic can serve third-party components you can easily install
  using `bower install`. It can also serve locally developed components
  for you.
- BowerStatic can automatically create inclusions for static resources
  in your web page; it inserts `<script>` and `<link>` tags for you
  automatically
- It is a WSGI-based framework, meaning that you should be able to
  integrate it easily into any WSGI-based Python web application. So if
  you use Pyramid, Flask or Morepath: BowerStatic is for you!

Look at the [BowerStatic website](http://bowerstatic.readthedocs.org)
for much more information about all this. And check out the
[source](https://github.com/faassen/bowerstatic). Contributions are
welcome!

BowerStatic was heavily inspired by another project that I helped
create: [Fanstatic](http://fanstatic.org). For more information on how
things led up to BowerStatic, read the [history section in the
docs](http://bowerstatic.readthedocs.org/en/latest/history.html).

I am not done yet. I still need to work on some of the cache busting
behavior, improve error reporting. But soon it will be time for the
first release.

Deeper integration with the [Morepath](http://morepath.readthedocs.org)
web framework is also coming. I have a good idea of what know what it
will look like. Look out for `more.static` soon!
