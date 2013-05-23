# # service
# The service sandbox is appropriate for modules that provide general-purpose functionalities,
# communicate with the server or other APIs, or perform background tasks.

define [
  "core/command"
  "core/dev"
  "core/events"
  "core/http"
  "core/promise"
  "core/store"
  "core/util"
  "ext/mediator"
  "ext/framework"
], (command, dev, events, http, promise, Store, util, mediator, framework) ->

  util.extend {}, mediator,
    promise, command,
    {dev}, {events}, {http}, {Store}, {util}
    routing: framework.routing,
    mvc:
      Model: framework.mvc.Model
      Collection: framework.mvc.Model
