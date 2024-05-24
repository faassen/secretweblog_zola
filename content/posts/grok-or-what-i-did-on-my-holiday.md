+++
title = "Grok: or what I did on my holiday"
date = 2006-11-09
slug = "grok-or-what-i-did-on-my-holiday"

[taxonomies]
tags = ["grok", "sprint"]
+++

I will use this blog entry to talk talk a bit about my holiday in
Germany a few weeks ago. I went to a mini sprint at
[Gocept](http://www.gocept.com), in Halle. I had a great time! (yes, I
am a geek) This sprint showed that good sprints aren't necessarily the
ones with many people participating; we just had 4 sprinters (and less
much of the time), and this was one of the most productive sprints I've
been at for years. I left the sprint energized and excited. Thanks to
Gocept for organizing this, it was awesome!

So what did we do on this sprint? You might have heard the news already
here and there: we worked on Grok.

This is Grok:

![image](http://faassen.n--tree.net/grok.jpg)

Grok is a caveman.

Grok talks like this: ME GROK SAY HI!

We all have a bit of the caveman or woman in us, although any
resemblance of Grok to me is solely in your imagination and a pure
coincidence and has absolutely nothing to do with the fact that the
artist who drew Grok is my wife. Cavemen, like us programmers, want
powerful and flexible tools. Cavemen are great at tools after all; they
practically _invented_ tools. But cavemen, and we, also want our tools
to be simple and effective.

Simple and effective like _clubs_: a club is powerful, flexible (you can
bash in anything, mash potatoes too) and also simple and effective. Zope
3 is powerful and flexible all right, but we need it to be simpler, thus
making it even more effective. This brings me to the Grok motto: _Grok
-- now even cavemen can use Zope 3_.

Besides a caveman, Grok is also a piece of software, and a project. The
project that started at this year's pre-EuroPython sprint with some of
my musings about improving Zope 3's development experience. I wrote some
of them these ideas down on a hot day at CERN in Geneva when I found out
I had been the first sprinter to arrive. These musings turned into a
discussion at the sprint. The discussion with the people there (among
others Jim Fulton, Steve Alexander, Philipp von Weitershausen and Uwe
Oestermeier) helped my thinking quite a bit.

The basic idea behind Grok is to provide an alternate way to configure
Zope 3 applications: it doesn't use ZCML. Instead, configuration can be
triggered from Python. The idea was to apply a few design guidelines
like Don't Repeat Yourself (DRY) and Convention over Configuration,
concepts popularized by Ruby on Rails.

For months I didn't have the opportunity to do much with these ideas,
until I spoke with Christian Theune of Gocept at the
[DZUG](http://www.dzug.org) meeting in september. He recently had been
confronted with the complexities of Zope 3 in a new way: a very smart
programmer, Wolfgang Schnerring, was doing an internship at Gocept. In
the course of this, we was learning to develop with Zope 3 and got quite
frustrated. We don't want to frustrate smart programmers if we can avoid
it. Good programmers are in rare supply.

We started to talk about Grok, and Christian got quite interested, so we
organized for me to visit Gocept and work with Christian and Wolfgang to
try to make some of my vague plans for Grok a reality. Philipp von
Weitershausen heard about these plans and we were happy to see him join
us. This completed our core team. Grok is our joint effort.

The first day started with Philipp and me arguing quite aggressively on
what Grok's design could be like, somewhat intimidating poor Wolfgang.
He was happy to find out we had just been warming up for the real work,
and by late afternoon all four of us were making great progress
sketching out Grok's design.

After doing that design work we started implementing Grok the next day.
We practiced quadruple-programming: one person typing, the rest of us
giving the long-suffering typer (initially Philipp) our kind directions.
The code in the editor was projected with a beamer. This worked a lot
better than one would expect: we used the time effectively planning out
our testing strategy (we practiced test-first programming), worrying
about design and edge cases, etc. We seem to have hit a very effective
combination of personalities in Christian, Philipp, Wolfgang and myself.

In fact it worked astoundingly well; for the first day of checkins
Philipp might've looked from the outside like he was a "perfect
programmer", checking in incremental improvements to Grok without any
hestitation about the design, going straight for his targets, extensive
testing, the works. Of course after a while we did hit some design
issues we retreated from later, but overall we could move very fast.
After the sprint I realized I'd actually not typed a letter of actual
Grok code even though I knew the codebase very well as I'd seen all of
it on the screen (since I've been back I've of course been checking in
stuff by myself). The code was better than I could've written just by
myself and I was entirely comfortable with it.

In the evenings we ate a number of delicious meals and played Guitar
Hero on Christian's Playstation, where we discovered that I'm a guitar
caveman and that Christian is a guitar god among otherwise quite
respectable guitar heros.

So what does Grok-based Zope 3 code look like? I'm still working on a
tutorial, but here is a trivial example of a complete Grok application:

    import grok

    class Document(grok.Model):
        def __init__(self):
            self.text = 'ME GROK SAY HI'

    class Index(grok.View):
        def render(self):
            return "The text is: " + self.context.text

ME GROK NO NEED ZCML

Grok fits my brain and I hope it will fit yours. Grok is entirely
compatible with Zope 3; all the power of Zope 3 is in there. We're not
changing the way Zope 3 works; we're just making it easier to use. Grok
combines the flexibility of a swiss army knife with the great usability
of a club.

To see a bigger example of Grok-based code, please take a look at the
[Grok-based wiki
implementation](http://svn.zope.org/grok/trunk/grokwiki). As a small
note of warning: the Grok wiki is not intended to be a pure example
code-base; we're using it as a Grok test-bed application so it is
subject to change.

You can get Grok and run Grok yourself (along with the wiki and some
other test-bed apps). Thanks to the wonders of zc.buildout it's actually
very easy:

    $ svn co svn://svn.zope.org/repos/main/grok/trunk grok
    $ cd grok
    $ python2.4 bootstrap/bootstrap.py
    $ bin/buildout

This will download and install Zope 3 (please wait a while) and will
make an instance with Grok and GrokWiki in it. To try the GrokWiki,
first start zope 3:

    $ parts/instance/bin/zopectl fg

You can now access Zope 3 on port 8080; you can log in with the username
grok and password grok. You can add 'grokwiki' in the ZMI here. After
you add it, you get a rather empty page asking you to register things.
Ignore that (it's a default Zope 3 thing), and just go click 'preview'
or go to the URL of the object you just created, for instance:

    http://localhost:8080/grokwiki

Grok is a work in progress; it's going to change. It's not complete yet:
we have a lot of things to do still. Don't build your applications on it
yet unless you want to help us developing Grok further. We do think we
have made great progress in a short time and I'm confident we'll make a
lot more progress in the months to come. I personally think we're going
to have quite an impact with Grok in the Zope world in 2007, and perhaps
beyond.

Grok is team work. If you're interested in Grok and want to help us out
developing it, we have a [grok-dev mailing
list](http://mail.zope.org/mailman/listinfo/grok-dev) you can join:

**Update**: updated the installation instructions slightly in response
to feedback in comments.
