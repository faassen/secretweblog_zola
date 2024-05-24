+++
title = "Obviel 1.0b6"
date = 2013-04-04
slug = "obviel-10b6"

[taxonomies]
tags = ["javascript", "obviel"]
+++

I've just released Obviel 1.0b6!

There are backwards incompatible changes to Obviel Template in this
release. I figured now was the time to do so, as it's not widely adopted
yet. The general pattern is to use imperative verbs where possible for
directives (though `data-on` is an exception):

- `data-each` was renamed to `data-repeat` and `@each` to `@repeat`.
- `data-view` becomes `data-render`, as it really calls Obviel's
  `render()` function to render an object.
- `data-func` becomes `data-call`, as it really calls a function on the
  view.
- `data-handler` becomes `data-on` as its shorter and `on` typically
  implies event handling.

A simple search and replace in your templates for these names should be
enough to update your templates.

There is also a bugfix in Obviel Template that was contributed by Daniel
Havlik, thank you!

You can find out more about Obviel here:

<http://www.obviel.org/en/1.0b6/>

and here is the complete changelog:

<http://www.obviel.org/en/1.0b6/CHANGES.html>

Have fun and let me know what you think of it!
