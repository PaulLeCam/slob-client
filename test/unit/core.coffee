define [
  "core/util"
  "core/template"
  "core/dom"
  "core/http"
  "core/promise"
  "core/command"
  "core/events"
  "core/pubsub"
  "core/mvc"
  "core/routing"
  "core/store"
], (util, template, dom, http, promise, command, events, pubsub, mvc, routing, Store) ->

  describe "core", ->

    describe "util", ->

      # For now, only check for functions used by the Slob librairy

      it "Should have an `extend()` function", ->
        util.should.have.property("extend").that.is.a "function"

      it "Should have an `isObject()` function", ->
        util.should.have.property("isObject").that.is.a "function"

      it "Should have an `isArray()` function", ->
        util.should.have.property("isArray").that.is.a "function"

    describe "template", ->

      it "Should have a `registerHelper()` function", ->
        template.should.have.property("registerHelper").that.is.a "function"

    describe "dom", ->

      it "Should have a `find()` function", ->
        dom.should.have.property("find").that.is.a "function"

      it "Should have a `data()` function", ->
        dom.should.have.property("data").that.is.a "function"

      it "Should have an `on()` function", ->
        dom.should.have.property("on").that.is.a "function"

      it "Should have an `off()` function", ->
        dom.should.have.property("off").that.is.a "function"

      it "Should have an `once()` function", ->
        dom.should.have.property("once").that.is.a "function"

      it "Should have a `ready()` function", ->
        dom.should.have.property("ready").that.is.a "function"

    describe "http", ->

      it "Should have an `ajax()` function", ->
        http.should.have.property("ajax").that.is.a "function"

      it "Should have an `get()` function", ->
        http.should.have.property("get").that.is.a "function"

      it "Should have an `getJSON()` function", ->
        http.should.have.property("getJSON").that.is.a "function"

      it "Should have an `post()` function", ->
        http.should.have.property("post").that.is.a "function"

      it "Should have an `param()` function", ->
        http.should.have.property("param").that.is.a "function"

    describe "promise", ->

      it "Should have a `deferred` function", ->
        promise.should.have.property("deferred").that.is.a "function"

      it "Should have a `when` function", ->
        promise.should.have.property("when").that.is.a "function"

    describe "command", ->

      describe "request", ->

        it "Should return a promise", ->
          res = command.request "test"
          res.should.have.property("done").that.is.a "function"
          res.should.have.property("fail").that.is.a "function"

        it "Should return an Error when the command is not registered", (done) ->
          res = command.request "nothere"
          res.done ->
            throw new Error "Unexisting command resolved deferred"
          res.fail (err) ->
            err.should.be.an.instanceof Error
            done()

        it "Should return the appropriate result when the command is registered", (done) ->
          command.register "test", (dfd) ->
            dfd.resolve "OK"
          command.request("test")
            .fail(-> throw new Error "Command request failed")
            .done (res) ->
              res.should.equal "OK"
              done()

    describe "events", ->

      it "Should have an `emit()` function", ->
        events.should.have.property("emit").that.is.a "function"

      it "`emit()` should alias to `trigger()`", (done) ->
        ev = util.extend {}, events
        ev.on "test", (val) ->
          val.should.equal "OK"
          done()
        ev.emit "test", "OK"

    describe "pubsub", ->

      it "Should have an `on()` function", ->
        pubsub.should.have.property("on").that.is.a "function"

      it "Should have an `off()` function", ->
        pubsub.should.have.property("off").that.is.a "function"

      it "Should have an `emit()` function", ->
        pubsub.should.have.property("emit").that.is.a "function"

    describe "mvc", ->

      describe "Model", ->

        model = new mvc.Model

        it "Should have an `emit()` method", ->
          model.should.have.property("emit").that.is.a "function"

        it "`emit()` should alias to `trigger()`", (done) ->
          model.on "test", (val) ->
            val.should.equal "OK"
            done()
          model.emit "test", "OK"

      describe "View", ->

        view = new mvc.View

        it "Should have an `emit()` method", ->
          view.should.have.property("emit").that.is.a "function"

        it "`emit()` should alias to `trigger()`", (done) ->
          view.on "test", (val) ->
            val.should.equal "OK"
            done()
          view.emit "test", "OK"

      describe "Collection", ->

        collection = new mvc.Collection

        it "Should have an `emit()` method", ->
          collection.should.have.property("emit").that.is.a "function"

        it "`emit()` should alias to `trigger()`", (done) ->
          collection.on "test", (val) ->
            val.should.equal "OK"
            done()
          collection.emit "test", "OK"

    describe "routing", ->

      it "Should have a `Router` class", ->
        routing.should.have.property("Router").that.is.a "function"

      it "Should have a `start()` function", ->
        routing.should.have.property("start").that.is.a "function"

    describe "store", ->

      describe "constructor", ->

        it "Should instanciate with optional data", ->
          s = new Store myKey: "myValue"
          s.data.should.eql myKey: "myValue"

        it "Should return an instance even if called without using `new`", ->
          s = Store()
          s.should.be.an.instanceof Store

      describe "set", ->

        it "Should set a single key and value", ->
          s = new Store
          s.set "myKey", "myValue"
          s.get("myKey").should.equal "myValue"

        it "Should set key/value pairs", ->
          s = new Store
          s.set
            key1: "value1"
            key2: "value2"
          s.get("key1").should.equal "value1"
          s.get("key2").should.equal "value2"

