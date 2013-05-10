# # routing
# ### Aliases to Backbone routing functions.

define [
  "backbone"
], (Backbone) ->

  Router: Backbone.Router
  start: -> Backbone.history.start.apply Backbone.history, arguments
