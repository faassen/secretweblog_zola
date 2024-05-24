+++
title = "mstform: a form library for mobx-state-tree"
date = 2019-08-15
slug = "mstform-a-form-library-for-mobx-state-tree"

[taxonomies]
tags = ["javascript", "react", "forms", "mobx"]
+++

# Introduction

So I've written a new web form library:
[mstform](https://github.com/isprojects/mstform).

The first form library I ever wrote was called
[ZFormulator](http://old.zope.org/Members/faassen/ZFormulator/folder_contents)
and I released it in 1999. My first frontend form library was [Obviel
Forms](https://obviel.readthedocs.io/en/1.0/form.html) and it I wrote it
in 2012 or so. I've been at it for a while.

Much has changed in web development since 1999, and I've learned a thing
or two along the way as well. So a little while ago, almost against my
will (though I admit I also enjoy it a lot), I helped to create another
form library, one for the frontend again. It integrates with
[mobx-state-tree](https://github.com/mobxjs/mobx-state-tree). You'd
probably use React to render the form, though you don't have to.

# A whirlwind introduction to mobx-state-tree

So what, you may ask, is mobx-state-tree, and why should I want to use
it in my React application? mobx-state-tree is a state management
library - it manages the state you show in your frontend UI. It's built
on top of another React state management library named
[MobX](https://mobx.js.org/). MobX is magic. You define your model
classes, and you mark a few properties and methods so that MobX can
observe them. You also mark your React components as observers. It's
easy. After that when you change your model instances your React UI will
automatically and efficiently update itself.

As I said, mobx-state-tree (MST to make it less of a mouthful) is built
on MobX. The way you mark your React components as observers is
identical. What it then adds is the following: it forces you to define
your models in a very particular way and then it gives you a ton of
features in return.

Here's a tiny example:

``` javascript
const Animal = types
  .model("Animal", {
    name: types.string,
    hunger: types.integer
  })
  .views(self => ({
    get isSated() {
      return self.hunger === 0;
    }
  }))
  .actions(self => ({
    feed(amount) {
      self.hunger -= amount;
      if (self.hunger < 0) {
        self.hunger = 0;
      }
    }
  }));
```

Here we have a model <span class="title-ref">Animal</span>. It has two
properties, <span class="title-ref">name</span> and
<span class="title-ref">hunger</span>. There's also a special view
property we have defined with a getter,
<span class="title-ref">isSated</span>. We've also defined an action
which manipulates the properties.

MST then gives you some interesting features:

- You get run-time checks if you put in the wrong type of value. With
  TypeScript you also get compile-time checks.
- You can automatically serialize this to JSON and deserialize it from
  JSON.
- You can install hooks to monitor any changes to properties.
- There is a mechanism for defining references between models, and the
  JSON serializer works with it.

mstform builds on MST to help you create web forms.

# Rendering a web form: you're on your own

In the past, for a library like Formulator or Grok or Obviel Forms, I
made sure it could *render* your form. That's nice to have when you have
simple forms -you just write a form description or perhaps a schema, and
boom, the system automatically shows a form. Django's form system works
like that too.

The problem with automatically rendering a form is that any complex form
will have special UI. Perhaps you want to display a piece of text
between two widgets. Perhaps you want to render repeating sub-forms in a
certain way. Perhaps you want to layout the form so that it responds to
the width of the browser window. I don't know. If you automatically
render a form and that's the default way of using the form library, the
form library has to supply concepts and hooks so that you can influence
the form rendering process. These hooks are typically difficult to use
for the developer and are incomplete, as it's difficult to anticipate
everything.

With mstform, I let all of that go. It doesn't try to render forms. It
isn't in control of rendering your form at all. It would be fairly
straightforward to build something on top of mstform that did this for
you, but it's not a priority. You have React. You have your own form
components or use some UI library that already provides them. mstform
instead makes it easy to integrate with these components.

# What does mstform do then?

If mstform doesn't render your form, what does it do then? It manages
the form contents - the *form state*. In fact, an earlier name for this
library *was* FormState, until I discovered there already was another
library out there with that name.

mstform in its essence lets you define a form that represents a MST
model. Here is an example for the <span class="title-ref">Animal</span>
model we defined above:

``` javascript
import { Form, Field, converters } from "mstform";

const form = new Form(Animal, {
    name: new Field(converters.string),
    hunger: new Field(converters.integer)
});
```

You can then use this form to manage the state of instances of that
model:

``` javascript
// use MST to create an instance of an animal
const elephant = Animal.create({name: "Elephant", hunger: 3});

// now make a form state for elephant
const formState = form.state(elephant);
```

You can access fields from the form state:

``` javascript
const nameField = formState.field('name');
```

Once you have a field, you can render it with React. Here is how you
could render an input text:

``` javascript
import { Component }, React from "react";
import { observer } from "mobx-react";

@observer
class Input extends Component {
    render() {
        const { type, field } = this.props;
        return <input type={type} {...field.inputProps} />;
    }
}
```

You can do a lot of other things with the field accessor too: get its
error message with <span class="title-ref">field.error</span>, check
whether the field is required with
<span class="title-ref">field.required</span>, check whether the field
is empty with <span class="title-ref">field.isEmpty</span> and so on.

# What does that give you?

Why should I use MST with mstform instead of rolling my own, you may
ask?

Here we come to features of mstform:

Convert form input  
The form input is often just a bunch of texts, but you have a data model
underneath. For instance, if I enter an integer in a text input it is a
string. mstform converts this into an integer.

Show edit forms  
Say you already already have form content, because you just loaded it
from the backend and deserialized it for instance, you need to convert
that content back again to its display state. For instance, render an
integer as a string so it can be displayed in a text input.

Client-side validation  
Even after the conversion was successful, you want to validate that the
value fulfills some criteria, such as being within a certain range. You
still need to do validation on the backend to be sure, but this way you
can show errors right away.

Error handling  
An easy way to show errors, both in conversion and validation. We can
also show backend-generated errors, to which we will get in a bit.

Repeated forms and sub forms  
You can express nested and repeated structures in your models easily in
the form.

Backend integration  
You can define how your form is saved to the backend. You can only
submit a form if it's valid. The backend can return validation errors
and warnings which can be displayed in the form.

Server-side validation  
You can also set it up so that your backend generates validation errors
during user interaction. This way the backend can remain in charge of
validation as the single source of truth, while you still dynamically
display errors right away.

Form access states  
Make your fields required, disabled, hidden and read-only. Disable
individual fields or a whole sub-form at once. You have to write
rendering code that can handle these states as mstform doesn't do
rendering, but once you have it your forms become very flexible indeed.

Modify the underlying object  
You can modify the underlying MST model instance with your own code and
the form automatically updates itself. Modify a field value, add a new
repeated item, the works. It's just that simple.

Derived values between fields  
A field can have a default value that is based on the values filled in
with other fields.

Support for different kinds of React input components  
Some components get the value with
<span class="title-ref">onChange</span>, others get the value as
<span class="title-ref">event.target.value</span>. Some components
display their value with <span class="title-ref">value</span>, others
with <span class="title-ref">checked</span>. mstform converters have
defaults, but you can override them to suit your needs.

Support for internationalized decimal input  
Decimal numbers tend to have quite a few differences between countries.
For instance, in the US you use periods for the fraction, and commas for
the thousands, but in the Netherlands it's the other way around. mstform
has a special decimal parser built-in which takes care of that.

TypeScript support  
mstform is written in TypeScript and exports TypeScript type definitions
for your development convenience.

For more, consult the [mstform
documentation](https://github.com/isprojects/mstform).

# Conclusion

Setting up a form with mstform takes a bit of effort, though it's not
difficult. Once you do, a lot of code you might write as custom and
failure-prone React components goes away, while you retain a lot of
flexibility. Your users edit a form, and a proper MST instance sits
under it. You can immediately sends its JSON to the backend. You can
load up new form contents from the backend just as easily.

Is this the last form library I will ever write? Experience teaches me
not to make such promises. But mstform does pack a lot of my experience
with web forms in it. I hope you'll give it a try!

# Credits

mstform was created by myself and team of people at a customer of mine
named [ISProjects](https://www.isprojects.nl/en/). I am very grateful to
ISProjects for their great support in this and quite a few other
interesting projects I got to work on for them. And they're looking for
developers!
