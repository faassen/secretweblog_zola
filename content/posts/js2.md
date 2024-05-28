+++
title = "JavaScript: when you need two ways to do it!"
date = 2024-05-28
slug = "js2"
description = "Wherein we discover JavaScript always gives you a choice."

[taxonomies]
tags = ["javascript", "typescript"]
+++

JavaScript is a cool language. (_Yes, you are cool too, TypeScript._) I've used
JavaScript a lot. (_Yes, TypeScript, I've used you a lot as well._)

JavaScript has [a strange design](https://javascriptwtf.com/) on the
expression level, but by ignoring those bits, the language is usable enough.
(_Yes, TypeScript, you have the same strange design but you give more
compile-time errors to stop devs from blundering into some of it._)

What's especially cool is that JavaScript has two of everything. (_Yes,
TypeScript, you have two of everything too!_)

- `undefined` and `null`.
- `==` and `===`.
- `function` and arrow functions (`=>`).
- `const` and `let`. Fun fact: `const` variables aren't immutable, you just
  can't rebind them.
- `var` versus those new ones, `const` and `let`. Okay, maybe that's three ways
  to declare a variable, but we're not going to let it ruin a good post.
- `for` loops and `forEach`.
- `for of` and `for in`. Just don't use `for in` anymore.
- `require()` and `import`.
- named and default exports. `export` vs `export default
- named and default imports too! `import {thing}` vs `import thing`.
- `await` and `then()` for async! (and callbacks, but again we're not letting
  that ruin a good post)
- classes and prototypes.
- `arguments` and `...` for when you want to pass variable arguments to a
  function.
- `test()` and `it()` to declare tests in Jest.
- `npm` and `yarn` (and all the other ones, okay...)
- `object` and `Map`. For when you need a hash table.
- `Boolean` and `"boolean"`. They're different! If you get the type of a boolean
  you get '"boolean"', not '"Boolean"'.
- `true` and `false`. Wait.
- `String` and `"string"`, `Object` and `"object"`, `String` and `"string"`.
  (_Yes, TypeScript, you make the lowercase ones into proper static types. But
  you can use the uppercase ones as static types too. But you shouldn't._)
- `XMLHTTPRequest` and `fetch` for when you want to talk to a server.
- (_Yes, TypeScript, you have `type` and `interface` and JavaScript doesn't. Well done!_)
- JavaScript even has two names! `JavaScript` and `ECMAScript`.
- Unlike most programming languages, the name consists of two words. _Java_,
  and _Script_. (_Yes, TypeScript, you have two words in your name too._)

JavaScript, if you need two ways to do it!

_Yes, TypeScript, you too._
