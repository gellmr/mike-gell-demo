
// This code relies on the navbar width.
// We have to wait for the page to load fully.
// We cannot use $( document ).ready

var windowResizeReadyJS = function (event) {
  
  // Make the navbar text become tiny, if the window is very small.
  var logCount = 0;
  $(document).on("windowResizeHandler", function( e ) {
    // console.log('Resized ' + logCount);
    logCount = logCount + 1;
    if (parseInt($('body nav.navbar').css('width')) > 382) {
      $(document).trigger( "normalMode" );
    } else {
      $(document).trigger( "smallMode" );
    }
    
  }).on("normalMode", function( e ) {
    // Normal navbar text size
    $('.mg-resizable-11-14').css('font-size', '12px');
    $('.mg-site-title').css('font-size', '24px');

  }).on("smallMode", function( e ) {
    // Shrink navbar text because window is small
    $('.mg-resizable-11-14').css('font-size', '11px');
    $('.top-level-container').css('min-width', '222px');
    $('.mg-site-title').css('font-size', '19px');
  });

  // Bind the window resize event to our custom handler
  $(window).resize(function (e) {
    $(document).trigger( "windowResizeHandler" );
  });

  // Init
  // Here we ensure the navbar text is the correct size when a new window is opened.
  $(document).trigger( "windowResizeHandler" );

};
// Gotta bind to both events, because we are using turbolinks.
jQuery(document).ready(windowResizeReadyJS);
jQuery(document).on('page:load', windowResizeReadyJS);