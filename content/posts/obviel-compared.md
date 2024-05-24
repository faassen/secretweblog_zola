+++
title = "Obviel Compared"
date = 2013-01-29
slug = "obviel-compared"

[taxonomies]
tags = ["obviel"]
+++

I'm asked sometimes how [Obviel](http://obviel.org) compares to other
client side web frameworks. This
[evaluation](http://codebrief.com/2012/01/the-top-10-javascript-mvc-frameworks-reviewed/)
of JavaScript MVC frameworks provides a few useful points to consider
and gives a good opportunity for me to highlight some features of
Obviel.

I think Obviel comes out pretty nicely in this particular set of
criteria, but of course many other criteria exist.

# UI Bindings ✓

*A declarative approach where the UI is updated when the underlying
model changes.*

Obviel provides this because views can listen to events on models. When
a model is updated, an event can be sent to the model. If a view is
currently representing the model in the UI, that view will be notified.
A typical response by the view can be to rerender itself, but more
detailed updates exist as well.

Obviel Forms uses a more direct form of data binding -- when you modify
a field in a web form, an underlying JavaScript object is updated
automatically with the JavaScript representation of that field. If you
change the underlying JavaScript object, the form is automatically
updated as well. I am hoping we can eventually expand Obviel Template
with some features to do in-line updates directly, though re-rendering a
view (these are typically small already) can take you a long way in the
mean time.

Then there's Obviel Sync. Obviel Sync is a library that lets you
declaratively bind models to some backend, typically a server. Using
Obviel Sync you can automate the sending of events to models.
Unfortunately Obviel Sync is as yet undocumented (the only part of
Obviel not to have docs) and needs a bit more polishing. If you're
interested in helping out, let me know!

While there is still a lot of potential in further expanding this
approach, I think Obviel already has a pass mark on this feature.

# Composed Views ✓

*Compose views (preferably at the template layer). This should entail
the potential for a rich view component hierarchy.*

Obviel is built around the concept of composing views, and the template
layer supports this. A central trick in Obviel is that the view to use
for a model is determined by looking at that model - if you swap in a
different model, a different view will be rendered. The code that
renders the view doesn't need to know or care what specific view is
used.

This can be driven from the template layer, by using the [data-view
directive](http://www.obviel.org/en/1.0b5/template.html#data-view).

You can create rich view components with Obviel; more about this in the
next section.

A definite pass for Obviel on this feature.

# Web Presentation Layer ✓

*No native-style widgets, but instead let people use HTML and CSS.*

What the right approach here is a debatable topic. Some client-side web
frameworks provide a whole widget abstraction and you build the user
interfact by composing those widgets together. Others are explicitly
centered around HTML and templating. Both approaches have their
advantages and disadvantages.

The author of the article leans heavily towards the approach where
people use their own HTML and CSS. Luckily to gain the pass on this
feature, Obviel fits in with this approach: Obviel is centered around
HTML templates and JavaScript and lets you do everything on that level.
It does not provide its own widget set but lets you use the UI elements
you want to use, directly in HTML.

That said, it is possible to create widgets on top of Obviel, using
Obviel Views. The [Obviel
Forms](http://www.obviel.org/en/1.0b5/form.html) library is an example
of such an approach. Another very interesting up and coming library
created by Rob Gietema, [Obviel
Bootstrap](https://github.com/robgietema/obviel-bootstrap), creates a
set of Obviel views for
[Bootstrap](http://twitter.github.com/bootstrap/) UI elements. Note that
you don't have to use Obviel Bootstrap to use Bootstrap with Obviel;
instead you can directly use the bootstrap css classes in the HTML of
the templates.

So, a pass for Obviel; Obviel's designed this way.

# Plays Nicely With Others ✓

*jQuery is pretty amazing. I want a framework which recommends using
jQuery itself instead of providing its own sub-par jQuery clone.*

Obviel is built on jQuery, so that's an easy pass for Obviel. jQuery
extends jQuery in a small but powerful way by letting you do
`$(el).render(obj)` to render a view on an element for an object.

Obviel passes on this one by design again.
