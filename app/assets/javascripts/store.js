
var updateCart = function( event ) {
  if ( event ) {
    var newQty = $(this).val();
    var inputElement = $(event.target);
    var inputId = inputElement.attr('id');               // eg "qtyToOrder-productId-23"
    var productId = inputId.toString().split('-').pop(); // eg "23"
    var parentalDiv = inputElement.parent().parent();

    if (productId <= 0) {
      // console.log("Invalid input.");
      return;
    }

    console.log(
      "submit ajax request. "       +
      " event.which:" + event.which +
      ' productId:'   + productId   +
      ' qty:'         + newQty
    );

    var params = {
      cartUpdate: {
        productId: productId,
        newQty: newQty
      }
    };

    $.ajax({
      url:"/cart",
      type:'PUT',
      dataType:"json",
      data: params,
      statusCode: {
        200: function(jqXHR) {
          var result = jqXHR.getResponseHeader('result');
          var message = jqXHR.getResponseHeader('message');
          console.log(message);
          switch(result) {

            case "removed-from-cart":
            parentalDiv.find('.maxStockMsg small').html('');
            parentalDiv.find('.inCartIcon').hide();
            inputElement.val(0);
            break;

            case "updated-qty":
            parentalDiv.find('.maxStockMsg small').html('');
            parentalDiv.find('.inCartIcon').show();
            break;
            
            case "set-to-max":
            var max = jqXHR.getResponseHeader('max');
            var maxStockElement = parentalDiv.find('.maxStockMsg small');
            maxStockElement.html(message);
            maxStockElement.fadeOut({
              duration: 4000,
              done: function(){
                maxStockElement.html('');
                maxStockElement.fadeIn({
                  duration: 0
                });
              }
            });
            inputElement.val(max);
            break;
          }
        },
        400: function(jqXHR) {
          var message = jqXHR.getResponseHeader('message');
          console.log("400 failed. message:" + message);
        },
        422: function() {
          console.log("Your session has expired.");
          window.location.href = '/session-expired-notice';
        }
      },
      complete: function(xhr, textStatus){
        //console.log("XHR COMPLETED with status " + textStatus + "\n");
        if (textStatus == "success") {
        }
      }
    });
  } else {
    console.log( "this didn't come from an event!" );
  }
};

var storeReadyJs = function(e) {

  console.log("\nstoreReadyJs()");
  console.log("BIND keydown to--> updateCart()");

  var result = $('div.top-level-container').on(
    // 'change keydown keyup',
    'change keyup',
    'input.qtyToOrder-input',
    updateCart
  );
};

// Gotta bind to both events, because we are using turbolinks.
jQuery(document).ready(storeReadyJs);
jQuery(document).on('page:load', storeReadyJs);