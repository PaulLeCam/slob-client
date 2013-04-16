define [
  "core/util"
  "core/dom"
  "core/events"
  "core/promise"
  "core/command"
  "core/store"
  "core/dev"
  "ext/mediator"
  "ext/framework"
], (util, dom, events, promise, command, Store, dev, mediator, framework) ->

  util.extend {}, promise, mediator, framework,
    {util},
    {dom},
    {events},
    {Store},
    {dev},
    request: command.request
