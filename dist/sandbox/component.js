(function() {
  define(["core/command", "core/dev", "core/events", "core/http", "core/promise", "core/store", "core/util", "ext/mediator", "ext/framework"], function(command, dev, events, http, promise, Store, util, mediator, framework) {
    return util.extend({}, mediator, framework, command, promise, {
      dev: dev
    }, {
      events: events
    }, {
      http: http
    }, {
      Store: Store
    }, {
      util: util
    });
  });

}).call(this);
