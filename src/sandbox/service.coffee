# # service
# The service sandbox is appropriate for modules that provide general-purpose functionalities,
# communicate with the server or other APIs, or perform background tasks.

define [
  "core/command"
  "core/dev"
  "core/events"
  "core/http"
  "core/mvc"
  "core/promise"
  "core/store"
  "core/util"
  "ext/mediator"
  "ext/routing"
], (command, dev, events, http, mvc, promise, Store, util, mediator, routing) ->

  util.extend {}, mediator,
    promise, command,
    {dev}, {events}, {http}, {routing}, {Store}, {util}
    mvc:
      Model: mvc.Model
      Collection: mvc.Collection
