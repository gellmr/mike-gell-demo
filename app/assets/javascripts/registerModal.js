$(document).ready(function() {
  $('#registerModalSubmit').click(function() {

    var _modal = $('#registerModal');

    var params = {
      user: {
        email: $("#user_email").val(),
        password: $("#user_password").val(),
        password_confirmation: $("#user_confirm_password").val()
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
        400: function(errorMessage) {
          // console.log("failed. errorMessage: " + JSON.stringify(errorMessage));
          console.log("failed. " + errorMessage.responseText);
        }
      }

    });
  });
});