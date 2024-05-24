+++
title = "The Ghost of Packaging Past and Future"
date = 2008-12-16
slug = "the-ghost-of-packaging-past-and-future"

[taxonomies]
tags = ["python", "packaging", "django"]
+++

There has been a recent discussion on how packaging of Python libraries
should be done. As frequently happens, the Zope community sometimes
encounters problems before many other communities do, and I think we
have an example of that here.

James Bennett
[wrote](http://www.b-list.org/weblog/2008/dec/14/packaging/):

> "Please, for the love of Guido, stop using setuptools and
> easy_install, and use distutils and pip instead."

Ian Bicking then [pointed
out](http://blog.ianbicking.org/2008/12/14/a-few-corrections-to-on-packaging/)
that this is impossible, as pip is actually _built upon_ setuptools.

With Grok we don't use <span class="title-ref">easy_install</span> much.
setuptools, overall, is great to have. It's hardly perfect, but it
offers many essential features that distutils alone doesn't offer, such
as the ability to actually list the dependencies of your project in the
first place. We also greatly enjoy the benefits that Buildout brings.

Even though we've been dealing with advanced packaging issues in the
Zope project for quite a while now, I am not going to be presumptuous
and tell you what to do or not to do, for the love of Guido or not. I'm
not going to tell you to use Buildout, for instance. Instead I'm going
to sketch out what we do right now, and what our use cases are.
Hopefully this will help inspire further improvements to the Python
packaging infrastructure.

## What Grok does

Let me first sketch out the way Grok's installation system works.

To install grok, you first need to install a small tool called
grokproject. This is the only time when `easy_install` comes in It is
used to download and install the small grokproject distribution. Many
people do this in a virtualenv. After that we don't use `easy_install`
anymore, and I actually imagine you could use `pip` as well in this
step.

Once you have grokproject installed you have new command line utility to
create Grok-based projects. It's appropriately named `grokproject`. To
create a new Grok project, you type something like this:

    $ grokproject myproject

`grokproject` will ask you a few questions (username/password of the
admin user), and will then create a project directory called `myproject`
and will install Grok's basic environment. This includes startup and
other useful scripts in a `bin` directory, a `setup.py` file and a `src`
file which will contain the actual source code of the project in a
Python package.

In the Grok project we go for code reuse as this enables us to reuse the
brains of smart people, so all this is done with a combination of Ian
Bicking's Paster and Jim Fulton's Buildout.

Paster is used to create the directory and file layout from a template.
You can in fact also use the Grok paster template using the
`paster create` command to create a project directory and then call
`buildout` manually - it will do the same thing.

Buildout is then automatically invoked. It will do whatever we tell it
to do through the project's `buildout.cfg` file. Buildout is pluggable
with recipes that are themselves distributed on PyPI. In Grok's case the
buildout step does the following:

- download Grok and all its dependencies from PyPI (we actually have an
  optimization here in that it will download a large bundle of libraries
  if it can)
- install all eggs in a centrally shared eggs directory (in your home
  directory typically). This way the next time you create a project with
  grokproject you will not have to download anything new. Note that
  Grok's eggs are installed unzipped; we don't like zipped eggs much
  either.
- install an empty ZODB database.
- install the zope control scripts for starting and stopping the server
  and such.

With Grok 1.0 (coming in early 2009) we will start using `paster serve`
for managing the Grok process, instead of our home-grown `zopectl`
script, so we can enjoy a lot of benefits of WSGI support out of the
box.

## Version management

Very important in this whole procedure is version management. When
someone installs Grok it's essential they will only get versions of
dependencies that we actually know will work. If it would get an
arbitrary recently released version of a library, any new release of a
library could potentially break Grok. In addition, all Grok projects
would use different versions of dependencies, which would make
communication about bugs rather difficult. We struggled with this for a
bit in the second half of 2007 and then solved it, using a feature of
Buildout.

Buildout allows you to specify the versions of the dependencies you need
in a special section. The specification looks like this:

    [versions]
    grok = 0.14.1
    grokcore.component = 1.5.1

The versions specification can be maintained in a separate file (similar
to pip's requirements file), and indeed grokproject will automatically
install a file `versions.cfg` in your project that contains the versions
specification for anything you use in your package. These files can be
loaded from the filesystem or from URLs.

We publish these version lists on canonical URLs on
<http://grok.zope.org/releaseinfo> that grokproject automatically
inspects when you create a new project.

An important feature is that in _your_ project you can override which
versions you really want, and extend it with versions of other packages
that your project is using. Grok gives you its own list to reuse, but
doesn't force you to do so. This is possible because buildout has a
built-in feature for overriding sections. Note that such overrides
wouldn't work if you locked the versions down in the individual
`setup.py` files themselves.

When you want to upgrade an existing grok-based project to a new release
of Grok, you simply download the appropriate `versions.cfg` for that
Grok release into your project and re-run buildout. It will proceed to
download any new packages you may need and you're ready to go.
Alternatively you can just make your project point to the releaseinfo
URL directly (we used to do this by default), although that has the
drawback that you cannot re-run buildout while you are working offline.

## Who manages version requirements?

Ian Bicking wrote:

> Pip requirement files are an assertion of versions that work together.
> setup.py requirements (the Setuptools requirements) should contain two
> things: 1: all the libraries used by the distribution (without which
> there's no way it'll work) and 2: exclusions of the versions of those
> libraries that are known not to work. setup.py requirements should not
> be viewed as an assertion that by satisfying those requirements
> everything will work, just that it might work. Only the end developer,
> testing the system together, can figure out if it really works. Then
> pip gives you a way to record that working set (using pip freeze),
> separate from any single distribution or library.

I'll note that we've been managing the `setup.py` requirements in the
way that Ian recommends from the start. It should express which
libraries are needed and the minimum version requirements that the
developer writing the `setup.py` knows about.

Who however is the "end developer"? Would that be a developer that uses
a framework like Grok, or the developers of the framework itself? I
don't know whether Ian meant this, but let's define "end developer" as
the developer actually building an application for the sake of this
discussion.

Of course the end developer always makes the final determination whether
libraries work together. But reuse is possible here, and a project like
Grok wants to give the end developer as much help as we can.

One of the advantages of a framweork that's distributed as a single
large distribution containing many sub-packages like Django is that the
developers of the package can determine whether this subset really works
together, not the end developer that uses Django to build an app. There
is no chance someone will install a version of Django where subpackage
'a' doesn't work properly with subpackage 'b', unless the Django
developers themselves made a mistake.

Indeed the Zope project used to distribute Zope 3 this way (and we still
distribute it that way as an option), but we wanted more flexibility for
end developers to select their individual dependencies, and evolve
different parts of the project at different rates. We also wanted to
make it easier for others to use individual components developed by the
Zope project, so we split Zope up into a whole bunch of packages and
started distributing them that way. Now we've been plugging away at
unwinding all sorts of dependencies that grew up between many of our
supposedly independently reusable packages while we weren't looking, but
that's [another
story](http://compoundthinking.com/blog/index.php/2008/09/17/djangocon-and-learning-from-zope-2/).

If you have de-coupled packages, like Grok does, the burden of
maintaining which versions work well together should not fall solely on
the end developers that use a set of libraries. This would mean that
each developer that used Grok would need to figure out a large list of
versions, as Grok is composed from a large list of dependencies.

While I fully agree that it's important that end developers should
_have_ the ability to determine the exact version of each package if
they should want to, I think often they want to delegate this job to the
developers of a larger project (like Grok or Django) to determine what
combination is known to work.

We want people to be able to work together to determine the known-good
set. We don't want to force end developers to figure out which list of
versions to freeze each time they create a new project. We need to have
the ability to share these lists of frozen versions, work on them as a
team, and release them so others can reuse them, and potentially extend
and override them.

That's what we've doing with Grok for more than a year now. We maintain
lists of versions for the developers that use Grok, but we give our
users the opportunity to override and extend our choices should they
wish to do so.

From what I see pip's requirement file mechanism and bundle mechanism
get there part of the way, but I do not yet see patterns for delegating
the management of such requirements files to a project like Grok, while
still allowing individual developers to override these choices where
needed. Perhaps I'm missing something.

## The future?

Grok's current approach could be improved. When I build a framework on
top of Grok, I need to host a new requirements file for that new
framework as well on some URL. While it's possible to combine
requirement lists together into a larger list with Buildout's
mechanisms, it is a bit frustrating we are forced to have to maintain
such a separate infrastructure entirely independently from PyPI. It's an
extra release step too, making the entire release process that's
automated so nicely by distutils and setuptools more cumbersome again.

I think it would be useful to allow people to ship "known-good"
requirements _along_ with the distributions, and host these directly on
PyPI. Someone that uses a library will not be forced to use these
requirements, but can opt to do so if they wish. Requirement lists
should be able to build on and override other requirements lists. I
wrote down [some ideas on how this might
work](http://faassen.n--tree.net/blog/view/weblog/2007/09/26/0) in 2007.
Perhaps the people working on this problem today will find some of my
old thoughts useful, so if you're really interested in these topics,
please read the linked article.
