+++
title = "Morepath 0.13 now with Dectate"
date = 2016-04-06
slug = "morepath-013-now-with-dectate"

[taxonomies]
tags = []
+++

We just released [Morepath](http://morepath.readthedocs.org) 0.13
([changes](http://morepath.readthedocs.org/en/0.13/changes.html#id1)).
Morepath is your friendly neighborhood Python web framework with super
powers, and with 0.13 it has gained a significant **power upgrade**.

This is the first Morepath release of 2016 and the biggest Morepath
release in a while. The major change in Morepath 0.13 is that it is now
build on the [Dectate](http://dectate.readthedocs.org) meta-framework
for configuration.

Morepath's configuration system is finally documented in the form of
[Dectate](http://dectate.readthedocs.org). Developers can extend
Morepath with new configuration directives and new configuration
registries and they behave exactly like the native ones. They're built
the same way.

Dectate offers [powerful
features](http://dectate.readthedocs.org/en/latest/usage.html#features)
that I believe takes Morepath's decorator-based configuration system far
beyond what you can do with most other web frameworks, which typically
use a Python file for configuration, or use an ad-hoc decorator-based
system. Too bad almost nobody seems to realize how much power this
brings to the developer... A [query
tool](http://dectate.readthedocs.org/en/latest/usage.html#query-tool)
for configuration, for instance.

The only framework with an equivalent system is Pyramid, but I think
Morepath still has some features it does not: Morepath allows multiple
independent configurations in the same run-time, for instance.

With the introduction of Dectate we've dropped Morepath's dependency on
[Venusian](http://docs.pylonsproject.org/projects/venusian). Venusian
was certainly valuable to Morepath, but over time we started to have
some issues with it: its requirement to scan Python code was a barrier
for beginners, and in some cases it could impact performance.

Dectate does not require scanning of packages in order to find
registrations, but it can certainly be handy to be able to do so, as you
can't miss any stray decorators in modules you didn't import anywhere
else. Morepath now supports it through the new
[importscan](http://importscan.readthedocs.org) dependency. importscan
defines a recursive import function extracted from Venusian.
