+++
title = "Grok's songlist application"
date = 2009-01-10
slug = "grok-s-songlist-application"

[taxonomies]
tags = ["grok", "framework"]
+++

I've been following with interest a number of posts that talk about
creating a simple REST-based web application that persists the number of
plays various songs have had. Here's the history:

- A pure WSGI application:
  <http://www.eflorenzano.com/blog/post/writing-blazing-fast-infinitely-scalable-pure-wsgi/>
- A easier to read but slower CherryPy application:
  <http://blog.dowski.com/2009/01/08/http-utilities-with-cherrypy/>
- An app using RESTish:
  <http://dev.timparkin.co.uk/2009/01/happy-medium-from-wsgi-to-cherrypy.html>
- And a followup using Werkzeug:
  <http://dev.timparkin.co.uk/2009/01/werkzeug-and-werkzeugish-example.html>

First a few comments on the protocol: the RESTfulness of this protocol
could definitely be improved. As was remarked by a comment on the
original post, REST-based apps return lists of URLs in overviews and the
overview in this app doesn't. I'd also modify the way new songs get
registered with the app and make that a POST request on the song
container, instead of implicity creating such resources by the mere act
of traversing. I haven't made any such modifications to the protocol
even though the last improvement would simplify my code as it'd let me
get rid of the `traverse` method.

I thought it'd be interesting to implement the same using Grok (1.0a1).
Without more ado, here it is:

    import grok
    from zope.app.publication.interfaces import IBeforeTraverseEvent

    class App(grok.Application, grok.Container):
        def traverse(self, id):
            if id not in self:
                song = self[id] = Song()
                return song
            return self[id]

    @grok.subscribe(App, IBeforeTraverseEvent)
    def applySkin(obj, event):
        # make rest layer the default if necessary
        if not IRESTLayer.providedBy(event.request):
            grok.util.applySkin(event.request, IRESTLayer, grok.IRESTSkinType)

    class IRESTLayer(grok.IRESTLayer):
        grok.restskin('main')

    class AppREST(grok.REST):
        grok.context(App)
        grok.layer(IRESTLayer)

        def GET(self):
            return ','.join(['%s=%s' % (k, v.count) for k, v in self.context.items()])

        def DELETE(self):
            for key in list(self.context.keys()):
                del self.context[key]

    class Song(grok.Model):
        def __init__(self):
            self.count = 0

    class SongREST(grok.REST):
        grok.context(Song)
        grok.layer(IRESTLayer)

        def GET(self):
            return str(self.context.count)

        def POST(self):
            self.context.count += 1
            return str(self.context.count)

Before I go into the good news (Grok gives you two important features
here that the other frameworks examples don't have), first the bad news.

It's about 10 lines longer than the CherryPy and Restish examples (the
Werkzeug example is shorter still but rather low-level).

Performance-wise it's the slowest of the bunch, on my machine, which is
comparable to the machines of the others (in my case an Intel Core 2 Duo
2400 MHz Linux box) I get about 580 requests per second (not too
shabby):

    Concurrency Level:      1
    Time taken for tests:   17.39500 seconds
    Complete requests:      10000
    Failed requests:        0
    Write errors:           0
    Total transferred:      2500000 bytes
    HTML transferred:       10000 bytes
    Requests per second:    586.87 [#/sec] (mean)
    Time per request:       1.704 [ms] (mean)
    Time per request:       1.704 [ms] (mean, across all concurrent requests)
    Transfer rate:          143.26 [Kbytes/sec] received

    Connection Times (ms)
                  min  mean[+/-sd] median   max
    Connect:        0    0   0.0      0       0
    Processing:     1    1   1.1      1      61
    Waiting:        0    1   1.0      1      60
    Total:          1    1   1.1      1      61

Now to the good news. The other examples all store their information in
a global variable in the form of a dictionary. _Gulp_. This application
actually features _true persistence_. When you restart your server, the
counted information is _still there_ - it's in the database. This means
that the benchmark actually includes _database access_ (to the ZODB).

You may have noted that there isn't much database access code there.
That's because the ZODB allows transparent persistence of Python
objects. This actually made it trivially easy to write this application
with true persistence.

The other has more to do with framework power. This is not low-level
code, and that shouldn't be underestimated. We have available to us a
framework that offers a ton of features, both out of the box and as
extensions. I'll talk about some out-of-the-box features here.

Grok's REST system allows you to extend existing (persistent) objects in
your application with RESTful behavior. These objects can retain their
original UI entirely. If I actually left out the applySkin code above,
the RESTful URLs would look like this:

    http://localhost:8080/++rest++main/song/1

and the normal URLs to the objects would look like this:

    http://localhost:8080/main/song/1

This means that you could give your app both a normal UI as well as
REST-based access. In the example I've used the applySkin line to
consolidate them into a single URL space however.

In addition, Grok's REST support also features a powerful and built-in
security system. You can give each access a permission by adding the
line `@grok.require`:

    @grok.require('some.permission')
    def GET(self):
        ...

Grok also takes care of URL management for you out of the box. The
objects in the app all have a URL automatically. Should I want to
display the URL of each song object in addition to its count I'd change
the GET line of `SongREST` to this:

    def GET(self):
        return grok.url(self.request, self.context) + ' ' + str(self.context.count)

If you want to see a much bigger REST-ful app I've written with Grok for
a customer (ID-StudioLab at the Technical University of Delft), please
check out [imageSTORE](http://code.google.com/p/imagestore/) (it comes
with a lot of doctests). It's a RESTful persistent storage of image
information.
