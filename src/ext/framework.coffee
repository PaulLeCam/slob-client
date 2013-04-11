define [
  "core/util"
  "core/dom"
  "core/mvc"
  "core/template"
  "core/routing"
  "core/store"
  "core/dev"
], (util, dom, mvc, template, routing, Store, dev) ->

  #
  # Template extension
  #

  subviews = new Store

  template.registerHelper "safe", (html) ->
    new template.SafeString html

  template.addSubView = (view) ->
    subviews.set view.cid, view
    new template.SafeString "<view data-cid=\"#{ view.cid }\"></view>"

  template.renderSubView = (cid) ->
    if view = subviews.get cid
      subviews.delete cid
      view.render().el
    else
      dev.warn "Could not render subView #{ cid }"
      ""

  template.renderSubViews = ($el) ->
    $el.find("view").each (i, view) ->
      $view = dom.find view, $el
      $view.replaceWith template.renderSubView $view.data "cid"

  template.registerHelper "subView", template.addSubView

  #
  # Router extension
  #

  class Router extends routing.Router

    loadPage: (page, args = []) ->
      args = [].slice.call args, 0
      args.unshift @previous
      require ["pages/#{ page }"], (run) ->
        run.apply run, args
      @previous = page

    setPage: (page = "home", url = "/") ->
      @previous = page
      @navigate url

  #
  # MVC extension
  #

  class Model extends mvc.Model

    store: new Store

    constructor: (params = {}) ->
      if (id = params.id or params.cid) and self = @store.get id
        self.set params, silent: yes
      else
        self = super params
        key = @id ? @cid
        @store.set key, self
      self

    emit: ->
      @trigger.apply @, arguments

    parse: (res) ->
      if res.status is "OK" then res.data else {}

  class Collection extends mvc.Collection

    emit: ->
      @trigger.apply @, arguments

    parse: (res) ->
      if res.status is "OK" then res.data else {}

  class View extends mvc.View

    initialize: (params = {}) ->
      if params.model and not (params.model instanceof mvc.Model)
        if @Model then @model = new @Model params.model
        else dev.error "Invalid model", params.model

      if params.collection and not (params.collection instanceof mvc.Collection)
        if @Collection then @collection = new @Collection params.collection
        else dev.error "Invalid collection", params.collection

      if not params.el and params.cid
        $el = dom.find "[data-view=#{ params.cid }]"
        @setElement $el if $el.length

    emit: ->
      @trigger.apply @, arguments

    renderer: (html) ->
      @$el
        .attr("data-view", @cid)
        .html html
      template.renderSubViews @$el
      @

  #
  # Widget
  #

  class Widget extends View

    contructor: (options) ->
      super options
      @stop() # Make sure widget does not start when instanciated

    start: ->
      if @rendered then @delegateEvents()
      else
        @render()
        @rendered = yes

    stop: ->
      @undelegateEvents()

  #
  # Public API
  #

  mvc = {Model, View, Collection}
  routing.Router = Router
  {mvc, template, routing, Widget}
