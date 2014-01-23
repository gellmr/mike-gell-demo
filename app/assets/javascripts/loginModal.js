jQuery(document).ready(function($) {

  $(document).on('click', '#loginModalSubmit', function() {

    var _user;

    var _modal = $('#loginModal');

    var params = {
      user: {
        email: $("#inputEmail").val(),
        password: $("#inputPassword").val()
      }
    }

    $.ajax({
      url:"/sessions",
      type:'POST',
      dataType:"json",
      data: params,

      statusCode: {

        201: function(response) {
          _user = response.user;
          // console.log("200 success! You are logged in as " + _user.id);
        },

        400: function() {
          console.log("400 failed");
        }
      },

      complete: function(xhr, textStatus){
        //console.log("Login XHR COMPLETED with status " + textStatus + "\n");
        if (textStatus == "success") {
          _modal.on('hidden.bs.modal', function () {
            window.location.href = '/users/' + String(_user.id);
          })
          _modal.modal('hide');
        }
      }

    });
    return false;
  });
});