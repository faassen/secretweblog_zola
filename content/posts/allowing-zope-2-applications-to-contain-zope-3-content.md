+++
title = "Allowing Zope 2 applications to contain Zope 3 content"
date = 2008-01-30
slug = "allowing-zope-2-applications-to-contain-zope-3-content"

[taxonomies]
tags = ["zope"]
+++

Five, the system to use Zope 3 within Zope 2, is a pain sometimes. Five
is full of hacks to ensure backwards compatibility with Zope 2. This
stops developers from using full-fledged Zope 3 strategies in places.

How could we make this pain go away?

The main reason these hacks in Five are necessary is acquisition.
Acquisition in turn is necessary to support the construction of URLs,
and most importantly, to look up security information. There has been
long-standing work on a branch of Zope 2 to make acquisition also
inspect the \_\_parent\_\_ attribute. This should help make some of the
hacks go away.

Five so far is about everything Zope 3 _except_ content objects. You can
do just about anything Zope 3 can with Zope 2, except store plain,
simple, Zope 3 content objects. I think if we added the ability to store
Zope 3 content objects to Zope 2, we could take a leap forward in
merging the two platforms. Suddenly just about any Zope 3 application
could be hosted in Zope 2. Existing Zope 2 applications (such as Plone)
could be extended with pure Zope 3 code. You'd be able to use things
like Grok more or less out of the box, say. You can start thinking about
gradual content migrations over multiple releases of your applications
towards a pure Zope 3 platform.

I'll sketch out what I think would need to be done to make this
possible. It's likely I'm missing some complexities, and perhaps I
overestimate some other complexities. My hope is that some of the
readers of this post will be stimulated into doing some experiments...

What would be required to let Zope 2 host Zope 3 content objects? Let's
first catalog what we already have (so no work is needed):

- code: we're shipping the Zope 3 codebase with Zope 2, so that's all
  already there.
- zodb: Zope 3 and Zope 2 content objects can share the same ZODB.

Now let's look at what's almost there:

- no more acquisition: we can look up Zope 2's security infrastructure
  using \_\_parent\_\_ references, without acquisition (the branch I
  mentioned).

What needs to be done?

- storage: we need to extend Zope's folder so you can store a Zope 3
  content object in it without any harm. Mixing it with Zope 2 objects
  would be nicest, but if that isn't available, two separate pools of
  objects would do for now.
- publishing: we need to make sure that as soon as someone traverses to
  a Zope 3 object, the Zope 3 publisher kicks in. We'd leave the Zope 2
  publisher completely behind. Initializing the Zope 3 publisher into
  the right state is going to be tricky. It's likely we need to amend
  Zope 2's request object so the Zope 3 publisher has everything it
  needs.
- security: we likely need a custom Zope 3 publisher so it can do
  view-level security checks, much like Grok does. We probably need some
  mix of Zope 2 security information and Zope 3 security information to
  determine whether someone has access. That's going to require some
  thought. Trying to make the whole Zope 3 security proxy machinery work
  would be more trouble, so I'd recommend skipping that step for now. I
  expect the combining of security systems would be the trickiest parts.
  Perhaps there are good ways to sidestep this issue.
- directives: Five works in part by reimplementing some of Zope 3's
  directives to make them work for Zope 2. Unfortunately the _original_
  version of the directives would need to be used to support pure Zope 3
  content. Possibly both sets of directives can be supported by
  migrating Five's registrations to a new namespace. It's going to break
  all existing Five-based ZCML. That ZCML should however be easily
  fixable by using the Five-specific namespace
  (<http://namespaces.zope.org/browser_five>, say) where needed. This
  namespace would have all registrations for
  <http://namespaces.zope.org/browser>, with special Five versions for
  those directives that need it.

Again, I hope these thoughts will set some people thinking...
