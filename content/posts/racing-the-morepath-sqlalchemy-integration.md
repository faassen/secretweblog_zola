+++
title = "Racing the Morepath: SQLAlchemy Integration"
date = 2014-02-27
slug = "racing-the-morepath-sqlalchemy-integration"

[taxonomies]
tags = ["planetpython", "python", "morepath", "pyramid"]
+++

I felt like I was *racing* on the Morepath today. My goal was to see how
to integrate Morepath with a database. To make this goal practical, I
looked into integrating Morepath with SQLAlchemy. To go faster, I
borrowed ideas and code liberally from Pyramid.

# Tweens

This morning I borrowed the idea of
[tweens](http://docs.pylonsproject.org/projects/pyramid/en/latest/narr/hooks.html#registering-tweens)
from Pyramid. A tween is basically much like a WSGI framework component,
but one that knows about the web framework -- it gets the web
framework's request, and it can send the web framework's response, among
other things. Now you can write this with Morepath:

``` python
@app.tween_factory()
def get_tween_factory(app, handler):
    def wrapping_handler(request, mount):
         reponse = handler(request, mount)
         response.headers['foo'] = 'bar'
         return response
    return wrapping_handler
```

You can plug in a function that generate a wrapper around the original
request handler.

# more.transaction

This allows all sorts of neat stuff, including, for Pyramid,
[pyramid_tm](http://docs.pylonsproject.org/projects/pyramid_tm/en/latest/),
which integrates Pyramid with the
[transaction](https://pypi.python.org/pypi/transaction) module.

So I ported over this code to Morepath in the form of
[more.transaction](https://github.com/morepath/more.transaction).

To use it in your Morepath app, simply do:

``` python
from more.transaction import transaction_app

app = morepath.App(extends=[transaction_app])
```

What happens now? Morepath will automatically commit the transaction if
there is no error (like a 500 error, say).

This means that Morepath now has integration with databases that use the
transaction module, such as the ZODB and also SQLALchemy (using
[zope.sqlalchemy](https://pypi.python.org/pypi/zope.sqlalchemy) for
transaction integration).

\[update after someone blindly complains after seeing the word "zope" in
a package name... Please don't do that.\]

Moreover, you can use *multiple* such databases in the same application.
You can modify the ZODB and a relational database in an application, and
be secure that if anything fails during the request handling, *none* of
the databases will changed -- both transactions will be aborted. There's
a lot of
[goodness](http://zodb.readthedocs.org/en/latest/transactions.html) in
the transaction module.

# Morepath settings infrastructure

It turns out pyramid_tm is configurable in various ways. It allows you
to set the number of attempts it will try to commit in the face of
conflicts, for instance. To support this, I had to build Morepath's
settings infrastructure; just the part where you can have settings at
all, not loading them from a config file -- that's for later.

Here's an example of the settings for the transaction app in
more.transaction:

``` python
@app.setting_section(section='transaction')
def get_transaction_settings():
    return {
        'attempts': 1,
        'commit_veto': default_commit_veto
        }
```

These are the defaults defined by more.transaction, but they can be
easily overridden in your own app (by writing the same code as above
with different values for the configuration).

When I started to write Morepath's settings infrastructure I wrote quite
a bit of code involving combining and extending settings, only to throw
it away by replacing it with much shorter code that builds on Morepath's
config engine that I already use for its other directives. Nice!

# morepath_sqlalchemy

Now that I had all the pieces I needed to put them together to
demonstrate SQLAlchemy integration:
[morepath_sqlalchemy](https://github.com/morepath/morepath_sqlalchemy).

This uses more.transaction, zope.sqlalchemy and SQLAlchemy together.
It's all done
[here](https://github.com/morepath/morepath_sqlalchemy/blob/master/morepath_sqlalchemy/main.py),
but I'll summarize the important bits of integration here:

``` python
from sqlalchemy.orm import scoped_session, sessionmaker
# SQLAlchemy session
Session = scoped_session(sessionmaker())

from zope.sqlalchemy import register
# register session with transaction module
register(Session)

import morepath
from more.transaction import transaction_app

# create our app, extending transaction_app.
# this means we get Morepath transaction integration
# and default settings for it.
app = morepath.App(extends=[transaction_app])
```

# Quite a day

It's all still rough, needs polishing and documenting, but the
foundations are now there. Quite the day of coding! I couldn't have done
it without the Pyramid project from which I could borrow many an idea
and piece of code.

Now I know Morepath can be integrated with any kind of database -- if
transaction module integration is there, like for SQLAlchemy and the
ZODB, it is *very* easy: just use more.transaction. But even if not, it
should now be possible to write a tween that does the trick.

Tweens allow other neat things too: I think I saw Pyramid's custom error
view system is based on a tween, and I still need [custom error
views](https://github.com/morepath/morepath/issues/15) in Morepath...

Interested? Hope to hear from you! Join \#morepath on freenode IRC, drop
me an email, or leave a comment on the [issue
tracker](https://github.com/morepath/morepath/issues?milestone=1&state=open).
