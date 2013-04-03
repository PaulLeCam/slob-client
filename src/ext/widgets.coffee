define [
  "core/util"
  "core/dom"
  "core/store"
], (util, dom, Store) ->

  typesStore = new Store
  elsStore = new Store

  start: (type, options) ->
    # wrong parameters
    if not type? or not options? or type is "*" and options is "*"
      console.warn "Wrong parameters to start widget", type, options
      return @

    if options is "*"
      if typeEls = typesStore.get type # re-start all widgets of type
        w.start() for w in typeEls.values()

    else
      options = {el: options} unless util.isObject options

      if elTypes = elsStore.get options.el # exists?
        if type is "*" # re-start all widgets for element
          w.start() for w in elTypes.values()
        else if (w = elTypes.get type) then w.start() # re-start single widget
        else @_new type, options # start new widget

      else @_new type, options # start new widget
    @

  _new: (type, options) ->
    require ["widgets/#{ type }"], (Widget) ->
      w = new Widget options

      elsStore.set options.el, new Store unless elsStore.has options.el
      elTypes = elsStore.get options.el
      elTypes.set type, w # add type to element's store

      typesStore.set type, new Store unless typesStore.has type
      typeEls = typesStore.get type
      typeEls.set options.el, w # add element to type's store

      w.start() # start widget
    , (err) ->
      console.warn "Error trying to start widget `#{ type }`", err

  stop: (type, el) ->
    # wrong parameters
    if not type? or not el? or type is "*" and el is "*"
      console.warn "Wrong parameters to stop widget", type, el
      return @

    if el is "*"
      if typeEls = typesStore.get type # stop all widgets of type
        w.stop() for w in typeEls.values()

    else
      if elTypes = elsStore.get el
        if type is "*" # stop all widgets for element
          w.stop() for w in elTypes.values()
        else if (w = elTypes.get type) then w.stop() # stop single widget
    @

  remove: (el) ->
    # wrong parameters
    if not el? or el is "*"
      console.warn "Wrong parameters to remove widget", el
      return @

    if elTypes = elsStore.get el
      for key in elTypes.keys() # get types ref for element
        elTypes.get(key).remove() # remove widget
        typesEl.delete el if typesEl = typesStore.get el # remove element from type's store
      elsStore.delete el # remove element from global store
    else
      sandbox.dom.find(el).remove()
    @
