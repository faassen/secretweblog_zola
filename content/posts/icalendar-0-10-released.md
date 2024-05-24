+++
title = "iCalendar 0.10 released!"
date = 2005-04-28
slug = "icalendar-0-10-released"

[taxonomies]
tags = ["release"]
+++

The last couple of months I've been heavily involved in a cool Zope +
Five based project involving calendaring, about which more will be
announced shortly. As part of this project I've had the opportunity to
improve [Five](http://codespeak.net/z3/five). The project also needed
support for the [iCalendar RFC](http://www.ietf.org/rfc/rfc2445.txt),
and this lead to me to become the janitor of the awesome Python
[iCalendar library](http://codespeak.net/icalendar).

The iCalendar specification defines a format for importing and exporting
information about calendars. Basically, you can specify in it that a
particular event with a particular title will be happening on a
particular date. There is however much more to it; certain events recur
every week, for instance, and there is a way to describe that. Events
may be private or public, and there's a way to describe that. And so on.

When I was faced with the task to enable iCalendar support for the
project I was working on, I did a websearch first, to see whether there
was any package that did this already out there. I already knew the
[Schoolbell](http://www.schooltool.org) project has an implementation,
but wanted to make sure I wasn't missing something.

Soon enough I ran into the iCalendar package created by [Max
M](http://www.mxm.dk/). It seemed general and capable, more so than the
schoolbell code, and I figured I'd give it a shot using it. I did have a
few smaller niggles though: I did not like the package and module
structure very much -- the files were CamelCase and all directly in the
distribution directory, and I've become used to a more structured
approach with lowercase package names and a setup.py and the like. The
package contained many doctests, but didn't contain any testrunner to
run them all at once, so I wanted to fix that too.

I contacted the author, Max M, and I got permission from him to move the
stuff over onto [codespeak.net](http://codespeak.net) subversion and
restructure the package structure. It turned out he had some requests
from other parties as well, including Linux distributors.

So I became what I can best describe as this project's janitor. I
reorganized the package structure, hooked in a test runner, and cleaned
up various texts some. I do not think I actually touched the code at all
so far, though there are a few places where I have some ideas for
improvements now.

The more I used the iCalendar package in the project afterwards, the
happier I became about it. It is very powerful and the iCalendar
import/export facility came together very quickly. My goal for the
iCalendar package became broader: I must let others know about this! It
needed a project website, mailing lists, the works! We must form a
community of users so we can work on this together. Being a project
janitor is a new and interesting experience to me, and we'll see whether
my efforts will help make the library more well known. If we can
establish a community to develop it beyond Max M, myself and Lennart
Regebro (who created a simple setup.py), I also have a chance of not
being its janitor forever. :) One of my hopes is that the schoolbell
people will start using this instead of their home-grown import/export
system.

Max M graciously gave his permission to start working on a web presence
on codespeak.net. The result of this is that for the release today, I've
also (thanks to the great guys at codespeak.net) set up little a
[website](http://codespeak.net/icalendar) that I linked to earlier. We
also got a mailing list and checkins mailing list now. If you're
interested in this project, I hope you'll subscribe.
