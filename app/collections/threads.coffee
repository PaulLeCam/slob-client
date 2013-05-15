define [
  "sandbox/component"
  "app/models/thread"
], (sandbox, Thread) ->

  class Threads extends sandbox.mvc.Collection

    model: Thread
