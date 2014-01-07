
function normalMode() {
  // Normal navbar text size
  $('.mg-navbar-title').css('font-size', '18px');
  $('.mg-navbar-link').css('font-size', '14px');
}

function smallMode() {
  // Shrink navbar text because window is small
  $('.mg-navbar-title').css('font-size', '11px');
  $('.mg-navbar-link').css('font-size', '11px');
  $('.container').css('min-width', '222px');
}

$(document).ready(function() {
  $(window).resize( function() {
    var size = $('body nav.navbar').css('width');
    if (parseInt(size) > 382) {
      normalMode();
    } else {
      smallMode();
    }
  });
  $(window).resize();
});