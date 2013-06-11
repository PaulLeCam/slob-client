(function() {
  define(["core/dev", "core/dom", "core/util"], function(dev, dom, util) {
    return function(Cls) {
      return util.extend(Cls.prototype, {
        initialize: function(params) {
          var $el;

          if (params == null) {
            params = {};
          }
          if (params.model && !(params.model instanceof mvc.Model)) {
            if (this.Model) {
              this.model = new this.Model(params.model);
            } else {
              dev.error("Invalid model", params.model);
            }
          }
          if (params.collection && !(params.collection instanceof mvc.Collection)) {
            if (this.Collection) {
              this.collection = new this.Collection(params.collection);
            } else {
              dev.error("Invalid collection", params.collection);
            }
          }
          if (!params.el && params.cid) {
            $el = dom.find("[data-view=" + params.cid + "]");
            if ($el.length) {
              return this.setElement($el);
            }
          }
        }
      });
    };
  });

}).call(this);
