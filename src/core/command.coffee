# # command
# ### Simple implementation of the command pattern.

define [
  "./promise"
], (promise) ->

  callbacks = {}

  # Register the name and function of a command.
  # The command function will be passed the deferred object it needs to either `resolve()` or `reject()`.
  register: (name, callback) ->
    callbacks[name] = callback

  # Request a command call by its name, adding arguments.
  # The request function will return a promise that can be either resolved or rejected by the command function.
  # If no command of this name was registered, the promise will be rejected with an error.
  request: (name, args...) ->
    dfd = promise.deferred()

    if cb = callbacks[name]
      args.unshift dfd
      cb.apply null, args
    else
      dfd.reject new Error "Undefined callback"

    dfd.promise()
