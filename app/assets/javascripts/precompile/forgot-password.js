(function() {

  var focusforgotPwEmailInput = function(e) {
    if ( $(this).val() == 'Your Email Address') {
      $(this).val('');
    }
  }

  var blurforgotPwEmailInput = function(e) {
    if ($(this).val() == '') {
      $(this).val('Your Email Address');
    }
  }

  var submitted = function(e) {
    $(this).addClass('disabled');
  }

  var forgotPwReadyJs = function(e) {

    $('div.top-level-container').on(
      'focus',
      '#password-reset-email',
      focusforgotPwEmailInput
    );
    $('div.top-level-container').on(
      'blur',
      '#password-reset-email',
      blurforgotPwEmailInput
    );
    $('div.top-level-container').on(
      'click',
      '#submit_request_reset_pw',
      submitted
    );
  };

  jQuery(document).ready(forgotPwReadyJs);
  
})();