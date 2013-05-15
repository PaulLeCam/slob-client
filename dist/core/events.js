(function() {
  define(["backbone"], function(Backbone) {
    var events;

    events = Backbone.Events;
    events.emit = events.trigger;
    return events;
  });

}).call(this);
