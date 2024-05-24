+++
title = "Powerful composition with Obviel data-render"
date = 2013-05-07
slug = "powerful-composition-with-obviel-data-render"

[taxonomies]
tags = ["obviel", "javascript"]
+++

[Obviel](http://obviel.org) is the client side web framework I've been
hacking on for the past few years. It has among many other things a
client-side template language called [Obviel
Template](http://www.obviel.org/en/1.0b6/template.html). Obviel Template
has a bunch of nice features such as [i18n
support](http://www.obviel.org/en/1.0b6/template_i18n.html), about which
I'll write more later. But the feature I want to talk about today is the
`data-render` directive.

Obviel lets you define views for types of objects, and render them on
elements. See my previous blog entry on the <span class="title-ref">core
of Obviel</span> for a very short introduction to this concept (note:
`data-handler` has been renamed to `data-on`). In web applications your
Obviel views are mostly going to have small templates - each view doing
its own thing: rendering a template for a model, handling user events,
etc. Complex UIs are created by composing views together.

`data-render` is the tool that lets you do this easily from within a
template. If we have the following model of a todo list:

    {
      iface: 'todo-list',
      todos: [{ iface: 'todo-item', title: 'Item 1' },
              { iface: 'todo-item', title: 'Item 2' }]
    }

Then we can create a view to render that `todo-list` like this:

    obviel.view({
       iface: 'todo-list',
       obvt: '<ul><li data-repeat="todos" data-render="@."></li></ul>'
    });

What, you may ask, is `@.`? It is Obviel Template's way to express "the
current object", in this case the current item in the `todos` array that
we are looping through using `data-repeat`.

And we also need to be able to render an individual `todo-item`:

    obviel.view({
       iface: 'todo-item',
       obvt: '<div>{title}</div>'
    });

Some benefits:

- each view is doing one and only one thing

- if `todo-item` has an event handler (for instance to handle `click`
  events), this will just work:

      obviel.view({
         iface: 'todo-item',
         obvt: '<div data-on="click|clicked">{title}</div>',
         clicked: function() {
           alert("You clicked!");
         }
      });

  \[update: fixed bug in code example by renaming 'click' to 'clicked'\]

- The `todo-list` view is agnostic about what individual entries of the
  `todos` array actually are. So if you add a `special-todo-item` to the
  `todos` array, and provide a view for it, it will just work too. This
  is pretty powerful if you are going to hook up entirely different
  events in it!

Have fun with Obviel and see you next time!
