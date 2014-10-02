(function() {

  var winHeight = 0;
  var fixedPanelHeight = 0;
  var fixedPanelJq = null;
  var threshold = 0;
  var panelVisible = 1;

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
    threshold = $("div.threshold-vis:visible").offset().top + fixedPanelHeight;
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

  var customWinResize = function(e){
    winHeight = $(window).height();
    threshold = $("div.threshold-vis:visible").offset().top + fixedPanelHeight;
    customVerticalScroll(e);
  }

  var customVerticalScroll = function(e){
    var wst = $(window).scrollTop();
    if ((wst + winHeight) < threshold){
      if (panelVisible == 1){
        // Hide
        panelVisible = -1;
        fixedPanelJq.animate({ bottom: 0 - fixedPanelHeight }, "fast", function(){ panelVisible = 0; });
      }
    }else{
      if (panelVisible == 0){
        // Show
        panelVisible = -1;
        fixedPanelJq.animate({ bottom: 0 }, "slow", function(){ panelVisible = 1; });
      }
      if (panelVisible == 1){
        // Visible
        fixedPanelJq.css("bottom", '0');
      }
    }
  }

  var docReady = function(e) {
    console.log("\n(docReady) document.URL: " + document.URL);

    winHeight = $(window).height();
    fixedPanelHeight = $('#fixedPanel').height();
    fixedPanelJq = $('#fixedPanel');
    threshold = $("div.threshold-vis:visible").offset().top + fixedPanelHeight;

    $( window ).resize(customWinResize);
    $( window ).scroll(customVerticalScroll);
    
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