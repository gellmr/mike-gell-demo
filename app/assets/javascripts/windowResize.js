
function normalMode() {
  // Normal navbar text size
  $('.mg-navbar-link').css('font-size', '14px');
}

function smallMode() {
  // Shrink navbar text because window is small
  $('.mg-navbar-link').css('font-size', '11px');
  $('.container').css('min-width', '222px');
}
var c = 0;
$(document).ready(function() {
  
  // This makes the navbar text become tiny, if the window is very small.
  $(window).resize( function() {
    console.log('resized' + c);
    c = c + 1;
    var size = $('body nav.navbar').css('width');
    if (parseInt(size) > 382) {
      normalMode();
    } else {
      smallMode();
    }
  });

  // Here we ensure the navbar text is the correct size when a new window is opened.
  // $(window).resize();
});