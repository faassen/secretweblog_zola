+++
title = "JavaScript Dependencies Revisited: An Example Project"
date = 2015-10-27
slug = "javascript-dependencies-revisited-an-example-project"

[taxonomies]
tags = ["javascript", "packaging"]
+++

# Introduction

A few years ago I wrote an [article on how I was overwhelmed by
JavaScript
dependencies](http://blog.startifact.com/posts/overwhelmed-by-javascript-dependencies.html).
In it I explored the difficulty of managing dependencies in a JavaScript
project: both internal modules as well as depending on external
packages. There were a ton of options available, and none of them seemed
to entirely fit what I wanted. I [followed up on
it](http://blog.startifact.com/posts/js-dependency-tools-redux.html)
going into the problem in more depth. Typical for JavaScript there were
a *lot* of different solutions for this problem.

The article on how I was overwhelmed is consistently one of the most
read articles on this blog, even though the overwhelming majority of
posts over the years is actually on Python. Apparently a lot of people
are overwhelmed by JavaScript dependency management.

It's time for an update. A few years in JavaScript time is like 10 years
in normal years, anyway. Everything changed like five times over since
then.

# What changed in JavaScript

So let's go through some of the changes:

One of the most important changes is that JavaScript now has a standard
way to do imports in the ES6 version of the language, and that people
are using it in practice, through transpilers like Babel.

Another change is that using npm and CommonJS packages has been emerging
as the most popular way to do client-side dependency management, after
being the dominant tool on the server already. In fact, back in 2013
people were already suggesting I use npm and a bundling tool (like
Browserify), and I was resistant then. But they were right. In any case,
it was already clear then that CommonJS was one of the most structured
ways to do dependencies, and it's therefore no surprise this lead to a
great tooling ecosystem.

Source map support in browsers has also matured. One of the reasons I
was resistant to a compile-time step is that debugging using the browser
introspector becomes more difficult. Now that source maps are pretty
well established, that is less of a problem. It's still not as good as
debugging code that doesn't need a compilation step, but it's tolerable.

While I'd like to be able to do without a compilation step, I need
performance, until the adoption of HTTP 2 makes this less of a concern.
I want to use ES6 and JSX anyway, so some kind of compilation step
cannot be avoided anyway.

# A Bundling Example

Last week I talked to Timo Stollenwerk about bundling tools. He asked me
to put a little example project together. So I created one: it does
bundling through Webpack, lets you use modern ES6 JavaScript through
Babel and has eslint support.

There are a ton of example JavaScript projects out there already. A lot
of them have quite a bit of JavaScript code in them to drive tools like
gulp or grunt -- something I don't really like. I prefer declarative
configuration and reusable libraries, not custom JavaScript code I need
to copy into my project. These projects also tend to have quite a bit of
code and little documentation that tells you what's going on.

While creating my example project, I went a bit overboard on the README.
So this example is the opposite of many others: a lot of documentation
and very little code. In the README, I go step by step explaining how to
set up a modern client-side JavaScript development environment.

The choices of tools in the project are my own -- they're stuff that
I've found works well together and is simple enough for me to
understand. Many alternatives are possible.

I hope it is of help to anyone! Enjoy!

<https://github.com/faassen/bundle_example>
