# # data-parse
# Extend a Model or Collection class to parse data sent from the server.

define [
  "core/util"
], (util) ->

  (Cls) ->

    util.extend Cls::,

      parse: (res) ->
        if res.status is "OK" then res.data else {}
