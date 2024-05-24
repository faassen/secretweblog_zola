+++
title = "Object Publishing"
date = 2013-10-23
slug = "object-publishing"

[taxonomies]
tags = ["python", "zope", "planetpython"]
+++

# Introduction

A final early Zope innovation that I want to talk about is object
publishing. Object publishing is one of those ideas that seemed weird at
the time. In fact, in its execution Zope would still be considered weird
by many today. But in an important way the idea of publishing code on
URLs is now absolutely the norm.

# The Web in 1998

Let's go back to 1998, when Zope was born. Let's look at a URL:

    http://example.com/dir/file.html

If you saw this URL in 1998, you knew that `/dir/file.html` refers to a
file on the filesystem on a web server somewhere. That is, there is an
actual directory `dir`, and an actual file `file.html`. Where the root
of the website would be on the filesystem was up to the configuration of
the web server, but once you're inside this root paths in URLs get
translated to paths in the filesystem.

A URL could refer to a static HTML file as above. You could also build
dynamic web applications. You'd do this by putting files in your web
server that were CGI scripts. When someone accesses the file, the script
would be executed and produce HTML content. So `script.cgi` or
`script.pl` or `script.py` or something.

# Zope's way

Zope was different. The path in a URL in Zope did not map to a file in
the filesystem anymore, but to a piece of Python code. Zope was one of
the first systems to do so. With Zope, the path was interpreted as a
series of steps to a Python method. So, the path:

    /a/b/c

would translate to:

    root['a']['b']['c']()

or possibly:

    root.a.b.c()

or a combination thereof. The concept is called _object publishing_ and
the process by which the right method to call is found is called
_traversal_, as an object graph is traversed.

URLs served from a Zope server looked clean, without complicated URL
parameters to encode state, and without file extensions. The URLs looked
so clean and unadorned that in fact they sometimes confused people who
were expecting a `.cgi` or `.pl` or `.php` or `.asp` or `.cfm`.
Bizarrely enough for a little while we had an effort to bring them back
so people would be less confused.

# The Web today

A variation of Zope's approach is now the norm. Most web development
frameworks in Python and other languages don't map URL paths to files
anymore, but to code. If you use a routing system like the one in
Django, for instance, a URL is not resolved to a file, but to a function
that typically queries an object from the database and then represents
it as HTML or JSON.

While the mapping of URL paths to code is now the norm, Zope's
_particular_ way of doing traversal is still weird to many. Zope's way
fits well with the ZODB, as the ZODB is natively an object graph that
can be traversed. Zope's way doesn't fit other database structures as
well.

Zope's approach is weird, but it's still worth examining. A benefit of
this traversing approach is that it gives URLs to _models_, not only
views or controllers; making explicit something that is implicit in more
modern routing-to-view web frameworks. This means that not only can a
URL be resolved to a model (and only then a view/controller), but you
can also _construct_ a URL with just a model. This is very powerful and,
in the RESTful, client-side web of today more relevant than ever.[1]

This blog entry is a part of a [series on
Zope](/posts/my-exit-from-zope) and my
involvement with it.
[Previous](/posts/the-weirdness-of-zope).
[Next](/posts/renewing-zope).

[1] I myself have explored combining routing and traversal in my older
[Traject](https://pypi.python.org/pypi/traject) library and the
so-new-oh-no-I-gotta-write-the-docs
[Morepath](https://github.com/morepath/morepath) web framework.
