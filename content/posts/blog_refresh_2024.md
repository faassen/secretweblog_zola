+++
title = "Refreshing my Blog Again"
date = 2024-05-26

[taxonomies]
tags = ["blog", "rust", "python"]
+++

I've refreshed my blog again! Let's talk a bit about the history of this blog,
and more specifically the technology behind it.

I started my blog in January 2005. It's been a while.

<!-- more -->

## Newsbruiser era

The first blogging system I used was called newsbruiser. It was the heyday of
the CMS, so newsbruiser had a web user interface where you could enter
restructured text, and then blog itself generated pages dynamically on the
server. It ran on the server of a friend of mine.

## Nikola era

In 2013 I decided to change things around with a new blog engine,
[Nikola](https://getnikola.com/) and also changed the server to the current
one: <https://blog.startifact.com>. It was still serving restructured text. [I
wrote about the change back then](@/posts/new-blog-engine.md). Thank you
Nikola, you did very well too.

## playing with Zola

But I felt the itch to refresh my blog again. Not for any particular reason,
but just because it's nice to change things once every while. It looks more
modern again.

Since recently I've been programming a lot in Rust, I figured I'd try
[Zola](https://www.getzola.org/). Zola has themes, and the theme brings a lot
to the table too, and I picked the [Tabi
theme](https://www.getzola.org/themes/tabi/).

I tried configuring a simple blog with it, and got along with Zola and Tabi and
figured out how to do the things I want.

It was time to see whether I could convert my blog data.

## the conversion and cleanup

zola uses markdown, and all my blog posts are in restructured text. I wrote
some code that uses pandoc to convert all my old blog posts from restructured
text to markdown. Note that I dislike restructured text, but markdown is
everywhere. pandoc is great!

I discovered I was using like 4 different subtly different datetime formats in
my old blog to track publication dates. I figured that was excessive, and the
time has never really done much for me either, so I converted them all into
simple dates.

I then spent a lot of time fixing up links and cleaning up stuff. Internal
links I broke in the 2013 transition now work again!

## performance

I like Zola - it was easy to install and easy to configure. The Tabi theme
makes it look nice.

I figured that since Zola is written in Rust it would be fast. I admit I am a
bit disappointed. It takes 7 to 8 seconds to regenerate all 233 pages. That's
not a lot, but `zola serve` makes it worse, as it watches the filesystem for
changes and then reruns the update if there is on.

I also see no debouncing happening, so every file change triggers a rebuild (I
noticed a commit 2 days ago may help). So if I save a file every few seconds
(and I often do!), or do a search/replace over a lot of blog entries (which I
was doing fixing up links), Zola sits there and rebuilds the blog over and over
again.

I have now learned about `zola serve --fast` which at the cost of consistency
between pages only updates the page being edited. That's definitely a lot
better.

I've brought up the runtime issue with the Zola devs and they say it may be a
bug as it should be able to scale to much larger number of pages. So we shall
see!

All of this is tolerable enough, anyway.

**Update 2024-05-30**: after some debugging it turns out the Tabi theme was
doing something expensive when accessing the configuration. An easy fix later
my whole blog builds in well under a second. The Tabi theme developer, who is
extremely responsive to my feedback, has already accepted this fix too. That's
more like it!

## preserving comments

Newsbruiser had a comment system, and with Nikola I used Disqus. During the
transition to Nikola I worked to move over the comments into Disqus, but they
seem to be gone now. I have moved a few select pages and comments into the main
text, so they are preserved.

## posting intentions

Of course there's no point in refreshing my blog if I don't have any intentions
to post. I have a bunch of drafts written and I hopefully will start posting
again more regularly. The blog has a [feed](/atom.xml), so I hope some of you
stick around to read it! Meanwhile, dive into the [archive](/archive). There is
a lot of stuff that talks about technology that has losts its relevance, which
may or may not be interesting to you. For more timeless stuff, check out [the
highlights](@/posts/secret-weblog-highlights.md) I wrote, um, almost 5 years ago already.
