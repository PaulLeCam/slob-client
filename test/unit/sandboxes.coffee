define [
  "sandbox/service"
  "sandbox/widget"
  "sandbox/component"
], (service, widget, component) ->

  describe "sandboxes", ->

    describe "service", ->

      it "Should be an Object", ->
        service.should.be.an.object

    describe "widget", ->

      it "Should be an Object", ->
        widget.should.be.an.object

    describe "component", ->

      it "Should be an Object", ->
        component.should.be.an.object
