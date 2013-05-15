(function() {
  define(["backbone"], function(Backbone) {
    return {
      Router: Backbone.Router,
      start: function() {
        return Backbone.history.start.apply(Backbone.history, arguments);
      }
    };
  });

}).call(this);
