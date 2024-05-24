+++
title = "Server Templating in Morepath 0.10"
date = 2015-04-09
slug = "server-templating-in-morepath-010"

[taxonomies]
tags = ["planetpython", "python", "morepath"]
+++

# Introduction

I just released Morepath 0.10
([CHANGES](https://morepath.readthedocs.org/en/0.10/changes.html))!
[Morepath](http://morepath.readthedocs.org) is a modern Python web
framework that **combines power with simplicity of use**. Morepath
0.10's biggest new feature is **server-side templating support**.

Most Python web frameworks were born at a time when server-side
templating was the only way to get HTML content into a web browser.
Templates in the browser did not yet exist. Server templating was a
necessity for a server web framework, built-in from day 1.

The web has changed and much more can be done in the browser now: if you
want a web page, you can accomplish it with client-side JavaScript code,
helped by templates, or embedded HTML-like snippets in JavaScript, like
what the React framework does. Morepath is a web framework that was born
in this new era.

Morepath could take a more leisurely approach to server templating. We
recommend that users rely on client-side technology to construct a UI --
something that Morepath is very good at supporting. For many web
applications, this approach is fine and leads to more responsive user
interfaces. It also has the benefit that it supports a strong separation
between user interface and underlying data. And you *could* still use
server template engines with Morepath, but with no help from the
framework.

But there is still room for server templates. Server-generated HTML has
its advantages. It's the easiest way to create a bookmarkable
traditional web site -- no client-side routing needed. For more dynamic
web applications it can also sometimes make sense to send a
server-rendered HTML page to the client as a starting point, and only
switch to a client-side dynamic code later. This is useful in those
cases where you want the end-user to see a web page as quickly as
possible: in that case sending HTML directly from the server can still
be faster, as there is no need for the browser to load and process
JavaScript in order to display some content.

So now Morepath has now, at last, gained server template support, in
version 0.10. We took our time. We prototyped a bit first. We worked out
the details of the rest of the framework. As we will see, it's nice we
had the chance to spend time on other aspects of Morepath first, as that
infrastructure now also makes template language integration very clean.

# The basics

Say you want to use [Jinja2](http://jinja.pocoo.org/), the template
language used by Flask, in Morepath. Morepath does not ship with Jinja2
or any other template language by default. Instead you can install it as
a plugin in your own project. The first thing you do is modify your
project's `setup.py` and add `more.jinja2` to `install_requires`:

    install_requires=[
      'more.jinja2',
    ],

Now when you install your project's dependencies, it pulls in
[more.jinja2](http://pypi.python.org/pypi/more.jinja2), which also pulls
in the Jinja2 template engine itself.

Morepath's extension system works through subclassing. If you want
Jinja2 support in your Morepath application, you need to subclass your
Morepath app from the `Jinja2App`:

    from more.jinja2 import Jinja2App

    class App(Jinja2App):
        pass

The `App` class is now aware of Jinja2 templates.

Next you need to tell your app what directory to look in for templates:

    @App.template_directory()
    def get_template_directory():
        return 'templates'

This tells your app to look in the `templates` directory next to the
Python module you wrote this code in, so the `templates` subdirectory of
the Python package that contains your code.

Now you can use templates in your code. Here's a HTML view with a
template:

    @App.html(model=Customer, template='customer.jinja2')
    def customer_default(self, request):
        return {
          'name': self.name,
          'street': self.street,
          'city': self.city,
          'zip': self.zip_code
        }

The view returns a dictionary. This dictionary contains the variables
that should go into the `customer.jinja2` template, which should be in
the `templates` directory. Note that you have to use the `jinja2`
extension, as Morepath recognizes how to interpret a template by its
extension.

You can now write the `customer.jinja2` template that uses this
information:

    <html>
    <body>
      <p>Customer {{name}} lives on {{street}} in {{city}}.</p>
      <p>The zip code is {{zip}}.</p>
    </body>
    </html>

You can use the usual [Jinja2](http://jinja.pocoo.org/) constructs here.

When you access the view above, the template gets rendered.

# Chameleon

What if you want to use [Chameleon](https://chameleon.readthedocs.org/)
(ZPT) templates instead of Jinja2 templates? We've provided
[more.chameleon](http://pypi.python.org/pypi/more.chameleon) that has
this integration. Include it in `install_requires` in `setup.py`, and
then do this to integrate it into your app:

    from more.chameleon import ChameleonApp

    class App(ChameleonApp):
        pass

You can now set up a template directory and put in `.pt` files, which
you can then refer to from the `template` argument to views.

You could even subclass both `ChameleonApp` *and* `Jinja2App` apps and
have an application that uses both Chameleon and Jinja2 templates. While
that doesn't seem like a great idea, Morepath does allow multiple
applications to be
[composed](http://morepath.readthedocs.org/en/latest/app_reuse.html#nesting-applications)
into a larger application, so it is nice that it is possible to combine
an application that uses Jinja2 with another one that uses Chameleon.

# Overrides

Imagine there is an application developed by a third party that has a
whole bunch of templates in them. Now without changing that application
directory you want to override a template in it. Perhaps you want to
override a master template that sets up a common look and feel, for
instance.

In Morepath, template overrides can be done by subclassing the
application (just like you can override anything else):

    class SubApp(App):
        pass

    @SubApp.template_directory()
    def get_template_directory_override():
        return 'override_templates'

That
[template_directory](http://morepath.readthedocs.org/en/latest/api.html#morepath.App.template_directory)
directive tells `SubApp` to look for templates in `override_templates`
first before it checks the `templates` directory that was set up by
`App`.

If we want to override `master.jinja2`, all we have to do is copy it
from `templates` into `override_templates` and change it to suit our
purposes. Since a template with that name is found in
`override_templates` first, it is found instead of the one in
`templates`. The original `App` remains unaffected.

# Implementation

In the introduction we mentioned that the template language integration
code into Morepath is clean. You should be able to integrate other
template engines easily too. Here is the code that integrates Jinja2
into Morepath:

    import os
    import morepath
    import jinja2


    class Jinja2App(morepath.App):
        pass


    @Jinja2App.setting_section(section='jinja2')
    def get_setting_section():
        return {
            'auto_reload': False,
        }


    @Jinja2App.template_loader(extension='.jinja2')
    def get_jinja2_loader(template_directories, settings):
        config = settings.jinja2.__dict__.copy()

        # we always want to use autoescape as this is about
        # HTML templating
        config.update({
            'autoescape': True,
            'extensions': ['jinja2.ext.autoescape']
        })

        return jinja2.Environment(
          loader=jinja2.FileSystemLoader(template_directories),
          **config)


    @Jinja2App.template_render(extension='.jinja2')
    def get_jinja2_render(loader, name, original_render):
        template = loader.get_template(name)

        def render(content, request):
            variables = {'request': request}
            variables.update(content)
            return original_render(template.render(**variables), request)
        return render

The
[template_loader](http://morepath.readthedocs.org/en/latest/api.html#morepath.App.template_loader)
directive sets up an object that knows how to load templates from a
given list of template directories. In the case of Jinja2 that is the
Jinja2 environment object.

The
[template_render](http://morepath.readthedocs.org/en/latest/api.html#morepath.App.template_render)
directive then tells Morepath how to render individual templates: get
them from the loader first, and then construct a function that given
`content` returned by the view function and `request`, uses the template
to render it.

# Documentation

For more documentation, see the [Morepath documentation on
templates](http://morepath.readthedocs.org/en/latest/templates.html).

[Let us know what you
think!](https://morepath.readthedocs.org/en/latest/community.html)
