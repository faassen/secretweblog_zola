+++
title = "Five-based i18n in Silva checked in (PTS Delenda Est)"
date = 2005-12-02
slug = "five-based-i18n-in-silva-checked-in-pts-delenda-est"

[taxonomies]
tags = ["i18n", "zope", "silva"]
+++

# Five-based i18n in Silva checked in (PTS Delenda Est)

Last summer the [Five](http://codespeak.net/z3/five) project pulled Zope
3's i18n architecture into the Zope 2 world, thanks to work done by
[Philipp von Weitershausen](http://worldcookery.com), [Lennart
Regebro](http://blogs.nuxeo.com/sections/blogs/lennart_regebro/) and
others (please forgive me if I forget someone!).

And yesterday, Philipp posted [a useful
article](http://worldcookery.com/files/fivei18n/) on his site describing
how to use it.

He probably didn't expect that
[Silva](http://www.infrae.com/products/silva) was going to switch over
to this codebase the next day! I ran into yet another unicode error in
Silva today when I was hacking on it. It was the last straw.
PlacelessTranslationService's wild hackery had been screwing up Silva's
unicode support up long enough... Like [Carthago of old to the ancient
Romans](http://en.wikipedia.org/wiki/Third_Punic_War),
*PlacelessTranslationService Delenda Est*: it must be destroyed.

Thanks to the great work done by the Zope 3 developers, the Five
developers, and the nice article Philipp wrote about it, a few hours
later PlacelessTranslationService had been purged from Silva. Lots of
custom cruft has been removed from Silva, and removing code while
retaining functionality is always good.

This is part of a general trend in the Zope world; people are throwing
away their custom code and can start to rely on cleaner solutions
developed lower down the framework. This allows for smooth evolution and
convergence between frameworks. It increases the size of communities
using the same codebase, which makes it more likely people will work on
it to improve it. I believe that the Zope community, with Five and other
efforts, is only beginning to tap into the full potential of this
pattern.
