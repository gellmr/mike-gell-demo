$(document).ready(function() {
  $('#registerModalSubmit').click(function() {

    var _modal = $('#registerModal');

    var params = {
      user: {
        email: $("#user_email").val(),
        password: $("#user_password").val(),
        password_confirmation: $("#user_password").val()
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

        400: function() {
          console.log("failed");
        }
      }
      
    });
  });
});