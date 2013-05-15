define [
  "ext/framework"
  "core/dom"
], (framework, dom) ->

  $test = dom.find("body").append "<div/>"

  describe "framework", ->

    describe "template", ->

      # How to test the `safe` helper with the runtime version of Handlebars?

      # Test addSubView

      # Test renderSubView

      # Test renderSubViews


