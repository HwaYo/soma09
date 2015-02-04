$(document).on('ready page:load', function(){
    new_noti_number = $("#new_noti_number").text();
    if(new_noti_number == 0) {
      $("#new_noti_number").remove();
    }

    $(".scroll").click(function(event){            
      event.preventDefault();
      $('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
      $(this).find('.no-read-notification').removeClass('no-read-notification');

      if($(this).data("read") === false) {
        $.ajax({
          type: "patch",
          url: "notifications/" + $(this).attr('id'), 
          data: { 'read' : true }
        }).success(function(result){
          new_noti_number = $("#new_noti_number").text() - 1;
          if(new_noti_number === 0) {
            $("#new_noti_number").remove();
          } else {
            $("#new_noti_number").text(new_noti_number + "");  
          }
        });
      }
    });
});