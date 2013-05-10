# # events
# ### Alias to Backbone Events.

define [
  "backbone"
], (Backbone) ->

  events = Backbone.Events
  # Alias `trigger()` as `emit()` to match NodeJS' EventEmitter API
  events.emit = events.trigger

  events
