+++
title = "the purpose to my \"whinging\" about the transition to Python 3"
date = 2007-06-23
slug = "the-purpose-to-my-whinging-about-the-transition-to-python-3"

[taxonomies]
tags = ["python3"]
+++

# the purpose to my "whinging" about the transition to Python 3

Collin Winter
[writes](http://oakwinter.com/code/on-python-3000-whinging/):

"I’m getting pretty sick of seeing blog posts and mailing lists threads
endlessly bemoaning that, “the core developers…are causing a huge risk
to the Python community by splitting it asunder for a period of years“.
Gloom, doom, pox and peril, blah blah blah."

Collin's quoting me, so that means he's getting pretty sick of me, among
others. I don't think I've been exactly *endless* about this though.
I've been talking about this for a few days now, so Collin in getting
sick already seems to be displaying his rather fragile constitution. :)

I also see the following in the comments to Collin's blog by a certain
Matt:

"The complainant you reference obviously won’t be happy until Guido
drops the Py3K idea altogether, or at least delivers a personal apology.
The rest of us will move forward with our clear migration plan, and our
optimism for the next version of Python."

Clearly he hasn't read what I said very well. I'll quote my previous
blog entry:

"There is a significant cost in doing this. I think the Python community
can bear this cost. I am not sure whether the cost is worth the gain,
but Guido thinks it's a good idea, and he does have enough credit with
me to trust his judgement. I understand the attraction of cleaning up
the language in a backwards incompatible fashion."

Again, I *understand* that the core developers feel it necessary to
break backwards compatibility. I can see where this is coming from. I
sympathize with the goals. (besides that, radical cleanups are fun and
exciting to language developers too. that's fine) I remember talking to
Guido years ago about the kind of unicode reformation that Python 3 is
going to introduce. I also know that Python 3 is not dropping out of the
sky, and I have been fully aware that backwards compatibility is going
to be broken for some time now.

My comments are a note of caution amongst enthusiasm. I'm not saying
"stop in your tracks", I'm just trying to inform the community that
Python 3 is not only a good thing, but also carries significant risks. I
think it is good to have a bit wider awareness of that.

I also think that Collin better fortify himself with some vitamins,
because he will likely remember this as the gentle beginnings. :) A bit
of community push-back to the core language developers about this
doesn't seem to be an entirely bad thing. After all, we're users of this
great language and you're going to ask a lot from the community with
this change.

Now Collin writes that he has worked on technology to mitigate the risk.
I applaud his efforts. It also shows to me that Collin is taking the
difficulty seriously. Unfortunately the tone of his blog entry is rather
dismissive, which is less good, though I understand why. He's been
working getting this done, and now he gets random people like me that
complain before they've even tried things.

Still, I'd prefer a slightly different tone expressing what I trust is
the true attitude of the language develpers, that is: "we hear you, we
agree that this is a very serious issue, we realize what we're going to
put the community through, and we're working on it."

Now to a few points where I think we could learn from each other's
perspective.

Collin writes: "I have absolutely no pity for anyone trying to migrate
to Python 3 without a test suite; you’re doing something fundamentally
stupid and we will not bend over backwards to save your dumb ass."

I see a *lot* of Python code out there in the real world being used in
production that doesn't have very good test coverage. I think a little
bit of pity for the dumb asses who decided to commit to the Python
language without writing proper unit test suites would do the core
developers good.

Some notes on test driven development: widespread adoption of
test-driven development in the Python world goes back to 2001 or
thereabouts - the unittest module made it to the library about then, I
believe. Python is about a decade older than that, and developing
without a test suite was a normal enough way to write Python code
throughout the 90s.

Lots of actual production code is not very well tested. You can say
people who wrote this code are stupid, but I don't think that's very
productive position to take. Sometimes people writing the code have
reasonable excuses for less than 100% test coverage. For instance, it is
difficult to properly test user interface code, which can take up a
significant portion of a codebase. A good example of this is game code.
There is quite a lively subcommunity of game developers in the Python
world, and I don't think many games have good automated test coverage.

Sometimes people act out of expediency, or are in a hurry, or don't know
any better even though they should, or simply disagree about testing
altogether - do we want to say those people shouldn't be part of our
community?

I must also note that Python has for a long time been actively promoted
to beginners who are learning how to program. Beginners are unlikely to
be very test-happy yet. They may also have produced code bases they
consider to be valuable. To alienate this audience would be against the
spirit of Python.

(By the way, I wonder what the plan is for Python C extensions. Are they
going to break? Are people to rewrite their C code? Is SWIG going to
work? I know that Pyrex will need a major update, for instance, so that
would mean difficulty in porting [lxml](http://codespeak.net/lxml).)

Instead of calling lots of people dumb and having no pity for them,
which sounds like the language developers would like to ignore their
problems altogether, it might be better treat these people with a bit of
understanding. Hopefully there are at least minor things that can be
done to help these people migrate towards Python 3. I'd like to ask the
language developers to keep their eyes open for these possibilities.
Just showing some patience and understanding will get you a long way
even if you can't do anything to help them concretely, by the way.

Now on to preparedness. The porting difficulties and risks lead me to
believe that we are going to have to deal with a situation of two
Pythons for quite a few years. Codebases written for one Python will be
inaccessible to the other Python without additional effort to port
things back and forth across the barrier. Let us, as a community, go
into this situation with open eyes. Let us be aware of the risks and the
costs. Let the language developers display patience and understanding,
because they realize they are asking a lot from the communities that use
this language. A community prepared will be able to handle the
transition difficulties a lot better than a community going into it with
blind optimism.

Colin writes: "If you think you can do better, show us the code. Talk is
cheap."

I'm not saying I can do better. I'm trying to inform the community that
we're in for a ride, that this ride is going to take a while, and the
ride won't be all be fun, even if we believe the destination is worth
it.

I can show Collin a *lot* of code, by the way, but I don't need to: just
study the cheeseshop. Talk is cheap, indeed. All that code is not.
