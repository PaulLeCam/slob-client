(function() {
  define(["jquery"], function($) {
    return {
      ajax: $.ajax,
      get: $.get,
      getJSON: $.getJSON,
      post: $.post,
      param: $.param
    };
  });

}).call(this);
