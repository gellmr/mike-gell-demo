(function() {

  var getAnchorFromUrl = function(str){
    if (str.indexOf("#") != -1) {
      var anchor = str.substring(str.indexOf("#")+1); // eg "http://siteurl/users/1/edit#address48"
      return anchor; // eg "address48"
    }
    else {
      return "";
    }
  }

  var scrollToElement = function(selector) {
    //console.log('scrollToElement: $(' + selector + ")");
    $('html, body').animate(
      { scrollTop: $(selector).offset().top },
      500
    );
  }

  var clickedBootStrapTab = function(e) {
    var newHref = e.target.href; // The href of the anchor for the tab that was just activated.
    var newAnchor = getAnchorFromUrl( newHref );
    $('#current_tab').val(newAnchor);
  }

  var docReady = function(e) {
    console.log("\n(docReady) document.URL: " + document.URL);
    
    // Register for the bootstrap tab 'shown' event.
    $('a[data-toggle="tab"]').on('shown.bs.tab', clickedBootStrapTab);

    var anchor = getAnchorFromUrl(document.URL); // eg "address48"
    if (anchor.length > 0){
      // User has just added a new address. Scroll to address.
        scrollToElement('a[data_address="' + anchor + '"]');
    }
  };

  jQuery(document).ready(docReady);
})();