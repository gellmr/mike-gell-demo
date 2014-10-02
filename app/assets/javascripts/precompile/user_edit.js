(function() {

  var anchorContainsString = function(anchor, str){
    return (anchor.toLowerCase().indexOf(str.toLowerCase()) > -1);
  }

  var containsAnchor = function(str){
     return (str.indexOf("#") != -1);
  }

  var removeAnchor = function(str){
    if (containsAnchor(str)) {
      return str.substring(0, str.indexOf("#"));
    }
    else {
      return str;
    }
  }

  var getAnchorFromUrl = function(str){
    if (str.indexOf("#") != -1) {
      var anchor = str.substring(str.indexOf("#")+1); // eg "http://siteurl/users/1/edit#myAddresses"
      return anchor; // eg "myAddresses"
    }
    else {
      return "";
    }
  }

  // Modify the current browser url, setting the current anchor.
  var setPageAnchor = function(newAnchor) {
    var historyData = {};
    var newTitle = "";
    var newUrl = removeAnchor(document.URL) + '#' + newAnchor;
    window.history.pushState(historyData, newTitle, newUrl);
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
    setPageAnchor(newAnchor);
    updateScrollPosition(newAnchor);
    $('#current_tab').val(newAnchor);
  }

  var showTab = function(tabName){
    // Call jquery method to select the address tab.
    var bootstrapElement = $('#accountDetailTabs a[href="#' + tabName + '"]');
    bootstrapElement.tab('show');
    $('#current_tab').val(tabName);
  }

  var updateScrollPosition = function(anchor) {
    if (anchorContainsString(anchor, "address")) {
      // myAddresses page
      if (anchorContainsString(anchor, "myAddresses")) {
        // scroll to the top of the page.
        //scrollToElement('a[href="#myAddresses"]');
        scrollToElement('a[href="#formTop"]');
      }else{
        // User has just added a new address. Scroll to address.
        scrollToElement('a[data_address="' + anchor + '"]');
      }
    }else{
      // accountDetails page
      //scrollToElement('a[href="#accountDetails"]');
      //scrollToElement('a[href="#pagetop"]');
      scrollToElement('a[href="#formTop"]');
    }
    console.log("anchor: #" + anchor);
  }

  var customVerticalScroll = function(e){
    var threshold = 373;
    var hide = 'N';
    var wst = $(window).scrollTop();
    var wh = $(window).height();
    var y = '0';
    var base = wst + wh;
    if (base < threshold){
      hide = 'Y';
    }
    if (hide == 'Y'){
      y = (wh - threshold) + wst;
    }
    $('#fixedPanel').css("bottom", y);
    //console.log(" winheight:" + wh + " base:" + base + " hide:" + hide + " y:" + y + " scrolltop:" + wst);
  }

  var docReady = function(e) {
    console.log("\n(docReady) document.URL: " + document.URL);
    
    $( window ).scroll(customVerticalScroll);
    $( window ).resize(customVerticalScroll);
    
    // Register for the bootstrap tab 'shown' event.
    $('a[data-toggle="tab"]').on('shown.bs.tab', clickedBootStrapTab);
    // If we don't yet have an anchor in the document url, then init to 'accountDetails'
    if (containsAnchor(document.URL) == false) {
      setPageAnchor('accountDetails');
    }
    // We are on the 'accountDetails' page, or the 'myAddresses' page.
    var anchor = getAnchorFromUrl(document.URL);
    // "accountDetails"
    // "myAddresses"
    // "address48"

    if (anchorContainsString(anchor, "address")) {
      showTab('myAddresses');
    }else{
      showTab('accountDetails');
    }
    updateScrollPosition(anchor);
  };

  // Gotta bind to both events, because we are using turbolinks.
  jQuery(document).ready(docReady);
  //jQuery(document).on('page:load', docReady);
})();