# # template
# Extend the template engine to handle subviews.

define [
  "core/dev"
  "core/store"
  "core/template"
  "core/util"
], (dev, Store, template, util) ->

  tmpl = util.extend {}, template

  # Local store for subviews
  subviews = new Store

  # Add a "safe" helper to render raw HTML
  tmpl.registerHelper "safe", (html) ->
    new tmpl.SafeString html

  # Add a view to the local store and return a DOM element that we can identify
  tmpl.addSubView = (view) ->
    subviews.set view.cid, view
    new tmpl.SafeString "<view data-cid=\"#{ view.cid }\"></view>"

  # Return the DOM element of a stored view and delete it from the store
  tmpl.renderSubView = (cid) ->
    if view = subviews.get cid
      subviews.delete cid
      view.render().el
    else
      dev.warn "Could not render subView #{ cid }"
      ""

  # Render all subviews present in a DOM element identified by a jQuery object
  tmpl.renderSubViews = ($el) ->
    $el.find("view").each (i, view) ->
      $view = $el.find view
      $view.replaceWith template.renderSubView $view.data "cid"

  tmpl
