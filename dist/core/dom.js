(function() {
  var __slice = [].slice;

  define(["jquery"], function($) {
    return {
      create: function(element) {
        return $("<" + element + "/>");
      },
      parse: $.parseHTML,
      find: function(selector, context) {
        if (context == null) {
          context = document;
        }
        if (selector === context) {
          return $(context);
        } else {
          return $(context).find(selector);
        }
      },
      data: function() {
        var args, selector;

        selector = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return $(selector).data.apply($, args);
      },
      on: function() {
        var args, selector;

        selector = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return $(selector).on.apply($, args);
      },
      off: function() {
        var args, selector;

        selector = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return $(selector).off.apply($, args);
      },
      once: function() {
        var args, selector;

        selector = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return $(selector).one.apply($, args);
      },
      ready: function(callback) {
        return $(function() {
          return callback();
        });
      }
    };
  });

}).call(this);
