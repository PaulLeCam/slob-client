(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["core/mvc"], function(mvc) {
    var Widget, _ref;

    return Widget = (function(_super) {
      __extends(Widget, _super);

      function Widget() {
        _ref = Widget.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Widget.prototype.contructor = function(options) {
        Widget.__super__.contructor.call(this, options);
        return this.stop();
      };

      Widget.prototype.start = function() {
        this.delegateEvents();
        if (!this.rendered) {
          this.render();
          return this.rendered = true;
        }
      };

      Widget.prototype.stop = function() {
        return this.undelegateEvents();
      };

      Widget.prototype.shutdown = function() {
        this.stop();
        this.rendered = false;
        return this.$el.html("");
      };

      return Widget;

    })(mvc.View);
  });

}).call(this);
