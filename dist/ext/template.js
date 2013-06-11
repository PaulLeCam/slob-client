(function() {
  define(["core/dev", "core/store", "core/template", "core/util"], function(dev, Store, template, util) {
    var subviews, tmpl;

    tmpl = util.extend({}, template);
    subviews = new Store;
    tmpl.registerHelper("safe", function(html) {
      return new tmpl.SafeString(html);
    });
    tmpl.addSubView = function(view) {
      subviews.set(view.cid, view);
      return new tmpl.SafeString("<view data-cid=\"" + view.cid + "\"></view>");
    };
    tmpl.renderSubView = function(cid) {
      var view;

      if (view = subviews.get(cid)) {
        subviews["delete"](cid);
        return view.render().el;
      } else {
        dev.warn("Could not render subView " + cid);
        return "";
      }
    };
    tmpl.renderSubViews = function($el) {
      return $el.find("view").each(function(i, view) {
        var $view;

        $view = $el.find(view);
        return $view.replaceWith(template.renderSubView($view.data("cid")));
      });
    };
    return tmpl;
  });

}).call(this);
