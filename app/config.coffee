require.config

  baseUrl: "../../"
  deps: ["json3"]

  shim:
    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"
    handlebars:
      exports: "Handlebars"

  paths:
    core: "dist/core"
    ext: "dist/ext"
    sandbox: "dist/sandbox"
    test: "build/test"
    json3: "components/json3/lib/json3"
    jquery: "components/jquery/jquery"
    underscore: "components/lodash/dist/lodash.compat"
    backbone: "components/backbone/backbone"
    handlebars: "components/handlebars/handlebars.runtime"
