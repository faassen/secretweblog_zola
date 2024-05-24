+++
title = "Tramline source code now available"
date = 2005-11-11
slug = "tramline-source-code-now-available"

[taxonomies]
tags = ["wsgi"]
+++

# Tramline source code now available

At the Plone conference 2005 I gave a lightning talk about tramline, a
lightweight up and download accelator for web applications. Now at last
I've found some time to put the source code online. This is not a proper
release yet, but it's there for interested people to take a look at it.

What is tramline about? From the readme:

> Tramline is a upload and download accelerator that plugs into Apache,
> using mod_python. Its aim is to make downloading and uploading large
> media to an application server easy and fast, without overloading the
> application server with large amounts of binary data.
>
> Tramline integrates into Apache using mod_python. The application
> server is assumed to sit behind Apache, for instance hooked up using
> mod_proxy or mod_rewrite.
>
> Tramline takes over uploading and downloading files, handling these
> within Apache. Only a small configuration change in Apache should be
> necessary to enable tramline.
>
> The application server remains in complete control over security, page
> and form rendering, and everything else. Minimal changes are necessary
> to any application to enable it to work with tramline; in fact it's
> just setting two response headers in a few places in the code.

Tramline is generic code, but is particularly useful for Zope
applications. Zope's object database, the ZODB, has one drawback: it
doesn't scale very well when large binary files are put into it. In
addition, many appservers have only limited resources available to
handle large upload or download processes. Tramline works around both
issues by letting Apache and the filesystem handle both.

Pay careful attention to the installation instructions. Tramline
currently needs a one-line patch in mod_python (a Python file so that's
easy, thankfully). It also needs the latest version of Apache 2.0
(2.0.55), that was released last month.

Here's where to find the source:

<http://codespeak.net/svn/rr/tramline/trunk>

If you want to give feedback or help out, please do! We have a mailing
list, here:

<http://codespeak.net/mailman/listinfo/tramline-dev>

*Update*: credit where credit's due: this is of course a project I built
for [Infrae](http://www.infrae.com), like almost all of the code I
write. Tramline was conceived by myself and Jan-Wijbrand Kolman.
