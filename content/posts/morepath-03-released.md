+++
title = "Morepath 0.3 released!"
date = 2014-06-23
slug = "morepath-03-released"

[taxonomies]
tags = ["morepath", "python", "planetpython", "python3"]
+++

Today I've released Morepath 0.3!

Morepath is a Python web framework that lets you write simple, flexible
code for the modern web, and makes linking to things as easy as it
should be.

New in Morepath 0.3 is the ability to write `path` directives that
[absorb](http://morepath.readthedocs.org/en/latest/paths_and_linking.html#absorbing)
the rest of the path. This is useful when you want to integrate a web
server with a frontend that does its own client-side routing using the
HTML 5 history API. In that case the server-side code needs an easy way
to absorb all sub-paths so it can pass them to the frontend router.

Another feature is the ability to mark views as
[internal](http://morepath.readthedocs.org/en/latest/views.html#request-view).
This allows you to write a view that is not published on the web but is
for reuse within other views.

Besides this Morepath 0.3 contains a number of bugfixes and
documentation improvements. See
[CHANGES](http://morepath.readthedocs.org/en/0.3/changes.html) for more
details.

If you like Morepath, please get in touch with me, either through the
[Morepath issue
tracker](https://github.com/morepath/morepath/issues?labels=&milestone=&page=1&state=open)
or the \#morepath IRC channel on Freenode. Let me know if there's
interest in starting a mailing list too!
