define [
  "sandbox/component"
], (sandbox) ->

  class Post extends sandbox.mvc.Model

    store: new sandbox.Store
