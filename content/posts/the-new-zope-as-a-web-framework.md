+++
title = "The New Zope as a Web Framework"
date = 2013-10-28
slug = "the-new-zope-as-a-web-framework"

[taxonomies]
tags = ["python", "planetpython", "zope"]
+++

# Using the New Zope

In 2004 the new Zope had started make it back into the old Zope through
the Five project. In 2005 I also had the opportunity to use the new Zope
in its pure, unadulterated form in a new project.

The overall experience of coding in the promised land of the new Zope
was mixed. On the one hand, if you wanted to write Python code it was
clearly a much cleaner environment than the old Zope. The new Zope also
was great at supporting all kinds of forms of extensibility in a clean
way through its component and configuration systems.

On the other hand, I found myself having to edit too many files at once
to get things done. You'd have the actual Python modules that contain
the application code, a Python module that described the API of the
various objects in your system (`interfaces.py`) and a XML file that
described how these objects plugged into the system and with each other
(`configure.zcml`).

I'm a lazy developer. I don't want to edit three files where I can edit
only one.

Why was this problem not as big in the old Zope after we added the new
Zope technologies to it? An important reason for this was the new Zope's
security system, not shared by the old Zope.

The new Zope had a transparent proxy system that made sure you could
only access an attribute on a Python object if you had permission for
it, otherwise you'd get an `AttributeError`. And you'd give yourself
permission by adding it to the `configure.zcml` (or the `interfaces.py`,
where it could then be picked up from). If you forgot, you'd be staring
at an AttributeError.

I found this pretty hard to use myself. All together the new Zope slowed
down the feedback cycle for me, making it hard for me to stay in the
flow when coding.

Let's make it clear: I also really appreciated the qualities of the new
Zope. But I thought that these complexities made life harder for myself
and also would hinder the adoption of the new Zope by other developers.
It was different enough conceptually already, and its verbosity could be
quite intimidating to many.

# Rise of the web frameworks

In 2005 the shape of web development was undergoing a significant
change. While there had been web frameworks for years, they were
becoming more popular, and the concept was finally coming into a more
clear focus. This was in a large part due to the rise of Ruby on Rails.
In the Python world Django and TurboGears were making a big splash.

Ruby on Rails attracted developers from Java who were really happy to
find _reduced_ complexity of configuration. And here we were with the
new Zope adding more of it. How was the new Zope going to compete as a
web framework?

I saw these problems, but many of the other developers of the new Zope
did not share my concerns. Different developers have different
strengths, and the developers of the new Zope were pretty smart ones.
Many of them had no problem editing 3 files at once and adding lots of
configuration XML to `configure.zcml`. They could keep all of this in
their heads and remain productive. Or, as they argued, doing it this way
_gained_ you something too and they didn't want to lose that.

It was my problem. So how was I going to fix this? In 2006, I decided to
go around the center, and start a new project to try to turn the new
Zope into a modern web framework: Grok.

This blog entry is a part of a [series on
Zope](/posts/my-exit-from-zope) and my
involvement with it.
[Previous](/posts/jim-fulton-zope-architect).
[Next](/posts/grok).
