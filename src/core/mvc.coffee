# # mvc
# ### Backbone Model, View and Collection with added `emit()` method.

define [
  "backbone"
], (Backbone) ->

  class Model extends Backbone.Model
    # Alias `trigger()` as `emit()` to match NodeJS' EventEmitter API
    emit: ->
      @trigger.apply @, arguments

  class View extends Backbone.View
    # Alias `trigger()` as `emit()` to match NodeJS' EventEmitter API
    emit: ->
      @trigger.apply @, arguments

  class Collection extends Backbone.Collection
    # Alias `trigger()` as `emit()` to match NodeJS' EventEmitter API
    emit: ->
      @trigger.apply @, arguments

  {Model, View, Collection}
