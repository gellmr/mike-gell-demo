
var cartSubmit = function(event, jqXHR, ajaxOptions) {
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

    case "Bad Request":
    // redirect to login page
    window.location.href = '/login';
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
  console.log("\n cart_submit.js ready handler.");
  $(document).on('ajax:complete', '#cartForm', cartSubmit);
});
