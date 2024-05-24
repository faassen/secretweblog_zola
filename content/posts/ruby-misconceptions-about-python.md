+++
title = "Ruby misconceptions about Python"
date = 2006-04-12
slug = "ruby-misconceptions-about-python"

[taxonomies]
tags = ["python"]
+++

# Ruby misconceptions about Python

I just ran into a rather misleading
[article](http://www.rexx.com/~oinkoink/Ruby_v_Python.html) claiming to
compare Ruby and Python. Let's please be done with some of these
misconceptions:

- Python 1.5.2 was released in april 1999. Talking about supposed design
  flaws in a version released in 1999 is a bit misleading. We're *seven
  years* past april 1999. Maybe the referenced article was written in
  2000, in which case it's somewhat more understandable. I do not
  believe it was, as it talks about Python's support for sets, which was
  added later.

- the opinion sketched about booleans is an opinion. Python did add an
  explicit `True` and `False` quite recently, in Python 2.3 I believe
  (we're at 2.4 now), but 0 is still considered to be False (try
  `bool(0)`).

- Yes, empty sets, like other empty sequences, are False in Python. Sets
  are built-in in Python 2.4, and were a library in Python 2.3, and
  empty sets are False in both. I happen to like empty sequences being
  False, but this particular opinion has the benefit in at least being
  original. :)

- Let's please cut the crap about OO being a bolt-on in Python. This is
  FUD. It's probable that many people who repeat this meme are not even
  aware of enough deep OO issues to ever have to care even if it *were*
  true.

- Python's OO implementation has indeed been improved in version 2.0
  (released in 2001). That doesn't mean we haven't been happily using
  multiple inheritance in Python 1.5.2; the notion that it was
  critically flawed is rather exaggarated. I think this needs to be said
  to back up the OO bolted-on FUD. Like, "if OO in Python is bolted on,
  why has Python had multiple inheritance support since forever and Ruby
  doesn't?" Advocate's answer: "Well, that's because that multiple
  inheritance was critically flawed in versions as recent as 1.5.2!"

- You can add and remove methods from classes in Python. This has been
  possible for years and years (including Python 1.5.2):

      class Foo(object):
         pass
      def mymethod(self):
         print "hello world"
      foo = Foo()
      Foo.mymethod = mymethod
      foo.mymethod()

  We were doing this with Zope in 1999. We think it tends to lead to
  maintainability nightmares and call this monkey-patching.

  And you can also add methods to individual objects in Python, though
  this is indeed slightly more tricky.

- Classes are types in Python too, if you inherit from `object`. This
  has been the case since Python 2.0 (released, remember, in 2001?):

      class Foo(object):
          pass
      foo = Foo()
      assert type(foo) is Foo

- Python programs also have a great capacity for "reflection". Saying
  that Ruby can do it in a discussion comparing Ruby and Python is a bit
  misleading as you imply you can't do it in Python.

- CPython's garbage collection is based on reference counting, which
  leads to predictable run-time behavior. For circular references
  CPython has had an additional garbage collection algorithm for years
  (since, I believe, Python 2.0 again, released in 2001...), so circular
  references aren't a problem.

  Jython by the way uses Java's garbage collection system, and
  IronPython uses the CLR's. I believe the PyPy implementation of Python
  uses Boehm's, but they're still working on it and are making it
  pluggable, as this is PyPy after all. :)

- `del`, by the way, just removes a reference and does not garbage
  collect right now, unless you only have a single reference to an
  object.

- Taking care of reference counting when building C extensions is indeed
  difficult. Luckily Python has access to automatic binding generator
  tools like Swig which take care of it, or systems like Pyrex which let
  you write C extensions in a Python syntax. I wrote a full suite of
  advanced libxml2 bindings (lxml) for Python with Pyrex and I didn't
  need to worry about reference counting.

  I wonder how Ruby deals with the interaction between its garbage
  collection and C libraries that use malloc? I can imagine this might
  sometimes make things a bit more difficult.

- the author of the article claimed they got more sophisticated as a
  programmer, and Python seemed less wonderful and Ruby seemed more
  attractive. That may be more a reflection of the personal evolution of
  the programmer than the capacity of the languages. I think this is so
  because the author was clearly not aware of many of the features that
  Python actually has when he was a predominantly programming in Python.

So, Ruby advocates, please consider stopping to spread the following
misconceptions about Python:

- Python's OO is bolted on. It's not bolted on. This misconception is a
  mismash between FUD and seriously outdated notions of Python's OO
  support.

  Python just is a multi-paradigm language with great OO support. You
  can do insanely advanced OO stuff in Python, including changing
  methods on classes at runtime, metaclasses, the works. And yes, you
  can do multiple inheritance in Python.

  I've never had to write a metaclass personally, by the way. Have you,
  Ruby programmer who claims Python's OO is bolted on?

- Python has no garbage collection. It does. This is an outdated notion
  about CPython, never true for other implementations.

If you want to advocate Ruby over Python, advocate things like support
for anonymous blocks. That's something neat that Python actually
*doesn't* have.
