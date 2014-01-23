function showErrors(errors) {

  var emailDiv = $('#registerModal div.form-group.email');
  var passwordDiv = $('#registerModal div.form-group.password');
  var confirmPasswordDiv = $('#registerModal div.form-group.passwordConfirmation');

  // clear the error classes, for all rego fields.
  emailDiv.removeClass('alert alert-warning');
  passwordDiv.removeClass('alert alert-warning');
  confirmPasswordDiv.removeClass('alert alert-warning');

  // Make the error classes visible, for all rego fields.
  function showWarningClass() {
    emailDiv.addClass('alert');
    passwordDiv.addClass('alert');
    confirmPasswordDiv.addClass('alert');
  };

  // Check if the error list is empty, for a given rego field.
  function gotErrors(arr) {
    if (typeof(arr) != "undefined" && arr.length > 0) {
      return true;
    }
    return false;
  };

  // Show the error messages for a given rego field.
  function displayErrors(errors, jqSelector) {
    for(var propName in errors) {
      errors[propName] = capitaliseFirstLetter(errors[propName]);
    };
    jqSelector.append(errors.join(', '));
  }

  // Get the list of errors, for all rego fields.
  var emailErrors = errors.responseJSON['email'];
  var pwErrors = errors.responseJSON['password'];
  var pwConfErrors = errors.responseJSON['passwordConfirmation'];

  // Clear the error text content, for all rego fields.
  emailDiv.find('span.error-message').empty();
  passwordDiv.find('span.error-message').empty();
  confirmPasswordDiv.find('span.error-message').empty();

  if (gotErrors(emailErrors)) {
    showWarningClass();
    emailDiv.addClass("alert-warning");
    displayErrors(emailErrors, emailDiv.find('span.error-message'));
  }

  if (gotErrors(pwErrors)) {
    showWarningClass();
    passwordDiv.addClass("alert-warning");
    confirmPasswordDiv.addClass("alert-warning");
    displayErrors(pwErrors, passwordDiv.find('span.error-message'));
  }

  if (gotErrors(pwConfErrors)) {
    showWarningClass();
    passwordDiv.addClass("alert-warning");
    confirmPasswordDiv.addClass("alert-warning");
    displayErrors(pwConfErrors, confirmPasswordDiv.find('span.error-message'));
  }
};


$(document).ready(function() {

  $(document).on('click', '#registerModal button.submitButton', function() {

    console.log("\n register modal submit button - clicked");

    var _modal = $('#registerModal');

    var params = {
      user: {
        email: $("#registerModal div.email input").val(),
        password: $("#registerModal div.password input").val(),
        password_confirmation: $("#registerModal div.passwordConfirmation input").val()
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
          _modal.on('hidden.bs.modal', function () {
            window.location.href = '/users/' + user.id;
          })
          _modal.modal('hide');
        },

        // bad request
        400: function(errors) {
          showErrors(errors);
        }
      }

    });
    return false;
  });
});