(function() {
  var __slice = [].slice;

  define(["core/pubsub", "./widgets"], function(pubsub, widgets) {
    return {
      widgets: widgets,
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
      pipeFrom: function(target, events, alias) {
        target.on(events, function() {
          var args;

          args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          args.unshift(alias != null ? alias : events);
          return pubsub.emit.apply(pubsub, args);
        });
        return this;
      },
      unpipeFrom: function(target, events, alias) {
        target.off(events, function() {
          var args;

          args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          args.unshift(alias != null ? alias : events);
          return pubsub.emit.apply(pubsub, args);
        });
        return this;
      },
      pipeTo: function(target, events, alias) {
        this.on(events, function() {
          var args;

          args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          args.unshift(alias != null ? alias : events);
          return target.emit.apply(target, args);
        });
        return this;
      },
      unpipeTo: function(target, events, alias) {
        this.off(events, function() {
          var args;

          args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          args.unshift(alias != null ? alias : events);
          return target.emit.apply(target, args);
        });
        return this;
      }
    };
  });

}).call(this);
