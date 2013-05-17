(function() {
  define(["core/util", "core/events", "core/http", "core/promise", "core/command", "core/store", "core/dev", "ext/mediator", "ext/framework"], function(util, events, http, promise, command, Store, dev, mediator, framework) {
    return util.extend({}, promise, command, mediator, framework, {
      util: util
    }, {
      events: events
    }, {
      http: http
    }, {
      Store: Store
    }, {
      dev: dev
    });
  });

}).call(this);
