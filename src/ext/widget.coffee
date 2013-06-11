# # widget
# A Widget is a customized View to be used with the widgets extension.

define [
  "core/mvc"
], (mvc) ->

  class Widget extends mvc.View

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
