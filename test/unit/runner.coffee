define ["../../config"], ->

  mocha.setup "bdd"

  # Make sure tests are performed in the right order
  require.config
    shim:
      "test/unit/framework":
        deps: ["test/unit/core"]
      "test/unit/widgets":
        deps: ["test/unit/core"]
      "test/unit/mediator":
        deps: ["test/unit/widgets"]
      "test/unit/sandboxes":
        deps: ["test/unit/framework", "test/unit/mediator"]

  require ["test/unit/sandboxes"], ->

    mocha.run()
