(function() {
  define(["core/util", "core/events", "core/http", "core/promise", "core/command", "core/store", "core/dev", "ext/framework"], function(util, events, http, promise, command, Store, dev, framework) {
    return util.extend({}, promise, command, framework, {
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
