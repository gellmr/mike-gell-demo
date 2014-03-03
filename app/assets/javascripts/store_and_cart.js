
var quantityUpdateButton = function(event) {
  if ( event ) {
    var buttonElement = $(event.currentTarget);
    var buttonId = buttonElement.attr('id');             // eg "qty-btn-minus-23"
    var productId = buttonId.toString().split('-').pop(); // eg "23"
    var inputId = '#qtyToOrder-productId-' + String(productId);   // eg "qtyToOrder-productId-23"
    var inputElement = $(inputId);
    var qty = parseInt(inputElement.val());
    if (isNaN(qty)) {
      qty = 0;
    }

    // Button id tells us to add or subtract.
    if (buttonId.toString().split('-')[2] == "plus") {
      qty += 1; // qty-btn-plus-23
    } else {
      qty -= 1; // qty-btn-minus-23
    }
    console.log("Try to update product " + productId + " -> new qty: " + qty );
    updateCart(productId, qty, inputElement, inputId);
  }
};

var quantityInputField = function(event) {
  if ( event ) {
    var qty = $(this).val();
    var inputElement = $(event.target);
    var inputId = inputElement.attr('id');               // eg "qtyToOrder-productId-23"
    var productId = inputId.toString().split('-').pop(); // eg "23"
    console.log("Try to update product " + productId + " -> new qty: " + qty );
    updateCart(productId, qty, inputElement, inputId);
  }
};

var updateCart = function( productId, newQty, inputElement, inputId) {

  var parentalDiv = $('div.parentalDiv-' + productId);
  var wellDiv = $('.well.product-' + productId);
  var minusBtn = $('#qty-btn-minus-' + productId);

  console.log(
    "submit ajax request. "       +
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
        var resultSubTot = jqXHR.getResponseHeader('resultSubTot');
        var resultGrandTot = jqXHR.getResponseHeader('resultGrandTot');
        var cartTotalItems = jqXHR.getResponseHeader('cartTotalItems');
        var cartTotalLines = jqXHR.getResponseHeader('cartTotalLines');
        var message = jqXHR.getResponseHeader('message');
        console.log(message);
        switch(result) {

          case "removed-from-cart":
          parentalDiv.find('.maxStockMsg small').html('');
          parentalDiv.find('.inCartIcon').hide();
          inputElement.val(0);
          var page = document.URL.split('/').pop().split('?').shift();
          if (page == "cart"){
            wellDiv.remove();
          }
          $('.cart-submit-btn').trigger('check-if-no-products');
          break;

          case "updated-qty":
          parentalDiv.find('.maxStockMsg small').html('');
          parentalDiv.find('.inCartIcon').show();
          inputElement.val(newQty);
          if (String(newQty) == "0") {
            minusBtn.addClass("disabled", "disabled");
          } else {
            minusBtn.removeClass("disabled", "disabled");
          }
          parentalDiv.find('.subtot-input').val('$ ' + resultSubTot);
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
          parentalDiv.find('input.subtot-input').val(resultSubTot);
          break;
        };
        $("h3.content-heading").html("My Cart - " + cartTotalLines + " Lines");
        $("input.total-items").val(cartTotalItems);
        $("input.grand-total").val('$ ' + resultGrandTot);
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

};

var checkIfNoProducts = function(e) {
  if ($('div.well').length == 0) {
    console.log("There are no products in the cart.")
    $(this).hide();
  }
  else {
    console.log("There are products in the cart.")
    $(this).show();
  }
};

var storeReadyJs = function(e) {

  console.log("\nstoreReadyJs()");
  console.log("BIND keydown to--> updateCart()");

  $('div.top-level-container').on(
    'change keyup',
    'input.qtyToOrder-input',
    quantityInputField
  );
  
  $('.cart-submit-btn').on('check-if-no-products', checkIfNoProducts);
  $('.cart-submit-btn').trigger('check-if-no-products');

  var result = $('div.top-level-container').on(
    'click',
    'button.qty-btn-plus, button.qty-btn-minus',
    quantityUpdateButton
  );
};

// Gotta bind to both events, because we are using turbolinks.
jQuery(document).ready(storeReadyJs);
jQuery(document).on('page:load', storeReadyJs);

