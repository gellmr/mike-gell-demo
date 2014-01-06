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
          // console.log("failed. " + errors.responseText);
          $('#error_messages').empty();
          for(var propName in errors.responseJSON) {
            var value = errors.responseJSON[propName];
            console.log(propName + ': ' + value);
            $('#error_messages').append('<li>' + propName + ': ' + value + '</li>');
          }
        }
      }

    });
  });
});