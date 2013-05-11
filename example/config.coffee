require.config

  baseUrl: "/js"
  deps: ["json3"]

  shim:
    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"
    handlebars:
      exports: "Handlebars"

  paths:
    json3: "lib/json3"
    jquery: "lib/jquery"
    underscore: "lib/lodash"
    backbone: "lib/backbone"
    handlebars: "lib/handlebars"