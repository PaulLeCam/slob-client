# # view-from-server
# Extend a View to handle possible Model, Collection and DOM element data sent by the server.

define [
  "core/dev"
  "core/dom"
  "core/util"
], (dev, dom, util) ->

  (Cls) ->

    util.extend Cls::,

      initialize: (params = {}) ->
        # If the *model* parameter is an object and not an actual instance of a Model, we try to set it
        if params.model and not (params.model instanceof mvc.Model)
          if @Model then @model = new @Model params.model
          else dev.error "Invalid model", params.model

        # If the *collection* parameter is an object and not an actual instance of a Collection, we try to set it
        if params.collection and not (params.collection instanceof mvc.Collection)
          if @Collection then @collection = new @Collection params.collection
          else dev.error "Invalid collection", params.collection

        # If we have a *cid* but no *el* parameter, we try to get the element from the DOM
        if not params.el and params.cid
          $el = dom.find "[data-view=#{ params.cid }]"
          @setElement $el if $el.length
