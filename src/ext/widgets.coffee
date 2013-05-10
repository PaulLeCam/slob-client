# # widgets
# The Widgets module manages widgets lifecycles by presenting an API to asynchronously load and initialize them
# and synchronously start, stop and remove them.
# By keeping both references by widgets types and DOM elements, it offers the possibility to
# start and stop all widgets of a certain type, or for a certain DOM element, at once.

define [
  "core/util"
  "core/dom"
  "core/promise"
  "core/store"
  "core/dev"
], (util, dom, promise, Store, dev) ->

  # We keep references to widgets in two stores: one for widgets types and the other for DOM elements
  typesStore = new Store
  elsStore = new Store

  # Promise wrapper for `require()`
  load: (type) ->
    dfd = promise.deferred()

    require ["widgets/#{ type }"], dfd.resolve, (err) ->
      # There was an error loading the widget
      dev.warn "Error trying to initialize widget `#{ type }`", err
      dfd.reject err

    dfd.promise()

  # To initialize a widget, we need its type (the module to load) and its parameters hash.
  # If the `options` argument is a string, we consider it is the DOM element to attach the widget to.
  # Because the widget module may require to be loaded, the function returns a promise.
  initialize: (type, options) ->
    dfd = promise.deferred()

    @load(type)
      .fail(dfd.reject)
      .done (Widget) ->
        options = {el: options} unless util.isObject options
        w = new Widget options

        # Get widget types references associated to the DOM element, or create a new one if not already set
        elsStore.set options.el, new Store unless elsStore.has options.el
        elTypes = elsStore.get options.el
        # Add type to element's store
        elTypes.set type, w

        # Get widget elements references associated to the type, or create a new one if not already set
        typesStore.set type, new Store unless typesStore.has type
        typeEls = typesStore.get type
        # Add element to type's store
        typeEls.set options.el, w

        # Resolve with the widget instance
        dfd.resolve w

    dfd.promise()

  # The `start()` function can be used to start a single widget by setting its type and DOM element.
  # If the widget is not already created, it will be by calling the `initialize()` function, that takes the same parameters.
  # It is also possible to start all initialized widgets of a certain type by setting the second argument to `*`,
  # or to start all initialized widgets attached to a DOM element by setting the first argument to `*`.
  start: (type, options) ->
    # Check for wrong parameters
    if not type? or not options? or type is "*" and options is "*"
      dev.warn "Wrong parameters to start widget", type, options
      return @

    # Re-start all widgets of the specified type
    if options is "*"
      if typeEls = typesStore.get type
        w.start() for w in typeEls.values()

    else
      options = {el: options} unless util.isObject options

      # Try to get widgets types associated to the specified DOM element
      if elTypes = elsStore.get options.el
        # Re-start all widgets for element
        if type is "*"
          w.start() for w in elTypes.values()
        # Re-start single widget
        else if (w = elTypes.get type) then w.start()
        # Initialize and start new widget
        else @initialize(type, options).done (w) -> w.start()

      # There are no widgets yet associated to this DOM element, let's initialize and start new widget
      else @initialize(type, options).done (w) -> w.start()
    @

  # The `stop()` function can be used to stop a single widget by setting its type and DOM element.
  # It is also possible to stop all widgets of a certain type by setting the second argument to `*`,
  # or to stop all widgets attached to a DOM element by setting the first argument to `*`.
  stop: (type, el) ->
    # Check for wrong parameters
    if not type? or not el? or type is "*" and el is "*"
      dev.warn "Wrong parameters to stop widget", type, el
      return @

    # Stop all widgets of the specified type
    if el is "*"
      if typeEls = typesStore.get type
        w.stop() for w in typeEls.values()

    else
      if elTypes = elsStore.get el
        # Stop all widgets for element
        if type is "*"
          w.stop() for w in elTypes.values()
        # Stop single widget
        else if (w = elTypes.get type) then w.stop()
    @

  # The `remove()` function removes all widgets for the specified DOM element and removes this element from the DOM.
  remove: (el) ->
    # Check for wrong parameters
    if not el? or el is "*"
      dev.warn "Wrong parameters to remove widget", el
      return @

    if elTypes = elsStore.get el
      # Get types references for DOM element
      for key in elTypes.keys()
        # Remove widget
        elTypes.get(key).remove()
        # Remove element from type's store
        typesEl.delete el if typesEl = typesStore.get el
      # Remove element from global store
      elsStore.delete el
    else
      # Remove the element from the DOM
      sandbox.dom.find(el).remove()
    @
