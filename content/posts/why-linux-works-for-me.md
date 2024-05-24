+++
title = "Why Linux Works for Me"
date = 2013-11-23
slug = "why-linux-works-for-me"

[taxonomies]
tags = ["linux", "twitter"]
+++

# Introduction

I can't sleep because some weird Twitter interaction I had earlier. I
shouldn't let it bother me, but it did. I received a retweet from
someone I didn't know, saying: "Linux doesn't work. There. I said it."

There was a link to a [blog
entry](http://gandre.ws/blog/blog/2013/11/15/notes-on-linux-it-doesnt-work/)
describing various frustrating problems the author had with Linux, who
was sincerely trying it out; applications that didn't do what was asked
of them, things generally not cooperating, and intimations that others
had experienced pain as well. Constructive feedback all. It also said
Linux doesn't work. It said Mac OS X and Windows *do* work.

Heh, I thought, "Linux doesn't work" isn't really right. I've been using
this Linux thing since 1995. Obviously Linux works for me. So I replied:
"Heh, Linux works for me. Linux doesn't work *for you*."

Don't reply stuff to strangers on Twitter! The original person didn't
reply (and hasn't yet. probably still resting in all innocence of this
whole thing), but someone else jumped in and said I sounded dismissive
and unhelpful. So I tried to clarify and defend myself. I didn't mean to
dismiss the original writer's negative experiences with Linux, I was
just nitpicky about language. "Linux doesn't work" sounded
sensationalist to me. What works for one person might not work for
another. This lead to a bevvy of tweets back and forth that make me
understand Twitter rage a lot better. Maybe Twitter doesn't work. For
me. Tonight.

# More context

One IRC discussion later with yet more people, I understood the context
a bit better. It turned out that the original author was a woman,
something I had been completely unaware of, though I started to suspect
something was up when the word "mansplaining" was uttered by yet another
person. And here I thought I was just being a nitpicker. There are real
issues women face in tech, and I had just obliviously stepped into a bit
of a hornet's nest. I have more reading to do.

So after I calmed down I reviewed my words; getting caught up in
unreasonable defensiveness in 140 line texts about nothing. I sent a few
clarifications and "sorry didn't mean to be dismissive of your
experience" back to the original writer. At the very least I could have
been construed as "not constructive". Sure, it was a pretty mindless
nitpicky tweet.

I'm sure this blog entry is part of that defensiveness too, but let's
turn it into something constructive instead. Let's have a conversation
about Linux, and why it works for me. And to tell some stories.
Hopefully nothing sounds mansplainy.

# A Very Brief History of Linux Troubles

I have been struggling with issues on Linux so long that I feel quite
spoiled these days. Mostly when I install Linux things just work. I
remember back in 2000 or so I would have to work hard getting my *mouse*
to work. Back in 2004 or so I remember having to wrestle with
nsdiswrapper to install a Windows driver just to make the wireless work.
And I remember struggling to hear sound.

Back then I had to be my own sysadmin, or worse. Whatever is worse than
being your own sysadmin.

# Topsy-Turvy World

These days the hardware support is so much better. Generally after
installation the graphics, sound and wireless work. I guess this
astounds me so much given my past experience I'm too easily pleased,
perhaps.

I was spoiled with Linux graphics support for some years. I'd been using
the (properietary) NVidia drivers and they worked quite well on my
previous laptop and my current desktop.

In fact, on my previous laptop it worked better than on Windows and Mac
OS X, a rare story of a topsy-turvy world that I'll share. My wife got a
new Mac OS X laptop at about the same time. It turned out almost all the
hardware, from motherboard to video card, was the same as on my laptop.
It was just my laptop was cheaper and didn't look very cool. But, you'd
say, Mac OS X works out of the box, and with Linux you need to tinker a
lot. True usually. Not this time.

With Linux, I could just install the NVidia driver from the repository,
reboot, and things worked. On the dual boot Windows partition that I was
maintaining for games and rarely used (I've since given it up), I had to
find a hacked NVidia driver as for some reason laptop support wasn't
officially in there. I think that got fixed since then. Annoying, but
tolerable.

With Mac OS X, my wife would start a 3d application that she'd bought
the Mac for, and that worked on the previous one, and after a few
minutes the laptop would crash horribly. Hard reboot required. In
desperation we eventually installed a separate Windows partition and it
worked just fine there -- the hardware was fine.

No fix was possible; there was some bug somewhere in the NVidia driver.
But it was impossible to upgrade. We had to wait half a year or so for
Apple to create an update of their operating system including NVidia
driver, and then *buy the upgrade* to get this bug fixed.

Topsy-turvy world. Not usually true. But a good story.

# Present Day Troubles

So last year I got a new laptop, and mindlessly got NVidia again, as it
had worked so well for me before, and then was thrust into a chaos of
installation issues I just wasn't used to anymore. The reason is NVidia
Optimus, a technology to let your laptop save power by using Intel
graphics unless demanding 3d applications are run.

That really sucked. I was really frustrated. I didn't need nonsense like
that. Eventually I got it sorted out, switching from Fedora back to
Ubuntu, but it was painful. I must report that the support has much
improved -- I recently reinstalled my laptop and while I still had to do
some special installation, it started working then.

Then there was the wireless on the laptop. For some reason when not
plugged in the wireless driver would magically decide it was going to go
into Ultimate Power Saving Mode and slow my internet down to an absolute
crawl. I found a fix which was to turn the powersaving off, but it was
annoying. I can report again that this got fixed in more recent
versions.

My desktop is usually pretty stable, but I got into the habit of using
its suspend feature instead of shutting it down. That worked fine for a
long time, but after one update the desktop would come back from
suspend, pretend everything was fine for hours on an end, and then
suddenly crash. I'm not used to hard freezes on Linux. I hear reports
that this finally got fixed too, but I haven't dared to try yet, and
switched to shutdowns. It boots up very fast these days too, anyway.

# Why?

Why go through this trouble? While Linux is pretty good at it these
days, generally speaking Windows and Mac OS X come with better hardware
support. Why this Linux desktop? Is this free software ideology?

I don't think so. I'm not really a Linux advocate. I used to be more
passionate about it. I do still appreciate the freedom it gives me,
where I as a developer or power user can really dig down deep if I'm
willing to invest the time.

But now that it's finally finally yes this year for real the year of the
Linux desktop, I'm not going to try to convert people. I think software
freedoms are important, and wish more people would care, but people care
about convenience, which makes total sense, so am not an activist about
it.

I'm not a Linux desktop developer either. If I were I'd want to use my
own stuff, obviously, and others too, but that's not it.

The reason why Linux works for me is that I'm a developer. And I think
Linux is a kick-ass system to develop on, especially web applications,
where I know my code is likely to get deployed on Linux servers as well.

# Back to 1995

Back in 1995 I first installed Linux on my PC at home. I remember
lugging a lot of slackware floppies around, as I didn't have an Internet
connection at home yet either. Why did I go through the trouble? Because
Linux, for me who didn't have the money to buy software, made for a much
better development environment than MSDOS. If I wrote a C program on
MSDOS and I made a mistake, the machine would hang, and I'd had to
reboot it. If I wrote a C program with Linux, and I made a mistake, I
could shut down the process with control-C. Linux simply was a better
operating system than MSDOS; it made better use of my hardware at the
time. And it came with all these development tools.

# Back to the present

Windows and Mac OS X have caught up in the stability department. While
Windows Vista, the last Windows I'm somewhat familiar with, made you
jump through hoops and reboot a thousand million times if you wanted to
upgrade it after a year or more of no upgrades (something I went through
last year. Hopelessly confusing and even scary to people unfamiliar with
computers, like the ones I was helping), it generally does not crash all
that often.

But with Linux I can download and install a huge range of programming
environments and libraries and tools, from mainstream to obscure, within
*seconds*. Windows and Mac OS X don't match that. Modern Linux package
repositories are *awesome* for this purpose. I know I could get stuff
like that set up with Mac OS X or even Windows, but it'd entail more
tinkering than I have patience for. So the scales balance the other way,
for me.

Otherwise it's a matter of familiarity and "makes no difference". I'm
familiar with Linux. I think the modern deskop environments are pretty
slick. Linux makes me comfortable. I'd feel lost if I have to use
something else. The other stuff feels clunky. I'm sure I could get used
to it, but I don't see a reason to.

The web browser works. That's important. I remember a period in the
early 00s when Microsoft had won the browser wars, and Netscape 4.7 on
Linux was aging and sites started to be developed for IE only. Thank
goodness Firefox brought us out of that situation. The basic freedom of
the web is pretty safe now in our multi-browser world.

Even playing games is getting so much better that I dumped Windows
entirely. No more dual booting. Thanks Humble Indie Bundle, and thanks
Steam! And Kerbal Space Program. I can't play all games available, but
enough to keep me happy. It's really awesome, actually; I never thought
it'd get this far.

It's now so much easier to maintain a Linux desktop, I barely have to
touch a global config file anymore. I don't really feel like I have to
play sysadmin anymore. But I'm sure my perspective on it is warped by
the years of difficulty that has gone before.

# Linux for non-developers?

Can the Linux deskop work for non-developers too? I think it does
sometimes, and has. I suspect in some ways a modern Linux desktop can be
less confusing in the amount of popups and warnings it gives you than at
least Windows Vista could be. It's just that trouble starts when people
want to install familiar Windows software. Learning the replacements
takes time, and while some stuff will work better, some of it will be
worse.

So let me end this with a story. About ten years ago, I was staying with
my parents over Christmas. My mother's competent with computers, now so
more so than ten years ago, but not an expert by any means.

I was playing with a Linux distribution that could be booted directly
from cdrom, without installation, which was new at the time. I had it
inserted into my parents laptop, and forgot to take it out when I went
up to bed at night. The next morning I came downstairs to find my mother
had started the computer, and it had booted into Linux. She was happily
playing the games that came with it. I told her how amazing that was;
mom, you're using Linux! My mom is using Linux. It just worked.

2003, the year of the Linux desktop. Briefly. We took the cdrom out. She
uses Windows again. I haven't pushed Linux on her.

Because while I'm okay with being a sysadmin sometimes, I don't want to
be her permanent tech support. That might indeed be worse than being
your own sysadmin.

(not because it's my mom! she's great! and she doesn't read this blog,
so I'm not just saying that. and tech support people! it's just not for
me, that's all! thank goodness this isn't Twitter; didn't fit in 140
characters, this)

There. That's out of my system now. I shouldn't really let this stuff
bother me, but what can you do when it does? Hopefully now I can finally
sleep. A 7 year old and a 4 year old are visiting in a few hours,
joining our toddler in generating energy and activity, demanding my
attention. Good night! Zzzz.
