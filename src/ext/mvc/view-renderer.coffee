# # view-renderer
# Add a `renderer()` method to a View class to handle the rendering of subviews.

define [
  "ext/template"
  "core/util"
], (template, util) ->

  (Cls) ->

    util.extend Cls::,

      # The `renderer()` set the HTML content for the element and render eventual associated subviews
      renderer: (html) ->
        @$el
          .attr("data-view", @cid)
          .html html
        template.renderSubViews @$el
        @
