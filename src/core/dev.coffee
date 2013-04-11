define [
  "./util"
], (util) ->

  #
  # Local references
  #

  refs = {}
  now = performance?.now ? performance?.webkitNow ? Date.now

  csl = console ?
    log: ->
    warn: ->
    error: ->

  csl.time ?= (key) ->
    refs[key] = now()

  csl.timeEnd ?= (key) ->
    if start = refs[key]
      time = now() - start
      @log "`#{ key }`: #{ time }ms"
      delete refs[key]

  #
  # Public API
  #

  api =
    active: no

  util.each ["log", "warn", "error", "time", "timeEnd"], (func) ->
    api[func] = ->
      if @active then csl[func].apply csl, arguments
      @

  api
