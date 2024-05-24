+++
title = "JS Dependency Tools Redux"
date = 2013-05-16
slug = "js-dependency-tools-redux"

[taxonomies]
tags = ["javascript", "obviel", "packaging"]
+++

# Introduction

\[UPDATE: This post has [new 2015
followup](/posts/javascript-dependencies-revisited-an-example-project.html)\]

Recently I looked into JavaScript dependency management and wrote a long
post about it where I was
[overwhelmed](/posts/overwhelmed-by-javascript-dependencies.html)
and found some solutions. Since then I've learned a few new things and
have thought a bit more, and I thought I'd share.

My goal is still to be able to develop [Obviel](http://obviel.org) with
smaller modules than I do now. Obviel is a client-side web framework,
but besides that you should not need to know anything about it in order
to understand this post.

So, I'm looking for a JavaScript dependency framework for the
client-side.

# AMD versus CommonJS

Last time I mentioned Asynchronous Module Definition
([AMD](http://requirejs.org/docs/whyamd.html)) and how it contrasts with
the [CommonJS](http://wiki.commonjs.org/wiki/CommonJS) module
definition. AMD wraps everything in your module in a function:

    define([jquery], function($) {
       var myModule = {
          foo: function() { ... };
       };
       return myModule;
    });

Whereas CommonJS uses this pattern:

    var $ = require('jquery');

    module.exports = { foo: function() { ... }};

Though AMD has sugar to make it look much like CommonJS plus the
`define()` function wrapper.

AMD was designed to work in web-browsers, client-side, whereas CommonJS
modules are mostly used on the server, typically in a NodeJS
environment. AMD modules can be directly loaded into the browser without
build step, which is an important advantage during development. AMD
modules like CommonJS modules can also refer to individual modules in
other packages. You could install such an AMD-based package using
[Bower](http://bower.io/), like you'd install a CommonJS-based package
using npm.

The most well known AMD implementation is called
[RequireJS](http://requirejs.org/). There is a small implementation of
it called [Almond](https://github.com/jrburke/almond) that RequireJS can
use in JavaScript modules that are packaged together for release.

Recently I also learned about [RaptorJS](http://raptorjs.org/), which is
a larger framework that features an extended AMD implementation as well
as a separate server-side module loader. It contains some interesting
ideas such as "adaptive packaging" which helps adjust codebases to
different target environments (client, servers, different browsers,
etc).

# CommonJS on the client

Of course people have worked on bringing CommonJS modules to the client
too. And have they! I ran into these so far:

- [browserify](http://browserify.org/)
- [OneJS](https://github.com/azer/onejs)
- [commonjs-everywhere](https://github.com/michaelficarra/commonjs-everywhere)
- [browser-build](https://github.com/krisnye/browser-build)
- [component](https://github.com/component/component)

May a thousand flowers bloom! Overwhelmed, me?

I've done a cursory review of these, so I apologize if I get something
wrong, but here goes:

- [browserify](http://browserify.org/) is a tool that can take a file
  with a CommonJS module (and its dependencies) and bundle them all up
  in a `.js` file you can use in the browser.

- [OneJS](https://github.com/azer/onejs) seems to do something very
  similar. The docs don't make it immediately obvious what its
  distinctive features are.

- [commonjs-everywhere](https://github.com/michaelficarra/commonjs-everywhere)
  does the same again (I think... the docs are a bit technical...), but
  has more features.

  One cool thing is [source
  maps](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/)
  support. Source maps I just found out about: they are basically a way
  to add debugging symbols to a minified, bundled `.js` file so the
  debugger can find out about the original source. This is handy if you
  bundle plain JS, and also makes it possible to offer better debugger
  support for languages such as CoffeeScript which compile to
  JavaScript. Source maps are only supported in Chrome right now, with
  Firefox support coming up.

  \[update: a commenter pointed out that browserify supports source maps too,  
  pass a `--debug` flag during building to enable this\]

- [browser-build](https://github.com/krisnye/browser-build) is a very
  recent implementation that does the same as the others, but is focused
  on performance: producing a browser version of CommonJS modules of
  your project really fast, so you never have to wait for your tool
  during development. It has support for source maps.

  But it also does something more: if you write your code in plain
  JavaScript (as opposed to CoffeeScript, say), it makes your original
  modules available to the browser in only very slightly edited form
  (the line numbers are the same). This should help debugging a great
  deal in browsers that don't support source maps.

  But I'm unsure about the details, as browser-build needs to have
  CoffeeScript available to compile the sources and run it and I too
  lazy to try this right now.

- [component](https://github.com/component/component) is also a package
  manager (I'll mention it again later in that context), but also
  contains a build system to generate a single `.js` file from CommonJS
  modules.

All of these approaches need a build step during development, which
makes debugging harder, though source maps will help. browser-build
minimizes the build step during development to the bare minimum,
however, and this will help debugging.

# Both? uRequire

Then there's [uRequire](https://github.com/anodynos/uRequire).

uRequire allows you to use CommonJS _or_ AMD _or_ both and converts them
to whatever is needed. It talks about a Universal Module Definition
([UMD](https://github.com/umdjs/umd)) I haven't studied yet, but
apparently its not necessary to use its boilerplate when using uRequire.
From what I understand in order to use code in the browser a build step
is required.

# JS frameworks with a module system

There are lots of JavaScript client-side frameworks that have grown
their own module systems. I'll only talk about a few here that seem
relevant.

- [Dojo](http://dojotoolkit.org/) had its own module system, but has
  started to use AMD in recent versions and has been pushing this
  forward. You can use Dojo modules directly in your own codebase - this
  kind of inter-package reuse is something I will go into more detail
  later.
- [Closure Tools](https://developers.google.com/closure/) by Google
  contains a lot of things, such as a powerful JavaScript compiler and
  various JavaScript libraries. It also features its own module system,
  which I'll also talk about more later.

# JavaScript Packages and Modules Redux

In the previous blog entry I explored some concepts surrounding
dependencies and modules. I've had some new insights on how these
concepts apply to the JavaScript world. I'll review some of this again,
this time with a focus on what these concepts look like in JavaScript.

- a _project_ is the codebase you're hacking on. In open-source JS land,
  typically it's something published on github. It's in hackable form,
  so contains a lot of separate `.js` files to separate concerns:
  modules.

- a _module_ is a JavaScript file that provides some functionality by
  exposing an API.

- a module may _depend_ on another module. A module dependency is
  expressed in the module itself, in source code. In JavaScript there
  are multiple systems for expressing modules and their dependencies,
  such as CommonJS, AMD and Google Closure.

- a _package_ is a collection of one or more modules that is published
  somewhere so others may use it (this may be published on the internet,
  or internal to a project). It has metadata that describes the package,
  its version number, who wrote it, and what other published packages it
  depends on.

  CommonJS packages on the server-side are distributed as essentially an
  archive of a CommonJS project: a `lib` directory full of modules, with
  `package.json` for metadata.

  Traditionally client-side JavaScript packages are just distributed as
  URLs pointing to a `.js` file that people can download. So, to get
  jQuery, you download a version at the jQuery website. This is a very
  large difference between browser and server.

  [Bower](http://bower.io/) packages are a formalization of this
  traditional pattern: there is a single `.js` file with `bower.json`
  metadata to describe it. Bower adds metadata (`bower.json`) and a
  package index to the original story.

  In fact the Bower story is more complicated: it does allow you to
  package up a directory of multiple modules too, which you could then
  use using, say, RequireJS. This is an entirely different way to use
  modules, but Bower is agnostic and just installs the stuff. Bower also
  supports listing more than one `.js` file in its `bower.json`
  configuration file; it's unclear to me what the semantics of this is
  exactly.

- _Package generation_. This is something I skipped in the previous
  discussion of concepts, but is very important in the JavaScript world
  especially.

  CommonJS packages are just archived versions of a particular project
  layout: a directory with a `package.json`, with a `lib` subdirectory
  which contains the individual `.js` modules.

  Browser-targeted packages are most commonly shipped as a single `.js`
  file as mentioned before. In the most simple case you maintain this
  `.js` file by hand directly and give it to others to use.

  But you can also generate a single `.js` package file by compiling a
  bunch of `.js` module files together. This is what the CommonJS
  generators described above do, except for browser-build, which
  actually maintains a tree of unbundled `.js` modules.

  The realization I had, perhaps obvious, is that a client-side
  JavaScript package is often shipped as a single compiled `.js` file.
  It's like how a C linker works - it bundles individually units into a
  larger library file (`.so`, `.dll`).

- A _package manager_ is a tool that installs a package into your system
  so you can start using it. `npm` is popular for NodeJS,
  [Bower](http://bower.io/) is focused on client-side packages and tries
  to be very package format agnostic.
  [component](https://github.com/component/component) contains a package
  manager too, centered around CommonJS (and also the build tool I
  mentioned earlier).

- A _package registry_ is a system where packages can be registered so
  that others may find and download them. npm has an index, and so do
  [Bower](http://bower.io/) and
  [component](https://github.com/component/component).

# MantriJS

Another dependency system I ran into since my last post is
[MantriJS](http://mantrijs.com/). MantriJS is built around the Google
[Closure Tools](https://developers.google.com/closure/) but hides them
from the developer, except for the dependency system.

You define a module that depends on others like this in Mantri/Closure
Tools:

    goog.provide('obviel.template');
    goog.require('obviel.util');

    obviel.template.foo = function() { ... };

Here you say you are defining a module called `obviel.template` and that
in this module `obviel.util` needs to be available. Once you `require`
something you have that available to use in your module, so you can now
do this:

    obviel.util.blah();

Mantri has a build step for development, but only to build a `deps.js`
file and only when you've changed a dependency. The modules themselves
are directly exposed to the browser during development, meaning you can
debug them. In this it looks quite similar to browser-build, though
browser-build does touch the individual modules in a minor way,
something MantriJS does not.

MantriJS does offer a build step to generate a single file `.js` package
from your modules, using the Closure Tools.

I tried to see whether MantriJS was easy to integrate with the Buster.JS
test runner; I had to wrestle quite a bit to get RequireJS running
properly before. It turned out to be very easy (it Just Worked ™!). See
the [jspakmantri](https://github.com/faassen/jspakmantri) example
project and compare it with the original RequireJS-based
[jspak](https://github.com/faassen/jspak) project if you like.

Thinking about MantriJS I realized something: MantriJS actually allows
you to have modules the way many existing client libraries do it: create
a namespace object and fill it with properties you want to expose. This
is important to me because that's how Obviel does it now, and I'd prefer
not to break that client API.

# Global Namespace Modules

So what is this client library module definition pattern MantriJS
supports? Everybody is familiar with it. It's what jQuery does for
instance: it fills the `jQuery` object (`$`) with the jQuery API and
exposes this.

For example, to make a module, you create an empty object, perhaps
listed in another object to namespace it, and make it globally
available:

    var obviel = {};
    obviel.template = {};

You then fill it with the API you want somehow, for instance like this:

    obviel.template.foo = function() { ... };

or like this:

    (function(module) {
       module.foo = function() { ... };
    }(obviel.template));

To use a module from another one, you simply refer to it:

    obviel.template.foo();

That's all that's needed, but there are also frameworks that help you
declare and use modules like this, such as MantriJS mentioned earlier;
YUI has another one. The primary benefit these add is the ability to
express module dependencies better, avoiding the need to mess around
with `<script>` tags.

So this pattern is neither CommonJS or AMD. But it is very widely used
on the client-side. Obviel uses it for instance, and Backbone too, and
Ember, and Knockout, and Mustache, and YUI, and Google Closure Tools. To
just list a few. Let's call it the Global Namespace Modules pattern
(GNM).

GNM is not a module _definition_ pattern like CommonJS or AMD. Instead
it is defined by how modules are _used_: you refer to the API of a
module using a global namespace that the module exposes (`jQuery`,
`obviel`, `Backbone`, `Mustache`, etc).

GNM assumes that modules are loaded in a particular order,
synchronously. You ensure this order by listing `<script>` tags in a
particular order, or by using a smart module loader like MantriJS, or by
bundling modules in order into a single `.js` package file.

Getting this more clear for myself is quite important to me. It had been
bugging me for a while after reviewing RequireJS: if I start using it
for Obviel, do I need to to break the Obviel API, which assumes GNM. Or
do I tell all developers to start using AMD for their code that uses
Obviel too?

\[update: here is a
[post](http://addyosmani.com/blog/essential-js-namespacing/) with more
on this pattern; here's
[another](http://thanpol.as/javascript/development-using-namespaces/)\]

# Requirements

After thinking about all this, here are some varying requirements for a
JavaScript module dependency system. Ideally Obviel can adopt one that
has all of these properties, or as close as possible:

- automated loader: no `<script>` tag management. (loader)

- encourage fine-grained modules. (fine)

- being able to use browser debuggers like Firebug or the Chrome Dev
  tools. (debug)

- source maps not required: being able to use these debuggers without
  relying on new source map technology. (nosm)

- no build step needed during development. (nobuild)

- support for exposing modules using the GNM pattern. Is this really
  important? Yes, as it's a very popular pattern on the web. Dojo went
  the way of telling people to use AMD for their own code, and that does
  help with fine-grained reuse between packages... (gnm)

- compilation tools: bundling, minification to deliver easy to use `.js`
  files. This way the browser can load a package efficiently and it
  becomes easy for people to start using the API the package exposes:
  just drop in a file. (comp)

- inter-package reuse: being able to require just one module from
  another package without having to load all of them. (reuse)

  There is some tension here with the bundling into a single `.js`
  package approach - if there's a module in a package that I don't use,
  why does it still get shipped to a web browser? On the server
  installing a bit more JS code in a package is not a problem, but on
  browsers people tend to start counting bytes.

  This tension can be reduced in various ways: jQuery now offers various
  smaller builds with less code. Build tools can cleverly only include
  modules that are really required, though for inter-package reuse this
  can defeat the benefit of caching.

- integration with BusterJS test runner. As this is the test runner I
  use for Obviel. Preferably with the least hassle. (bjs)

- CommonJS everywhere: client definition of modules same as on server,
  so CommonJS packages can be used on the client too. There is after all
  potentially a lot of useful code available as a CommonJS package that
  can be used on the client too, and potentially some of my Obviel code
  can be run on the server too. (cjs)

# Review

Let's review some of the systems mentioned in the light of these
requirements. If I get it wrong, please let me know!

<table>
<thead>
<tr class="header">
<th>system</th>
<th>loader</th>
<th>fine</th>
<th>debug</th>
<th>nosm</th>
<th>nobuild</th>
<th>gnm</th>
<th>comp</th>
<th>reuse</th>
<th>bjs</th>
<th>cjs</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>manual</td>
<td>N</td>
<td>N</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>N</td>
</tr>
<tr class="even">
<td>RequireJS</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>N</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>N</td>
</tr>
<tr class="odd">
<td>browserify</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>N</td>
<td>N</td>
<td>N</td>
<td>Y</td>
<td>Y?</td>
<td>Y?</td>
<td>Y</td>
</tr>
<tr class="even">
<td>cjs-everywhere</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>N</td>
<td>N</td>
<td>N</td>
<td>Y</td>
<td>Y?</td>
<td>Y?</td>
<td>Y</td>
</tr>
<tr class="odd">
<td>browser-build</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>N</td>
<td>N</td>
<td>Y</td>
<td>Y?</td>
<td>Y?</td>
<td>Y</td>
</tr>
<tr class="even">
<td>uRequire</td>
<td>Y</td>
<td>Y</td>
<td>?</td>
<td>?</td>
<td>N</td>
<td>N</td>
<td>Y</td>
<td>Y?</td>
<td>?</td>
<td>Y</td>
</tr>
<tr class="odd">
<td>MantriJS</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>Y</td>
<td>N</td>
<td>Y</td>
<td>Y</td>
<td>N</td>
<td>Y</td>
<td>N</td>
</tr>
</tbody>
</table>

\[update: source maps are also a browserify feature\]

A few notes from the perspective of Obviel:

Nothing ticks all the boxes for Obviel from what I can see. RequireJS,
MantriJS and browser-build come closest.

The manual system involves maintaining `<script>` tags yourself. That is
what I'm doing with Obviel now. It involves no build step, so debugging
is easy during development. It supports the popular global namespace
modules pattern. If a framework exposes multiple modules that users are
to include using `<script>` tags, like Obviel currently does, then
inter-package reuse is possible. Compilation into a single `.js` file is
not needed but there are tools that can do it for you. But it's not
fine-grained at all, breaking a fundamental requirement for Obviel.

RequireJS is quite nice; script tag management goes away, no build step
is needed but compilation to a `.js` file is still possible. It allows
fine-grained reuse of modules in _other_ RequireJS based packages, which
is very nice. After some effort it integrates with BusterJS. But it
doesn't offer Global Namespace Modules support out of the box. It
shouldn't be too hard to make it do that, though, by simply exposing
some modules myself, possibly during a build step.

The various CommonJS approaches are interesting. It _is_ attractive is
to be able to use same approach on the browser as on the server. But
most tools require a bundling build step and I'd like to avoid having to
rely on still uncommon source maps to do debugging. That's why
browser-build is one of the more interesting ones, as it minimizes the
build step required and makes debugging easier.

I still a bit unclear to me whether fine-grained module reuse of other
npm-installed packages is possible - do these modules get exposed to the
browser too (in a bundle or directly for browser-build?). From what I've
read here and there I think so. I also haven't explored how easy it is
to integrate these with client-side Buster (server-side Buster
integration is supported by Buster), but I get the impression it's
posible.

The CommonJS approaches don't offer Global Namespace Modules support so
I'd have to hack that up as for RequireJS.

MantriJS was quite a revelation to me as it helped me come clarify my
thinking about the Global Namespace Modules pattern. I've contacted the
author and he's very responsive to my questions, also nice. It turned
out to be dead-easy to integrate with Buster.JS. MantriJS assumes that
external JS packages are bundled up in a single `.js` file for reuse
however, so fine-grained module reuse of other packages is not possible.

# Still overwhelmed

I'm still
[overwhelmed](/posts/overwhelmed-by-javascript-dependencies.html)
by the choices available as well as all the details. But I know a bit
more about what's possible and what I want now. Are there any players in
this field that I missed? Undoubtedly more will come out of the woodwork
soon. What do you think about my requirements? Should I just give up on
GNM, or forget about not having a build step during development? Am I
missing an important requirement? Please let me know!
