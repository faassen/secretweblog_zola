# Software to the People

I'm a software developer. Now LLMs are here, and LLMs change everything about
software development. A lot of the expertise I built up over over [40 years] of
working on software is now less valuable; machines can do a better job in many
cases. There's an irony in this, as one thing software developers have been
doing since the start of software development is automating processes done by
humans.

That a machine can now develop software more quickly than I can worries me and
depresses me. It also makes me think about what new possibilities it opens for
me and others, and how society could handle all this. I have to do that.

So this post is going to be optimistic, not because I believe the future is
rosy, but because it's useful to have positive visions of the future that we can
make small steps towards. Perhaps we even *need* them -- without a positive
vision we're left with thinking everything status quo or in decline. That
doesn't seem like an good attitude. I need them.

I'm deliberately not going to talk about the many downsides of AI. The ones I
worry about the most are [information pollution] and centralization of power,
and there are many, many other downsides. But I don't think this technology is
going to go away, and cool new things are also possible now, so let's think
about how we can make it work for us. But I can't stop you from putting me in a
mental box of your choosing, and you don't need to read this.

## Non-programmers can now program

[Back in the 80s] for a little while, when you bought a home computer and booted
it, it booted into a command prompt where you could write Basic programs. When
you bought the computer, it shipped with a book on how to program it in Basic.
It was in the box. 

Computer users were encouraged to write software. In part this was because
computers weren't so useful yet, and were restricted to a relatively small
audience, but in part it was philosophy: this is a device that users can
program. Let's help them.

You also had environments like Hypercard to lower the barrier to creating
software, and the early web also had this philosophy in the sense anyone could
create their own HTML pages. Even a 1990s quick GUI constructor like Visual
Basic or Delphi had a drastically lower barrier to than most development had in,
say, 2020. 

We went far away from that over the years, for a host of reasons, both good and
bad. The only easy to access programming language today that I know of is one
inside Excel and other spreadsheets [purely functional]. As software developers
in general we have not supported empowering users, and often actively worked
against it in one way or another.

But it's 2026 now. Suddenly, a non-programmer can create a program useful to
them, just by describing it. 

This ability is still mostly hidden away to expert computer users. The chatbot
websites do offer a way to create a little bit of HTML and JavaScript, and I'm
sure there's other stuff going on I haven't looked into, as well.

*But what if this was your phone?*

## The phone as the portal to the computing world

I am typing this on a desktop computer. I'm weird. Most people don't even have
laptops. Most people engage with the computing world through their phone. The
phone is one of the most locked down, programmer-hostile computing devices out
there. It's vastly more powerful than 1980s super computers, it's connected to
high-speed internet, and what it does is track you, manipulate you and spy on
you.

What if the phone was a lot more like a 1980s home computer instead? You get a
new phone. You start it. It has no apps. It just asks what you want. So you ask
it to build the things you need. And then you do have apps.

Obviously current day phones are nothing like this, and the powers that be that
control our phones and apps have absolutely no interest in making them be like
this as far as I can see.

## The benefit of your own apps

If you build your own app, it's not going to spy on you. The parts of the
platforms and (web) APIs your app uses can still spy on you of course, but it's
at least a *signicant limitation* on spying.

Your own app isn't going to try to advertise to you. Your app isn't going to
suddenly update and destroy the features you liked most. Your app isn't trying
to manipulate you into addictive behavior. Your own app won't have dark UI
patterns to please agree to share all your data with our 700 partners. Your app
does what you need it to do, no more, and no less. It might be horribly broken
of course, but it's easy to create a new one.

## You are not alone

But even though making an app yourself is now pretty easy, not everybody is
going to be doing it, right? Not everyone has the time or judgement, even if
it's drastically easier to do so today. That's correct.

But you're not alone. What if you could share app source code with friends?
Useful techniques and patterns and apps can spread. Or you can say, I want an
app just like this one, but please modify it for me to do this differently. And
then you share that.

## Migating risk

What would a phone look like that supported this kind model of engagement with
computing, and made it not only easy, but also safe?

The phone platform needs to have a solid base that exposes capabilities only as
needed, easily reviewed. One of the main risks to users building their own apps
is that those apps could be hopelessly insecure. The platform needs to have
safeguards: that apps run in a sandbox and that the system only exposes those
capabilities they actually need. 

The Android permission model has elements of this, but is controlled by an
advertiser. But you can be a lot more radical: [WebXdc] is a web-based sandbox
for apps that originated in the [DeltaChat] project that offers the beginning of
such a sandboxed approach. WebXdc counteracts centralization by restricting who
these apps can talk to - only their peers in the same chat channel, not the open
internet.

And consider this: we see a lot of news about LLMs being great at find security
flaws now. 

So you could ask an LLM to analyze the app's source code you got from a stranger
for problems before you use it. 

Or what gets distributed is not an app but a [description of how it works] that
can be audited. 

Some failures of apps are far more critical than others. If I book an airline
flight with my own app, I better be sure that the booking went through, and not
too soon either! This suggests some kind of safeguarded core again, with the
ability to see, cancel and confirm important transactions.

There are more risks - prompt injection for instance. But we're not alone. To
make sure we are safe, we need to help and support each other. Having a network
of trust is something we need to have on the internet *too*.

## Capabilities of the platform and internet

What else could such a phone platform do? I think a common approach to UI would
be useful, so that your apps look similar by default. I think the platform can
take care of a lot, it just needs to step out of the way when it comes to actual
end-user functionality.

To be useful, many apps would need to talk to the wider internet. The web would
turn more into a web of data services rather than a web of UIs. This is a
transformation that has been long underway, but that transformation would
finally become actually useful to end users. 

For privacy and decentralization, nothing beats peer to peer. DeltaChat for
instance is not dependent on centrally controlled servers, but lets anyone host
it. Via [Iroh] it can also talk completely peer to peer. And it's good enough
for many apps. Your text editor or game may not need internet access beyond
being able to share stuff with your friends.

## Could this work?

The appeal to centralization, both for the purposes of user convenience and
control over users isn't going to be go away. But we can as a society, people
working together, give more weight to the more decentralized alternatives,
because in real ways it can be *less* user hostile too. For quite a while made
illegally downloading copyrighted material was not only cheaper but *also more
convenient*. A decentralized alternative can keep the centralized powers in
check.

There's a lot to be figured out. I'm aggressively handwaving here. But I hope I
have sketched a more positive vision of what's possible. And if so, now you have
this idea in your head as well. Maybe that will mean something to the future.


