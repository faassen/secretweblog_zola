+++
title = "Obviel 1.0rc1 released!"
date = 2013-05-15
slug = "obviel-1_0rc1-released"

[taxonomies]
tags = ["obviel", "javascript"]
+++

I've just released [Obviel](http://obviel.org) 1.0rc1. This, or
something very close to it, will be turned into 1.0 final.

What's new in Obviel 1.0rc1?

- upgraded and tested with newer version of jQuery (1.9.x)
- new Obviel Forms widget, passwordField
- a few fixes and improvements in Obviel Template
- a few fixes surrounding event handling

See the [changelog](http://www.obviel.org/en/1.0rc1/CHANGES.html) for
details (and ignore the (unreleased) bit -- I have too many things to
update before a release and should automate it!). We've been getting
more people contribute to Obviel lately, thank you and please do keep it
up!

We're planning a few big changes for Obviel after 1.0:

- transition code from bitbucket to github, as that seems to be the hub
  for JS related development and any exposure is good exposure.
- finally finish Obviel Sync - a very configurable framework for syncing
  models with a backend (such as a HTTP server). We've made a huge leap
  forward with this recently, and there is also a lot of potential in
  this, so this _will_ happen.
- use more JavaScript tools to manage the codebase besides Buster.js
  which we already use for test running. The main aim right now is to
  split Obviel's code into smaller modules, and still generate a simple
  usable `.js` package so it's easy to include in a codebase. See this
  blog entry for [some of my packaging
  explorations](/posts/overwhelmed-by-javascript-dependencies.html).
