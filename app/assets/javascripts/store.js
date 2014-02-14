
$(document).ready(function() {

  var updateCart = function( event ) {
    if ( event ) {
      var inputElement = $(event.target)
      console.log("submit ajax request: " + event.which + ' productId: ' + inputElement.attr('id'));
      inputElement.css('border-style', 'solid');
      inputElement.css('border-width', '2px');
      inputElement.css('border-color', 'green');
      
    } else {
      console.log( "this didn't come from an event!" );
    }
  };

  $('div.storeContents').on('keypress', 'input.qtyToOrder-input', updateCart);

  $('div.storeContents').on('blur', 'input.qtyToOrder-input', updateCart);
});