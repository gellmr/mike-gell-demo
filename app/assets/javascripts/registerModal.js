$(document).ready(function() {
  $('#registerModalSubmit').click(function() {

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
        201: function() {
          console.log("success");
          $('#registerModal').modal('hide');
        },
        400: function() {
          console.log("failed");
        },
      }
    }).done(function(data){
      console.log('done() ...data: ' + data);
    });

  });
 });