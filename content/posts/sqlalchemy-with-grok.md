+++
title = "SQLAlchemy with Grok"
date = 2008-04-08
slug = "sqlalchemy-with-grok"

[taxonomies]
tags = ["grok", "sqlalchemy"]
+++

Grok needs a great relational database integration story. Grok already
has a great database story: by default, we use an object database: the
ZODB. The ZODB is great as you can just store normal Python objects. You
can persist complicated nested structures easily. But this entry isn't
about the ZODB. Relational databases are also great. You can query
tables every which way very easily. You can manage your data in a RDMS,
a familiar system for many, and integrate with existing RDMS that
already exist in many places.

Thanks to object relational mappers (ORMs), working with relational
databases has become pretty easy as well. Python has a number of object
relational wrappers available for it. Recently I started a project that
uses Grok with a relational database. It was a good opportunity to
investigate this topic more deeply, keeping in mind what might be useful
for Grok. I evaluated two object relational mappers: Storm and
SQLAlchemy. I don't claim to have done anything like an in-depth
technical evaluation. I didn't. I don't believe there are many technical
reasons to choose one or the other. In the end I went with SQLAlchemy
for this project. I think it would make a good default integration story
for Grok.

I looked at Storm. Storm is nice, and is used by two large parties in
the Zope community: Canonical (where it originated) and Lovely Systems
(who use it a lot). The Storm developers maintain Zope 3 integration
together with Storm. In the Grok community, we also have Christian
Klinger actively working on Grok integration. One thing bothered me
though: Storm lacks the ability to generate database schemas from Python
code.

I asked why that may be so. It turns out this lack is a deliberate
choice, and the Storm developers have good reasons: usually, with large
scalable relational databases, you don't want auto-generation of
schemas. Control and flexibility is important in these cases, and being
limited by a Python-based schema language would hinder a project and,
possibly even worse, piss off the database admins.

When I approached the Storm mailing list about this topic I got friendly
and helpful responses, but it was quite clear that schema-generation,
while not completely out of the question (perhaps in an extension),
isn't part of the Storm culture. It's like threading and Twisted - you
can do it if you want, but if you talk to the developers they will keep
reminding you that in most cases you shouldn't do it. It also reminded
me of the Zope 3 attitude - control and flexibility are of paramount
importance.

Grok emphasizes slightly different things however. We happily use the
control and flexibility that Zope 3 offers, and don't want to lose it if
we can help it, but we let ease of use weigh more heavily when we make
choices. That said, the "control & flexibility" attitude is actually
great for Grok - it's very nice to be able to build on such a flexible
and well-engineered base!

SQLAlchemy seems to share the Zope 3 attitude as well: it offers a lot
of flexibility and control. People are building more high level
declarative systems on top of it, such as
[Elixir](http://elixir.ematia.de/trac/wiki). SQLAlchemy also offers some
extra features compared to Storm. The one that mattered to me was schema
generation from Python code. I myself think schema generation can be
quite useful. Not for large-scale relational databases, but projects
often start out small, and more often stay small. If you're just trying
to develop a small web application, it's very nice to be able to get
started quickly and just write Python code.

This approach suited my project, and I think it will suit Grok as well.
For something like Grok, making it easy to get started is very
important, and to me that means it needs to include schema-generation. I
realize that schema-generation is the wrong choice for many projects,
but I don't think it's the wrong choice for all projects, and I didn't
feel like rolling my own with Storm while it was already there for
SQLAlchemy.

When evaluating Storm, we saw it had several strong connections to our
Zope community. Such connections are valuable, as it means that if I, as
a community member, have a question or a problem, there's a good chance
I'll get an answer. It also means that useful integration code is likely
to be written. What's interesting is that while Storm has buy-in from
larger companies in our community, SQLAlchemy seems to have more
activity in open-source land.

The evidence I have for this is that we have almost too many integration
layers that connect Zope's transaction machinery to SQLAlchemy. I've
used z3c.sqlalchemy and z3c.zalchemy (yes, they are different!) in small
projects in the past. This time I felt it was time to try out
collective.lead, born in the Plone world. Besides these, there are also
people advocating WSGI-based integrations!

I actually had to use an unreleased branch of collective.lead (I hope
there will be a release soon, and for your reference, it's `elro-tpc`),
and it didn't work right with sqlite. Once I switched to PostgreSQL, it
did work quite well. Laurence Rowe, developer of collective.lead, was
very helpful in answering my questions. Don't ask me for technical
reasons on why it might be better than the others, though! Some time in
the future, we'll need to figure out which Zope 3/SQLAlchemy integration
layer is right for Grok.

So what does Grok code that uses SQLAlchemy look like? I'll give just a
sketch here - this is not a complete application. Actually besides the
database setup code, my project's code ended up very similar to code
that uses the ZODB - the patterns are the same.

Let's start with setting up the database. collective.lead needs us to
register a global utility that includes the database URL, table
definitions and the object/relational mappers:

    from collective.lead import Database
    from collective.lead.interfaces import IDatabase
    import sqlalchemy as sa
    from sqlalchemy import Table, Column

    class MyDatabase(grok.GlobalUtility, Database):
        grok.provides(IDatabase)
        grok.name('mydb')

        _url = sa.engine.url.URL(drivername='postgres', database='foo')

        def _setup_tables(self, metadata, tables):
            user_table = Table(
              'user', metadata,
                Column('user_id', Integer, primary_key=True),
                Column('username', String(20), unique=True, index=True),
                Column('password', String(100)))
            metadata.create_all(self._engine)
            tables['user'] = user_table

        def _setup_mappers(self, tables, mappers):
             mappers['user'] = mapper(
                User, tables['user'],
             )

I find the use of underscores in collective.lead here a bit ugly. I
actually hope we can make much of this utility go away again by defining
some clever grokkers and using some declarative approach combining class
and table definitions (Elixir is one option to explore). What the right
way is needs careful thought (perhaps at the
[Grokkerdam](http://wiki.zope.org/grok/GrokkerdamSprint) sprint?).

Above we define a table `user`, then map it to the class `User`. We
haven't defined this class yet, so let's do that now:

    import grok

    class User(grok.Model):
       pass

This is in fact an entirely normal Grok model. You can do everything
with it that you can do with a normal model, connect views to it,
adapters, traversers, etc. Just about the only thing that you probably
shouldn't be doing is stuffing it into the ZODB - that would be rather
confusing! I think eventually Grok wants to introduce a new base-class
for ORMed classes, but for now, the `grok.Model` approach actually
appears to work just fine. The fields in a record, as defined by the
`user` table, become attributes on `User` instances.

Creating an object is a trifle more involved than just instantiating it
and sticking it into a container, like you'd do with the ZODB, but still
very easy. You can create new users like this:

    from zope import component

    session = component.getUtility(IDatabase, name='mydb').session
    user = User()
    session.save(User)

The `getUtility` call looks up the utility we defined above. It's a bit
verbose to keep looking up the session this way, but this can be easily
abstracted away into a small utility function. More high-level
abstractions also are possible: there is some work going on involving
ORM-based container classes, which act like Zope 3 containers (folders).
Zope 3 containers in turn act much like Python dictionaries. Such a
container should make this pattern even more similar to the ZODB
pattern.

All the stuff you can do with Grok add and edit
[forms](http://grok.zope.org/documentation/how-to/automatic-form-generation)
also works fine, including `applyData`. To make automatic form
generation work, you do need to define a Zope interface for `User` to
define the schema. Unfortunately defining the Zope 3 schema for `User`
violates DRY (Don't Repeat Yourself) - you need to define the columns
(which become attributes) in the `user` table definition and then also
define them again, in a different way, in the `IUser` schema. This is
another important topic to think about - perhaps we can devise a way to
generate Zope 3 schemas from SQLAlchemy table definitions or vice versa.
There are projects in the Plone world (Alchemist, collective.mercury)
that offer such a facility, so we need to investigate those.

Grok makes it very easy to make custom traversers to set up your URL
space. Let's combine it with a query example. If you want to make an
object that acts as the base of all users in URL space
(base/_username_), you could do this:

    class UserContainer(grok.Model):
         def traverse(self, name):
             session = component.getUtility(IDatabase, 'mydb').session
             return session.query(User).filter(User.username == name).first()

This contains a query that looks for users by name. If it can be found,
a `User` instance is returned. If not, SQLAlchemy's `first()` will
return `None`, which is exactly what `traverse` wants too if the object
cannot be found. Nice!

This code is similar to the code that would go into a generic ORM
container (base)class that I talked about before. In fact, in my
project, the code almost automatically started evolving other bits and
pieces needed to create such a container, such as way to remove items,
and a way to get all the items in the container (defined by a query).
With use of `zope.location.location.locate()` you can make the results
of such a query fit right into Grok, so you can also use `view.url()` on
`User` instances to get their absolute URL, just like you can do with
ZODB-backed objects.

In my project, I combined the ZODB with SQLAlchemy. The transaction
machinery is integrated, so if you have an uncaught exception in your
code both the ZODB transaction and the relational transaction are
aborted (and rolled back) at the same time. A successful request commits
both. This way I could store things that most easily fit in the ZODB in
the ZODB, and use relational tables where I wanted to. In many systems,
the filesystem is used directly where a relational databases don't work
well, but then you lose the benefit of transactions. A combination of
ZODB and RDMBS gives us quite interesting possibilities to explore.

In conclusion: the Grok community has various things to think about and
improve concerning relational database integration - some of it I
discussed here. Even without those features, using SQLAlchemy with Grok
already felt very natural and easy. This is no doubt in large part
thanks to SQLAlchemy's and Zope 3's flexibility.

I hope we can get some people to work on this during the Grokkerdam
sprint and afterward, and soon make ORM integration a first-class
citizen for Grok. It will add another important feature to Grok, and
take away another reason not to use Grok (unfamiliarity with the ZODB).
Once we have the basic integration done, we can explore building
higher-level features. If you don't mind some DRY violations, it's not
hard to create powerful CRUD interfaces with Grok and SQLAlchemy right
now, but of course we want to eliminate the DRY violations.
