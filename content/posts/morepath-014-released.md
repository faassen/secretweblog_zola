+++
title = "Morepath 0.14 released!"
date = 2016-04-26
slug = "morepath-014-released"

[taxonomies]
tags = ["morepath", "python", "planetpython"]
+++

Today we released [Morepath](http://morepath.readthedocs.org) 0.14
([CHANGES](http://morepath.readthedocs.org/en/0.14/changes.html)).

What is Morepath? Morepath is a Python web framework that is powerful
and flexible due to its advanced configuration engine
([Dectate](http://dectate.readthedocs.org)) and an advanced dispatch
system ([Reg](http://reg.readthedocs.org)), but at the same time is easy
to learn. It's also extensively documented!

The part of this release that I'm the most excited about is not
technical but has to do with the community, which is growing -- this
release contains significant work by several others than myself. Thanks
Stefano Taschini, Denis Krienbühl and Henri Hulski!

New for the community as well is that we have a web-based and
mobile-supported chat channel for Morepath. You can [join
us](https://discord.gg/0xRQrJnOPiRsEANa) with a click.

Please join and hang out!

Major new features of this release:

- Documented [extension
  API](http://morepath.readthedocs.org/en/latest/extension_api.html)
- New [implementation
  overview](http://morepath.readthedocs.org/en/latest/implementation.html).
- A new document describing [how to
  test](http://morepath.readthedocs.org/en/latest/testing.html) your
  Morepath-based code.
- Documented how to create a [command-line query
  tool](http://morepath.readthedocs.org/en/latest/config_query.html) for
  Morepath configuration.
- New [cookiecutter
  template](https://github.com/morepath/morepath-cookiecutter) to
  quickly create a Morepath-based project.
- New releases of various extensions compatible with 0.14. Did you know that
  Morepath has [more.jwtauth](https://pypi.org/project/more.jwtauth/),
  [more.basicauth](https://pypi.org/project/more.basicauth/) and
  [more.itsdangerous](https://pypi.org/project/more.itsdangerous/) extensions
  for authentication policy,
  [more.static](https://pypi.org/project/more.static/) and
  [more.webassets](https://pypi.org/project/more.webassets/) for static
  resources, [more.chameleon](https://pypi.org/project/more.chameleon/) and
  [more.jinja2](https://pypi.org/project/more.jinja2/) for server templating
  languages, [more.transaction](https://pypi.org/project/more.transaction/) to
  support SQLAlchemy and ZODB transactions and
  [more.forwarded](https://pypi.org/project/more.forwarded/) to support the
  `Forwarded` HTTP header?
- Configuration of Morepath-based applications is now simpler and more
  explicit; we have a new `commit` method on application classes and
  applications get automatically committed during runtime if you don't
  do it first.
- Morepath now performs host header validation to guard against header
  poisoning attacks.
- New
  [defer_class_links](http://morepath.readthedocs.org/en/latest/api.html#morepath.App.defer_class_links)
  directive. This helps in a complicated app that is composed of
  multiple smaller applications that want to link to each other using
  the `request.class_link` method introduced in Morepath 0.13.
- We've refactored both the publishing/view system and the link
  generation system. It's cleaner now under the hood.
- Introduced an official [deprecation
  policy](http://morepath.readthedocs.org/en/latest/developing.html#deprecation)
  as we prepare for Morepath 1.0, along with [upgrade
  instructions](http://morepath.readthedocs.org/en/latest/upgrading.html).

Interested? Feedback? [Let us
know](http://morepath.readthedocs.org/en/latest/community.html)!
