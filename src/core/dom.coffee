# # dom
# ### Aliases to jQuery functions related to DOM.

define [
  "jquery"
], ($) ->

  create: (element) -> $ "<#{ element }/>"
  find: (selector, context = document) ->
    if selector is context then $ context
    else $(context).find selector
  data: (selector, args...) -> $(selector).data.apply $, args
  on: (selector, args...) -> $(selector).on.apply $, args
  off: (selector, args...) -> $(selector).off.apply $, args
  # Rename `one` to `once` to match Backbone's Events and NodeJS' EventEmitter APIs
  once: (selector, args...) -> $(selector).one.apply $, args
  ready: (callback) -> $ -> callback()
