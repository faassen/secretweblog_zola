+++
title = "What Zope can learn from Zope"
date = 2008-09-19
slug = "what-zope-can-learn-from-zope"

[taxonomies]
tags = ["zope"]
+++

# What Zope can learn from Zope

So we've had [what Django can learn from
Zope](http://compoundthinking.com/blog/index.php/2008/09/17/djangocon-and-learning-from-zope-2/),
[what Zope can learn from
Mozilla](http://philikon.wordpress.com/2008/09/17/what-zope-can-learn-from-mozilla/),
and a few years ago already we had [what Zope can learn from Ruby on
Rails](http://faassen.n--tree.net/blog/view/weblog/2005/04/06/0). (and
www.zope.org still sucks, but grok.zope.org and repoze.org don't)

Since the Zope of almost a decade ago was mentioned by a TurboGears guy
in a negative light to a Django audience a few of course took this
opportunity to bash Zope, as the word Zope is like a red flag. Zope has
accumulated long, rich history of good and bad ideas, so we must present
a tempting target.

Zope can learn from Django, and is of course doing so. We've been around
for a decade and you aren't around for that long if you don't learn and
adapt.

Let's now talk about what Zope can learn from Zope itself. How can that
be?

## The Past from the Future

The obvious way for Zope to learn from Zope is for the past to learn
from the future. We've presumably learned some things over time, after
all. What could the old Zope 1 and Zope 2 hackers have learned from
modern web development with Zope 3, Repoze, and Grok?

### Filesystem development

Zope 2 has a user interface in which software development can take
place. Limited, untrusted Python code is stored in the object database.
This has two major drawbacks:

- it's Python, but Python with a few twists: untrusted so normal imports
  and operations are not always possible, and implicit acquisition
  pulling things in everywhere. This sucks, we want to use Python the
  way it is designed to be.
- you can't use normal file system tools to manage your code. Instead
  you have to use the web browser UI. That still isn't ideal even with
  modern AJAX goodness, and certainly wasn't ideal in 1999. It means
  reimplementing all the tools that already exists (editors, version
  control systems, searching, etc) on top of Zope. This was an
  attractive effort that many in the Zope community undertook, and most
  of that work is now lost.

Zope 2 development through the filesystem was also possible, but it has
a completely different development model than the through the web
development, and this accounts for part of the infamous Z-shaped
learning curve of Zope 2.

Zope 3, and Grok, have filesystem-based development only. You just write
normal Python code in normal Python modules which reside in normal
Python packages. You use your favorite editor, and your favorite version
control system.

### Fine-grained components

Zope 2 introduced a powerful component programming model. Zope 2 is
extensible through so-called *Products*, which often were used to create
new ways to help developers program in the web UI. As an example, one
product I wrote back in 2001 is called Formulator, which helps people
construct web forms by putting together fields in the Zope UI.

Unfortunately Zope 2 components are rather coarse-grained. Single Zope 2
components would have to inherit from a lot of mixin classes in order to
play within the Zope 2 framework, fattening up their APIs to
unmanageable sizes. Components would be so coarse-grained it became hard
to reuse them in other contexts, as they would make assumptions that
were hard to override. It was hard to just use Formulator's widget
classes and not its Form class for instance.

Zope 3 instead has a powerful component model that allows for
fine-grained components. These components define interfaces which
typically only provide a few methods, and this allows for
loosely-coupled development and true reusable components. We distribute
these components in many separate packages, which allows for a lot of
flexibility - application developers may choose not to use some.

## The Future from the Past

Now let's turn it around and consider what Zope 3 can learn from Zope 2.
What can we learn from the successes of our past? What have we lost?
What should we bring back?

### A user-interface

So the Zope 2 user interface has drawbacks for developers. It locks code
into a hard to manage Zope-only format. It was also Zope 2's killer
feature.

Zope 2's through the web user interface contributed enormously to Zope
2's success. Zope 2 was being adopted by non-Python programmers who
discovered they could be very productive using the Zope 2 UI. These
developers often turned into full-fledged Python programmers later on.

A user interface offers discoverability: in Zope 2 you get a drop-down
list of components you could add to your object database. See an
unfamiliar one? Just try creating one of those, see what UI options it
presents, and click the "help" button. The UI encouraged experimentation
and learning.

The Zope 2 UI also allows less hardcore developers to easily tweak
layouts here and there and do a bit of simple scripting.

The Zope 2 UI was also used as a crude CMS and often extended to build
simple CMSes that were still quite powerful for their time. In this
sense the Zope 2 UI was quite similar to the admin UI that is one of the
killer features of Django.

Zope 3 has lost almost all of this. Zope 3 does have a UI modeled after
Zope 2's, but it's rarely used. Zope 3's UI was intentionally cripped
compared to Zope 2's to prevent unmaintainable code to be created, and
some ideas existed for checking out code from the object database for
development on the filesystem, but it never really went anywhere. As a
result Zope 3 is only approachable for Python developers, and is harder
for beginners to pick up.

Grok has made Zope 3 a lot more approachable already, and I think is
competitive with the other modern Python web frameworks, but a user
interface could bring many more people in beyond this.

The Zope 2 UI had the drawback that it was all UIs in one, and did none
of them very well as a result. I think we should work on bringing back
most of the features of the Zope 2 UI back to Zope 3:

- an introspector UI. See what content objects are stored in your
  database, what APIs they offer, what views exist for them. There is a
  Zope 3 apidoc tool that does this. In addition, the Grok introspector
  was developed in last year's summer of code, and more work on it was
  done in this year's summer of code.
- a management UI: install, uninstall, configure and monitor
  applications and the server. Grok has a simple UI that allows you to
  do this. There is also the ZAM effort.
- a through the web development UI: we shouldn't be thinking about a
  full-fledged IDE here. This one should be tackled carefully, step by
  step. Tweaking page templates is something that could be presented in
  a UI quite well, for instance. Some work to this effect was done in
  the `five.customerize` package.
- an "editing backend" - it would offer navigation through the object
  tree, would display the contents of containers and would allow
  form-based editing of schema-driven contents. This would help provide
  a "good enough" solution for many applications that need some form of
  editing backend.

A component with a user interface starts to look like the coarse grained
components of Zope 2. We should therefore be careful: the user interface
should be easily replaceable and de-installable. We shouldn't be locked
into it, but it should be there when we need it.

The good news is that many of the pieces are already in place for this
work, and we should continue these efforts.
