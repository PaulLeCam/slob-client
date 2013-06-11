# # router
# Customize page loading and initialization.

define [
  "core/routing"
  "core/util"
], (routing, util) ->

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

  routing.Router = Router
  routing
