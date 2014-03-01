
var cartSubmit = function(event, jqXHR, ajaxOptions) {
  var message = jqXHR.getResponseHeader('message');
  if (message != null) {
    console.log(message);
  }
  switch(ajaxOptions) {
    case "success":
    var userId = jqXHR.getResponseHeader('userId');
    var orderId = jqXHR.getResponseHeader('orderId');
    console.log("userId: "  + userId);
    console.log("orderId: " + orderId);
    // redirect self...
    window.location.href = '/users/' + userId + '/orders/' + orderId;
    break;
    
    case "error":
    // redirect to login page
    window.location.href = '/login';
    break;
  }
};

jQuery(document).ready(function ($) {
  console.log("\n cart_submit.js ready handler.");
  $(document).on('ajax:complete', '#cartForm', cartSubmit);
});
