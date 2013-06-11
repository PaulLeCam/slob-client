(function() {
  var __slice = [].slice;

  define(["core/promise", "core/util"], function(promise, util) {
    return {
      initialize: function(config) {
        var dfd, item, promises;

        dfd = promise.deferred();
        if (config != null) {
          if (util.isArray(config)) {
            promises = (function() {
              var _i, _len, _results;

              _results = [];
              for (_i = 0, _len = config.length; _i < _len; _i++) {
                item = config[_i];
                _results.push(this.instanciate(item));
              }
              return _results;
            }).call(this);
            promise.when.apply(this, promises).then(function() {
              var res;

              res = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
              return dfd.resolve(res);
            }, dfd.reject);
          } else if (util.isObject(config)) {
            this.instanciate(config).pipe(dfd.resolve, dfd.reject);
          } else {
            dfd.reject(new Error("Unhandled initialize argument"));
          }
        } else {
          dfd.resolve();
        }
        return dfd.promise();
      },
      instanciate: function(config) {
        var dfd,
          _this = this;

        if (config == null) {
          config = {};
        }
        dfd = promise.deferred();
        if (config.load != null) {
          this.load(config.load).fail(dfd.reject).done(function(Cls) {
            return _this.factory(Cls, config).pipe(dfd.resolve, dfd.reject);
          });
        } else {
          dfd.reject(new Error("No load path provided"));
        }
        return dfd.promise();
      },
      load: function(path) {
        var dfd;

        dfd = promise.deferred();
        require([path], dfd.resolve, dfd.reject);
        return dfd.promise();
      },
      factory: function(Cls, config) {
        var dfd, res;

        dfd = promise.deferred();
        res = new Cls(config.data);
        if (config.fetch && config.fetch === true) {
          res.fetch().then(dfd.resolve, dfd.reject);
        } else {
          dfd.resolve(res);
        }
        return dfd.promise();
      }
    };
  });

}).call(this);
