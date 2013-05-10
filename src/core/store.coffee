# # store
# ### Simple key/value store with utility functions from Lo-Dash.

define [
  "./util"
], (util) ->

  class Store

    constructor: (@data = {}) ->
      # Allow to create new instance by calling `Store()` instead of `new Store()`
      new Store @data unless @ instanceof Store

    keys: ->
      util.keys @data

    values: ->
      util.values @data

    has: (key) ->
      util.has @data, key

    get: (key) ->
      @data[key]

    # Accept either a key and value arguments or a hash of key/value pairs
    set: (key, value) ->
      if util.isObject key
        util.extend @data, key
      else if key?
        @data[key] = value
      @

    delete: (key) ->
      delete @data[key]
      @
