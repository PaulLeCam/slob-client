define [
  "sandbox/component"
], (sandbox) ->

  class Thread extends sandbox.mvc.Model

    store: new sandbox.Store
