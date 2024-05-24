+++
title = "Overwhelmed by JavaScript Dependencies"
date = 2013-05-13
slug = "overwhelmed-by-javascript-dependencies"

[taxonomies]
tags = ["javascript", "python", "obviel", "planetpython", "packaging"]
+++

# Introduction

\[UPDATE: This post has [new 2015
followup](http://blog.startifact.com/posts/javascript-dependencies-revisited-an-example-project.html)\]

This is about managing dependencies in a well-tested client-side
JavaScript codebase, how I got overwhelmed, and how I automated the
pieces to make it *Just work* ™.

The JavaScript world has grown a lot of tools for dependency management.
I've dipped my toes into it into the past, but didn't really know much
about it, especially on the client-side. Now I've done so, and I'm
somewhat overwhelmed. I also found some solutions.

If you don't feel overwhelmed by JavaScript dependency management yet,
this document can help you to *become* overwhelmed. And then perhaps it
can help a little to become less so.

\[update: I've created a
[followup](http://blog.startifact.com/posts/js-dependency-tools-redux.html)
to this post further analyzing the various options available\]

# A Client-side Codebase

The JavaScript client-side codebase I work on is fairly large; it's a
JavaScript web framework called [Obviel](http://obviel.org). Obviel is
large immaterial to this document however, so don't worry about it. I'm
going to talk about tools like Grunt and RequirejS and Bower and Buster
instead.

So far I've managed dependencies for Obviel manually by adding the right
`<script>` tags on web pages. If something needs `foo.js` and `bar.js` I
need to manually make sure it's being included. Even if `bar.js` is only
needed indirectly by `foo.js` and not by the code I'm writing myself.
Managing `<script>` tags by hand is doable but annoying.

Obviel is extensively unit tested. For the tests the dependency
situation is more involved. Obviel uses this nice JavaScript test runner
called [Buster.JS](http://docs.busterjs.org/en/latest/). It runs on the
server and is based on [Node.js](http://nodejs.org/). It features a
command-line test runner that can be hooked up to actual web browsers so
you can run a whole set of different tests automatically without having
to go clicking about in web browsers.

Buster needs to be configured properly so that it knows what
dependencies there are to run tests in the browser. This is done in a
file called `buster.js` that you put in your project. You still need to
explicitly manage dependencies by hand, though there are a few shortcuts
such as including all `.js` files in a whole directory as dependencies
at once.

# The Goal

I've always been dissatisfied with all this explicit dependency
management in Obviel's development. I want to use more fine-grained
modules in Obviel. Even it is decently modular already, I want to break
up Obviel into smaller modules still so I can more easily manage the
code during development. A hash table implementation that can have
object keys, for instance, should be in its own module, and not in, say,
`obviel-session.js`. I want smaller modules that do one thing well.
Deployment of client-side JavaScript code favors large `.js` files, but
during development I want smaller ones.

Moreover, I want everything to *Just Work* ™. If use a new internal
module in my project, or if I start depending on a new external library
in my project, I should be able to use them right away without the
hassle of config file editing. I should be able to hack on my code and
write unit tests and depend on stuff in them without worrying.

# My Python Background

Over the years, I've
[worked](http://blog.startifact.com/posts/older/the-ghost-of-packaging-past-and-future.html)
[a
lot](http://blog.startifact.com/posts/older/a-history-of-python-packaging.html)
with Python dependency management; PyPI, distutils, setuptools, pip etc.
And build tools like buildout. And of course, the Python `import`
statement. I learned a lot about JavaScript tools, and the Python tools
I'm already familiar with helped me put them in the right context.

For JavaScript dependency management so far I've piggy-backed on
Python's systems through [Fanstatic](http://fanstatic.org), which I
helped create. Fanstatic is a Python HTTP middleware that I helped
create. It can automatically insert needed dependencies (`.js`, `.css`,
etc) into a web page on the server-side. Using Fanstatic-wrapped Obviel
(the [js.obviel](https://pypi.python.org/pypi/js.obviel) Python library)
works pretty well in a Python project, but it doesn't work for
*developing* Obviel and it won't work for people who don't use Fanstatic
or even Python.

# Dependency management

What do I mean by dependency management anyway? Let's write down a few
concepts:

- a *project* is the codebase I'm hacking on. It could be an application
  or a framework or a library. It's in hackable form, checked out from a
  version control repository such as git. You can check out jQuery or
  the Linux Kernel or Obviel as a project. A project can typically be
  used to generate one or more packages.

- a *module* is a source code unit (normally a file) that provides some
  functionality. It contains things like functions and classes. Usually
  it exposes an API. A project typically contains multiple modules. So
  `foo.js` is a module, and so is `foo.py`, `foo.c`, etc.

- a module may *depend* on another module. A module dependency is
  expressed in the module itself, in source code.

  In Python and many languages this is done by *importing* the module by
  name somehow:

      import foo

  The C module system is bolted on through textual inclusion during the
  compilation phase:

      #include <stdio.h>

  In JavaScript there *is* no native way to express module dependencies,
  but people have created frameworks for it such as Node's module
  loading system and RequireJS, which I'll go into later.

- a *package* is a collection of one or more modules that is published
  somewhere so others may use it (this may be published on the internet,
  or internal to a project). It has metadata that describes the package,
  its version number, who wrote it, and what other published packages it
  depends on. In Python this information is in a file called `setup.py`,
  in JavaScript it's... well, it depends.

  I'll note that Linux distributions also feature packages that can be
  installed. I'll call these *deployment packages*. Deployment packages
  for various reasons are not very convenient to develop against. This
  is why many languages such as Python or JavaScript or Ruby or Perl
  have language-specific package systems. I'm focusing on such
  development-oriented packaging systems here.

- a module in package A may depend on another module in package B. In
  this case package A describes in its metadata that it depends on
  package B. This is an *external* dependency on a module in another
  package.

- A *package manager* is a tool that installs a package into your system
  so you can start using it. It's distinct from a version control system
  which installs a *project* into your system so you can start hacking
  on it, though package managers can be built on top of version control
  system software.

- A *package registry* is a system where packages can be registered so
  that others may find and download them. CPAN is the package registry
  for Perl code, for instance. Some of these systems allow manual
  download of packages through a web interface as well as automated
  downloads; Python's PyPI is the example I'm most familiar with.
  JavaScript has several package registries.

When I develop a project I want to be able to express in my metadata
somewhere that it depends on some packages, and in my project's modules
I want to express what other modules they depend on.

I don't want to have to worry about other config files for this, as
that's only more code to maintain and more mistakes to make.

And if I check out a project, I want to start hacking on it as soon as I
can. To get the project's external dependencies I want to be able to run
a command that does that for me.

Again, it should *Just Work* ™.

# server-side js packaging

I mentioned Buster.JS before. Using Buster.JS and its various plugins
for linting (jshint) and code coverage and so on introduced me to the
world of [npm](https://npmjs.org/), the package manager for Node.js.

npm is built around the
[CommonJS](http://wiki.commonjs.org/wiki/CommonJS) specs for JavaScript
package management. There's a file called `package.json` that describes
what dependencies packages have on others. Like what `setup.py` does for
Python packages.

There's also a registry of published packages for npm; this is like PyPI
for Python, CPAN for Perl, etc. npm lets you to download and install
packages from this registry, either by hand or by reading a config file.
This is much like easy_install or pip for Python.

So npm provides the equivalent of what pypi + distutils + distribute +
pip is for Python. I haven't really studied npm in detail yet, but it
seems nice. npm appears to be more coherent than the Python equivalents,
which grew over the years layering on top of each other, sometimes glued
together in hacky ways. npm looks cleaner.

# server-side imports

Unlike Python and many other languages, JavaScript doesn't have a
standard way to import modules. So people had to invent some!

In Node.JS, import works like this:

    var otherModule = require('otherModule');

You can then use `otherModule` like a module, so call functions on it
for instance:

    otherModule.someFunction();

`require()` doesn't just take names, but paths, such as relative paths,
so you can see stuff like this:

    ``require('../otherModule');``

to get a module from one directory higher up.

`npm` installs modules in a directory called `node_modules` which is
often in the project's home directory. There are some lookup rules I
don't quite fully grasp yet for getting modules with `require()` from
other places.

# client-side imports

But Obviel isn't a server-side JavaScript codebase; it's a client-side
one that runs in the browser. So I need dependency management for
browser JS.

The big fish here is [RequireJS](http://requirejs.org/). It is a
client-side library that implements a spec called Asynchronous Module
Definition, or [AMD](https://github.com/amdjs/amdjs-api/wiki/AMD). AMD
modules look like this:

    define(['jquery', 'obviel'], function($, obviel) {
       ... 
       obviel.view({...});
       ...
       $('.foo').render(blah);
       ...
    });

So, a module is wrapped in a function that's passed to `define()`. AMD
also allows this:

    define(function(require) {
       var otherModule = require('otherModule');
    });

which starts to look a lot like CommonJS, expect this wrapper function
around it all.

AMD was actually born originally as part of the CommonJS project, but
there was some difference of opinion and the AMD folks went off on their
own.

My understanding is that the main point of contention is that the AMD
folks figured an explicit function wrapper was the way to go for
client-side code to ensure maximum portability of JavaScript code (no
preprocessing of JS code necessary), and because it's good practice
anyway on the browser to avoid global variables from leaking out of your
code. The CommonJS folks wanted the client-side code to look more like
server-side modules. See the [Why
AMD?](http://requirejs.org/docs/whyamd.html) document for more on this
from the AMD perspective.

How does RequireJS know where to find modules? You need to specify where
it looks for modules in a config file. In that config file you can map
one path to another, so you can tell it where to look for your project's
modules, and where jQuery is and so on.

# client-side packaging

That brings us to client-side packaging. One popular package manager for
doing this is called [Bower](http://bower.io/). It introduces this
config file called `bower.json` which is like `package.json` (or
`setup.py`) but then for declaring front-end package metadata and
dependencies. Bower also introduces its own package registry and you
have a command-line tool to install packages, which end up in a
`components` directory, much like the way `npm` installs server-side
packages into `node_modules`.

# Overwhelmed yet?

So we have two different ways to define modules, and two different way
to do packaging. I am simplifying matters here - CommonJS does offer
definitions to transport modules to the client too, and there are ways
to manage client-side packages using npm too, and I'm sure other package
managers exist too.

You may start to agree with me that this is all somewhat overwhelming,
especially if you're new to this! But we're not there yet...

# bower and RequireJS

bower is agnostic as to what's in packages and how they're used;
RequireJS is just one possibility. So when I install a package into a
project using bower, RequireJS has no clue that it is even there, let
alone where to import it from. As a result, I cannot import any modules
from that package in my project's modules. I need to tell RequireJS
first.

So if I install jQuery using bower, I still need to manually tell
RequireJS in its config file how to find it: look in
`components/jquery/jquery.js` for it, please. Only after that I can
depend on it in my module.

This doesn't *Just Work* ™. I want to install something with bower and
start using it right away. We need something to help glue this together.

# Grunt

To construct complex Python projects I use this system called
[buildout](http://www.buildout.org/). It can be used to pull in
dependencies, install scripts, and automate all sorts of other tasks
too. Buildout is driven from a configuration file - it's kind of like
`Make` and the `Makefile` configuration file. s So JavaScript has some
build automation systems too. One popular one is called
[Grunt](http://gruntjs.com). It takes a config file called
`Gruntfile.js`. It can be extended with plugins which you install with
npm.

Grunt is pretty useful to automate jobs such as gluing bower and
RequireJS together.

# grunt-bower-requirejs

Using npm, you can install a grunt plugin called
[grunt-bower-requirejs](https://github.com/yeoman/grunt-bower-requirejs).
You configure it up in `Gruntfile.js`. Now if you run `grunt` it will
automatically make any dependencies installed using bower available for
RequireJS. It does this by manipulating the RequireJS config to tell it
where bower-installed packages are.

So now (at least after I run `grunt`), I can `require()` whatever
bower-installed packages I like from my own JS code. Awesome!

# Gluing up Buster

We're not all there yet. Remember the test runner I use, Buster? There
is already a [buster-amd](https://github.com/busterjs/buster-amd)
plugin, which is needed to let Buster behave properly around RequireJS.
Making this work did take somewhat tricky configuration featuring a
`pathMapper` and a regex I don't quite understand, but okay.

There is also already a
[grunt-buster](https://github.com/busterjs/grunt-buster) plugin. This
can automatically start a [PhantomJS](http://phantomjs.org/) based web
browser to run the tests, and then run them, if I type `grunt test`.
Pretty neat!

Is this enough to make things *Just Work* ™? After all I should be able
to rely on RequireJS declare the dependencies for my test modules. But
no...

As mentioned before, Buster actually has a special requirement if you
run tests against a web browser: it needs to know what JS resources to
publish to the web browser it runs the tests in, so that they are even
available for RequireJS at all. It is kind of what Fanstatic does,
actually!

# grunt-bower-busterjs

So now Buster needs to know what client-side packages are installed
through Bower too, just like RequireJS.

Unfortunately there wasn't a grunt plugin for this yet that I could
find. Balazs Ree, my friend from the Zope community who also is doing
lots of stuff with JavaScript, suggested creating something like
grunt-bower-requirejs to create bower integration for buster. Good idea!

It turned out grunt-bower-requirejs was extremely close to what was
needed already, so I forked it and hacked it up into
[grunt-bower-busterjs](https://github.com/faassen/grunt-bower-busterjs).
When plugged into grunt, this generates a `bowerbuster.json` file.
Following Balazs' advice I then tweaked Buster's `buster.js`
configuration file to load up `bowerbuster.json` into the test sources
list.

And then, at last, everything started to *Just Work* ™!

# jspak - a sample project

There is a good chance you're now overwhelmed as I was. Hopefully I can
help: I've pulled all this together into a sample project called
[jspak](https://github.com/faassen/jspak). It integrates bower and
buster and grunt and RequireJS and seems to *Just Work* ™.

I will consult it myself when I start the job of converting Obviel to
use it but perhaps it's useful for others too.

# Thoughts

Here are a few thoughts concerning all this.

It *would* be nice if the JavaScript world could work out a system where
I don't need 5 or 6 configuration files just to get a project going
where I can install client-side packages and run the tests
(`Gruntfile.js`, `bower.json`, `bowerbuster.json`, `buster.js`,
`package.json`, `rjs.js`). I'm sure glad I got it working though!

Maybe such a system already exists; there just *might* be a parallel
JavaScript ecosystem out there with yet another way to do packaging and
imports that has *Just Worked* ™ all the time already. One never knows
with JavaScript!

The Python packaging world feels a lot more comfortable to me than the
JavaScript one. One obvious reason that doesn't really count is just
because I'm used to Python packaging and am familiar with its quirks.

Another reason is that JavaScript actually runs in web browsers as well
as on the server, while Python is used on the server only. This means
JavaScript needs to solve problems that Python just doesn't have.
(Though various projects exist that make something like Python run in
the browser too. One wonders how packaging works for them.)

Finally an important reason is that Python actually has a freaking
built-in `import` statement! People then kind of naturally gravitate
towards using something that is already, instead of creating several
different ways. JavaScript clearly doesn't follow the Zen of Python:
"There should be one-- and preferably only one --obvious way to do it."
("Although that way may not be obvious at first unless you're Dutch." --
I'm Dutch :) )

Finally, a funny thing about JavaScript project names: Buster.JS,
Node.js, CommonJS, RequireJS - not being very consistent with the
spelling of the *JS* bit, are we? I'm a programmer and I'm trained to
pay attention to irrelevant things like that.
