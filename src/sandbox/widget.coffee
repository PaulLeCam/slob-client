# # widget
# The widget sandbox is appropriate for user-facing modules such as pages and widgets.

define [
  "core/command"
  "core/dev"
  "core/dom"
  "core/events"
  "core/promise"
  "core/store"
  "core/util"
  "ext/mediator"
  "ext/framework"
  "ext/widgets"
], (command, dev, dom, events, promise, Store, util, mediator, framework, widgets) ->

  util.extend {}, mediator, framework, widgets,
    promise,
    {dev}, {dom}, {events}, {Store}, {util},
    request: command.request
