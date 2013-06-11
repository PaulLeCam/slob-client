# # model-cache
# Extend a Model to add a cache, avoiding to have multiple instances of a same entity.

define [], ->

  (Cls) ->

    class Model extends Cls

      # Each Model class must have its own store of instances
      store: new Store

      # When we instanciate a model, we check in the store if it is not already present.
      # If this is the case, we silently update its data.
      constructor: (params = {}) ->
        if (id = params.id or params.cid) and self = @store.get id
          self.set params, silent: yes
          return self

        super params
        key = @id ? @cid
        @store.set key, @
