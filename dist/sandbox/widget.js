(function() {
  define(["core/util", "core/dom", "core/events", "core/promise", "core/command", "core/store", "core/dev", "ext/mediator", "ext/framework"], function(util, dom, events, promise, command, Store, dev, mediator, framework) {
    return util.extend({}, promise, mediator, framework, {
      util: util
    }, {
      dom: dom
    }, {
      events: events
    }, {
      Store: Store
    }, {
      dev: dev
    }, {
      request: command.request
    });
  });

}).call(this);
