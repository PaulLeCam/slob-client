(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone"], function(Backbone) {
    var Collection, Model, View, _ref, _ref1, _ref2;

    Model = (function(_super) {
      __extends(Model, _super);

      function Model() {
        _ref = Model.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Model.prototype.emit = function() {
        return this.trigger.apply(this, arguments);
      };

      return Model;

    })(Backbone.Model);
    View = (function(_super) {
      __extends(View, _super);

      function View() {
        _ref1 = View.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      View.prototype.emit = function() {
        return this.trigger.apply(this, arguments);
      };

      return View;

    })(Backbone.View);
    Collection = (function(_super) {
      __extends(Collection, _super);

      function Collection() {
        _ref2 = Collection.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      Collection.prototype.emit = function() {
        return this.trigger.apply(this, arguments);
      };

      return Collection;

    })(Backbone.Collection);
    return {
      Model: Model,
      View: View,
      Collection: Collection
    };
  });

}).call(this);
