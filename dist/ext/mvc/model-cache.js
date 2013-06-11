(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define([], function() {
    return function(Cls) {
      var Model;

      return Model = (function(_super) {
        __extends(Model, _super);

        Model.prototype.store = new Store;

        function Model(params) {
          var id, key, self, _ref;

          if (params == null) {
            params = {};
          }
          if ((id = params.id || params.cid) && (self = this.store.get(id))) {
            self.set(params, {
              silent: true
            });
            return self;
          }
          Model.__super__.constructor.call(this, params);
          key = (_ref = this.id) != null ? _ref : this.cid;
          this.store.set(key, this);
        }

        return Model;

      })(Cls);
    };
  });

}).call(this);
