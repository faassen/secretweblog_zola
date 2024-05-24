+++
title = "Obviel 1.0b"
date = 2012-05-31
slug = "obviel-1-0b"

[taxonomies]
tags = ["obviel", "release", "templating"]
+++

# Obviel 1.0b

It's been quiet around [Obviel](http://www.obviel.org/), the client-side
web framework that I've been working on. That isn't because there wasn't
any activity. The opposite is the case: I've just released Obviel 1.0b
with a ton of new goodies. And when I mean a ton I do mean a ton:

- a whole new *template language* called [Obviel
  Template](http://www.obviel.org/en/1.0b/template.html) that supports
  sub-views & i18n
- gettext-style [i18n in
  JavaScript](http://www.obviel.org/en/1.0b/i18n.html)
- and the most out there new thing: an actual client-side *routing
  library* called [Traject](http://www.obviel.org/en/1.0b/traject.html)

For more details, here's the
[changelog](http://www.obviel.org/en/1.0b/CHANGES.html).

Why would you want a client-side web framework like Obviel? More and
more web development is happening on the client side, in JavaScript. End
users get a more dynamic user interface. Developers get to enjoy a
cleaner separation between UI and backend, and various scalability
benefits as the burden of rendering the UI has moved to the client. A
rich client-side UI isn't something to use for all web sites, but it
certainly is a nice thing for the web applications where you can!

[jQuery](http://jquery.com/) is a very nice library to help build
dynamic web UIs, but for larger projects your JavaScript easily grows
out of control and becomes a tangled mess. With Obviel you can add
structure to your jQuery application, and make each bit more easy to
understand and more reusable.

You can get started with Obviel without learning a ton of new things
beyond jQuery: learn about the new function `.render()` that Obviel adds
to jQuery, and you're quite far along already. You'll find your
client-side code becomes more clean and RESTful.

Obviel is there for you then you need more: templating,
internationalization, forms, client-site routing, and more.

Obviel isn't the only client-side framework out there. I do think it
offers some unique perspectives on how to do templating, i18n,
model/view separation and form generation. Unique for the client-side
that is: I've been porting over patterns from advanced server web
frameworks that I'm familiar with to JavaScript and the browser to see
what happens. And what happens feels good to me. I hope you'll check it
out and let me know what you think!
