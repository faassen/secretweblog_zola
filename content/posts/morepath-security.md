+++
title = "Morepath Security"
date = 2014-01-07
slug = "morepath-security"

[taxonomies]
tags = ["planetpython", "python", "morepath"]
+++

In this post I'd like to discuss the security infrastructure of the
[Morepath](http://morepath.readthedocs.org) web framework. I hope that I
can showcase some of the interesting features of Morepath security,
generate a bit of feedback for me, and also serve as the start of
documentation on this topic. Finally, it's also useful for me to get an
overview of where gaps in my implementation still exist.

# What it should do

So what do I mean by "security"? I mean infrastructure in the Morepath
web framework that helps you make sure that the web resources published
by your application are only accessible by those people who are allowed
to by your application. If you're not allowed you'll get a HTTP error.

Right now that error is HTTP Unauthorized (401) but I think I'll shortly
change it to make it HTTP Forbidden (403), and make HTTP Unauthorized
optional when HTTP Basic Authentication is in use. But I need to add a
bit of infrastructure to make that possible first.

# What does this look like in practice?

First we need to make sure that the application has an *identity
policy*: a system that takes the HTTP request and established a claimed
identity for it. For basic authentication for instance it will extract
the username and password. The claimed identity can be accessed by
looking at the `identity` attribute on the request object.

This is how you install an identity policy into a Morepath app:

``` python
from morepath.security import BasicAuthIdentityPolicy

@app.identity_policy()
def get_identity_policy():
    return BasicAuthIdentityPolicy()
```

Let's say we want two permissions in our application, view and edit. We
define those as plain Python classes:

``` python
class ViewPermission(object):
    pass

class EditPermission(object):
    pass
```

Since they're classes they could even inherit from each other and form
some kind of permission hierarchy, but we'll keep things simple here.

Now we can protect views with those permissions. Let's say we have a
`Document` model that we can view and edit:

``` python
@app.html(model=Document, permission=ViewPermission)
def document_view(request, model):
    return "<p>The title is: %s</p>" % model.title

@app.html(model=Document, permission=EditPermission)
def document_edit(request, model):
    return "some kind of edit form"
```

This says that we only want to allow access to `document_view` if the
identity has `ViewPermission` on the `Document` model, and only allow
access to `document_edit` if the identity has `EditPermission` on the
`Document` model.

But how do we establish permissions for models at all? We can do this
with the `permission` directive. Let's give absolutely everybody view
permission:

``` python
@app.permission(model=Document, permission=ViewPermission)
def document_view_permission(identity, model, permission)
    return True
```

We can implement any permission policy we like. Let's say a user has
`EditPermission` on `Document` if it's in a list `allowed_users` on that
document:

``` python
@app.permission(model=Document, permission=EditPermission)
def document_edit_permission(identity, model, permission):
    return identity.userid in model.allowed_users
```

# Morepath Super Powers Go!

What if we don't want to have to define permissions on a per-model
basis? In our application, we may have a *generic* way to check for the
edit permission. We can easily do it with Morepath, as it knows about
inheritance:

``` python
@app.permission(model=object, permission=EditPermission)
def has_edit_permission(identity, model, permission):
    return has_generic_edit_permission(identity, model)
```

This permission function is registered for model `object`, so will be
valid for *all* models in our application. We can of course still make
exceptions for particular models:

``` python
@app.permission(model=SpecialModel, permission=EditPermission)
def special_model_edit_permission(identity, model, permission):
    return exceptional_edit_permission_check(identity, model)
```

Variation is not only on model, but can also on permission or identity.
For instance, we can register a permission policy for when the user has
not logged in yet, i.e. has no claimed identity:

``` python
@app.permission(model=object, permission=EditPermission, identity=None)
def has_edit_permission_not_logged_in(identity, model, permission):
    return False
```

This permission check works in addition to the ones we specified above.
In short you can be as generic or specific as you like.

# Login forms

We've tackled a lot, but not yet how a user actually logs in to
establish an identity in the first place. We need a view that gets
triggered when the user logs in, for instance by submitting a login
form. I'll sketch out some code here to give you an idea:

``` python
import morepath

@app.root()
class Root(object):
    pass

@app.html(model=Root, name='login')
def login_attempt(request, model):
    username = request.form['username']
    password = request.form['password']
    # check whether user has password, using password hash and database
    if not user_has_password(username, password):
        return "Sorry, login failed"
    # okay, user is known, so modify response remembering that user
    @request.after
    def remember_security(response):
        # create identity object
        identity = morepath.Identity(username)
        # modifies response, setting identity
        morepath.remember(response, request, identity)
   # redirect to original page after successful login attempt
   return morepath.redirect(request.form['came_from'])
```

This would work well for session, cookie or ticket-based authentication:
after the identity is established once it is remembered on the response
object, so that it is automatically sent with each new request.

For HTTP basic authentication this form-based authentication approach
wouldn't work, of course. We'd instead need to issue a HTTP Unauthorized
response, causing the browser to ask the user for a username/password
combination, which it would then send along for each subsequent request.
The `remember` operation is a no-op for basic auth.

Note: Currently this is in fact broken code as I haven't enabled the
implicit generic function implementation lookup yet for Morepath
implementations. It's an easy fix as I have the infrastructure for it in
[Reg](http://reg.readthedocs.org), but I need to add it to my todo list.

# Theory: Identity/permits

Security in Morepath has two parts:

- establish someone's claimed *identity*.
- use that claimed identity to see whether access to a Morepath view is
  *permitted*.

This looks very much like, but isn't quite, a separation between
authentication and authorization. There are subtle differences.

Establishing identity only establishes a *claimed* identity and does not
verify (with, say, a database), that this identity is in fact still
recognized by the system (the user may be removed), or that this
identity is even as it is claimed.

In the case of some identity policies and some applications this is in
fact enough: if someone manages to claim an identity, then it *is* the
identity, without the need to access a database. This is for instance
the case with cryptographic ticket based authentication systems such as
the one implemented by
[mod_auth_tkt](http://www.openfusion.com.au/labs/mod_auth_tkt/). If
someone comes along with the right encrypted auth tkt cookie, we know
that's the identity we gave to this user earlier when they first logged
in. No database verification check is needed.

Then there's the next step: to see whether a claimed identity is
permitted to access a view on a model. This can be seen as the
authorization step, and will normally have to access some kind of
database to do so. It may however do something in addition when
accessing the database: verify that the claimed identity is still valid.
This is done in this step because it can sometimes be established
whether someone has access *and* whether the claimed identity is valid
by a single database query.

What have these changes accomplished? We've made sure that establishing
a claimed identity can be done without touching a database; only
checking whether that identity is permitted something has to touch a
database, possibly only once.

I'm grateful to Chris McDonough, creator of the Pyramid web framework,
who wrote a [very useful
postmortem](http://plope.com/pyramid_auth_design_api_postmortem) on
Pyramid's design and what he'd do differently if he could change things.
That was extremely useful when I come up with Morepath's security
system, so thanks again, Chris! Also inspirational was my long
familiarity with Zope's security system, and I hope to have distilled
some of it down to the minimum. Of course anything I got wrong is my own
fault.

# Identity Verification?

I think the case of Morepath it would in fact be easy to let users
specify an app-specific `verify` function, which will be called with the
identity and *can* use the database to establish whether an identity is
claimed. This would be easy to integrate into Morepath, and doesn't
require the miniframeworks that Chris bother him in his postmortem. It
could look like this (for something like basic auth):

``` python
@app.function(generic.verify, object)
def verify_identity(identity):
     return validate_password(identity.userid, identity.password)
```

I could add a bit of sugar for this in the form of a directive:

``` python
@app.verify()
def verify_identity(identity):
     return validate_password(identity.userid, identity.password)
```

The default verify would just return `True`, so it would still work for
identity policies and applications that have no need for identity
verification. Identification verification would *not* be part of
identity policy, but part of Morepath's security infrastructure, as it
would be entirely application specific.

# More identity policies

Right now Morepath implements only a single identity policy, and that's
`BasicAuthIdentityPolicy` for HTTP basic auth. I hope I will get time in
the future to port some of the more interesting functionality from
Pyramid's `authentication` module; the `AuthTktAuthenticationPolicy`
looks interesting in particular. These could then be made available in a
Morepath extension module. If *you* are interested in helping this
porting activity I'd be thrilled though -- get in touch with me, please!

# Conclusion

I'm pretty pleased with the flexibility of the Morepath security system:
you can be fine-grained or generic when you need to. It's all built on
top of the Morepath foundations of directive-based configuration and Reg
generic functions, and it fits.

The identity system should be able to cope well with any kind of
authentication system you can throw at it, allowing you to write generic
code and swapping in a different one with ease. The only oddball is the
perennial exception of HTTP Basic Auth, but at least Morepath can deal
with it.

There may seem to be many concepts involved at first, but I think in
fact they've been kept down to an amount that you can still keep in your
head after you get used to it.

I hope to get feedback on this, and I also hope people will play with
it, so we can smoothen out any kinks quickly. Please let me know what
you think! Join the \#morepath IRC channel on freenode!
