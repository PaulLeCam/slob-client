# # mediator
# The mediator module presents a simple API for application modules to interact with each other in a decoupled manner.
# It exposes functions to manipulate widgets, a pub/sub implementation, and the ability to (un)pipe events to or from the pub/sub.

define [
  "core/pubsub"
  "./widgets"
], (pubsub, widgets) ->

  widgets: widgets

  on: ->
    pubsub.on.apply pubsub, arguments
    @
  off: ->
    pubsub.off.apply pubsub, arguments
    @
  once: ->
    pubsub.once.apply pubsub, arguments
    @
  emit: ->
    pubsub.emit.apply pubsub, arguments
    @

  pipeFrom: (target, events, alias) ->
    target.on events, (args...) ->
      args.unshift alias ? events
      pubsub.emit.apply pubsub, args
    @
  unpipeFrom: (target, events, alias) ->
    target.off events, (args...) ->
      args.unshift alias ? events
      pubsub.emit.apply pubsub, args
    @

  pipeTo: (target, events, alias) ->
    @on events, (args...) ->
      args.unshift alias ? events
      target.emit.apply target, args
    @
  unpipeTo: (target, events, alias) ->
    @off events, (args...) ->
      args.unshift alias ? events
      target.emit.apply target, args
    @
