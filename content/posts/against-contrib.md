+++
title = "Against \"contrib\""
date = 2014-08-11
slug = "against-contrib"

[taxonomies]
tags = ["open source", "python", "planetpython"]
+++

It's pretty common for an open source project to have a "contrib"
directory as part of its project structure. This contains useful code
donated to the project by outsiders. It seems innocuous. A contrib
section, why not?

**I don't like contrib**. A contrib directory gives the signal that
"yes, we carry this source code around, but it's not *really* part of
our project". What does that mean? Why is it even part of your project
at all then? Why isn't this code distributed in library form instead?
I'd much prefer the project to be smaller instead, as in that case I
wouldn't have to worry about the contrib code at all.

Perhaps in the case of *your* project, placing code in contrib doesn't
really mean "it's not really part of our project". Perhaps the code in
contrib is meant to be a fully supported part of project's codebase. If
so, why use the name "contrib" at all? It doesn't signal anything
functional -- it only signals something about origins, which is why
people should suspect any claim that it's a fully integral part of the
project. **Projects, instead of dumping something in contrib, just put
that code in its appropriate place and really own it.**

# Arguments for contrib

One argument for a contrib section is that by placing code there, the
tests are automatically run for it each time you run the tests in the
core code. This way a project is in a position to fix obvious breakages
in this code before release.

There's a problem with this approach: more subtle breakages run the risk
of being undetected, and nobody is clearly in charge of guarding against
that, because the code isn't really owned by the project *or* the
contributor anymore. It's in this weird contrib half-way house.

Besides, we have plenty of experience as an open source community with
developing extension code that lives outside of a project. Making sure
extensions don't break and get fixed when they do requires communication
between core library authors and extension authors. I think it's mostly
an illusion that by placing the code in contrib you could do away with
such communication -- if a project really wants to do away with
communication, really *own* the code.

**Placing code in contrib is not a substitute for communication.**

That's not to say the current infrastructure cannot be improved to help
communication. For instance, in the Python world the
[devpi](http://doc.devpi.net/latest/) project is exploring ways to
automatically run the tests for dependent projects to see whether you
caused any breakage in them.

Another argument for a contrib section has to do with discovery. As a
user of your project I can look through contrib for anything useful
there. I don't have to go and google for it instead. Of course googling
is really easy anyway, but...

If you want to make discovery easy, then add a list of useful extensions
to your project to the project's *documentation*. Many projects with a
contrib directory do this anyway. But that already takes care of
discovery; no reason to add the code to "contrib".

And again, infrastructure can to help support this -- it is useful to be
able to discover what projects depend on a project. Linux package
managers generally can tell you this, but I can see how
language-specific ecosystems can offer more support for this too. For a
Python specific example, it would be useful if PyPI had an easy way to
discover all projects that depend on another one.

# Effects on contribution

As an open source project developer you should want to attract
contributions to your project. **When you add code to "contrib", you
tell a contributor "your contribution is not a full and equal part of
this project". That's not a great way to expand your project's list of
core contributors...**

And you are a new contributor who wants to improve something in the
contrib of a project, who do you even talk to? You might be worried that
the project owner will say: sorry, that code is in contrib, I don't care
about improving it. **Since people are less confident that the project
even cares about code in "contrib", that discourages them from trying to
contribute to that code**

# Summary

Don't add code to a "contrib" section of your project. **"contrib",
paradoxically, can have a chilling effect on contribution**. Either
maintain that code externally entirely, or make your project really own
that code.
