


var searchStore = function(e) {
  var str = $('input.product-search').val();

  if ($(this).attr('name') == "product-search-button") {
    console.log("Clicked product search button. " + str);
  } else if ($(this).attr('name') == "product-search-input") {  
    console.log("Typed some product search string. " + str);
  }
  ajaxProductSearch(str);
};

var ajaxProductSearch = function(str) {
  var params = {
    productSearch: {
      queryString: str
    }
  };
  $.ajax({
    url:"/store",
    type:'PUT',
    dataType:"json",
    data: params,
    statusCode: {
      200: function(jqXHR) {
        var message = jqXHR.message;
        console.log("[200] message: " + message);
        var form = $('div.centeredProducts form');
        form.children().remove();
        form.append(jqXHR.html);
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

var storeReadyJs = function(e) {

  console.log("\nstoreReadyJs() " + e.type);
  console.log("BIND keydown to--> searchStore()");

  // $('div.top-level-container').on(
  //   'keyup',
  //   'input.product-search',
  //   searchStore
  // );
  
  $('div.top-level-container').on(
    'click',
    'button.product-search',
    searchStore
  );
};

// Gotta bind to both events, because we are using turbolinks.
jQuery(document).ready(storeReadyJs);
jQuery(document).on('page:load', storeReadyJs);