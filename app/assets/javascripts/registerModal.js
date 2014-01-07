function showErrors(errors) {
  $('#form-group-email').removeClass('alert alert-warning');
  $('#form-group-password').removeClass('alert alert-warning');
  $('#form-group-password-confirmation').removeClass('alert alert-warning');

  function showWarningClass() {
    $('#form-group-email').addClass('alert');
    $('#form-group-password').addClass('alert');
    $('#form-group-password-confirmation').addClass('alert');
  };

  var emailErrors = errors.responseJSON['email'];
  var pwErrors = errors.responseJSON['password'];
  var pwConfErrors = errors.responseJSON['password_confirmation'];

  $('#form-group-email .error-message').empty();
  $('#form-group-password .error-message').empty();
  $('#form-group-password-confirmation .error-message').empty();

  if (typeof(emailErrors) != "undefined" && emailErrors.length > 0) {
    showWarningClass();
    $('#form-group-email').addClass("alert-warning");
    for(var propName in emailErrors) {
      emailErrors[propName] = capitaliseFirstLetter(emailErrors[propName]);
    };
    $('#form-group-email .error-message').append(emailErrors.join(', '));
  }

  if (typeof(pwErrors) != "undefined" && pwErrors.length > 0) {
    showWarningClass();
    $('#form-group-password').addClass("alert-warning");
    $('#form-group-password-confirmation').addClass("alert-warning");
    for(var propName in pwErrors) {
      pwErrors[propName] = capitaliseFirstLetter(pwErrors[propName]);
    };
    $('#form-group-password .error-message').append(pwErrors.join(', '));
  }

  if (typeof(pwConfErrors) != "undefined" && pwConfErrors.length > 0) {
    showWarningClass();
    $('#form-group-password').addClass("alert-warning");
    $('#form-group-password-confirmation').addClass("alert-warning");
    for(var propName in pwConfErrors) {
      pwConfErrors[propName] = capitaliseFirstLetter(pwConfErrors[propName]);
    };
    $('#form-group-password-confirmation .error-message').append(pwConfErrors.join(', '));
  }
};

$(document).ready(function() {
  $('#registerModalSubmit').click(function() {

    var _modal = $('#registerModal');

    var params = {
      user: {
        email: $("#input_email").val(),
        password: $("#input_password").val(),
        password_confirmation: $("#input_password_confirmation").val()
      }
    }
    console.log("Try to register...");
    $.ajax({
      url:"/users",
      type:'POST',
      dataType:"json",
      data: params,

      statusCode: {

        201: function(user) {
          console.log("success! user: " + user.id);
          _modal.modal('hide');
          // window.location.href = '/home/' + user.id;
        },

        // bad request
        400: function(errors) {
          showErrors(errors);
        }
      }

    });
  });
});