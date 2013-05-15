(function() {
  var __slice = [].slice;

  define(["./promise"], function(promise) {
    var callbacks;

    callbacks = {};
    return {
      register: function(name, callback) {
        return callbacks[name] = callback;
      },
      request: function() {
        var args, cb, dfd, name;

        name = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        dfd = promise.deferred();
        if (cb = callbacks[name]) {
          args.unshift(dfd);
          cb.apply(null, args);
        } else {
          dfd.reject(new Error("Undefined callback"));
        }
        return dfd.promise();
      }
    };
  });

}).call(this);
