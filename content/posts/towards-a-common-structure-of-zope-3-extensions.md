+++
title = "Towards a common structure of Zope 3 extensions"
date = 2005-10-07
slug = "towards-a-common-structure-of-zope-3-extensions"

[taxonomies]
tags = ["zope", "packaging", "linux"]
+++

Quite a few Zope 3 extensions are starting to appear. This is great.
There is all the great work done within the [Z3ECM svn
repository](http://svn.nuxeo.org/trac/pub/browser/z3lab/). There's
Infrae's [hurry](http://codespeak.net/svn/z3/hurry/trunk) library of
little Zope 3 odds and ends. Then there are various Zope 3 extensions
written by Zope corporation, such as
[zc.catalog](http://svn.zope.org/Sandbox/zc/catalog) and
[zope.formlib](http://svn.zope.org/zope.formlib). There's also various
work done in the [Zope 3 base](http://codespeak.net/svn/z3) svn
repository.

Various patterns are emerging in the way these extensions are
structured. I want to suggest a common pattern we all adhere to, and the
reasons why. My aim is to suggest a common Pythonic structure, so that
we don't do our homegrown Zope thing.

## Warning

The word "package" in this text means what you check out from SVN. It's
also what you can distribute to others in a tarball. It's what linux
distributors use to create their distribution packages. It's also what
you can use to create a Python egg (see more later).

The word "python package" in this text means what is importable in
Python. It has the `__init__.py`. It's like a Python module, but bigger.

These packages are not necessarily identical, and in fact I'll argue
they _shouldn't_ be identical. When I say "package" I mean the former
distribution package, when I say "python package" I'll mean the latter.

## Why is a common package layout important?

Developers know where to look when they start using a new package.
Distributors and packagers (such as linux distributors) know where to
look and what to do. System administrators need to know only a single
trick to install Python packages into Zope, not a different one for each
package. Eventual metadistributions like what Zope 3 ECM may become will
be easier to build.

Furthermore, distutils is now the standard for python packages. This
involves a `setup.py` script the package root which can be used to build
and install Python packages. It can also be used to create distributions
of Python packages. Distutils presumes having a place where the setup.py
can live.

Recently Phillip Eby has been doing a lot of great work with Python
eggs, setuptools and easy_install. Briefly:

- eggs make it easy to distribute Python packages to be installed. It
  handles dependencies.
- setuptools makes it easy to create eggs. It also makes it to upload
  our package into cheeseshop.python where other Python developers can
  find it.
- easy_install makes it trivial to install packages and the dependencies
  by typing a one liner.

We need to structure our Zope 3 packages so they're easy to use with
eggs. I expect Zope 3 core will start using eggs pretty soon, so let's
prepare our extensions.

## Package namespaces

Some packages create their own Python package namespace (`hurry`, `zc`)
by utilizing a namespace package with an empty
<span class="title-ref">\_\_init\_\_.py</span>. Others expect to live
within the `zope` namespace of Zope 3, probably in the hope that this
package will one day be core. Some packages just sit in the top level,
creating a new namespace all for themselves, other packages cohere under
a common namespace.

Recommendations:

- Being in core is not so important with Zope 3. It's a flexible system.
  We'll distribute collections of packages, probably using eggs to
  handle dependencies. Don't use `zope` as a top level package name
  unless you're really developing the package inside
  `svn.zope.org/Zope3`. `zope` makes it harder to install as a normal
  Python package as you need to hack the zope hierarchy and mess about
  with symlinks. `python setup.py install` becomes impossible. If your
  package enters core, you'll probably do more changes anyway that break
  compatibility than just changing the package namespace.
- Use a top level namespace package. So, I didn't call my query package
  `query`, as I imagine there are other python modules called that way.
  Instead I used a top level namespace called `hurry` and put it there.
  There's probably nothing else that's imported as `hurry.query` in the
  Python world.
- Try to cohere multiple related packages under a shared toplevel
  namespace package. I've tried to do this with hurry, which has
  `hurry.file`, `hurry.workflow` and `hurry.query`. This is also to
  prevent namespace pollution.

## Structure of a package

Some packages conflate the concept of distribution package and Python
package. Thus, the Python modules are just in the top level of the
distribution package, which has an `__init__.py`.

This is not good if you want your package to be released to the world,
or possibly even be picked up by a Linux distributor. When I download a
release tarball of some interesting Python extension, I expect to be
able to unpack it, and _not_ find all the source right there. No, I
expect a nice `README.txt`, a `INSTALL.txt`, a `setup.py`, and perhaps a
testrunner and a `doc` directory. I don't want to be bothered with lots
of files of the source code itself.

The source code, that which ends up being importable somehow, that which
ends up on the `PYTHONPATH` somehow, is in a separate subdirectory. This
is often called `src`, like with Zope 3. An alternative structure also
frequently used and useful if your package will have everything in a
single Python namespace package anyway is to make this Python namespace
package the immediate subdirectory.

It's actually the layout of Zope 3 SVN. It's also the layout of, say,
Twisted, and PEAK, and CherryPy, and many, many other Python packages.

By using such a structure, it's trivial to create a simple release: you
just do an svn export, tar it up, and you're done. It also become easy
to create eggs, and the like.

Recommendations:

- split your source code away from your top level distrubtion package
- put your Python packages either in a subdirectory called `src`, or put
  your single namespace package directly in a subdirectory with the name
  of your Python namespace package (`twisted`).
- Put in a `README.txt` and a `LICENSE.txt` at the very least.
- Strongly consider putting in a `setup.py`.
- Let's all investigate eggs and make our own packages work with them.
