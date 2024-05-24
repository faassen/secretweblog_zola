+++
title = "The Core of Obviel"
date = 2013-01-31
slug = "the-core-of-obviel"

[taxonomies]
tags = ["obviel", "javascript"]
+++

# The Core of Obviel

## Start with jQuery

Obviel's core principle is pretty simple if you know jQuery.

With jQuery, you can select one or more elements like with a selector:

    var el = $('#foo')

You get a list of wrapped DOM elements. You can do things with these:

    el.text(); // get the text content

    el.attr('foo'); // get an attribute

    el.html('<p>Hello</p>'); // set the HTML content

## Add the Obviel

Obviel expands jQuery with a `render` function:

    el.render(obj); // render an object on el

Once you know this, you know the most important thing about Obviel.

## Views

Now how does Obviel *know* how to render `obj` on `el`?

You need to tell Obviel first (typically when the JavaScript file is
being loaded) by defining a *view*:

    obviel.view({
      iface: 'animal',
      html: '<p>This is an animal</p>'
    });

This view works for the *iface* `animal`. An iface is a simple marker on
objects you want to render. So if you have this object:

    var obj = {
      iface: 'animal'
    };

We render `obj` on `el`:

    el.render(obj);

Obviel knows that to render obj, it needs to use the view registered for
`animal` above.

Once the view is found, Obviel renders the view on the element. In the
case of the view above, it will insert `<p>This is an animal</p>` into
`el`.

## Obviel Template

Above we insert a snippet of HTML. Typically you want to insert
something more specific to the object at hand. Let's expand the animal
object a bit so it has some more information:

    var obj = {
      iface: 'animal'
      name: 'lion',
      sound: 'growls'
    };

Here's a view that will display a bit of information about such an
animal with a `name` and `sound` property:

    obviel.view({
      iface: 'animal',
      obvt: '<p>The {name} {sound}</p>'
    });

When this view is rendered:

    el.render(obj);

the `<p>The lion growls</p>` will be inserted into `el`.

The `obvt` bit above is an Obviel Template. Obviel Template lets you do
variable substitution, repeat elements, bind events and has extensive
i18n support.

## Custom JavaScript

Finally, you may want to execute some custom JavaScript code when a view
is rendered. You can do this by defining a `render` function on the
view:

    obviel.view({
       iface: 'animal',
       obvt: '<p class="animal">The {name} {sound}</p>',
       render: function() {
          $('.animal', this.el).click(function() {
            alert("You clicked on the animal: " + this.obj.name);
          });
       }
    });

As you can see you can combine `obvt` (or `html`) with a custom `render`
function. You can access the element on which the view is rendered with
`this.el` and the object being rendered with `this.obj`.

In fact you can use Obviel Template's event handler support to clean up
this code:

    obviel.view({
       iface: 'animal',
       obvt: '<p class="animal" data-handler="click|animalClicked">The {name} {sound}</p>',
       animalClicked: function() {
         alert("You clicked on the animal: " + this.obj.name);
       }
    });

## More

This should get you started! But Obviel is extensively documented at
<http://obviel.org> should you need more information.

Good luck!
