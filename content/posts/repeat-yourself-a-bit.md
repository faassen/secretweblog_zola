+++
title = "Repeat Yourself, A Bit"
date = 2025-01-27
slug = "repeat-yourself-a-bit"

[taxonomies]
tags = ["programming", "llm"]

[extra]
mastodon_comment_id = 113901237721415934
+++

"Don't Repeat Yourself", abbreviated
[DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself), is a mantra I
subscribe to as a programmer. I don't want to have the same code in multiple
parts of the codebase. Part of the reason is just reuse: if I can reuse code,
it's just easier. Repetitive code is also difficult to maintain - if it's in
multiple places, a change may mean I need to update multiple places, which is
tedious and mistake prone. A more subtle reason to try to avoid repetition is
because doing so is design pressure to come up with a succinct, effective
expression of what you are trying to implement, in other words, it encourages
you to create useful abstractions. So, DRY!

<!-- more -->

## Exceptions to DRY

All right, there's an exception; I do sometimes accept repeating myself. Test
driven development promotes a practice where you can repeat yourself
*temporarily* to make the tests pass, and *then* you refactor to get rid of the
repetition. The idea is that repetition can be used to make the individual
steps smaller and easier. And you very well may need to see repetition before
you can be confident about the best way to eliminate it. Again: repetition as a
design pressure. 

Oh, there but there's also another exception, a fundamental one I can't easily
eliminate [^point-free]: if I name something in code (a variable, a function, a
class, etc) I need to have a way to refer back to it. I do this by using its
name. So I'm repeating that name.

In a more subtle way many patterns are repeated too. Take for instance looping
through a bunch of numbers - there is probably a preferred way of spelling that
in your language of choice. This is called an *idiom*, and all programming
languages have such idioms, and if you learn a language well you will use them.
I express similar stuff in a similar way so that people can recognize it
easily, and it makes code more readable.

In tests, I often am quite tolerant of repetition. Yes, I do factor away
repetitive test code at times into shared setups or fixtures. I also look for
opportunities to improve the APIs I'm testing - if I can see a way to avoid
repetition by making the code under test nicer to use, I will do that. It's
another good design pressure, and a core idea behind test-driven development.

But there are huge benefits to having all code for a single test be right
there. It makes it easy to understand and adjust it in isolation. Often you
have tests that are very similar but subtly different, so repetition helps
here. Repetition in test code is typically not very costly, so the benefits to
repetition stand out more.

I'm not a big fan of boilerplate and I treat it as a sign that the code that
requires it could be better organized; another design pressure. Nonetheless, I
do tolerate some repetition in declarative code that expresses the "what" --
more so than in procedural code which expresses the "how". This is something
that's worth going into in more detail.

## The Trade-offs of High Level Abstractions

Consider a large application with multiple sections, each letting you manage
some kind of application entity with a CRUD UI, where each separate section of
the application has an overview, an edit form and add form to manage the entity
that section is about. I'm okay with repeating myself a bit in declarative code
where I wire this stuff up. 

You could try to introduce a level of abstraction high enough to make that
repetition go away, and I love thinking about stuff like that, but you can
*lose* something too - with the higher abstraction things can become harder to
understand, and more importantly, it becomes more difficult to make an
exception; a part of your application that is *almost* the same as others, with
just a few details different. And exceptions like that are common in large
applications.

The Django Admin interface is an interesting example of the tradeoffs involved
here. Django is a web application framework, and it lets you declare models in
code which will then be backed by a relational database. The Django Admin
framework lets you then easily create admin UI pages where you can manage
instances of these models. The Django Admin interface framework is high level.
It can automatically derive a whole admin UI from the description of the models
involved, supplemented by a bit of additional declarative detail supplied by
the programmer.

This is a really useful feature, but it's used more to have an "under water
view" for specialized users than it is for constructing real end user
interfaces. 

In fact, the [Django
documentation](https://docs.djangoproject.com/en/5.1/ref/contrib/admin/) on the
admin interface outright says so right at the top:

> One of the most powerful parts of Django is the automatic admin interface. It
reads metadata from your models to provide a quick, model-centric interface
where trusted users can manage content on your site. The admin’s recommended
use is limited to an organization’s internal management tool. It’s not intended
for building your entire front end around.
>
> The admin has many hooks for customization, but beware of trying to use those
hooks exclusively. If you need to provide a more process-centric interface that
abstracts away the implementation details of database tables and fields, then
it’s probably time to write your own views.

This is because that level of abstraction also makes it *harder* to adjust it
to the demands of particular end user interfaces, even though it offers a *lot*
of customization options. So in real end user interfaces made with Django you
typically see more repetition.

Some repetition in code that leans declarative is normal and good. It can help
with coherence and flexibility.

## Tooling for Repetition

Repeated code is so common in software we are all familiar with tools that help
us with it. 

Tools that create starter projects for a framework are common; they create
boilerplate and help you get started quickly. Many developers use code snippet
tools to help them create idioms quickly from within their editor. 

Another tool for repetition that is very commonly used is program
analysis-based autocomplete - I only have to type part of a variable or
function name and then the UI lets me complete it quickly. It's *also* a tool
for discovery, to quickly see what is available, but it's not just that - the
bit where you can autocomplete is a tool to help you do repetition.

The most common tool for repetition is so obvious you might even forget about
it: copy and paste. Copy and paste is a tool that lets us create repeated code
easily, and we use it all the time. That repetition may be within our codebase,
or it may involve code copied from another codebase or an example we find
online. Interestingly enough with copy and paste the copy often doesn't stay
identical to the original (that would be easy to abstract into a function);
instead we adjust the original to its new context. The longer the fragment we
copy, the less likely is it to stay the same.

## LLMs as Repetition Tools

Autocomplete using LLMs (like Github Copilot) is also a tool that can be used
to create repetition in code. For short fragments LLM autocomplete can behave
in a similar way to autocomplete for functions or variables. But it's more than
that - it's also generative - it can generate repetitions of *patterns* rather
than just repetitions of code. Using it this way is like copying a piece of
code and then adjusting it within its context. Like program analysis based
autocomplete, it can also be a tool for discovery, but of patterns and idioms
rather than variables and APIs.

Unlike the repetition tools discussed earlier, LLM autocomplete is not
consistent; it may do something new each time. So it's not entirely reliable,
but it can definitely be reliable enough to create useful repetition of
patterns. 

I've seen the argument that LLMs in programming are a priori bad as they're
tools for repetition, and repetition in code is bad. I've hope to at least have
convinced you it's not as simple as that.

I've also seen it argued that LLM-based autocomplete is a complete game changer
for programming - which is a bit much to ask of a tool that mixes the
functionality of copy and paste with autocomplete. [^whole-program]

## Conclusion

I believe it's a good development practice to avoid repetition in code.
By all means venture to eliminate repetition - the ability to do that is one of
the great powers and joys of programming. But we can do that while recognizing
that a moderate amount of repetition is also essential grease; so much so that
we have tools to support it. Repeat yourself, just a bit.

[^point-free]: In functional programming there is such a thing as [point-free
style](https://en.wikipedia.org/wiki/Tacit_programming) where names are less
common. A language like Forth is centered around it too.

[^whole-program]: There are other emerging applications of LLMs in programming
where they are used to generate whole programs and edits to them, so called
["chat oriented
programming"](https://sourcegraph.com/blog/the-death-of-the-junior-developer),
but that's another topic.
