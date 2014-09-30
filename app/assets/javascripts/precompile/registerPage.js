(function() {

  function showErrors(errors) {

    var emailDiv = $('form.registerForm div.form-group.email');
    var passwordDiv = $('form.registerForm div.form-group.password');
    var confirmPasswordDiv = $('form.registerForm div.form-group.passwordConfirmation');

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
    var pwConfErrors = errors.responseJSON['password_confirmation'];

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

    $(document).on('click', 'form.registerForm button.submitButton', function() {

      console.log("\n registerForm submit button - clicked");

      var params = {
        user: {
          email: $("form.registerForm div.email input").val(),
          password: $("form.registerForm div.password input").val(),
          password_confirmation: $("form.registerForm div.passwordConfirmation input").val()
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
            window.location.href = '/users/' + user.id + '/edit';
          },

          // bad request
          400: function(errors) {
            console.dir(errors);
            showErrors(errors);
          }
        }

      });
      return false;
    });
  });

})();