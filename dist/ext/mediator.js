(function() {
  var __slice = [].slice;

  define(["core/events", "core/util"], function(events, util) {
    var pubsub;

    pubsub = util.extend({}, events);
    return {
      on: function() {
        pubsub.on.apply(pubsub, arguments);
        return this;
      },
      off: function() {
        pubsub.off.apply(pubsub, arguments);
        return this;
      },
      once: function() {
        pubsub.once.apply(pubsub, arguments);
        return this;
      },
      emit: function() {
        pubsub.emit.apply(pubsub, arguments);
        return this;
      },
      pipeFrom: function(target, ev, alias) {
        target.on(ev, function() {
          var args;

          args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          args.unshift(alias != null ? alias : ev);
          return pubsub.emit.apply(pubsub, args);
        });
        return this;
      },
      unpipeFrom: function(target, ev, alias) {
        target.off(ev, function() {
          var args;

          args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          args.unshift(alias != null ? alias : ev);
          return pubsub.emit.apply(pubsub, args);
        });
        return this;
      },
      pipeTo: function(target, ev, alias) {
        this.on(ev, function() {
          var args;

          args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          args.unshift(alias != null ? alias : ev);
          return target.emit.apply(target, args);
        });
        return this;
      },
      unpipeTo: function(target, ev, alias) {
        this.off(ev, function() {
          var args;

          args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          args.unshift(alias != null ? alias : ev);
          return target.emit.apply(target, args);
        });
        return this;
      }
    };
  });

}).call(this);
