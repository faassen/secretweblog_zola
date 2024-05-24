+++
title = "SolidJS fits my brain"
date = 2022-07-14
slug = "solidjs-fits-my-brain"

[taxonomies]
tags = ["javascript", "react", "solidjs"]
+++

In this article I'm going to talk about the
[SolidJS](https://www.solidjs.com/) frontend framework, and why I think
it's cool and fits my brain.

# React

I got interested in React because of a talk by Pete Hunt at [JSConf
Europe](https://blog.startifact.com/posts/jsconf-eu-2013-impressions/)
back in 2013. React was a baby then, a controversial baby, and this talk
convinced me and many others to give it a serious look. What did I
learn?

React had a very nice approach to fine-grained declarative components,
and the use of a virtual DOM, even though de-empathised now, was a
revelation. I gave up my own efforts on a frontend framework and
switched to React instead.

# State management

State management on the client is something I was interested in already.
With React I went through the pre-flux era, flux and Redux. I thought
Redux was cool, but I did find state management with Redux to be rather
verbose. Newer layers above it have since softened these drawbacks.

Redux heavily leans on the immutability paradigm: you never change
state, but you create a new version of it instead with each change. This
brings some benefits, and one is related to performance: you can skip
updating a particular UI component in your program entirely if you know
the data you sent to it hasn't changed. You don't have to regenerate its
virtual DOM or have to do any updates in the live DOM in that case.
Immutable data has the interesting property that it lets you determine
it hasn't changed with a very cheap comparison operation.

In 2016 I learned about [MobX](https://mobx.js.org/README.html). This
takes a very different approach: it's [Key Value
Observable](https://scribe.rip/@ryansolid/b-y-o-f-part-3-change-management-in-javascript-frameworks-6af6e436f63c)
(KVO). Basically MobX just lets you create objects and classes, annotate
them very lightly to mark which data is observable, and then it tracks
state changes in a fine-grained manner. If you update a property on an
observed object, MobX updates only those React components that use it.
Any other components are left alone. You don't need to think about it:
it just works. Updates are more fine-grained than with Redux with less
effort. It seemed like magic to me. In fact I recall spending a day at a
React Europe hackathon trying to understand its magic when I first
encountered it.

In 2017 I started using [MobX](https://mobx.js.org/README.html) for a
real project, and I've been happy with it ever since. On occasion I've
looked at other state management systems for React (including the
built-in hooks), but nothing could compare with the ease of use and
power of MobX.

# The Genesis of SolidJS

This capsule history is a vague impression more than an accurate
historical reconstruction, but it appears Ryan Carniato, the creator of
SolidJS, also was impressed by MobX, and KVO frameworks in general. As I
mentioned, React uses a virtual DOM - your React component produce a
state tree, and this is then used to update the real browser DOM, only
changing what is actually different. Ryan had the brilliant insight you
could use a KVO framework directly to update DOM. This way you get
fine-grained updates of the UI entirely skipping the virtual DOM. This
lead to the development of SolidJS.

# SolidJS Performance

The SolidJS approach turned out to be fast: according to various
benchmarks SolidJS performs near the speed of hand-optimized DOM
manipulation.

Does performance matter a lot? It's
[complicated](https://blog.startifact.com/posts/is-premature-optimization-the-root-of-all-evil/).

React is fast enough for most purposes, and frameworks tend to engage in
performance matches as it's an easy benchmark to compare. Users of
frameworks like to use performance to evaluate frameworks far more than
they should. Then again, performance can also be reflective of good
design, and it's important a framework doesn't lead you into performance
pitfalls. And low-powered devices are common especially in the mobile
phone world, and higher performance approaches use less energy.

Raw performance of a framework isn't everything: developer usability
matters. **The fastest framework is no framework at all. But we use
frameworks for a reason, and the reason is not performance, it's
developer usability**.

So let's look at developer usability next.

# Solid and React as frameworks

What's important in a framework is that it gives you the tools to build
your application well, keeping a lot of tradeoffs in mind: how easy is
it to reason about, speed of development, maintainability, evolvability,
and, yes, performance.

What does React do for you as a framework? It lets you avoid thinking
about DOM updates. You can just pretend it's like a server-side
framework, and that all your declarative function components get re-run
each time you change any data and that this describes the new state of
the UI, even though that doesn't really happen underneath and it can
skip a lot of those steps as an optimization. It's easy to reason about
and it helps the code that uses it stay maintainable and performant, and
that's what makes it valuable to use it as a framework.

**Solid looks and feels a lot like React, even though it's very
different underneath**. It offers fine-grained components you define
like functions that take props and return JSX, just like modern React.
It has functions that look a lot like React hooks; `useState` becomes
`createSignal`, `useMemo` becomes `createMemo`, and `useEffect` becomes
`createEffect`. Solid was immediately familiar to me as a React user.

# How Solid is different from React

But Solid does a few things differently. You don't need to declare any
dependencies for hooks, unlike in React. It does dependency tracking, so
that when a value changes, any hooks that use that value run
automatically. This is a great feature, as suddenly you don't need to
think about it anymore. The subtleties of hooks in React are tricky. On
top of this, Solid offers an easy way to integrate with server APIs with
`createResource`.

React with MobX goes a step above plain React in ease of use and
optimization -you can treat state as mutable, and MobX tracking is so
clever only those React components rererender that use the state you
changed. Solid has that built in. Solid has `createStore` which lets you
define observable objects with fine-grained reactivity, much like MobX
does.

Solid then takes this a step further; the update is not a rerender of
the component (rerunning the function) but of a much finer granularity:
when you change a value that's used in an expression in JSX somewhere,
only that expression gets rerun and results in a DOM update.

With Solid, just like React, you can also, sort of, pretend it's like a
server-side framework, and that all your JSX re-runs whenever you change
any data. But in fact the function components *don't* get rerun. They
only run once, when the component is created in the tree. That has some
differences with React code:

- You can't unpack props like is common with React, as props is a
  reactive object. This means in JSX you need to write
  `<div>{props.foo}</div>`.
- You can't put a `console.log` in a component body and expect it to
  re-run in each update. Instead you need to place it in a function that
  is used in a JSX expression somewhere, or use `createEffect`.

What you get from this, besides performance, is easy to reason about
behavior. Create functions, the equivalent of hooks, are just functions.
They run once per component, though the functions you pass them are
reactive. So can use create functions anywhere you like, such as in
conditional expressions and loops. You don't even have to put them in
the function component.

The granularity of components can be a subtle aspect of React
performance optimization -- more components can support more
fine-grained updates. But in Solid, this matters a lot less - you can
make your components as big or small as you like and it won't make much
of a difference.

# My experience with Solid

After playing with Solid for a couple of months I've used it for real
projects for the first time over the last month. I found it easy to
think in Solid. Only very rarely has Solid surprised me unpleasantly.
Refactoring and extending code was easy and it let me do what I wanted.
The TypeScript support is also good. It's a subjective experience, but
it fits my brain!

I haven't even talked about bundle size yet, but it was definitely neat
when my entire Solid project's bundle is half the size of the
`react-dom` bundle by itself. And Solid manages to pack a powerful state
management framework in along the way!

Solid has a few basic principles you need to be aware of, but its API
has quite a few knobs and possibilities. Luckily I didn't need to
understand all of them to be able to use Solid effectively. And once
every while when I ran into a new problem I recalled reading something
about it in the API manual that I only half understood at the time, and
suddenly it clicked and helped me solve the problem.

Last week I built a little library
[solid-dexie](https://github.com/faassen/solid-dexie) that integrates
Solid with [Dexie](https://dexie.org/), an API on top of IndexedDB
that's built into the browser. Dexie offers live queries, a form of
reactivity to the contents of the database - when you add or modify a
record the query result, and the UI that depends on it, automatically
updates. Dexie also has React integration in the form of a
`dexie-react-hooks` package. In my library, I figured out how to
integrate it with Solid with a few lines of code -- it took a bit of
headscratching but it's pretty neat!

Are there any drawbacks to Solid compared to React? There's one big one:
the ecosystem of SolidJS is much smaller. React has an enormous range of
libraries on offer that do all sorts of things. For Solid it's more
limited. **What is out there for SolidJS in its ecosystem is pretty
good, as it has the benefit of refining the best ideas from the React
ecosystem, but the ecosystem needs more time to grow**. For some
projects this drawback will outweigh the benefits. I love the benefits
though, so I am going to look for more opportunities to use Solid in the
future.
