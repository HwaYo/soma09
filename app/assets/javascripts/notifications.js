$(document).on('ready page:load', function(){
    $(".scroll").on('click', function(e){            
      // scroll 이동 
      e.preventDefault();
      $('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);

      // 읽음 표시 & 서버 데이터 갱신 
      $(this).find('.no-read-notification').removeClass('no-read-notification');
      if($(this).data("read") === false) {
        $.ajax({
          type: "patch",
          url: "notifications/" + $(this).attr('id'), 
          data: { 'read' : true }
        }).success(function(result){
          var newNotification = $("#new-notification-number"),
              newNotificationNumber = newNotification.text() - 1; 
          if(newNotificationNumber === 0) {
            newNotification.remove();
          } else {
            newNotification.text(newNotificationNumber + "");  
          }
        });
      }
    });
});