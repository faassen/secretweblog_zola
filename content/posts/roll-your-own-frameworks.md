+++
title = "Roll Your Own Frameworks"
date = 2020-05-18
slug = "roll-your-own-frameworks"

[taxonomies]
tags = ["python", "javascript", "framework", "programming", "planetpython"]
+++

## Introduction

When I build an application, I build frameworks along the way. I
recently realized that not everybody thinks this is normal, so I thought
I'd give a description of what I do and why I think it's a good idea.

But let's stop for a moment and briefly discuss what I understand to be
a software development framework. Examples of frameworks are frontend
web frameworks like React, backend web frameworks like Django, UI
component frameworks like Ant Design, an
[ORM](https://en.wikipedia.org/wiki/Object-relational_mapping) like
SQLAlchemy, or a form library like
[mstform](https://github.com/isprojects/mstform) (which I helped
create), and so on.

A framework can be large or small, but in the end it's code that
fulfills some task that you can control by plugging in your own code and
declarations. Frameworks are
[declarative](https://en.wikipedia.org/wiki/Declarative_programming) in
nature, and declarations tend to be easier to understand and maintain
than code that has a lot of moving
[imperative](https://en.wikipedia.org/wiki/Imperative_programming)
parts. This way frameworks also help you structure your application. My
article [Framework
Patterns](@/posts/framework-patterns.md)
discusses a bunch of ways frameworks let you do that.

I will fully admit my bias up front: I like creating frameworks. But
besides enjoying it, I also think this activity has enormous benefits
when you build large, long-lived, successful applications.

Examples are good! Over the last two decades, I've written or helped to
write the following "roll your own" frameworks while building
applications:

- several form libraries: from
  [ZFormulator](http://old.zope.org/Members/faassen/ZFormulator/info.1)
  in the late 1990s to [mstform](https://github.com/isprojects/mstform)
  most recently.
- two workflow engines.
- a frontend routing system.
- an entire frontend web framework (before it was cool!). See
  [Obviel](http://www.obviel.org).
- countless tiny frameworks. This is important so I will tell you more
  later.

## Why a framework at all?

Frameworks are overhead. You need to learn them. They can be in the way.
They may have performance implications.

Why not just avoid them altogether? Use the platform, whether that may
be the web browser or the operating system or whatever else.

I think this is an illusion. A platform is already a framework. If it
fits what you want to do, great. But it may just not be a great
framework for your particular purpose.

Frameworks offer features and help you get things done.

A more subtle effect is that frameworks also help with maintenance --
they offer a structure to your application code that makes it easier to
decide how to add new features to it and makes it easier to navigate
your codebase.

Successful applications tend to grow in complexity over time. Frameworks
can help you prevent your application from growing into a big ball of
mud.

## Why aren't existing frameworks enough?

Why should you roll your own frameworks at all and not just build on top
of an existing one? After all, an existing popular framework has many
benefits: it is documented, you can hire people that already know it,
and perhaps most importantly, you don't have to build and maintain it
yourself. Even if you pick a less popular framework it still means you
don't have to build and maintain it, and there is so much out there.

All this is true, and I encourage people to use existing frameworks
where possible. But as everyone who has used a framework knows, you tend
to reach points where the only way to make a framework do what you want
is an ugly way. This is not a surprise -- all applications and all
developers are unique, and a framework tries to generalize concerns, so
it's likely it doesn't fit perfectly all the time.

That's usually okay -- you often gladly pay the price of more work in
exchange for the feature the framework offers. But sometimes it's not
okay; sometimes the price you have to pay to write nice code is too high
-- it's difficult to write, it's hard to test, or the maintenance burden
is enormous.

### Small versus large

Small frameworks that do one thing well tend to be less constraining
than larger frameworks that arrange a whole set of things for you. A web
framework like Django offers a whole bunch of features out-of-the-box:
from templating to database integration, all in an integrated whole.
Because Django makes these choices, a development team does not have to
make them. Removing the burden of decision making alone can be valuable,
so you can focus on what is important. But it also makes it more likely
that some of the choices do not fit what your application needs.

A smaller web framework, like Flask (or
[Morepath](http://morepath.readthedocs.org), which I created) does less,
but also gives the developers more room to make the right decisions for
the application. It's a trade-off.

The choice to remain focused can have an impact on the ecosystem
surrounding a framework. React chose to remain focused. As it became
more popular, a lot of creative solutions to other problems emerged in
its ecosystem: forms, state management, UI component libraries, routing,
and much more. If React had made these choices for the developers, there
might have been less room for this creative ferment. But it does load up
developers with extra choices to make, such as whether they should use
Redux, Mobx or something else.

### Mind the gaps

No matter which frameworks you choose to use, there will be gaps. There
will be important functionality of your application where your existing
framework doesn't have an opinion and you can find no smaller framework
to help you in a satisfactory way. The price you have to pay for just
"powering through" by doing a repetitive ugly thing is too high -- the
code becomes unmaintainable or even impossible to write correctly. This
may be tolerable for minor features, but unfortunately it's most likely
to happen in core features of your application, where you spend the most
effort. What to do then?

## Roll your own

That's when I start thinking about rolling my own framework. I focus my
own framework on exactly the problems the application needs help with
the most. The benefit is that I can decrease the maintenance cost of the
application code and accomplish difficult goals. The cost is that I need
to write and maintain the framework.

I think people often underestimate the benefits of doing this and
overestimate the costs, so I will discuss both.

### Benefits

The benefits are the same as you get from any framework. Your custom
framework helps organize your code in structures that help with
maintenance, and makes hard things easier. Your own framework is likely
to fit your application's concerns pretty well. Another big benefit is
that if it turns out the framework needs new features, you don't need to
wait for anyone and can just add them.

Application code tends to be difficult to test automatically. This is
because an application by its nature tends to integrate things --
servers, file systems, databases, and so on. It's a whole. This means
that application tests tend to lean towards integration tests, and
integration tests are harder to write, slower to run, and more difficult
to maintain than subsystem tests.

But the code of your framework is not application code and does not
suffer from these problems. It's a subsystem. Tests tend to be easier to
write and maintain and they can run quickly. So by creating a framework
for application functionality you have taken that functionality out of
_the difficult and frustrating to test_ realm and put it into the _fun
and easier to test_ realm.

Because you have separated the framework from the rest of the
functionality, it becomes easier to ensure loose coupling between the
framework and the application. Loose coupling and tests allows you to
move very quickly in a framework codebase, and make changes that can
have a big impact right away throughout your application.

It's also easier to document a framework. This is because you have
something separate you can point at that is not enormous and therefore
not overwhelming to document.

All of these things incidentally tend to become easier if you separate
your framework into its own software package and maintain it separately
from the application, though this also has drawbacks -- you need to
manage these packages -- so decide whether you should do this on a
case-by-case basis.

### Costs

All this means that the maintenance burden of your framework is less
than you might expect -- if you extract a framework from your
application you can effectively convert a larger maintenance burden in
your application to a smaller one in your framework.

But you still need to _create_ the framework. Is this something super
difficult that only elite genius programmers can do? It would be cool to
think so as this would mean I'm an elite genius programmer, but I
actually think framework creation should and can be part of the toolbox
of any developer. It's something that you can _learn_.

## Tiny frameworks

The act of creating a framework may seem daunting, but a framework can
be tiny and still be worthwhile. Many frameworks fit in a single screen
of code.

Here are some things that may well fit in one screen of code and are
frameworks:

- a reusable HTML template.
- a base class.
- a React component with an onClick event handler.
- a function that takes another function as an argument.

Examples of tiny frameworks I've helped to create, just in the last few
months, include:

- a way to define how to export and import fields of a particular data
  model to and from Excel.
- a small wrapper to make it easier to talk to particular SOAP
  endpoints.
- a way to use this wrapper to make it easier to write testing mocks for
  SOAP endpoints.
- a Python decorator to declare certain common authorization behaviors
  more easily.
- integration between URLs and form state to make it easier to express
  complicated search parameters.

You will note that I have a harder time describing these tiny frameworks
as I can't just say "backend web framework" or "form library", which
immediately call up a whole bunch of associations for many people.
That's because these frameworks were designed to serve very specific
goals.

Here are two slightly bigger frameworks I've built to help serve
application-specific goals:

- a frontend store that integrates an existing React Table component
  with a backend REST service. It takes care of synchronizing
  pagination, searchability, sortability, and manages frontend URL
  parameters.
- a customizable way to normalize frontend JSON payloads and backend
  data where some fields are read-only for security purposes.

Again you will note it is more difficult to express what I mean. As long
as you can define what they do well for yourself and the people who use
them, that may actually be a good thing. It means you're solving real
problems for a specific application.

Incidentally I could not describe my front-end web framework
[Obviel](http://www.obviel.org) very well in the beginning, as people
weren't very familiar with those ideas yet -- it was before Backbone,
Ember, Angular, React and Vue came along. Now it's easy.

## How to grow your frameworks

I won't go into the technical details of how to create a framework here.
Look at existing frameworks for guidance, and read my [Framework
Patterns](@/posts/framework-patterns.md)
article. Instead I want to discuss ways to incrementally create
frameworks while you build an application.

### Start small

Certainly do not try to build a grand unifying framework that will solve
everything once it is done. This is a trap. It will result in analysis
paralysis or
[over-engineering](@/posts/under-engineering-over-engineering-right-engineering.md).
You risk solving problems you don't actually have and blinding yourself
to the problems you do need to solve. Do not make the construction of a
framework a requirement for the construction of the application that
needs it.

When I say create frameworks when you build an app I do mean _multiple_
frameworks. By all means don't start from scratch. Build on existing
frameworks. When you have a particular problem and you suspect someone
else has solved it already, look around first.

I try to stop myself from building a larger framework if I already know
existing frameworks are out there that solve a similar problem. Only
after due consideration of these do I start thinking about rolling my
own. For tiny frameworks this doesn't matter that much, as they're very
fast to create anyway.

If you are very experienced in a particular problem domain you may be
able to build a framework independently of constructing applications
that need it. But that is the exception to the rule: in general you
should not build a framework before you are building the part of the
application that needs it.

### Look for opportunities

You won't know about all the frameworks you need to build when you start
building your application. Just iteratively build application features.
But keep your eye out for framework opportunities: that bit of code that
is repetitive and annoying. General rule: repetitive (mostly)
[declarative](https://en.wikipedia.org/wiki/Declarative_programming)
code is fine, but repetitive
[imperative](https://en.wikipedia.org/wiki/Imperative_programming) code
is a risk and thus an opportunity for a framework that can help make it
more declarative.

Then build a modest framework to help you. Integrate it with the
application early.

### Controlled growth

When you integrate a framework into an application, first tackle a
single case, and then spread it out to all the other places you can use
it. So try your validation system with a single form first, tweak it
where needed, and then spread it to all the other forms, tweaking it as
you go.

Make sure to spend time to convert existing code to use the framework
you created. This can give you insight about gaps in your framework you
may want to fix. The consistency is important. Programmers look for
example code in the application first. Make sure all existing code uses
the new pattern so that the old way of doing things that doesn't use the
framework yet doesn't spread inadvertently.

Look for opportunities for growing existing frameworks. Your form
validation library could perhaps automatically clear invalid fields or
set defaults in the same validation phase. And since you have spread it
to all forms already, now it is easy to add this new functionality
everywhere in your application all at once.

### Pretend a little

Don't worry too much about whether your framework is useful in another
context. It's already useful if it helps you in a single application.
But do pretend a little to yourself that you will open-source it. Have
good tests and write documentation and a changelog. The future will be
grateful.

But because you didn't open-source it or since your open source project
has 1.5 users (like most of mine!) don't be too afraid to break APIs in
the early days if you need it. Mold them like the wet clay they are.

## Conclusion

Use existing frameworks where you can, but don't be afraid to roll your
own when you can't. It may seem daunting but it can be learned. By
extracting a framework both your application and the framework can
become easier to manage.

So next time you are working on an application, look for framework
opportunities. Don't be too ambitious, but start small, then slowly grow
your framework. It's great to give it the open source treatment with
tests, documentation and a changelog, but it doesn't have to be in set
in stone right away because of that. It's your own framework and you can
make it do what _you_ need, even if you change your mind along the way.

So plant a few framework seeds in the garden of your application, and
have fun!

## Thank you

Thank you to those who generously helped to proofread this article:

- Jürgen Gmach
- Wasim Lorgat
- Russ Ferriday

## Preserved Comments

### Olumide

All your examples read more like libraries than frameworks. Inversion of
control alone doth not framework make.

### Martijn Faassen

I myself see a huge gray area between non-framework library and framework. I
can however understand the perspective that inversion of control alone does not
make a framework, but I do think it shifts the code in that direction on the
library/framework spectrum. I'm surprised about your comment that "all your
examples" are definitely not frameworks. Would you really consider a frontend
web framework or a frontend router to be libraries rather than frameworks?

But perhaps you are responding to the "tiny frameworks" section. I think some
of these are more obviously frameworky than others. The SOAP connection layer
has typical framework properties: it defines its own declarative grammar to
declare SOAP endpoints, where you can inject your own code to influence how
parameters are passed. It helps structure the code that uses it. The framework
has grown to also support mocking.

The excel import/export system has a way to declare fields, and you can
override their behavior on a per-field basis with custom code.

I'll grant that the URL parameter management system may fit "library" better --
it reads a model definition and turns it into URL parameters, and back through
JSON, and more properly is really a part to support a little search framework
where you can define frontend models that define search parameters.

I think the word "framework" invite thoughts about declarative code that helps
to structure your application, and I would encourage people to think in that
direction.

But to those with strong opinions about whether these are libraries or
frameworks, may I suggest you read this as "roll your own libraries"?
