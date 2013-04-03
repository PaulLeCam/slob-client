define [
  "./util"
], (util) ->

  class Store

    constructor: (@data = {}) ->
      new Store @data unless @ instanceof Store

    keys: ->
      util.keys @data

    values: ->
      util.values @data

    has: (key) ->
      util.has @data, key

    get: (key) ->
      @data[key]

    set: (key, value) ->
      if util.isObject key
        util.extend @data, key
      else if key?
        @data[key] = value
      @

    delete: (key) ->
      delete @data[key]
      @
