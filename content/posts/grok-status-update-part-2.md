+++
title = "Grok Status Update Part 2"
date = 2008-06-03
slug = "grok-status-update-part-2"

[taxonomies]
tags = ["grok"]
+++

I continue yesterday's [status
update](http://faassen.n--tree.net/blog/view/weblog/2008/06/02/0) with
some more topics. Lots of stuff is going on in the Grok world!

**grokproject improvements**

Maurits van Rees, Tim Terlegård, Reinout van Rees and others at the
Grokkerdam sprint worked on improving grokproject in many ways:

- improve paster integration
- less questions asked and better defaults
- less different URLs are involved when installing grokproject the first
  time, as we now have the ability to bundle a lot of eggs in a big
  file, lowering the chance of the installation failing because some
  site we pull in an egg from happens to be down.

After the sprint, Maurits continued to work on `z3c.recipe.eggbasket`,
which should make this easy to manage for developers and release
managers. All this is coming to you in Grok 0.13, if not earlier in an
interim grokproject release.

**megrok.kss**

Godefroid Chapelle, Jeroen Vloothuis, Jean-Paul Ladage and others worked
on polishing off [KSS](http://kssproject.org/) support in Grok, in the
form of the Grok extension `megrok.kss`. KSS is a powerful, declarative
way of doing AJAX in the form of something very much like a CSS sheet.

KSS actions have now become views on views, which seems to be a good
place, as KSS actions actually typically apply to the view itself (on
the browser-side, so HTML). Documentation on KSS was also extended, and
some discussions were started about the KSS APIs. Jeroen switched over
the extension to use KSS's new base library, `kss.base` with Grok, so
we're up to speed on the latest and greatest KSS.

**the url method**

Thanks to the work done by Peter Bengtsson and Jan-Jaap Driessen at the
Grokkerdam sprint, the `url` method on views now has an extra optional
parameter, `data`, which can be passed a dictionary with query
parameters.

A test coverage analysis and a bug report showed there were still
problems with the support of the url method in viewlets and viewlet
managers. This led to some discussions as to how fix viewlets. Work is
being done to fix this on a branch by Jan-Wijbrand Kolman.

**megrok.responseheaders**

Peter Bengtsson (and I know others worked with him, but I now forget
who.. sorry!) worked at the Grokkerdam sprint to develop a package
called `megrok.responseheaders`. This is a nice example of how Grok can
be extended with new directives for existing views. It adds two new
directives, `http_content_type` and `http_cache_control`. These can be
added to view classes to control view content type and cache control
information.

Right now it's only available in SVN,
[here](http://svn.zope.org/megrok.responseheaders/), as it is based on
some changes made in a newer version of our Martian configuration
library. Once Grok 0.13 is released, it'll need a bit of polishing and
can be released.
