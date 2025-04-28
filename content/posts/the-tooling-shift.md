+++
title = "The Tooling Shift"
date = 2024-05-30
slug = "the-tooling-shift"
description = "Tool maven versus language maven. Do modern development environments enable you to be both? How does this affect languages?"

[taxonomies]
tags = ["programming"]

[extra]
mastodon_comment_id = 112529877831369105

+++

## I'm not a power user

Even though I know a lot of computer stuff, I still wouldn't call myself a
power user. I use Linux. I've been using Linux for a very long time, so over
the years I have picked up a lot of things. But while I know enough of bash,
Make, git, etc to do what I need, I don't know them in depth, even though I'm
confident I could learn. I have the impression that some other developers know
the ins and outs of various tools.

I used Emacs for a long time; over 15 years. I never became a power user of
Emacs either. I used `python-mode` which provided syntax highlighting and a bit
of indentation support. I occasionally used a linter, rarely a debugger, and I
wrote once a tool to find unused imports in Python code. I used `meld`, a tool
for visual diffing. But I'd use these tools on the CLI, not integrated in the
editor. I recall at one point near the end of my Emacs era I tried to integrate
more of such tools into Emacs, but, perhaps due to my lack of skill, Emacs
became unstable.

I have dabbled with devops tooling a little when I needed to, but the whole
area doesn't interest me all that much. Meanwhile others are slinging docker
containers left and right.

Am I overestimating others in being power users, underestimating myself? It's
quite possible. But I don't mind knowing only basics of some tools.

It's different for programming languages. When it comes to languages I enjoy
and have used a lot, I want to know a lot more.

## The IDE Divide

This brings me to [The IDE Divide](https://blog.osteele.com/2004/11/ides). This
is a blog post from _2004_ by Oliver Steele. My own blog, pretty ancient,
started in 2005. I don't recall when I first read this article, but probably
around that time. It's still insightful and it's definitely worth a read.

It portrays the developer world as divided into two camps: language mavens and
tool mavens. Whereas a language maven focuses on features of the programming
language, and feels empowered by languages that let them do higher-level
programming. Tool mavens instead focus on using powerful development tools -
the IDE, for instance. They are the power users of such tools.

Oliver describes the various forces that make developers specialize as either
a tool maven or a language maven. It's hard to be both.

I was a language maven for a very long time. I used tooling in a minimal
fashion. Editors didn't offer much in the first place. When they did offer a
feature, I wasn't a power user enough to use it. Dynamically typed languages
like Python let me mold the clay and got out of the way.

Interestingly enough, I _was_ an early adopter of language-based package
management. This was close enough to the language domain for me to invest in
learning the tooling.

## The Tooling Shift

But something has shifted over the course of the last 10 years. For myself, I
can date a major transition exactly, as I tweeted about it at the time. I've
since left Twitter for [mastodon](https://hachyderm.io/@faassen), so I'll
quote my tweet here. This is from January 27, 2017:

> I used atom ide, prettier, mobx, pony orm for the first time for a project
> today. Feels great. Never even played with pony & prettier before

Now Mobx and Pony ORM are both libraries, so they don't matter in this
discussion. But prettier is the first code autoformatter I ever used, for
autoformatting JavaScript, and Atom is the first modern programmer's editor I
used. I used Atom because I wanted an easier and more reliable way to install
extensions. I now use VS Code, which is very similar.

Gone were the Emacs keybindings I knew and I started using ctrl-c, ctrl-v
keybindings everywhere. I actually became _more_ of an editor power-user; I
learned how to move lines and code blocks, and how to use multiple cursors.

And in the years after that, I found myself using more and more tooling. Editor
integrated linters. Static type checking. Autocomplete. Inline documentation.
LLM autocomplete (copilot).

I believe I'm not the only one who has experienced this shift.

## Why the shift?

What has changed? Is the tooling better or have I changed? I believe that using
these tools I can write higher quality code more efficiently, though I can't
prove that.

Did I lose something along the way? The core of how I develop hasn't changed
dramatically, I think. I build up tests when I write code. When there is a bug,
I sprinkle print statements around and think, rather than go for the debugger.
I try to be bold about refactoring early and often.

I think I'm more of a tool user because the tooling is better today, and more
accessible. It's a lot easier to install an extension into VS Code than it was
to install an Emacs extension. Now I know Emacs has an extension package
manager, and I even used one for a little while, but for me, then, the barrier
to entry was too high.

People expect a lot more from tooling now. A big force in that shift has been
the [Language Server
Protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol), which helped
create an ecosystem for tooling. It's easier to create and distribute tools
today.

Steele argues in "The IDE Divide" that it's very difficult to be a language
maven and tool maven at the same time, because there aren't enough hours in the
day to learn both. My modern observation is that if the barrier to access tools
becomes a lot lower, it's possible to learn a lot more tooling.

## How the tooling shift affects languages

The tooling shift is affecting older languages that did without much tooling
for a long time. There has been a big push to add static types to both
JavaScript and Python in recent years. One of the main reasons to do so is to
improve development tooling, but it does increase the complexity of both
languages. And getting all the development tools installed is still a
frustrating process of making choices and configuration.

Rust, a relatively new language that came to prominence when the tooling shift
was underway, took tooling very seriously early in its existence, and it
shows: quality tools are instantly available when you install the language.

So is tooling affecting the design of languages, or is the design of languages
affecting the tooling? There's a feedback cycle in both directions.

Another point made in "The IDE Divide" is that tooling requirements make it
harder for new languages that don't have much tooling yet to gain a foothold.
Now even language mavens like me are becoming more reliant on tools.

The LSP makes tackling the tooling story for a language easier, but it's still
an extra hurdle. LLM based autocomplete like copilot adds an additional
barrier, as a new language won't have a lot of code to train an LLM against yet
either.

On the other hand I believe new language development is in fact flourishing.
It's too early to say how the adoption curve of really new languages is
affected by the tooling shift.

## Conclusion

I think there has been a major shift in how developers use development tools in
recent years. People expect a lot more of them. I think having such tools
available helps developers. The tooling shift affects the design pressures on
both older and newer languages.
