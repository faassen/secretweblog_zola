+++
title = "A buildout for lxml"
date = 2006-10-03
slug = "a-buildout-for-lxml"

[taxonomies]
tags = ["packaging", "lxml"]
+++

I've created what's called a "buildout" for lxml, and I figured I'd let
everybody know how cool that is.

Buildout is a new system for constructing Python applications and its
constituent parts, based on setuptools and eggs. Much more information
can be found here:

<http://cheeseshop.python.org/pypi/zc.buildout/>

Now before you read all that (it's pretty technical), let me explain
what problem the lxml buildout tries to solve.

Recently I tried using lxml's XMLSchema validator against an XML file
and a schema. It gave a validation error, but to the best of my
knowledge, the XML file should've been valid. Thinking it might perhaps
be a bug that was fixed in more recent versions of libxml2, I set out to
build and install libxml2 and libxslt locally, compiled lxml against it,
and confirmed it: the document does validate against the schema with the
most recent release of libxml2. This was indeed a bug in libxml2.

Now downloading, building and installing libxml2 and libxslt and linking
lxml against it is quite a bit of work. Buildout to the rescue! Now it's
just this:

    $ svn co https://infrae.com/svn/buildout/lxml-recent/trunk lxml-recent
    $ cd lxml-recent
    $ python bootstrap/bootstrap.py
    $ bin/buildout

and then wait. It'll download, configure and compile libxml2, libxslt,
will downoad the lxml source and compile it against the libraries.

In the end you end up with a script that invokes the Python interpreter
with the right paths set up so it can import lxml. Here's how to start
it:

    $ bin/lxmlpython

Though you can also manipulate the `PYTHONPATH` yourself in your scripts
to put the lxml development egg on it, and then you can use the regular
Python you used to run `bootstrap.py` with.

The only thing needed is a `buildout.cfg` - that's basically what you're
checking out above, along with a standard bootstrap script and a
required recipe (`zc.recipe.cmmi`) that hasn't been released as an egg
to cheesehop yet.

Let's go through each section of `buildout.cfg`:

    [buildout]
    develop = zc.recipe.cmmi
    parts = libxml2 libxslt lxml lxmlpython

Each `buildout.cfg` file has a top section called `[buildout]`.

This one has a line `develop`. It says that I have one development egg,
`zc.recipe.cmmi`. If the recipe were uploaded to the cheeseshop, this
line can go away entirely, but right now it hasn't been released as an
egg yet, so I need the local checkout of zc.recipe.cmmi to be available
as an egg.

The next line, `parts`, lists what parts need to be built to finish the
whole buildout. I want libxml2, libxslt, lxml and lxmlpython. The rest
of the `buildout.cfg` file contains information on how to build the
specified parts. Each part uses a recipe, such as `zc.recipe.egg`,
`zc.recipe.cmmi`, etc.

The first part specifies how to build libxml2. We use the
`configure;make;make install` recipe (`zc.recipe.cmmi`), which we just
made available as a (development) egg. Here is the section that builds
libxml2:

    [libxml2]
    recipe = zc.recipe.cmmi
    url = ftp://xmlsoft.org/libxml2/libxml2-2.6.26.tar.gz
    extra_options = --without-python

The tarball we want to download, compile and install is specified with
the `url` option. This is enough for many tarballs: the tarball would be
compiled and installed as a part in the `parts` directory under the
buildout.

We want to do one extra thing and pass the special option to the
configure script of libxml2: do not compile libxml2 with its default
Python bindings. After all, lxml replaces those default binding bindings
with something better!

The next section for `[libxslt]` is very similar. We do pass another
extra option along to `configure` to make it link to the libxml2 part we
just built:

    [libxslt]
    recipe = zc.recipe.cmmi
    url = ftp://xmlsoft.org/libxml2/libxslt-1.1.17.tar.gz
    extra_options =  --with-libxml-prefix=${buildout:directory}/parts/libxml2/
                  --without-python

Now we want to build the lxml egg in the `[lxml]` section. We want to
compile lxml 1.1.1 - the system will automatically download its sources
from the cheeseshop. We want to pass a few extra options to the lxml
build process (its setup script), to make sure it links against the
libxml2 and libxslt parts we just built:

    [lxml]
    recipe = zc.recipe.egg:custom
    eggs = lxml == 1.1.1
    include-dirs = ${buildout:directory}/parts/libxml2/include:${buildout:directory}/parts/libxslt/include
    rpath = ${buildout:directory}/parts/libxml2/lib:${buildout:directory}/parts/libxslt/lib

Finally, we want to build a Python interpreter with the lxml egg as an
available import on the `PYTHONPATH`:

    [lxmlpython]
    recipe = zc.recipe.egg
    interpreter = lxmlpython
    eggs = lxml

That's all that's needed to make it download, compile and build lxml and
its requirements.

Many buildout recipes exist: we already saw `zc.recipe.egg` (which we
use here just to build an interpreter that has the egg on its path), and
`zc.recipe.egg:custom` to build the lxml egg with some custom options,
and `zc.recipe.cmmi` to do configure;make;make install.

At Infrae we also built a recipe to deploy OpenOffice in server mode,
and allowing us to connect to it with PyUNO with the Python interpreter
we want, for document conversion purposes.

Other recipes available can install Zope 3 and the ZODB.

This expanding pool of recipes will allow us to put together extremely
complicated applications in a reproducable fashion. The idea of buildout
is to have control and reproducability - to know exactly what is
installed and not to have to install all Python libraries into a global
site-packages.

As I said before, buildout uses setuptools and easy_install internally,
so the whole egg story just works; it expands on that.

I think this way of building lxml has more benefits than just my single
use case of trying it with the latest version of libxml2. It'll allow
one to deploy lxml against a known-good version of libxml2 and libxslt,
at least on a linux system. It should also help testing and developing
lxml - it becomes a lot more easy to test and develop against different
versions of libxml2.

I hope this short introduction makes people interested in buildout!
