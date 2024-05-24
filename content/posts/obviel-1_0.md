+++
title = "Obviel 1.0!"
date = 2013-05-20
slug = "obviel-1_0"

[taxonomies]
tags = ["obviel", "javascript"]
+++

I'm proud to announce the release of Obviel 1.0:

<http://www.obviel.org/en/1.0/>

Obviel is a client-side web framework that supports powerful UI
composition based on an easy to learn core. On top of that Obviel adds a
lot of features, such as templating, i18n support, form generation and
validation, and routing. Obviel stays close to HTML but lets you build
sophisticated components when you need to.

Obviel has come a long way since its
[beginnings](http://blog.startifact.com/posts/older/obviel.html). On top
of the core we've added a template language, an internationalization
system that integrates with JavaScript and templates alike and a routing
library. So it's high time for the One Dot Oh release!

# Standout Features of Obviel

- a [powerful core](/posts/the-core-of-obviel) that enables [model-driven UI
  composition](/posts/powerful-composition-with-obviel-data-render). If you know jQuery it will be
  easy to learn this core.

- Integrated internationalization (i18n) based on
  [gettext](https://en.wikipedia.org/wiki/Gettext). In a world with multiple
  languages we need UIs that can be easily translated to other languages. I
  haven't met a client-side web framework yet that can beat Obviel in this
  area.

  Obviel offers an i18n approach that lets you mark strings in your
  JavaScript code in the gettext style:

      _("My translatable string")

  and also lets you mark translatable strings in templates:

      <p data-trans="">My translatable string</p>

  Obviel then offers tools to automatically extract these strings into a
  `.pot` file that you can offer to translators in various ways; gettext
  has vary extensive tool support.

  See [Obviel Template i18n](http://www.obviel.org/en/1.0/template_i18n.html)
  and [Internationalizing your Obviel
  Project](http://www.obviel.org/en/1.0/i18n.html) for more information.

- Extensive [documentation](http://www.obviel.org/en/1.0/documentation.html).
  Documentation has been and is a priority and Obviel has been documented to
  bits.

- Testing is as much a priority as the docs are: Obviel is extensively unit
  tested using the [Buster.JS](https://busterjs.readthedocs.io/en/latest/)
  JavaScript testing framework.

- Automatic form construction using client-side validation: [Obviel
  Forms](http://www.obviel.org/en/1.0/form.html)

- Routing: path (`/foo/bar`) to object and object to path with
  [Traject](http://www.obviel.org/en/1.0/traject.html).

  Traject lets you build a nested navigation space on the client-side.
  Not only can you route a path to an object, but you can also generate
  a path _for_ an object, something that results in cleaner and more
  decoupled code.

# What's next for Obviel?

We have been transitioning the code from bitbucket to github and from
mercurial to git to make it more accessible to JavaScript hackers who
are more familiar with git. We're still busy updating the docs, but the
transfer has been complete and the code now lives [on
github](https://github.com/obviel/obviel).

We've been doing
[lots](http://blog.startifact.com/posts/overwhelmed-by-javascript-dependencies.html)
of [research](http://blog.startifact.com/posts/js-dependency-tools-redux.html)
on using a JavaScript module system for Obviel so we can better maintain the
codebase. I've been overwhelmed by the options, but soon we'll pick one, I
promise! We'll also introduce various JavaScript codebase maintenance tools
such as the [Grunt](http://gruntjs.com/) task runner.

We are still busy working on a configurable transceiver framework for
integrating Obviel with a diversity of backends (HTTP, websockets,
localstorage): Obviel Sync. More on this soon!
