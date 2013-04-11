define [
  "core/util"
  "core/events"
  "core/http"
  "core/promise"
  "core/command"
  "core/store"
  "core/dev"
  "ext/framework"
], (util, events, http, promise, command, Store, dev, framework) ->

  util.extend {}, promise, command, framework,
    {util},
    {events},
    {http},
    {Store},
    {dev}
