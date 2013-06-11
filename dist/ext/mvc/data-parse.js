(function() {
  define(["core/util"], function(util) {
    return function(Cls) {
      return util.extend(Cls.prototype, {
        parse: function(res) {
          if (res.status === "OK") {
            return res.data;
          } else {
            return {};
          }
        }
      });
    };
  });

}).call(this);
