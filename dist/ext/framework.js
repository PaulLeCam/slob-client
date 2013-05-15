(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["core/util", "core/dom", "core/mvc", "core/template", "core/routing", "core/store", "core/dev"], function(util, dom, mvc, template, routing, Store, dev) {
    var Collection, Model, Router, View, Widget, subviews, _ref, _ref1, _ref2, _ref3;

    subviews = new Store;
    template.registerHelper("safe", function(html) {
      return new template.SafeString(html);
    });
    template.addSubView = function(view) {
      subviews.set(view.cid, view);
      return new template.SafeString("<view data-cid=\"" + view.cid + "\"></view>");
    };
    template.renderSubView = function(cid) {
      var view;

      if (view = subviews.get(cid)) {
        subviews["delete"](cid);
        return view.render().el;
      } else {
        dev.warn("Could not render subView " + cid);
        return "";
      }
    };
    template.renderSubViews = function($el) {
      return $el.find("view").each(function(i, view) {
        var $view;

        $view = dom.find(view, $el);
        return $view.replaceWith(template.renderSubView($view.data("cid")));
      });
    };
    template.registerHelper("subView", template.addSubView);
    Router = (function(_super) {
      __extends(Router, _super);

      function Router() {
        _ref = Router.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Router.prototype.loadPage = function(page, args) {
        if (args == null) {
          args = [];
        }
        args = [].slice.call(args, 0);
        args.unshift(this.previous);
        require(["pages/" + page], function(run) {
          return run.apply(run, args);
        });
        return this.previous = page;
      };

      Router.prototype.setPage = function(page, url) {
        if (page == null) {
          page = "home";
        }
        if (url == null) {
          url = "/";
        }
        this.previous = page;
        return this.navigate(url);
      };

      return Router;

    })(routing.Router);
    Model = (function(_super) {
      __extends(Model, _super);

      Model.prototype.store = new Store;

      function Model(params) {
        var id, key, self, _ref1;

        if (params == null) {
          params = {};
        }
        if ((id = params.id || params.cid) && (self = this.store.get(id))) {
          self.set(params, {
            silent: true
          });
          return self;
        }
        Model.__super__.constructor.call(this, params);
        key = (_ref1 = this.id) != null ? _ref1 : this.cid;
        this.store.set(key, this);
      }

      Model.prototype.emit = function() {
        return this.trigger.apply(this, arguments);
      };

      Model.prototype.parse = function(res) {
        if (res.status === "OK") {
          return res.data;
        } else {
          return {};
        }
      };

      return Model;

    })(mvc.Model);
    Collection = (function(_super) {
      __extends(Collection, _super);

      function Collection() {
        _ref1 = Collection.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      Collection.prototype.emit = function() {
        return this.trigger.apply(this, arguments);
      };

      Collection.prototype.parse = function(res) {
        if (res.status === "OK") {
          return res.data;
        } else {
          return {};
        }
      };

      return Collection;

    })(mvc.Collection);
    View = (function(_super) {
      __extends(View, _super);

      function View() {
        _ref2 = View.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      View.prototype.initialize = function(params) {
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
      };

      View.prototype.emit = function() {
        return this.trigger.apply(this, arguments);
      };

      View.prototype.renderer = function(html) {
        this.$el.attr("data-view", this.cid).html(html);
        template.renderSubViews(this.$el);
        return this;
      };

      return View;

    })(mvc.View);
    Widget = (function(_super) {
      __extends(Widget, _super);

      function Widget() {
        _ref3 = Widget.__super__.constructor.apply(this, arguments);
        return _ref3;
      }

      Widget.prototype.contructor = function(options) {
        Widget.__super__.contructor.call(this, options);
        return this.stop();
      };

      Widget.prototype.start = function() {
        if (this.rendered) {
          return this.delegateEvents();
        } else {
          this.render();
          return this.rendered = true;
        }
      };

      Widget.prototype.stop = function() {
        return this.undelegateEvents();
      };

      return Widget;

    })(View);
    mvc = {
      Model: Model,
      View: View,
      Collection: Collection
    };
    routing.Router = Router;
    return {
      mvc: mvc,
      template: template,
      routing: routing,
      Widget: Widget
    };
  });

}).call(this);
