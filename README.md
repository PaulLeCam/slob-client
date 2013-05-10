Slob
====

Slob is a set of simple RequireJS modules made to abstract librairies such as Lo-Dash, jQuery, Backbone, Handlebars... and assemble them into a framework and other components to ensure modularity of application code.

Previous work
-------------

Slob is based on best-practices articles and presentations, most notably:

* [Scalable JavaScript Application Architecture](http://www.slideshare.net/nzakas/scalable-javascript-application-architecture) by Nicholas Zakas
* [Large-scale JavaScript Application Architecture](https://speakerdeck.com/addyosmani/large-scale-javascript-application-architecture) by Addy Osmani
* [Learning JavaScript Design Patterns](http://addyosmani.com/resources/essentialjsdesignpatterns/book/) by Addy Osmani
* [Building The Next SoundCloud](http://backstage.soundcloud.com/2012/06/building-the-next-soundcloud/) by Nick Fisher

Work in progress
----------------

This code is still in very early development, it requires lots of testing and is not appropriate for production applications.
Future developments will focus on adding tests and examples.

Architecture
------------

Slob architecture is made of 3 parts, defining 3 layers of abstraction:

* The **core** is made to abstract librairies and eventually split or assemble them into different functionalities. It also offers basic implementations of different design patterns and general-purpose utilities.
* The **extensions** purpose is to augment the core functionalities and provide new ones to match the needs of the application, assembled in a simple framework and a mediator.
* The **sandboxes** purpose is to provide a limited API of the core and framework functionalities to the actual application modules depending on their role, such as services and widgets.

License
-------

MIT - See LICENSE file
