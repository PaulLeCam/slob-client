# # widget
# The widget sandbox is appropriate for user-facing modules such as pages and widgets.

define [
  "core/command"
  "core/dev"
  "core/dom"
  "core/mvc"
  "core/promise"
  "core/store"
  "core/util"
  "ext/mediator"
  "ext/template"
  "ext/widget"
  "ext/widgets"
], (command, dev, dom, mvc, promise, Store, util, mediator, template, Widget, widgets) ->

  util.extend {}, mediator, widgets,
    promise,
    {dev}, {dom}, {mvc}, {Store}, {template}, {util}, {Widget}
    request: command.request
