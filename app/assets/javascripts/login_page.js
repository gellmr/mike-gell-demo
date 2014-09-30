(function() {

  jQuery(document).ready(function($) {

    $('input#inputPassword').on('keypress', function(event){
      if (event.which == 13){
         $("button#loginPageSubmit").trigger("click");
      }
    });

    $(document).on('click', '#loginPageSubmit', function() {

      var _user;

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
          },

          400: function(jqXHR) {
            var message = jqXHR.getResponseHeader('message');
            console.log("400 failed " + message);
            var flashElement = $('.loginFailMessage');
            flashElement.show();
            flashElement.html(message);
          }
        },

        complete: function(xhr, textStatus){
          //console.log("Login XHR COMPLETED with status " + textStatus + "\n");
          if (textStatus == "success") {
            console.log("redirection: " + xhr.responseJSON.redirection);
            window.location.href = xhr.responseJSON.redirection;
          }
        }

      });
      return false;
    });
  });

})();