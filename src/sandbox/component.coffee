# # component
# A component is a general-purpose module.
# Basically, this sandbox should be used by modules that are too restricted by the `widget` and `service` sandboxes.

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

  util.extend {},
    mediator, framework,
    command, promise,
    {dev}, {events}, {http}, {Store}, {util}
