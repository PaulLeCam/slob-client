(function() {
  define(["./util"], function(util) {
    var api, csl, now, refs, _ref, _ref1, _ref2, _ref3;

    now = (_ref = (_ref1 = typeof performance !== "undefined" && performance !== null ? performance.now : void 0) != null ? _ref1 : typeof performance !== "undefined" && performance !== null ? performance.webkitNow : void 0) != null ? _ref : Date.now;
    csl = typeof console !== "undefined" && console !== null ? console : {
      log: function() {},
      info: function() {},
      warn: function() {},
      error: function() {}
    };
    refs = {};
    if ((_ref2 = csl.time) == null) {
      csl.time = function(key) {
        return refs[key] = now();
      };
    }
    if ((_ref3 = csl.timeEnd) == null) {
      csl.timeEnd = function(key) {
        var start, time;

        if (start = refs[key]) {
          time = now() - start;
          this.log("`" + key + "`: " + time + "ms");
          return delete refs[key];
        }
      };
    }
    api = {
      active: false
    };
    util.each(["log", "info", "warn", "error", "time", "timeEnd"], function(func) {
      return api[func] = function() {
        if (this.active) {
          csl[func].apply(csl, arguments);
        }
        return this;
      };
    });
    return api;
  });

}).call(this);
