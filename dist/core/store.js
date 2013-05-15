(function() {
  define(["./util"], function(util) {
    var Store;

    return Store = (function() {
      function Store(data) {
        this.data = data != null ? data : {};
        if (!(this instanceof Store)) {
          return new Store(this.data);
        }
      }

      Store.prototype.keys = function() {
        return util.keys(this.data);
      };

      Store.prototype.values = function() {
        return util.values(this.data);
      };

      Store.prototype.has = function(key) {
        return util.has(this.data, key);
      };

      Store.prototype.get = function(key) {
        return this.data[key];
      };

      Store.prototype.set = function(key, value) {
        if (util.isObject(key)) {
          util.extend(this.data, key);
        } else if (key != null) {
          this.data[key] = value;
        }
        return this;
      };

      Store.prototype["delete"] = function(key) {
        delete this.data[key];
        return this;
      };

      return Store;

    })();
  });

}).call(this);
