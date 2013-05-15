define [
  "sandbox/component"
  "app/models/post"
], (sandbox, Post) ->

  class Posts extends sandbox.mvc.Collection

    model: Post
