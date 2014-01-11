$(document).ready(function() {
  $('#loginModalSubmit').click(function() {
    
    var _user;

    var _modal = $('#loginModal');

    var params = {
      user: {
        email: $("#input_email").val(),
        password: $("#input_password").val()
      }
    }

    console.log("Try to log in...");
    $.ajax({
      url:"/sessions",
      type:'POST',
      dataType:"json",
      data: params,

      // success: function(data, textStatus, jqXHR){
      //   console.log("Login XHR success. Status: " + textStatus + "\n");
      // },

      // error: function(jqXHR, textStatus, errorThrown){
      //   console.log("Login XHR error. Status: " + textStatus + "\n");
      // },

      statusCode: {

        201: function(response) {
          _user = response.user;
          console.log("200 success! You are logged in as " + _user.id);
        },

        400: function() {
          console.log("400 failed");
        }
      },

      complete: function(xhr, textStatus){
        console.log("Login XHR COMPLETED with status " + textStatus + "\n");
        if (textStatus == "success") {
          _modal.modal('hide');
          window.location.href = '/users/' + String(_user.id);
        }
      }

    });
    return false;
  });
});