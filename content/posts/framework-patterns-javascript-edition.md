+++
title = "Framework Patterns: JavaScript edition"
date = 2021-11-01
slug = "framework-patterns-javascript-edition"

[taxonomies]
tags = ["javascript", "typescript", "react", "framework", "rest", "programming"]
+++

Software developers use software frameworks all the time, so it's good
to think about them. You might even [create one
yourself](@/posts/roll-your-own-frameworks.md),
but even if you don't, understanding the design principles underlying
them helps you evaluate and use frameworks better.

<!-- more -->

A few years ago I wrote a [post about
patterns](@/posts/framework-patterns.md)
I've seen in frameworks. In it, while I did discuss other languages, I
mostly used examples from the Python world. This is a revised version
that focuses on frameworks written in JavaScript or TypeScript.

Let's give some examples of frameworks: well-known frameworks in the JS
world include React, Express, NextJS and Jest. Frameworks are not all
about solving the same problem and do not have to cover all aspects of
your application -Jest for instance is focused on letting you write
tests, but doesn't care about how you compose web pages.

# Framework versus library

So what distinguishes a framework from a normal software library? You
install both from `npm`, right? They all have a `package.json`.

You can see a software framework as a library that calls your
application code instead of the other way around. This is known as the
"Hollywood Principle": "Don't call us, we'll call you".

So whereas you can make a HTTP GET request using `axios` by calling the
`get` function it exposes, you give a framework like NextJS functions
and components to call, and it calls them. React lets you define
functions that it then lets you combine in a tree, and React itself
takes care of re-rendering parts of the tree and updating the browser
when state changes.

Many libraries have aspects of frameworks so there is a gray area.

It's often claimed about React that it's "just a library", not a
framework, but given that it presents a declarative way to structure UI
for your applications including a special approach to state management,
with support for both web UIs as well as native UIs, I certainly see it
as a (micro) framework.

# Frameworks make applications more declarative

The framework defines the grammar: framework-provided functions,
objects, classes, types. Then you use that grammar by bringing some of
the words: application-defined functions, objects, classes, types and
config.

The grammar provides an organizing principle for your application, or at
least parts of your application. A framework helps structure the way you
write code, making it more declarative. Declarative code is code that
says what it wants, not how to do it. Declarative code has less noise
and tends to be easier to understand and adjust. Especially as a
codebase grows over time, declarative patterns become more important to
keep it manageable. Frameworks help you do that.

NextJs for instance makes your application more declarative in how
particular pages match routes: you declare these by placing files with
the names of these pages in a directory structure. This means that a
developer new to a project can quickly see what pages exist and what
code is used to render them, and easily add new pages as well.

# Frameworks restrict

As developers our intuition may be that we want to use the tool with the
least restrictions, so we get ultimate power and flexibility. Frameworks
however do the opposite of that: they restrict what you can do. They
force you to use it in a certain way, and if you step out of that,
expect pain or the framework breaking. In return for following these
restrictions, the framework gives you access to its powers.

This is quite similar to why we use programming languages. If ultimate
power and flexibility was all that we wanted in software development,
we'd all be using assembly language - it lets you exactly control which
instructions are executed, and you can use memory in whatever way you
want. It turns out that is very difficult to manage and understand, so
instead we use higher level languages to help us do that.

An example of a restriction in React is how state is managed. Here's
some **BROKEN** code that breaks that restriction:

```tsx
import React from "react";

const myState = { value: 0 };

const Foo = ({}) => {
  const handleClick = () => {
    myState.value = 5; // Don't do that!
  };
  return <button onClick={handleClick}>{myState.value}</button>;
};
```

Here we manage state as a global object. When we click on a button, we
modify that global state. But that doesn't do what we want: React does
not notice this change, and the UI doesn't update with the new value
after we click the button.

Let's fix that:

```tsx
import React, { useState } from "react";

const Foo = ({}) => {
  const [value, setValue] = useState(0);
  const handleClick = () => {
    setValue(5);
  };
  return <p>{value}</p>;
};
```

Here we follow the restrictions of React: we manage state using its
built-in `useState` hook. Because React restricts you in this way, React
can now automatically re-render the component whenever there is a state
change. That's the power the framework gives you, but you do have to buy
into its restrictions.

# Mega frameworks, micro frameworks

Mega frameworks are frameworks that aim to solve a large range of
problems during application development. Famous examples in the web
space are Rails and Django: problems solved span from UI in template
rendering to interacting with the database through an ORM. When you deal
with an application written with that framework you can expect the
organizing principles of the framework to reach far into its code base.
A newcomer to such a framework benefits by having to just look at one
integrated source for solutions.

In the JS world mega frameworks are less common. Vue goes further than
React in what it covers as a frontend framework: it has an official
router and state management solution whereas React does not. But Vue
nonetheless restricts itself to the frontend. NextJS also offers
integration and supports server-side use cases, but is still focused on
the UI part of the story.

Micro frameworks aim to solve one problem well. Examples of these are
plenty in the JavaScript world: Express for programming an HTTP server,
and React for managing a UI. The benefit of such frameworks is that an
application development team is not locked into the framework so much
and can adopt a collection of high-quality frameworks from a whole
ecosystem. That's also its drawback: it takes effort to collect and
maintain these.

A mega framework can be constructed from scratch, like Django or Rails
historically were. You can also assembly a mega framework out of a
selection of micro frameworks.

Whatever the size and scope of the framework, you can find patterns in
them.

# Configuration

So in a framework, we give our code to it, so it can call us. In order
for the framework to call our code, we need to tell the framework about
it. Let's call this _configuring_ the framework. Configuration can take
the form of JS/TS code, or could be done through a separate DSL.

There are many ways to configure a framework. Each approach has its own
trade-offs. I will describe some of these framework configuration
patterns here, with brief examples and mention of some of the
trade-offs. Many frameworks use more than a single pattern. I don't
claim this list is comprehensive -- there are more patterns.

# Callback patterns

In the next section I discuss a number of basic patterns that help you
inform the framework what application code to call.

# Pattern: Callback function

The framework lets you pass in a callback function to configure its
behavior.

## Fictional example

This is a `createForm` function the framework provides. You can use it
to configure what the framework should do when you save the form by
providing a callback function:

```ts
import { createForm, FormData } from "framework";

function mySave(data: FormData) {
  // application code to save data somewhere goes here
}

const myForm = createForm(mySave);
```

## Real-world example

`Array.map` is a (nano)framework that takes a (pure) function:

```ts
[1, 2, 3].map((x) => x * x);
```

You can go very far with this approach. Functional languages do. If you
glance at React in a certain way, it's configured with a whole bunch of
callback functions called React components, along with more callback
functions called event handlers.

## Trade-offs

I am a big fan of this approach as the trade-offs are favorable in many
circumstances. In object-oriented languages this pattern is sometimes
ignored because people feel they need something more complicated: pass
in some fancy object or do inheritance. I think callback functions
should in fact be your first consideration.

Functions are simple to understand and implement. The contract is about
as simple as it can be for code: you get some arguments and need to give
a return value. This limits the knowledge you need to use the framework.

Configuration of a callback function can be very dynamic in run-time --
you can dynamically assemble or create functions and pass them into the
framework, based on some configuration stored in a database, for
instance.

Configuration with callback functions doesn't really stand out, which
can be a disadvantage -- it's easier to see when someone subclasses a
base class or implements an interface, and language-integrated methods
of configuration can stand out even more.

Sometimes you want to configure multiple related functions at once, in
which case an object that implements an interface can make more sense --
I describe that pattern below.

# Pattern: Subclassing (inheritance)

The framework provides a base-class which you as the application
developer can subclass. You implement one or more methods that the
framework will call.

## Fictional example

```ts
import { FormBase } from "framework";

class MyForm extends FormBase {
  load(): FormData {
    // application code here
  }
  save(data: FormData) {
    // application code here
  }
}

const myForm = new MyForm();
```

## Real-world example

This pattern is less common in JavaScript, which I think is a good
thing. But there are examples, such as class-based React (which React
has been moving away from for years now):

```ts
class Welcome extends React.Component {
  render() {
    // application code here
  }
  componentDidMount() {
    // application code here
  }
}
```

## Subclassing questions

When you subclass a class, this is what you might need to know:

- What base class methods can you override?
- Which methods should you _not_ override?
- When you override a method, can you call other methods on `this`?
- Is the method intended to be supplemented (don't forget `super` then!)
  or overridden, or both?
- Does the base class inherit from another class also provides methods
  for you to override?
- When you implement a method, can it interact with other methods on
  these other classes?

## Trade-offs

Many object-oriented languages support inheritance as a language
feature. You can make the subclasser implement multiple related methods.
It seems obvious to use inheritance as a way to let applications use and
configure the framework.

It's less common in JavaScript-based frameworks, perhaps because
JavaScript developers have learned the lessons from other languages, or
perhaps simply because classes were standardized relatively recently.

React used classes but is moving away from it. It always came with the
strong recommendation only to subclass from `React.Component` directly,
and never to create any deeper inheritance. An ORM like Sequelize also
can work with classes, but my impression is that there too the
inheritance hierarchy is supposed to be only a single level deep. Flat
inheritance hierarchies indeed have less problems than deeper ones, as
the questions above are easier to answer.

TypeScript offers the framework implementer a way to give more guidance
(`private`/`protected`/`public`). The framework designer can put hard
limits on which methods you are allowed to override. This takes away
some of these concerns too, as with sufficient effort on the part of the
framework designer, the language tooling can enforce the contract. Even
so, such an API can be complex for you to understand and difficult for
the framework designer to maintain.

I think the disadvantages of subclassing outweigh the advantages for a
framework's external API. I still sometimes use base classes
_internally_ in a library or framework -- base classes are a lightweight
way to do reuse there. In this context many of the disadvantages go
away: you are in control of the base class contract yourself and you
presumably understand it. But those are internal, and not base classes
that a framework user has to know anything about at all.

# Pattern: interfaces

The framework provides an interface that you as the application
developer can implement. You implement one or more methods that the
framework calls.

## Fictional example

```ts
import { createForm, FormBackend, FormData } from "framework";

// typescript checks that you're not lying
const myFormBackend: FormBackend = {
  load(): FormData {
    // application code here
  }
  save(data: FormData) {
  // application code here
  }
}

const myForm = createForm(myFormBackend);
```

And inside `framework`:

```ts
export interface FormBackend {
  load(): FormData;
  save(data: FormData);
}
```

I gave a TypeScript example here, as this example is an especially good
use case for that language. It works just fine in JS as well, if you
just remove the `FormBackend` type, but with TS you get a compile-time
error if you break the contract, and in JS you get a runtime one.

## Alternative: interfaces with classes

In the above example we implemented the interface as an object literal,
and this works well. There's an alternative implementation that uses
classes (without inheritance):

```ts
import { createForm, FormBackend, FormData } from "framework";

// typescript checks that you're not lying
class MyFormBackend implements FormBackend {
  load(): FormData {
    // application code here
  }
  save(data: FormData) {
    // application code here
  }
}

const myForm = createForm(new MyFormBackend());
```

If you remove the type declarations, including the `implements FormData`
bit, it works in plain JS as well, but again you won't get the benefit
of compile-time checks. An advantage of the class-based approach is if
you need multiple implementations of the interface each configured
differently; in this case you can add a `constructor` to your class and
store information on it, and create multiple instances of it. Then
again, if you create objects on the fly you can do the same.

## Real-world example

I had to look for a little while to find an example of this pattern; and
then I realized the very editor I was typing in has an extension system
that works this way. This is an example from the VSCode extension API:

```ts
const provider: vscode.DocumentSemanticTokensProvider = {
  provideDocumentSemanticTokens(
    document: vscode.TextDocument
  ): vscode.ProviderResult<vscode.SemanticTokens> {
    // analyze the document and return semantic tokens
  },
};

vscode.languages.registerDocumentSemanticTokensProvider(
  selector,
  provider,
  legend
);
```

This example in fact registers an interface with only a single method,
`provideDocumentSemanticTokens` so it's functionally the same as the
callback pattern. But it supports a range of registration APIs, some of
which take more complex interfaces.

## Trade-offs

The trade-offs are quite similar to those of callback functions. This is
a useful pattern to use if you want to define related functionality in a
single bundle.

I go for interfaces if my framework offers a more extensive contract
that an application needs to implement, especially if the application
needs to maintain its own internal state.

The use of interfaces can lead to clean composition-oriented designs,
where you adapt one object into another.

You can use run-time dynamism with functions where you dynamically
assemble an object that implements an interface.

My recommendation is to use this pattern over class inheritance in
framework design, as the boundary with the application is a lot more
clean.

# Registration patterns

Consider a framework like Express or NextJS: given a URL it needs to
find a function or React component to handle that URL. We can say that
the framework _dispatches_ to application code based on the URL.

The framework is in charge of decoding the URL and dispatching, but how
does it know where to dispatch? Internally it needs some form of
_registry_; a collection like an `Array` or a `Map`.

The code that the application registers could be a callback function, an
object that implements a certain interface, or even a class.

Frameworks use different ways to let applications do this registration:
we can call this _configuration_.

# Pattern: imperative registration API

You register your code with the framework directly by invoking a
function or method to make the registration.

## Fictional Example

```ts
import { register, dispatch } from "framework";

register("chicken", () => "Cluck!");
register("cow", () => "Moo!");
```

Here we have a framework that lets us register animals and a function
that should be called to make that animal's sound.

Let's look inside this framework:

```ts
type Handler = () => string;

const registry = new Map<string, Handler>();
export function register(name: string, handler: Handler) {
  registry.set(name, handler);
}
export function dispatch(name: string): string {
  const handler = registry.get(name);
  if (handler == null) {
    return "Unknown!";
  }
  return handler();
}
```

Our registry here is a `Map` where the key is the name of the animal and
the value is the `Handler` function. That's an implementation detail
however: we instead export a `register` function that can be used by the
application developer. The `dispatch` function is an example of how the
framework uses the registry.

In this example the dispatch is so simple we could have just as well
stored the `"Cluck"` and `"Moo"` strings directly in the registry, but
you can imagine an example where the functions receive parameters from
the framework and do real work .

## Real-world example

The Express framework for implementing web backends uses the imperative
registration pattern:

```ts
router.get("/caravans", async (req, res) => {
  // application code here
});
```

We make the registration by calling `router.get`. This adds a handler
object to an `Array` (the registry) in `router`. When resolving a
request, Express goes through this array one by one to match the path in
the URL, until it finds a matching handler.

The handler is application code that handles the request and produces a
HTTP response.

The VSCode example above for interfaces also uses an imperative
registration API - configuration gets stored in a `Map`.

## Trade-offs

I use this pattern a lot, as it's easy to implement and good enough for
many use cases. It has a minor drawback: you can't easily see that
configuration is taking place when you read code. You can expose a more
sophisticated configuration API on top of this layer: a DSL or language
integrated registration, which I discuss later. But this is
foundational.

The registration order can matter. What happens if you make the same
registration twice? Perhaps the registry rejects the second
registration. Perhaps it allows it, silently overriding the previous
one. There is no general system to handle this, unlike patterns which I
describe later.

Registration can be done anywhere in the application which makes it
possible to configure the framework dynamically. But this can also lead
to complexity and the framework can offer fewer guarantees if its
configuration can be updated at any moment.

The registrations can happen anywhere. This means you can do them at the
top level of a module, which can be very convenient, but it does means
you rely on a side-effect of importing this module. Doing a lot of work
during import time in general can lead to hard to predict behavior and
makes it difficult to do overrides in a structured manner. Bundling
tools like webpack also cannot perform their tree shaking optimization,
reducing bundle size by dead-code elimination, in the presence of
side-effects (see the `sideEffects: false` setting in `package.json`).

For these reasons it's often better to restrict an application's
registration code to a specific function that needs to invoked to
perform them, and not do them anywhere else.

# Pattern: convention over configuration

The framework configures itself automatically based on your use of
conventions in application code. Common conventions include:

- File name conventions (name Jest test files `.test.js`)
- Default or specially named module exports.

This could get more sophisticated as well, such as introspecting objects
(using the
[Reflect](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Reflect)
API) or even function signatures.

## Fictional example

```ts
export function handleChicken() {
  return "Cluck!";
}
export function handleCow() {
  return "Moo!";
}
```

So, anything prefixed with `handle` that is exported gets registered.

We need to bootstrap the framework somewhere by loading the module with
our `handle` functions in it and introspecting it:

```ts
import * as myModule from "myModule";
autoRegister(myModule);
```

Let's look inside this framework. It's layered over the previous
imperative registration example:

```ts
import { register } from "imperative-framework";

export function autoRegister(module) {
  Object.keys(module).forEach((key) => {
    if (key.startsWith("handle")) {
      const name = key.slice(6).toLowerCase();
      register(name, module[key]);
    }
  });
}
```

## Real-world example: NextJS

NextJS uses convention over configuration:

- Routes are based on filenames of modules and subdirectories in the
  `pages` directory. So, a file `pages/foo/bar.js` handles the URL path
  `/foo/bar`. Dynamic routes are also supported using the `[param]`
  convention: `pages/post/[postId].js`, which matches any URL path such
  as `/post/one` and `/post/whatever`.
- Convention: the default export in a page module is the React component
  used to render that page. NextJS also looks at specially named
  functions such as `getServerSideProps` and `getStaticProps` to obtain
  server data to pass into the page.

## Trade-offs

Convention over configuration can be great. It allows the user make code
work without _any_ ceremony. It can enforce useful norms that makes code
easier to read -- it makes sense to postfix your test files with
`.test.js` anyway, as that allows the human reader to recognize them.

I like convention over configuration in moderation, for some use cases.
For cases where you have more complicated registrations to make with a
large combination of parameters, it makes more sense to allow
registration with an explicit API. An alternative is to use a high-level
DSL.

The more conventions a framework has, the more disadvantages show up.
You have to learn the rules, their interactions, and remember them. You
may sometimes accidentally invoke them even though you don't want to,
just by using the wrong name. You may want to structure your
application's code in a way doesn't really work with the conventions.

And what if you wanted your registrations to be dynamic, based on
database state, for instance? Convention over configuration is a
hindrance here, not a help. The developer may need to fall back to a
different, imperative registration API, and this may be ill-defined and
difficult to use.

It's harder for the framework to implement some patterns -- what if
registrations need to be parameterized, for instance? The framework may
need more special naming conventions to let you influence that. Or
alternatively it leads the framework designer to use modules, objects or
classes over functions, but those have the drawback that they are more
unwieldy.

Static type checks are of little use with convention over configuration
-- I don't know of a type system that can tell you to implement a
particular function signature if you postfix it with `View`, for
instance.

# Pattern: DSL-based declaration

You use a DSL (domain specific language) to configure the framework.
This DSL offers some way to hook in custom code. The DSL can be an
entirely custom language, but you can also leverage JSON, YAML or
(shudder) XML.

You can also combine multiple languages: I've helped implement a
workflow engine that's configured with JSON, and expressions in it are a
subset of Python expressions with a custom parser and interpreter.

## Fictional example

```json
{
  "entries": [
    "chicken": "Cluck!",
    "cow": "Moo!"
  ]
}
```

Here we express the declarations outside of JavaScript. In this case
we've used JSON.

## Real world example: `package.json`

A `package.json` file is a DSL that describes a JS package:

```JSON
{
  "name": "framework-patterns-example",
  "version": "1.0.0",
  "scripts": {
    "dev": "next",
    "build": "next build",
    "start": "next start",
    "type-check": "tsc",
    "lint": "eslint . --ext .js,.jsx,.ts,.tsx",
    "test": "cross-env NODE_ENV=test jest --runInBand",
    "test-verbose": "cross-env NODE_ENV=test jest --runInBand --verbose",
    "test-watch": "cross-env NODE_ENV=test jest --runInBand --verbose --watch"
  }
}
```

We can see plain data entries, but also an example of an embedded
language in the `scripts` section, in this case the shell commands to
use to execute the scripts.

## Trade-offs

Custom DSLs are a very powerful tool if you actually need them. But they
are also a lot more heavyweight than the other methods discussed, and
that's a drawback.

A custom DSL is thorough: a framework designer can build it with very
clean boundaries, with a clear grammar and hard checks to see whether
code conforms to this grammar. If you build your DSL on JSON or XML, you
can implement such checks pretty easily using one of the various schema
implementations.

A custom DSL can provide a declarative view into your application and
how everything is wired up. A drawback of DSL-based configuration is
that it is quite distant from the code that it configures. A DSL can
cause mental overhead -- the application developer not only needs to
read the application's code but also its configuration files in order to
understand the behavior of an application. If the DSL is high-level,
this can be very helpful, but for more low-level declarations it can be
much nicer to co-locate configuration with code.

A custom DSL can be restrictive. This sounds like a drawback but is in
fact an important advantage: the restrictions can be built on by the
framework to guarantee important properties.

A DSL can offer certain security guarantees -- you can ensure that DSL
code can only reach into a limited part of your application.

A custom DSL gives the potential for non-developers to configure
application behavior. At some point in a DSL there is a need to
interface with user code, but this may be abstracted away quite far. It
lets non-developers reuse code implemented by developers.

A DSL can be extended with a GUI to make it even easier for
non-developers to configure it.

Since code written in a DSL can be stored in a database, you can store
complex configuration in a database.

A DSL can implement a declaration engine with sophisticated behavior --
for instance the general detection of configuration conflicts (you try
to configure the same thing in conflicting ways in multiple places), and
structured, safe overrides that are independent of code and import
order. A DSL doesn't have to use such sophistication, but a framework
designer that designs a DSL is naturally lead in such a direction.

A DSL also provides little flexibility during run-time. While you
_could_ generate configuration code dynamically, that's a level of meta
that's quite expensive (lots of generate/parse cycles) and it can lead
to headaches for the developers trying to understand what's going on.

DSL-based configuration is also quite heavy to implement compared to
many other more lightweight configuration options described.

# Pattern: imperative declaration

You use a configuration engine and you drive it from programming
language code in an imperative way, like imperative registration. In
fact, an imperative declaration system can be layered over a imperative
registration system.

The difference from imperative registration is that the framework
implements a deferred configuration engine, instead of making
registrations immediately: configuration is _transactional_.
Configuration commands are first collected in a separate configuration
phase, and only after collection is complete are they preprocessed, then
executed, resulting in actual registrations.

This pattern supports configuration introspection tooling, and
pluggable, extensible applications.

## Fictional example

```ts
register("chicken", () => "Cluck!");
register("cow", () => "Moo!");
commit();
```

This looks the same to the user as imperative registration. The
difference here is that `register` is much more sophisticated. It
actually can detect conflicts between registrations for the same thing,
and allows a way to do structured overrides. Only when `commit` is
called does the registration in fact get applied.

So, if you do this:

```ts
register("chicken", () => "Cluck!");
register("chicken", () => "Moo!");
commit();
```

then the configuration engine tells you upon `commit` that you can't
register two things for `"chicken"`. It doesn't matter if these
`register` calls happen far away from each other.

The configuration engine also allows you to override its default
behavior. Let's say we have a special application profile "rooster"
where we want the chicken to do something else:

```ts
register("chicken", () => "Cock-a-doodle-do!", "rooster");
commit();
```

## Real-world example?

This is an underutilized pattern. Do you know of an example in the
JavaScript world?

Even in the Python world, where the Pyramid web framework used this (and
I use a language-integrated version of it in Morepath) it isn't used
very often.

## Trade-offs

This _looks_ very similar to language-integrated **registration** but
the behavior is declarative.

This brings some of the benefits of a configuration DSL to code. Like a
DSL, the configuration system can detect conflicts ("the route name
'hello' is registered twice!"), and it allows sophisticated override
patterns that are not dependent on the vagaries of registration order or
import order.

Another benefit is that configuration can be generated programmatically,
so this allows for a certain amount of run-time dynamism without some
the costs that a DSL would have. It is still good to avoid such dynamism
as much as possible though, as it can make for very difficult to
comprehend code.

You can try to co-locate registrations with code, or do all registration
in a separate location. But if you do co-locate registration, you risk
running into JavaScript's growing aversion to module side-effects unless
you take special measures; see the discussion about bundle size above.

Declarative registration a lot more heavy-weight than just passing in a
callback or object with an interface -- for many frameworks that is more
than enough ceremony, and nothing beats how easy that is to implement
and test.

# Registration pattern layering

Framework designers often directly implement a DSL or a convention over
configuration system without too much consideration of how things get
registered.

That is unfortunate, as I think defining a clean imperative declaration
API layer underneath leads to a cleaner, easier to maintain and
understand framework implementation.

The bottom of the configuration layer is an imperative declaration API.
You can then layer convention over configuration, a DSL or an imperative
declaration API over it.

# Type patterns

The following patterns are specific to TypeScript. The idea is to let
the type checker support the developers that use a framework - it gives
the developer clear error messages and code autocomplete in their
editor.

# Pattern: Type Checking

Establish clear boundaries in code by specifying function type or
interface.

We can be brief about this as we saw it in the interface pattern example
above.

# Pattern: Generic Types

Normally we give the framework our application code. But with
TypeScript, we can also give the framework an application level type, so
that it can use it to typecheck your code elsewhere.

```ts
export function registerThing<T>(
  thing: T,
  validateThing: (thing: T) => boolean
) {
  // something frameworky
}
```

This code is very generic: it works over any thing type `` `T ``. Let's
write a concrete type as an example:

```ts
type SomeThing = {
  name: string;
  value: number;
};
```

And something that implements the type `SomeThing`:

```ts
const myThing: SomeThing = {
  name: "Some Thing",
  value: 3,
};
```

Then we pass the type `SomeThing` explicitly as `T`:

```ts
registerThing<SomeThing>(myThing, (thing) => thing.value > 2);
```

This way the framework knows about this type and uses it to typecheck
the `validateThing` function argument as well.

# Pattern: Generic Type Inference

Using generic types explicitly is rather heavy. Instead, we can let the
framework API infer the type of the generic type argument.

This already works in the example above: since we have a parameter
`thing` of type `T` we can also omit the generic type as it can be
inferred:

```ts
registerThing(myThing, (thing) => thing.value > 2);
```

Because of type inference, TypeScript still knows the `thing` argument
of the `validateThing` function is of type `SomeThing`.

A good framework API in TypeScript wants to be easy to use while
avoiding `any` and offer type checking where possible. Generic type
inference can be used to enable this.

# Pattern: Type Generation

Sometimes the type information we want to use with a framework are not
available as typescript definitions: they are available in some
specification, or perhaps a database schema. To support development a
framework can generate the types for the developers from this other
source.

This pattern can even make a library behave a bit more like a framework
in that you fill in the gaps to make it work with your application - but
the gaps you fill in are not in the form of callbacks but types, derived
from another source.

Real world examples include:

- You have an [OpenAPI](https://swagger.io/specification/) specification
  of your REST web service. But during the implementation using a
  framework, for instance using Express, you want to make use of types
  derived from this, instead of redefining them, so that you are more
  sure you are implementing the right specification. You can use a tool
  like
  [openapi-typescript](https://www.npmjs.com/package/openapi-typescript)
  to help you do that.
- You are using [Slonik](https://www.npmjs.com/package/slonik), a
  library to write SQL embedded in TypeScript code. But Slonik cannot
  derive the types of SQL queries. So you use
  [@slonik/typegen](https://www.npmjs.com/package/@slonik/typegen) to
  automatically generate these types during runtime, getting you the
  benefits of type checking.
- You are using [Contentful](https://www.contentful.com/) as a CMS. The
  types are maintained by Contentful. But you want typechecking for CMS
  contents you retrieve from the Contentful API, so you use
  [contentful-typescript-codegen](https://github.com/intercom/contentful-typescript-codegen).
  You do these by passing them into the [contentful API
  library](https://www.npmjs.com/package/contentful) as generic types,
  turning this library a bit more into an application-specific
  framework.

# Conclusion

I hope this overview helped you understand the decisions made by
frameworks a bit better.

And if you design a framework -- which [you should
do](@/posts/roll-your-own-frameworks.md), as
larger applications need frameworks to stay coherent -- you now
hopefully have some more concepts to work with to help you make better
design decisions.

```

```
