$(document).ready(function() {

  $('div.modal').on('show.bs.modal', function () {
    // Disable body scroll whenever a bootstrap modal is visible
    console.log('Hide scrollbar');
    $('body').css('overflow','hidden');

  }).on('hidden.bs.modal', function () {
    // Enable body scroll whenever all bootstrap modals are hidden
    console.log('Show scrollbar');
    $('body').css('overflow','auto');
  });

 });