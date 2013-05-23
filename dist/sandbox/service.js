(function() {
  define(["core/command", "core/dev", "core/events", "core/http", "core/promise", "core/store", "core/util", "ext/mediator", "ext/framework"], function(command, dev, events, http, promise, Store, util, mediator, framework) {
    return util.extend({}, mediator, promise, command, {
      dev: dev
    }, {
      events: events
    }, {
      http: http
    }, {
      Store: Store
    }, {
      util: util
    }, {
      routing: framework.routing,
      mvc: {
        Model: framework.mvc.Model,
        Collection: framework.mvc.Model
      }
    });
  });

}).call(this);
