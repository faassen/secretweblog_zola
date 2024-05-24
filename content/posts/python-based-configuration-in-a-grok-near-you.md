+++
title = "Python-based configuration in a Grok near you"
date = 2010-01-02
slug = "python-based-configuration-in-a-grok-near-you"

[taxonomies]
tags = ["grok", "framework"]
+++

BFG 1.2 offers [imperative
configuration](http://plope.com/Members/chrism/bfg_12_imperative_config):
doing configuration not in ZCML but in Python. The declarative
configuration system is built on top of this. This is an interesting
approach that has some merit.

It's interesting to compare this to Grok's configuration system, which
also focuses on Python, not ZCML. Grok however offers a declarative
configuration system in Python, not an imperative one.

It's important to note that from the start Grok's declarative
configuration system allowed the user to be entirely explicit about how
configuration happens. I don't know whether Chris was referring to Grok
when he mentioned that in BFG no false choice between convention over
configuration and ZCML is offered, but in case anyone had the wrong
impression: Grok doesn't offer such a choice. You can be as explicit as
you like. Relying on convention-based configuration patterns is an
option when using Python-based configuration, but not an obligation.

Grok's declarative configuration system can be used in tests. If you
have a component that you need to register, you can use
`grok.testing.grok_component` to automatically configure it according to
the standard Grok configuration rules.

Here is an example, a component:

    import grok
    class MyAdapter(grok.Adapter):
       grok.context(AdaptedFrom)
       grok.provides(IAdaptedTo)

This adapter when configured, be registered as allowing instances of
class AdaptedFrom to objects providing interface IAdaptedFrom.

If we want to configure this adapter in our tests, we can use
`grok_component`:

    >>> from grok.testing import grok_component
    >>> grok_component('MyAdapter', MyAdapter)
    True

The `grok_component` function can also be imported from the reusable
`grokcore.component` library, through `grokcore.component.testing`.

Interesting about this design is that Grok allows the use of the same
configuration system for test-configuration as well as real
configuration. There is no need to learn a different configuration
approach when running tests.

Grok's focus on configuration as an area to challenge existing Zope
assumptions is long-standing. Grok strikes a different balance than BFG
as Grok aims to remain compatible with existing Zope-based systems.

Nothing's perfect. So, I'll close with some areas where we should
improve Grok's configuration system:

- while it is very convenient to be able to register a component with
  the same configuration as it would have in a real application (a
  common case), we might need a way to support registering an existing
  component differently. Subclassing probably usually does provide this.
- we need to better promote grok_component as a well-understood tool by
  writing better documentation and more tests. Often I myself fall back
  on using the zope.component registration APIs in tests directly
  myself, and I need to understand why. Perhaps this is simply something
  to get used to, or perhaps the reasons are more fundamental and there
  is a BFG-like imperative configuration system at some level.
- we need to fix the API so we can avoid the first argument to
  `grok_component`, which is, if I recall it correctly, mostly useless.
