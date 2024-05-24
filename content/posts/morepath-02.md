+++
title = "Morepath 0.2"
date = 2014-04-24
slug = "morepath-02"

[taxonomies]
tags = ["morepath", "planetpython", "python", "python3"]
+++

I've just released [Morepath](http://morepath.readthedocs.org/en/0.2/)
0.2! Morepath is your friendly neighborhood Python web microframework
with super powers.

Major changes include:

- Python 3 support thanks to a generous contribution by Alec Munro.
- Documented [security
  infrastructure](http://morepath.readthedocs.org/en/0.2/security.html).

And various smaller tweaks. You can also read the
[changelog](http://morepath.readthedocs.org/en/0.2/changes.html).

What makes Morepath special? You can read about its
[superpowers](http://morepath.readthedocs.org/en/0.2/superpowers.html)
and read how it
[compares](http://morepath.readthedocs.org/en/0.2/compared.html) to
other web frameworks, but here are some highlights:

- Route to model, then look up views. This leads to better link
  generation, better generic views, better reusable code.
- Have apps that can extend other apps, combine apps together. Extend
  and override anything, even Morepath behavior itself, but don't affect
  other apps in the same runtime.

It's lots of power contained in a small codebase.

(If you followed the [Morepath](http://morepath.readthedocs.org/en/0.2/)
link above, ignore the `0.1` in the title bar there: those *are* the 0.2
docs, not 0.1. I've now fixed the doc building configuration to include
the version number from the package itself.)
