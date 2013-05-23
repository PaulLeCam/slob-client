(function() {
  define(["core/command", "core/dev", "core/dom", "core/events", "core/promise", "core/store", "core/util", "ext/mediator", "ext/framework", "ext/widgets"], function(command, dev, dom, events, promise, Store, util, mediator, framework, widgets) {
    return util.extend({}, mediator, framework, widgets, promise, {
      dev: dev
    }, {
      dom: dom
    }, {
      events: events
    }, {
      Store: Store
    }, {
      util: util
    }, {
      request: command.request
    });
  });

}).call(this);
