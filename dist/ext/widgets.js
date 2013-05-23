(function() {
  define(["core/dev", "core/dom", "core/promise", "core/store", "core/util"], function(dev, dom, promise, Store, util) {
    var elsStore, typesStore;

    typesStore = new Store;
    elsStore = new Store;
    return {
      load: function(type) {
        var dfd;

        dfd = promise.deferred();
        require(["widgets/" + type], dfd.resolve, function(err) {
          dev.warn("Error trying to initialize widget `" + type + "`", err);
          return dfd.reject(err);
        });
        return dfd.promise();
      },
      initialize: function(type, options) {
        var dfd;

        dfd = promise.deferred();
        this.load(type).fail(dfd.reject).done(function(Widget) {
          var elTypes, typeEls, w;

          if (!util.isObject(options)) {
            options = {
              el: options
            };
          }
          w = new Widget(options);
          if (!elsStore.has(options.el)) {
            elsStore.set(options.el, new Store);
          }
          elTypes = elsStore.get(options.el);
          elTypes.set(type, w);
          if (!typesStore.has(type)) {
            typesStore.set(type, new Store);
          }
          typeEls = typesStore.get(type);
          typeEls.set(options.el, w);
          return dfd.resolve(w);
        });
        return dfd.promise();
      },
      start: function(type, options) {
        var elTypes, typeEls, w, _i, _j, _len, _len1, _ref, _ref1;

        if ((type == null) || (options == null) || type === "*" && options === "*") {
          dev.warn("Wrong parameters to start widget", type, options);
          return this;
        }
        if (options === "*") {
          if (typeEls = typesStore.get(type)) {
            _ref = typeEls.values();
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              w = _ref[_i];
              w.start();
            }
          }
        } else {
          if (!util.isObject(options)) {
            options = {
              el: options
            };
          }
          if (elTypes = elsStore.get(options.el)) {
            if (type === "*") {
              _ref1 = elTypes.values();
              for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                w = _ref1[_j];
                w.start();
              }
            } else if ((w = elTypes.get(type))) {
              w.start();
            } else {
              this.initialize(type, options).done(function(w) {
                return w.start();
              });
            }
          } else {
            this.initialize(type, options).done(function(w) {
              return w.start();
            });
          }
        }
        return this;
      },
      stop: function(type, el) {
        var elTypes, typeEls, w, _i, _j, _len, _len1, _ref, _ref1;

        if ((type == null) || (el == null) || type === "*" && el === "*") {
          dev.warn("Wrong parameters to stop widget", type, el);
          return this;
        }
        if (el === "*") {
          if (typeEls = typesStore.get(type)) {
            _ref = typeEls.values();
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              w = _ref[_i];
              w.stop();
            }
          }
        } else {
          if (elTypes = elsStore.get(el)) {
            if (type === "*") {
              _ref1 = elTypes.values();
              for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                w = _ref1[_j];
                w.stop();
              }
            } else if ((w = elTypes.get(type))) {
              w.stop();
            }
          }
        }
        return this;
      },
      remove: function(el) {
        var elTypes, key, typesEl, _i, _len, _ref;

        if ((el == null) || el === "*") {
          dev.warn("Wrong parameters to remove widget", el);
          return this;
        }
        if (elTypes = elsStore.get(el)) {
          _ref = elTypes.keys();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            key = _ref[_i];
            elTypes.get(key).remove();
            if (typesEl = typesStore.get(el)) {
              typesEl["delete"](el);
            }
          }
          elsStore["delete"](el);
        } else {
          sandbox.dom.find(el).remove();
        }
        return this;
      }
    };
  });

}).call(this);
