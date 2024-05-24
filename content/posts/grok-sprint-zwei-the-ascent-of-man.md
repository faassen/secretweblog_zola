+++
title = "Grok Sprint Zwei: the Ascent of Man"
date = 2007-01-09
slug = "grok-sprint-zwei-the-ascent-of-man"

[taxonomies]
tags = ["grok", "sprint"]
+++

Yesterday I returned from "Grok Sprint Zwei", the second grok sprint, hosted by
Philipp von Weitershausen in Dresden, Germany (and partially at Gocept for the
warming up). Grok is a project to make Zope 3 safe, easy and fun for cavemen
and other hominids like ourselves. Zope 3 of course is the powerful and
flexible framework for the construction of web applications. See
[here](@/posts/grok-or-what-i-did-on-my-holiday.md) for my initial introduction
of the Zope Grok project.

To summarize, Grok is an advanced alternate way to construct Zope 3
based applications that makes it possible to use the powerful Zope 3
component architecture (the glue that binds Zope 3 together) without
having to write lots of configuration code. Instead, we apply
"convention over configuration" to Zope 3. We aim for two things:

- developers can write simple Python code to make Zope 3 applications
- developers can still fully exploit the power of Zope 3 (object
  database, pluggability, authentication, virtual hosting support, etc,
  etc)

Besides a project, Grok is also a caveman. Here he is again, relaxing
after his work at the sprint:

[2024 note: image is sadly lost]

We had five people participating in the sprint. Everybody present at the
first sprint was back: Philipp von Weitershausen, Christian Theune,
Wolfgang Schnerring and myself. New at this sprint was Jan-Wijbrand
Kolman. Jan-Wijbrand and I go back a while by now; I've had the pleasure
to work with him for some years. More recently, after the first Grok
sprint, we have been doing regular work on Grok and Grok applications. I
was particularly happy he could make it to the second sprint, as he has
lots of experience with usability, and Grok is a (developer) usability
project.

The second Grok sprint was a success: we set ourselves goals and we
accomplished them. We also played lots of [Guitar
Hero](http://en.wikipedia.org/wiki/Guitar_hero) in the evening. :) The
major new things in Grok after this sprint are:

- security declarations for views. Views are public by default but you
  can now restrict access using permissions. This allows Grok to make
  use of Zope 3's advanced authentication/authorization support.

  In Grok, we deliberately turn off security for anything _but_ views
  (only security where your app faces the web), as we noticed that the
  standard pervasive Zope 3 security proyxing model can hinder rapid
  application development.

- local utility support. Local utilities can be used to do
  context-specific configuration and storage (such as the storage of an
  index). They are equivalent to CMF's tools. Utilities are looked up by
  interface which makes it easy to plug in new ones implementing the
  same interface. We now have an easy way to use local utilities.

  Concretely, this means Grok applications can now easily use powerful
  Zope 3 components such as the Zope 3 catalog for indexing of objects.

We think Grok now has enough features to start developing real world
applications. We could of course only go so quickly as we're exposing
existing Zope 3 features.

Since we're now ready with features, what remains to be done? One thing
we are going to continue to do is build real-world applications with
Grok. This will help us polish Grok further.

One of the main areas that is still lacking is documentation that tells
you how to use Grok, so we will be working on this now.

Another aspect we want to work on is a focused admin UI for Grok
applications. This is explicitly much more narrowly targeted than the
Zope Management Interface. The admin ui is aimed at developers and
admins to install and inspect Grok-based applications.

We hope to do an initial release of Grok within a few weeks. We are also
planning another sprint in april, where we plan to make Grok ready to
exit the cave and step into the wide world, club in hand and smile on
his face - ready for the ascent.
