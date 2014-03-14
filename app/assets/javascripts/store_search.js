


var searchStore = function(e) {
  var str = $('input.product-search').val();

  if ($(this).attr('name') == "product-search-button") {
    console.log("Clicked product search button. " + str);
  } else if ($(this).attr('name') == "product-search-input") {  
    console.log("Typed some product search string. " + str);
  }
  
  var href = $('a.product-search').attr('href');
  $('a.product-search').attr('href', href + '?query_string=' + str)
};

var storeReadyJs = function(e) {
  
  $('div.top-level-container').on(
    'click',
    'a.product-search',
    searchStore
  );
};

// Gotta bind to both events, because we are using turbolinks.
jQuery(document).ready(storeReadyJs);
jQuery(document).on('page:load', storeReadyJs);