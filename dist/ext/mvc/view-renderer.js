(function() {
  define(["ext/template", "core/util"], function(template, util) {
    return function(Cls) {
      return util.extend(Cls.prototype, {
        renderer: function(html) {
          this.$el.attr("data-view", this.cid).html(html);
          template.renderSubViews(this.$el);
          return this;
        }
      });
    };
  });

}).call(this);
