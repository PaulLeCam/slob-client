(function() {
  define(["core/command", "core/dev", "core/events", "core/http", "core/mvc", "core/promise", "core/store", "core/util", "ext/mediator", "ext/routing"], function(command, dev, events, http, mvc, promise, Store, util, mediator, routing) {
    return util.extend({}, mediator, promise, command, {
      dev: dev
    }, {
      events: events
    }, {
      http: http
    }, {
      routing: routing
    }, {
      Store: Store
    }, {
      util: util
    }, {
      mvc: {
        Model: mvc.Model,
        Collection: mvc.Collection
      }
    });
  });

}).call(this);
