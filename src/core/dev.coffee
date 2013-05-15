# # dev
# ### Wrapper for the console to ensure logs are only displayed when enabled.

define [
  "./util"
], (util) ->

  # Get current time with best precision available
  now = performance?.now ? performance?.webkitNow ? Date.now

  # Empty replacement functions for console if they are not available
  csl = console ?
    log: ->
    info: ->
    warn: ->
    error: ->

  # Simple replacement functions for `time()` and `timeEnd()` if they are not available in the console
  refs = {}

  csl.time ?= (key) ->
    refs[key] = now()

  csl.timeEnd ?= (key) ->
    if start = refs[key]
      time = now() - start
      @log "`#{ key }`: #{ time }ms"
      delete refs[key]

  api =
    # By default, logging is disabled, we have to explicitely enable it in the application
    active: no

  # Decorate console functions to ensure they are only executed when logging is enabled
  util.each ["log", "info", "warn", "error", "time", "timeEnd"], (func) ->
    api[func] = ->
      if @active then csl[func].apply csl, arguments
      @

  api
