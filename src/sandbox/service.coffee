define [
  "core/util"
  "core/events"
  "core/http"
  "core/promise"
  "core/command"
  "core/store"
  "core/dev"
  "ext/mediator"
  "ext/framework"
], (util, events, http, promise, command, Store, dev, mediator, framework) ->

  util.extend {}, promise, command, mediator,
    {util},
    {events},
    {http},
    {Store},
    {dev},
    routing: framework.routing,
    mvc:
      Model: framework.mvc.Model
      Collection: framework.mvc.Model
