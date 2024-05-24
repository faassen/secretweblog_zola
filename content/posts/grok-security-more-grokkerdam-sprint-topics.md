+++
title = "Grok security: more Grokkerdam sprint topics"
date = 2008-04-17
slug = "grok-security-more-grokkerdam-sprint-topics"

[taxonomies]
tags = ["grok", "sprint"]
+++

# Grok security: more Grokkerdam sprint topics

In my [previous
article](http://faassen.n--tree.net/blog/view/weblog/2008/04/11/0) on
the [Grokkerdam](http://wiki.zope.org/grok/GrokkerdamSprint) sprint, I
discussed various topics people may want to work on during the sprint.
This blog entry is dedicated to some more topics, all security-related.

## Easier authentication

Zope 3, and thus Grok, offers a flexible infrastructure for
authentication of users and groups. It's actually very nice to have this
flexibility: just a couple of weeks ago I could quite quickly write a
bit of code that authenticates a user against a relational database
table, for instance.

Unfortunately, this flexibility also has the usual price: it takes some
time and effort to figure out how it works. It would be nice if Grok had
some default authentication setup that was just *there*. It should let
you manage users (in the ZODB) and let them log in. Then you can move on
with the more important parts of your application, and you don't have to
spend time building a user interface for user management when the basics
of your application doesn't even work yet. The flexibility you need
should still be there later, of course.

Some experiments towards improving the default authentication story for
Grok have resulted in the
[LoginDemo](http://svn.zope.org/grokapps/LoginDemo/) and
[PlainLoginDemo](http://svn.zope.org/grokapps/PlainLoginDemo/) demo
applications, which are certainly worth studying.

## Easier authorization

Authentication is one thing, authorization another. Zope offers a
powerful security infrastructure. The model is based on permissions, and
principals. For "principal" just read "user" (it can also be a group).
The lowest level security check in Zope is just whether a principal has
a permission on a certain object.

On top of this, a security policy is built. The security policy is
pluggable, meaning you can write application-specific security
politicies if you want. The default security policy of Zope 3 and Grok
lets you assign permissions locally, that is, on a per-object basis, and
offers other features, such as roles. It's also pluggable - to find out
what permissions a principal has on an object it uses an adapter
(`IPrincipalPermissionMap`), and you can plug in special adapters for
your own objects, which is very handy sometimes.

Assigning roles and permissions is not particularly hard, and it's not
very hard to check whether someone has a permission either. I think we
could already improve the authorization story a lot if we simply
documented best practice patterns on how one uses the default security
policy in Grok. This would make a good sprint task.

## Skin-based security

Grok offers a skin concept. You can put your views for an object in a
namespace called a *skin* and then trigger the use of this namespace in
the URL (++skin++foo), or in code. A skin presents all views available
in a *layer*. Views can be associated with a layer, causing these views
to be in those skins that use this layer. Layers are interfaces, and
this means a layer can inherit from another one, or be composed from
multiple smaller layers.

Skins allow you to build multiple UIs for your application. For a CMS
application you could for instance have one (default) skin to present
your public website, and another skin that lets you edit your content.

All this is already there in Grok. One thing we could get better at is
skin-based security. It would nice if you can exactly control what views
your web application exposes to the world. The default views that some
Zope 3 package supply for various objects may not at all be what you
want to expose to the world. In many cases, for security reasons, you
only want to show the views that you defined in your application's code,
and not expose any other URLs in your applications.

Skins may be able to help with this. If a skin used a layer that didn't
inherit from any other layer (not even the default one), and you then
tell your application to only let users access content in that skin, you
are precisely controlling what views a user is able to accesss. At the
sprint, it would be good if we could figure out how to make this
straightforward with Grok. We need to experiment with this approach, and
write some tests that check whether our assumptions are correct. We also
need to make sure Grok doesn't break when we block all other views -
some are probably essential for the operation of the application.

## Model-based security

Zope 3 offers an extensive infrastructure for model-based security out
of the box. You can specify in ZCML what permissions are needed to
access which methods and attributes of an object. Zope then takes care
at a low level that code running for a particular principal (triggered
by the current web request) cannot access, or even see, those methods or
attributes. It does this by wrapping objects in otherwise-transparent
security proxies.

All this sounds like a great way to accomplish security by default in
your application. You have a fine grained way to allow the user to
access various methods and attributes. This should help you catch
security problems in your application. You cannot actually call a method
before you give it a permission, and in fact you might get an
`AttributeError` if you try to access an attribute when you don't have
permission to. You first need to write some ZCML assigning permissions
to be able to do that.

Unfortunately all this is also a great way to make development less
agile than it should be. It can slow you down quite a bit if you have to
start writing security declarations right away, at the start of
development. You then have to maintain them throughout the evolution of
your application. Early on in development many developer typically don't
really know yet what permissions would go with what methods. I don't
even know what methods there are yet. Or what *classes* there are.

Since I also don't know exactly what permissions I'd want in my
application yet, I'd be tempted to just declare everything public, so I
can see something in my web browser. There goes the idea of security by
default - if I forget to give something the right permission later on,
everything in my application will appear to work correctly, except that
people might have access to things they have no business to. The only
thing I ended up doing is typing up a lot of ZCML security declarations
just to make my application work. It's also not very nice to have to
tell a beginner about all this when they just want to present "Hello
world" on the screen.

Because you sometimes really want to be able to call a method and don't
have time to figure out why the security proxies aren't letting you
*this* time, or even if you know, don't have time to refactor the
application so it is right and proper with security, people sometimes
remove proxies manually in order to do this. Security by default once
again actually may end up making you less secure.

Security-proxies spread around, a bit like acquisition wrappers in Zope
2. This probably sounds rather worrying to those who have worked with
Zope 2 acquisition. With Zope 2 implicit acquisition, your objects
suddenly have attributes that are not really theirs. With Zope 3
security proxies, your objects appear to *lack* attributes that the user
you are logged in as doesn't have the permission for. Your object also
lacks those attributes that you haven't actually declared the permission
for yet. The declarations are off in some ZCML file, so it's not
immediately obvious what has a permission and what is lacking. Also
similar to acquisition is that, at least with the default security
policy, an object without a parent connection is forbidden to be used at
all. All this can cause quite a bit of frustration during development.

Finally, after all this, security proxies don't atually wrap
*everything*: some common operations actually result in content-objects
that aren't proxies. If you use a catalog index to look up objects you
actually get unproxied objects back. Suddenly, no security checks are
taking place at all. Just when you were used to them.

With Grok, we decided to get rid of security proxies entirely, much
simplifying the life of a developer. Security proxies make for bad
usability for developers. Instead, Grok offers security per view, not
per model. You can say which permission a user needs to have in order to
see a view. The full pluggable security model of Zope 3 still works, but
if you aren't satisfied with the automatic view-level checks you will
have to check permissions by hand in your code. This is much simpler to
work with than Zope 3's security proxy model, and it's still likely more
powerful than what just about any other web framework offers out of the
box.

After all this negativity about security proxies, I might surprise you
and put security proxies back on the table. Model-based security
certainly has benefits - views can be left entirely public, but since
they can't access any models that that the user doesn't have access to,
your application remains safe. Some of the drawbacks of Zope 3's
approach also have to do with ZCML - your security declarations are off
in some other file away from your code. If we brought the security
declarations closer to the code itself again, things will likely be
clearer. Maybe we can also come up with ways to make the addition of
model-based security more incremental in an application. Even if
maintaining this stuff too early on during development is a major pain,
it might be very valuable to have the ability to do model-based security
later in the evolution of the application. At the sprint, perhaps we can
think of ways to tame model-based security and add it to Grok.
