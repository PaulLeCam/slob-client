(function() {
  var __slice = [].slice;

  define(["core/mvc", "core/promise", "core/store", "core/util", "ext/mvc-factory"], function(mvc, promise, Store, util, factory) {
    var DataStore;

    return DataStore = (function() {
      function DataStore(config) {
        if (config == null) {
          config = {};
        }
        if (!(this instanceof DataStore)) {
          return new DataStore(config);
        }
        this.config = new Store;
        this.instances = new Store;
        this.configure(config);
      }

      DataStore.prototype.configure = function(config) {
        var item, key, value, _i, _len;

        if (config == null) {
          config = {};
        }
        if (util.isArray(config)) {
          for (_i = 0, _len = config.length; _i < _len; _i++) {
            item = config[_i];
            this.config.set(item.key, item);
          }
        } else {
          for (key in config) {
            value = config[key];
            this.config.set(key, value);
          }
        }
        return this;
      };

      DataStore.prototype.initialize = function(config) {
        var dfd, key, promises, value, _i, _len, _ref, _ref1, _ref2, _ref3;

        dfd = promise.deferred();
        if (config != null) {
          if (util.isArray(config)) {
            promises = [];
            for (_i = 0, _len = config.length; _i < _len; _i++) {
              key = config[_i];
              if (value = this.config.get(key)) {
                if ((_ref = value.key) == null) {
                  value.key = key;
                }
                promises.push(this.instanciate(value));
              }
            }
          } else if (util.isString(config)) {
            if (value = this.config.get(key)) {
              if ((_ref1 = value.key) == null) {
                value.key = key;
              }
              promises = [this.instanciate(value)];
            } else {
              dfd.reject(new Error("Could not initialize undefined key `" + config + "`"));
            }
          } else if (util.isObject(config)) {
            promises = [];
            for (key in config) {
              value = config[key];
              this.config.set(key, value);
              if ((_ref2 = value.key) == null) {
                value.key = key;
              }
              promises.push(this.instanciate(value));
            }
          } else {
            dfd.reject(new Error("Unhandled initialize argument"));
          }
        } else {
          promises = [];
          for (key in config) {
            value = config[key];
            if ((_ref3 = value.key) == null) {
              value.key = key;
            }
            promises.push(this.instanciate(value));
          }
        }
        if ((promises != null) && promises.length) {
          promise.when.apply(this, promises).then(function() {
            var res;

            res = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
            return dfd.resolve(res);
          }, dfd.reject);
        } else {
          dfd.resolve();
        }
        return dfd.promise();
      };

      DataStore.prototype.instanciate = function(config) {
        return factory.instanciate(config);
      };

      DataStore.prototype.get = function(key, options) {
        var config, dfd, _ref, _ref1;

        if (options == null) {
          options = {};
        }
        dfd = promise.deferred();
        if (util.isObject(key)) {
          this.instanciate(key).pipe(dfd.resolve, dfd.reject);
        } else if (this.instances.has(key)) {
          dfd.resolve(this.instances.get(key));
        } else if (this.config.has(key)) {
          config = this.config.get(key);
          if (util.isObject(config) && (config.load != null)) {
            if ((_ref = config.key) == null) {
              config.key = key;
            }
            this.instanciate(config).pipe(dfd.resolve, dfd.reject);
          } else {
            dfd.resolve(config);
          }
        } else {
          if ((_ref1 = options.key) == null) {
            options.key = key;
          }
          this.instanciate(options).pipe(dfd.resolve, dfd.reject);
        }
        return dfd.promise();
      };

      DataStore.prototype.set = function(key, value) {
        var f, k;

        if (util.isObject(key)) {
          for (k in key) {
            f = key[k];
            this._set(k, v);
          }
        } else {
          this._set(key, value);
        }
        return this;
      };

      DataStore.prototype._set = function(key, value) {
        if (!value) {
          return;
        }
        if (value instanceof mvc.Model || value instanceof mvc.Collection) {
          return this.instances.set(key, value);
        } else {
          return this.config.set(key, value);
        }
      };

      return DataStore;

    })();
  });

}).call(this);
