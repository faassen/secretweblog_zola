+++
title = "Renewing Zope"
date = 2013-10-24
slug = "renewing-zope"

[taxonomies]
tags = ["python", "zope", "planetpython", "plone"]
+++

## Introduction

The Zope community in late 2001 had been around for a few years already,
almost an eternity in web time back then. Still, we weren't afraid to do
bold new things. Perhaps too bold, as we'll see.

## Zope Rewrite

We were learning new, better ways to do web development. Led by Jim
Fulton, lead architect of Zope, we set out to rewrite Zope, fix
mistakes, explore new innovations, make Zope cleaner, easier, and more
powerful. I say _we_ now, as by that time I and many others were fully
engaged in this project to build its next generation.

One way that this engagement was fostered was by sprints. The Zope
community pioneered the sprints now widely adopted in the Python
community; we would gather together in real life to work on the new
Zope. At such a sprint you would often find yourself working with Jim
Fulton himself, so they were quite the draw.

In the new Zope, we would have more powerful and more clean
extensibility and reuse mechanisms. Zope components would be developed
as normal Python packages. We would do away with the weird magic of
acquisition. We would make the glueing together of components into
applications an explicit, coherent notion instead of a collection of
ad-hoc APIs.

Central to this was the Zope Component Architecture, which introduced
the notion of an explicit interface, along with a way to register and
look up components that would enrich models (we called them _views_ and
_adapters_). It could also fulfill the role of a service locator, and
provided the basis for an event system.

Besides sprint-driven development we were also early adopters of
strongly test-driven development.

This exciting renewal of Zope was done as a complete rewrite. That's
scary; rewrites have a habit of never being completed, and you risk the
[second system
effect](https://en.wikipedia.org/wiki/Second-system_effect). But in many
ways we succeeded -- we had a capable, very powerful and much cleaner
web framework in the new Zope. (There were flaws, as it was not
_easier_, just difficult in new ways, but I'll go into that later.)

So we had an exciting new Zope. We had a practical problem, however.
Almost all of the _real_ work done with Zope was done with the old Zope.
This new, better Zope was held up as the future, but was tantalizingly
out of reach for those of us with large codebases built on top of the
old Zope.

## Five: Redefining Zope

I've written a lot of code over the years, some of it generally useful,
most of it not. But I believe some of my biggest contributions to Zope
were not in the form of code, but projects that helped _redefine_ what
Zope was all about, giving people new ways to use it, and giving the
project new directions.

The first such redefinition I attempted was Five, a name I came up with
by adding together the version numbers of the old Zope (2) and the new
(3). It was cute, and stuck in people's mind, and such things can
matter.

The new Zope was out of reach to users of the old Zope. The community
had been led to believe that the new Zope would be the _next_ Zope. We
thought that at some point in the nebulous future there would be a
transition to the next system, some form of compatibility, some way to
transfer code from the old to the new system. How this would work was
left unspecified.

I grew doubtful about whether it would work at all. It was in the future
and seemed to stay there. And I wanted to use the new stuff.

So in 2004 I took a different approach. I worked out a way to add the
code of the new Zope to the old, using the new Zope as a library,
extending the old Zope: Five. Through Five, the new ways of developing
became available in the old system. We could use the new Zope, right
then and there, in the context of the old Zope. We could use the better
ways of doing things without giving up our existing codebases.

By 2006 the Five technology was merged into the core of the old Zope:
Five became an integral part of it. Finally in 2009 we fixed the
confusing, now deceitful naming, which was still suggesting after all
these years that Zope 3, the new Zope, was the next Zope, which it was
not. We let the new Zope evaporate into a puff of libraries. The next
Zope was no more; there was just Zope. Its code lives on, in the old
Zope, and various successor frameworks.

## The Wisdom of Hindsight

Was the Five solution ideal? It was not. It made the old Zope more
complex. While code written in the new way was more clean and
maintainable, we didn't gain all of the cleanliness, because the old
stuff was still there. The transition from old to new ways of doing
things would be a very long one. The Plone developers, for instance,
adopted the new ways many years ago, but are only now finally able to
remove some of the old ways from the next version of their CMS.

Should we have done things differently? In retrospect, we should perhaps
not have created the new Zope at all. Instead we could have embarked on
a project to renew the old Zope from within, directly. That would have
been very difficult as well, though. We might have missed out on
something too. A clean slate, after all, lets you take a step back from
what you're doing, and helps you think things through more clearly. We
benefited from that as well.

The new Zope project was flawed, and the approach to merge it into the
old Zope generated difficulty as well as opportunity. But through these
projects Zope did continue to evolve, renew itself, and stay relevant.

This blog entry is a part of a [series on
Zope](@/posts/my-exit-from-zope.md) and my
involvement with it.
[Previous](@/posts/object-publishing.md).
[Next](@/posts/jim-fulton-zope-architect.md).

## Preserved Comments

### Chris McDonough

> Maybe as much as second-system effect, I suspect poor distribution factoring
> played a role in the the not-better-ness of Zope 3. It was laudable to try to
> break it up into bits, but the actual breaking up was done incredibly poorly
> given the resulting dependency graph of the pieces. Only things like the ZCA
> and ZODB and a handful of utility packages like zope.deprecation were
> actually useful outside the big ball of dependencies. The rest of the stuff
> was broken up very mechanically in 2001, and a good number of distributions
> in the zope-dot namespace had (and still have) transitive dependencies on
> basically every other zope-dot distribution. This signifies, to me at least,
> that they probably should have been left as one big distribution, at least
> until the truly reusable bits fell out. Breaking them out without considering
> whether the bits being broken out were actually reusable added to the
> toolchain and release burden (the "KGS" was of outsized importance). It
> eventually made Zope-the-web-framework irrelevant by turning us into
> packaging accountants instead of programmers for a good number of years,
> while other frameworks just ignored packaging almost entirely and focused on
> creating software.
>
> The number of zope-dot distributions that are truly reusable vs. the total
> number of zope-dot distributions is still tiny. An otherwise uninterested
> party can make zero sense of why e.g. https://pypi.python.org/pyp... exists
> as its own thing, because it's plain just not sensible for it to exist
> outside of some larger whole. This led to a lot of confusion and mistrust,
> because Zope 3 was _supposed_ to be this tightly-factored thing made up of
> small parts, but in reality it was not; with some notable exceptions, the
> distributions it was split up into were not factored well enough for someone
> who didn't want to swallow a bunch of other distributions (sometimes dozens)
> too. So it just became easier for people to ignore zope-things than to try to
> figure out which parts were useful by themselves and which parts weren't.
>
> What I think we learned as a community from that is that if something doesn't
> actually have a life of its own (e.g. its own docs, its own set of users who
> are interested in this particular part, but might not be interested in some
> other part of the system) it should either a) not be released or b) be kept
> as part of a larger whole that has its own identity. And although the
> specific factoring was largely a failure, the exercise of actually doing the
> distribution splitting did end up really helping the Python packaging story,
> if only for being an early adopter of setuptools.

### Martijn Faassen

> I agree that the factoring of Zope 3 into sub-packages was bad. Splitting it
> up into independent packages around 2006 in some ways made things worse,
> though it did make the bad factoring more clear. I agree that you should only
> split stuff off when it looks like this thing can have an identity on its
> own.
>
> The transitive dependency issue of each zope._ package on the rest of zope._
> hairball was solved back in 2009, actually. After that we could finally dump
> the useless Zope 3 ZMI code, for instance. Pushing for that refactoring was
> one of my last contributions to Zope. It succeeded but didn't open up Zope
> for further development as I'd wished. By then it was far too late.
>
> Packaging accountancy was a distraction, but I don't think it was the primary
> cause of stagnation. I think that was broken decision making: we couldn't
> agree on doing new stuff anymore. To do innovation we had go around Zope, not
> through it - see Grok or Repoze for instance. Package accountancy was one of
> the last things we _could_ find common ground on, because it was boring, so
> it still happened. You still see such maintenance common ground in upgrading
> various libraries to be Python 3 compatible today.

### Chris McDonough

> That's a good theory.
>
> We should probably treat PyPI more like a retail store than a warehouse these
> days, and we probably should have been for years.

> Possibly internally the packaging dependency hairball bust-up was solved for
> some definition of solved. But from the perspective of a "retail customer"
> just walking up to the ecosystem, even with all of our contributions towards
> trying to untangle it, and even with your efforts to put a more friendly face
> on Z3 via Grok, not so much. It was, and is, still just as intimidating and
> confusing to even a seasoned Python programmer as it was in 2004 and possibly
> more so, because the jukes we did to break dependencies just added
> conditional code instead of removing the actual complexity. Even today,
> zope.authentication depends on packages that have zero life outside of the
> whole like zope.location or ones like zope.browser which exist only to
> service a self-inflicted packaging problem. There's just no real chance of
> explaining why these things are the way they are to some otherwise
> uninterested person.
>
> And I think this really did contribute to stagnation. If you can't get other
> people excited about your systems, what's the point of releasing them? At
> least this is true for me; I saw no point in continuing to have total
> fidelity with the Zope brand when it was so tarnished, and I think as much as
> anything, the packaging decisions really did contribute to that tarnish.
> There were other problems too that you tried to address (e.g. over-reliance
> on ZCML), but I think we might have survived that if the distribution story
> didn't just almost-immediately turn everyone off.
>
> I am glad you are working on things like Reg, which seems to be more
> retail-friendly, because you can very easily detect its outline; you know
> where it starts and where it stops and who might want to use it.
>
> FWIW, I am actually working on something a bit similar but possibly more
> ambitious and therefore more risky, factored out of stuff that already exists
> in Pyramid. Possibly we should compare notes at some point, at least once
> I've gotten some software together to demonstrate the requirements. The main
> one that ZCA doesn't provide is predicates unrelated to adaptation (e.g.
> execute this view if the request method is GET, without needing to attach
> some otherwise pointless IGET interface to the request). So I'm going to see
> if I can get something going there that is reusable, because I need it in
> both Pyramid and in things like Substance D. That said, I am dreading working
> on it because it's a deep dive that will consume me for weeks.

### Martijn Faassen

> Oh, sure, if you walk up to PyPI and look at zope.\* packages you'll be
> hopelessly lost. No question about that. We solved the technical issue of
> "pull in one dependency, get all the others", not the usefulness of the
> libraries themselves. You need to solve the technical issue too if you want
> to make libraries useful, but that's indeed a pretty backwards way of doing
> things, just the only step forward I could see if you want to evolve the
> existing split up codebase as we had it then. Libraries should start out
> being useful.
>
> But we worked on the dependency hairball for other reasons too - we could
> _dump_ lots of dependencies weren't using anymore but were still pulling it.
> The effort wasn't a total loss for us using Grok or Zope 2.
>
> I agree that the intimidating codebase without approachable contributed to
> stagnation. Paradoxically enough splitting things up was actually intended to
> make the codebase less intimidating, but in some ways made it worse. But this
> predates putting stuff on PyPI too: there were far too many packages in the
> zope.\* tree early on already, when the codebase itself was still maintained
> as a single tree.
>
> I see the splitup into PyPI as a mixed bag; it helped expose underlying
> problems and made things even less approachable at the same time.
>
> A reworking of the component stuff more ambitious than Reg? In Reg I actually
> have a Predicate registry that plugs into the rest of Reg; I use it in
> Morepath, though I haven't gone through Pyramid's more complicated predicate
> use cases yet.
