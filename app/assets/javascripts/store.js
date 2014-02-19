
$(document).ready(function() {

  var updateCart = function( event ) {
    if ( event ) {
      var newQty = $(this).val();
      var inputElement = $(event.target);
      var inputId = inputElement.attr('id');               // eg "qtyToOrder-productId-23"
      var productId = inputId.toString().split('-').pop(); // eg "23"

      // console.dir(event);
      console.log(
        "submit ajax request. "       +
        " event.which:" + event.which +
        ' productId:'   + productId   +
        ' qty:'         + newQty
      );
      inputElement.css('border-style', 'solid');
      inputElement.css('border-width', '2px');
      inputElement.css('border-color', 'green');

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
          200: function(response) {
          },
          400: function() {
            console.log("400 failed");
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

  $('div.storeContents').on('change keydown keyup', 'input.qtyToOrder-input', updateCart);
});