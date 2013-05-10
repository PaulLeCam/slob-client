# # pubsub
# ## Implementation of Backbone Events for application pub/sub.

define [
  "./util"
  "./events"
], (util, events) ->

  util.extend {}, events
