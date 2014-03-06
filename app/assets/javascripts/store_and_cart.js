
// Get the product Id from an element whos name follows the pattern:
//   "qty-btn-minus-23"
//   "qty-btn-plus-23"
//   "qtyToOrder-productId-23"
//   "remove-from-cart-23"
var popProductId = function(element) {
  var elementId = element.attr('id');      // eg "qty-btn-minus-23"
  var productId = elementId.toString().split('-').pop(); // eg "23"
  return productId;
}

var getInputElement = function(productId) {
  var inputId = '#qtyToOrder-productId-' + String(productId);   // eg "qtyToOrder-productId-23"
  var inputElement = $(inputId);
  return inputElement;
}

var quantityUpdateButton = function(event) {
  if ( event ) {
    var buttonElement = $(event.currentTarget);
    var productId = popProductId(buttonElement); // eg "23"
    var inputElement = getInputElement(productId);
    var qty = parseInt(inputElement.val());
    if (isNaN(qty)) {
      qty = 0;
    }

    // Button id tells us to add or subtract.
    if (buttonElement.attr('id').toString().split('-')[2] == "plus") {
      qty += 1; // qty-btn-plus-23
    } else {
      qty -= 1; // qty-btn-minus-23
    }
    inputElement.val(qty);
    console.log("Try to update product " + productId + " -> new qty: " + qty );
    updateCart(productId, qty, inputElement);
  }
};

var quantityInputField = function(event) {
  if ( event ) {
    var qty = $(this).val();
    var inputElement = $(event.target);
    var productId = popProductId(inputElement); // eg "23"
    console.log("Try to update product " + productId + " -> new qty: " + qty );
    updateCart(productId, qty, inputElement);
  }
};

var removeFromCart = function (event) {
  console.log("Remove from cart!");
    var element = $(event.currentTarget);
    var productId = popProductId(element); // eg "23"
    var inputElement = getInputElement(productId);
    var qty = -1;
    inputElement.val(0);
    hideInCartIcon(productId);
    console.log("Try to update product " + productId + " -> new qty: " + qty );
    updateCart(productId, qty, inputElement);
};

var hideInCartIcon = function(productId) {
  var parentalDiv = $('div.parentalDiv-' + productId);
  parentalDiv.find('.inCartIcon').hide();
};

var updateCart = function( productId, newQty, inputElement) {

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
        $("h3.content-heading").html("My Cart - " + cartTotalLines + " Lines");
        $("input.total-items").val(cartTotalItems);
        $("input.grand-total").val('$ ' + resultGrandTot);
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
  _this = $(this);

  $.ajax({
    url:"/cart/is-empty",
    type:'GET',
    complete: function(jqXHR, textStatus){
      var message = jqXHR.getResponseHeader('message');
      var cart_lines = parseInt(message);
      console.log("cart_lines: " + cart_lines);

      if (textStatus == "success") {

        if (cart_lines == 0) {
          console.log("There are no products in the cart.")
          _this.hide();
          $('#clearMyCartBtn').addClass("disabled");

        }else{
          console.log("There are products in the cart.")
          _this.show();
          $('#clearMyCartBtn').removeClass("disabled");
        }
      }
    }
  });
};

var storeAndCartReadyJs = function(e) {

  console.log("\nstoreAndCartReadyJs() " + e.type);
  console.log("BIND keydown to--> updateCart()");

  $('div.top-level-container').on(
    'change keyup',
    'input.qtyToOrder-input',
    quantityInputField
  );
  
  $('.cart-submit-btn').on('check-if-no-products', checkIfNoProducts);
  $('.cart-submit-btn').trigger('check-if-no-products');

  $('div.top-level-container').on(
    'click',
    'button.qty-btn-plus, button.qty-btn-minus',
    quantityUpdateButton
  );

  var result = $('div.top-level-container').on(
    'click',
    '.remove-from-cart',
    removeFromCart
  );
};

// Gotta bind to both events, because we are using turbolinks.
jQuery(document).ready(storeAndCartReadyJs);
jQuery(document).on('page:load', storeAndCartReadyJs);

