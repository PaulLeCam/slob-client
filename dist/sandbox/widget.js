(function() {
  define(["core/command", "core/dev", "core/dom", "core/mvc", "core/promise", "core/store", "core/util", "ext/mediator", "ext/template", "ext/widget", "ext/widgets"], function(command, dev, dom, mvc, promise, Store, util, mediator, template, Widget, widgets) {
    return util.extend({}, mediator, widgets, promise, {
      dev: dev
    }, {
      dom: dom
    }, {
      mvc: mvc
    }, {
      Store: Store
    }, {
      template: template
    }, {
      util: util
    }, {
      Widget: Widget
    }, {
      request: command.request
    });
  });

}).call(this);
