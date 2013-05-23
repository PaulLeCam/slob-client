# # mediator
# The mediator module presents a simple API for application modules to interact with each other in a decoupled manner.
# It exposes a pub/sub implementation, and the ability to (un)pipe events to or from the pub/sub.

define [
  "core/events"
  "core/util"
], (events, util) ->

  pubsub = util.extend {}, events

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

  pipeFrom: (target, ev, alias) ->
    target.on ev, (args...) ->
      args.unshift alias ? ev
      pubsub.emit.apply pubsub, args
    @
  unpipeFrom: (target, ev, alias) ->
    target.off ev, (args...) ->
      args.unshift alias ? ev
      pubsub.emit.apply pubsub, args
    @

  pipeTo: (target, ev, alias) ->
    @on ev, (args...) ->
      args.unshift alias ? ev
      target.emit.apply target, args
    @
  unpipeTo: (target, ev, alias) ->
    @off ev, (args...) ->
      args.unshift alias ? ev
      target.emit.apply target, args
    @
