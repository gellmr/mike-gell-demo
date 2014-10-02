(function() {
  
  var topLevelContainer;
  var searchAnchorSel;
  var searchAnchorJq;
  var productSearchInput;
  
  var searchStore = function(e) {
    var str = productSearchInput.val();

    if ($(this).attr('name') == "product-search-button") {
      console.log("Clicked product search button. " + str);
    } else if ($(this).attr('name') == "product-search-input") {  
      console.log("Typed some product search string. " + str);
    }
    
    var href = searchAnchorJq.attr('href');
    searchAnchorJq.attr('href', href + '?query_string=' + str);

    e.preventDefault();
    window.location = searchAnchorJq.attr('href');
  };

  var storeReadyJs = function(e) {

    topLevelContainer = $('div.top-level-container');
    productSearchInput = $('input.product-search');
    searchAnchorSel = 'a.product-search';
    searchAnchorJq = topLevelContainer.find(searchAnchorSel);

    $('#product-search-div').on('keypress', function(event){
      if (event.which == 13){
         searchAnchorJq.trigger("click");
      }
    });

    topLevelContainer.on(
      'click',
      searchAnchorSel,
      searchStore
    );
  };

  jQuery(document).ready(storeReadyJs);

})();