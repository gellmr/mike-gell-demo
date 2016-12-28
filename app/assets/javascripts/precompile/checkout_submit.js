(function() {

  var checkoutSubmit = function(event, jqXHR, ajaxOptions) {
    var message = jqXHR.getResponseHeader('message');
    if (message != null) {
      console.log(message);
    }
    switch(jqXHR.statusText) {

      case "Created":
      var userId = jqXHR.getResponseHeader('userId');
      var orderId = jqXHR.getResponseHeader('orderId');
      console.log("userId: "  + userId);
      console.log("orderId: " + orderId);
      // redirect self...
      window.location.href = '/users/' + userId + '/orders/' + orderId;
      break;

      case "Unauthorized":
      window.location.href = '/login'; // redirect to login page
      break;

      case "Bad Request":
      window.location.href = '/login'; // redirect to login page
      break;

      case "Internal Server Error":
      // redirect to login page
      console.log("There was a server error!")
      var errorDiv = $('#serverError');
      errorDiv.html(jqXHR.statusText);
      errorDiv.show();
      break;
    }
  };

  jQuery(document).ready(function ($) {
    $(document).on('ajax:complete', '#checkoutForm', checkoutSubmit);
  });

})();
