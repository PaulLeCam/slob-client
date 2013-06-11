# # mvc-factory
# Load and instanciate MVC classes.

define [
  "core/promise"
  "core/util"
], (promise, util) ->

    initialize: (config) ->
      dfd = promise.deferred()

      if config?
        if util.isArray config
          promises = (@instanciate item for item in config)
          promise.when.apply(@, promises).then (res...) ->
            dfd.resolve res
          , dfd.reject

        else if util.isObject config
          @instanciate(config).pipe dfd.resolve, dfd.reject
          
        else
          dfd.reject new Error "Unhandled initialize argument"

      else
        dfd.resolve()

      dfd.promise()

    instanciate: (config = {}) ->
      dfd = promise.deferred()
      if config.load?
        @load(config.load)
          .fail(dfd.reject)
          .done (Cls) =>
            @factory(Cls, config).pipe dfd.resolve, dfd.reject
      else
        dfd.reject new Error "No load path provided"
      dfd.promise()

    load: (path) ->
      dfd = promise.deferred()
      require [path], dfd.resolve, dfd.reject
      dfd.promise()

    factory: (Cls, config) ->
      dfd = promise.deferred()
      res = new Cls config.data
      if config.fetch and config.fetch is on
        res.fetch().then dfd.resolve, dfd.reject
      else
        dfd.resolve res
      dfd.promise()
