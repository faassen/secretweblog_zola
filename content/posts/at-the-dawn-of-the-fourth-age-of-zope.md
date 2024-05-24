+++
title = "At the Dawn of the Fourth Age of Zope"
date = 2007-11-15
slug = "at-the-dawn-of-the-fourth-age-of-zope"

[taxonomies]
tags = ["zope", "silva", "plone"]
+++

Some years ago, in 2004, I came up with the following quote to promote
the Five project, which was the first step towards the inclusion of Zope
3 technologies in Zope 2. Zope 3 technologies are now heavily used in
Zope 2 projects, and Zope 3 code has been part of Zope 2 for a while
now, but back then we were just at the start of this process. The quote
itself was creatively adapted from the first season intro of Babylon 5,
a 90s scifi TV show:

_"It was the dawn of the third age of Zope. The Five project was a dream
given form. Its goal: to use Zope 3 technologies in Zope 2.x by creating
a Zope 2 product where Zope 3 and Zope 2 could work out their
differences peacefully."_

I realized today we are now at the dawn of a new age of Zope: the fourth
age.

What are the ages of Zope? A community needs its mythology, its history
and storytelling, so let's tell them to each other and everybody else.

**Zope's First Age: The Age of Through-the-web Development.
(1998-2001)**

In 1998, Digital Creations (now Zope Corporation) open sourced their
Principia web application platform, renaming it to Zope. This open
sourcing was a rather unprecedented move for the times and drew much
attention from the press. The web was hot, and the Zope community grew
quickly.

It was an age of discovery and exploration. Much of Zope development was
done using the Zope Management Interface (ZMI) and through the web.
People would write DTML templates, ZSQL expressions, later ZPT templates
and Python Scripts in a web browser to put together web applications.
You could also install so called "Products" to extend Zope with new
features, but how exactly to do this remained a mystery to most members
of the community.

**Zope's Second Age: The Age of Product Development (2001-2004)**

Slowly the Zope community started to figure out how to do Product
development. A Zope "Product" is basically a special kind of Python
package you can install in a special place to have Zope pick it up. A
Product can register new content types with Zope. These could be used to
extend the ZMI development platform's abilities. This age saw the rise
of the CMF, the Content Management Framework, which worked this way.

More and more also we saw the creation of whole new applications in
Product form. The major CMS projects of Zope, such as Plone and Silva,
started somewhere in this age.

The second age also saw the start of the Zope 3 project, an undertaking
to rewrite the Zope platform taking into account the lessons learned
from Zope 2. At this time we did not yet know what shape Zope 3 would
eventually take. "Zope 3" shows we were still expecting a pattern of
replacement: Zope 3 would be a successor that would replace our Zope 2,
and we'd somehow move our code over to the new platform. It didn't
happen that way.

The second age was an age of building. It was in many ways an age of
diversification and parting of the ways. Different projects building on
Zope would move in quite different directions and the community started
breaking apart into different sub-communities with their related but
slightly different ways of doing things.

**Zope's Third Age: The Age of Zope 3 Technologies. (2004-2007)**

The Zope 3 platform developed and matured, and the first applications
started to be developed on this platform. It was realized that it would
not be a clean successor to Zope 2. Zope 2 was there to stay. Instead,
the community started integrating the Zope 3 technologies within Zope 2
itself, starting with the Five project.

This was an age of a coming together of ways. The different
sub-communities started sharing more again. The main way this was done
was through the increased use of Zope 3 technology: the Plone, Silva
projects, and Zope 2 and CMF themselves, started integrating Zope 3
technologies heavily into their codebases.

**Zope's Fourth Age: the Age of the Rebirth of Zope (2007-)**

During the third age, outside the Zope world, other web technologies had
started to become more and more popular. Projects like Ruby on Rails,
Django, TurboGears and Pylons started gathering significant mindshare.

Zope would have to adapt, reinvent itself, or be consigned to
irrelevance. This process of adaptation had been long underway with the
Zope 3 project. The previous ages have shown that the Zope community has
a magnificent ability to adapt itself.

It was now time to apply the lessons from the competition: start to
actively reach out to the outside world. Communicate better. Accomplish
the goal we set out to reach long ago with Zope 3: to work with the
broader Python community instead of being isolated in our own community.

This is the age we find ourselves in today. It is the age of the
eggification of Zope 3, and slowly also Zope 2: the splitting up of Zope
technologies into more independently reusable and evolvable packages,
using common Python technologies such as setuptools and the Python
package index. It is the age of WSGI, allowing Zope to be integrated
with other Python web technologies more easily.

The [Grok](http://grok.zope.org) project set out to make Zope 3
technologies more easy to use for beginners and experts alike. The
[Repoze](http://repoze.org/) project set out to bring Zope 2 kicking and
screaming into the modern egg and WSGI age. We are taking a fresh new
look at ourselves.

We are just at the dawn of this new fourth age. We still need to
drastically improve both the quality and quantity of our communication
with the rest of the world. We need to reach out to the world and say
"Zope is back. It is new again, reforged, but forged within it are
hard-earned lessons of the past. Please come and join us."

I hope the effort of the fourth age will be successful, and that many
newcomers will join the Zope community in the next years. Who knows what
the fifth age will bring us? In a large part, it will be up to the
newcomers.
