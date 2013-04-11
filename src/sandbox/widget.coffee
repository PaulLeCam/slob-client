define [
  "core/util"
  "core/dom"
  "core/events"
  "core/promise"
  "core/command"
  "core/dev"
  "ext/mediator"
  "ext/framework"
], (util, dom, events, promise, command, dev, mediator, framework) ->

  util.extend {}, promise, mediator, framework,
    {util},
    {dom},
    {events},
    {dev},
    request: command.request
