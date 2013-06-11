(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  define(["core/routing", "core/util"], function(routing, util) {
    var Router, _ref;

    Router = (function(_super) {
      __extends(Router, _super);

      function Router() {
        _ref = Router.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Router.prototype.loadPage = function() {
        var args, page;

        page = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
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
    routing.Router = Router;
    return routing;
  });

}).call(this);
