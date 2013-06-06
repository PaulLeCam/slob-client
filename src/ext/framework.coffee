# # framework
# The framework module extends functionalities from the core for the needs of the application.

define [
  "core/dev"
  "core/dom"
  "core/mvc"
  "core/routing"
  "core/store"
  "core/template"
  "core/util"
], (dev, dom, mvc, routing, Store, template, util) ->

  # ## Template

  # Local store for subviews
  subviews = new Store

  # Add a "safe" helper to render raw HTML
  template.registerHelper "safe", (html) ->
    new template.SafeString html

  # Add a view to the local store and return a DOM element that we can identify
  template.addSubView = (view) ->
    subviews.set view.cid, view
    new template.SafeString "<view data-cid=\"#{ view.cid }\"></view>"

  # Return the DOM element of a stored view and delete it from the store
  template.renderSubView = (cid) ->
    if view = subviews.get cid
      subviews.delete cid
      view.render().el
    else
      dev.warn "Could not render subView #{ cid }"
      ""

  # Render all subviews present in a DOM element identified by a jQuery object
  template.renderSubViews = ($el) ->
    $el.find("view").each (i, view) ->
      $view = $el.find view
      $view.replaceWith template.renderSubView $view.data "cid"

  # ## Router

  class Router extends routing.Router

    # Load a page module an call its initialization function with the specified arguments,
    # passing it the name of the previous page
    loadPage: (page, args...) ->
      args.unshift @previous
      require ["pages/#{ page }"], (run) ->
        run.apply run, args
      @previous = page

    # Set the current page and navigate to a specific URL
    setPage: (page = "home", url = "/") ->
      @previous = page
      @navigate url

  # ## Model

  class Model extends mvc.Model

    @Store = Store

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

    # Alias `trigger()` to `emit()` for consistency with other events objects
    emit: ->
      @trigger.apply @, arguments

    parse: (res) ->
      if res.status is "OK" then res.data else {}

  # ## Collection

  class Collection extends mvc.Collection

    # Alias `trigger()` to `emit()` for consistency with other events objects
    emit: ->
      @trigger.apply @, arguments

    parse: (res) ->
      if res.status is "OK" then res.data else {}

  # ## View

  class View extends mvc.View

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

    # Alias `trigger()` to `emit()` for consistency with other events objects
    emit: ->
      @trigger.apply @, arguments

    # The `renderer()` set the HTML content for the element and render eventual associated subviews
    renderer: (html) ->
      @$el
        .attr("data-view", @cid)
        .html html
      template.renderSubViews @$el
      @

  # ## Widget
  # A Widget is a customized View to be used with the widgets extension.

  class Widget extends View

    contructor: (options) ->
      super options
      # Make sure the widget does not start when instanciated
      @stop()

    # When starting a widget for the first time, we render it.
    # Then, later calls to the function will ensure events are bound.
    start: ->
      @delegateEvents()
      unless @rendered
        @render()
        @rendered = yes

    # Alias to `undelegateEvents()`
    stop: ->
      @undelegateEvents()

    # Stop widget and empty DOM element
    shutdown: ->
      @stop()
      @rendered = no
      @$el.html ""

  # ## Public API

  mvc = {Model, View, Collection}
  routing.Router = Router
  # Expose mvc, template, routing objects and Widget class
  {mvc, template, routing, Widget}
