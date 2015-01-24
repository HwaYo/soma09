$(document).ready(function() {
  
  $('.comment_input').on('keypress', function(e) {
    
    if ($(this).val().length != 0) {
      $(this).parent().find('.comment_submit').removeClass("disabled");
    } else if(e.keyCode == 13) {
      return false;
    } else {
      $(this).parent().find('.comment_submit').addClass("disabled");
    }
  });
});
