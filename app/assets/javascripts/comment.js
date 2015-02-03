$(document).ready(function() {
  
  $('.comment_input').on('keyup', function(e) {
    
    if ($(this).val().length != 0) {
      $(this).parent().find('.comment_submit').removeClass("disabled");
    } else if(e.keyCode == 13) {
      console.log('Enter Pressed');
      e.preventDefault();
      return false;
    } else {
      $(this).parent().find('.comment_submit').addClass("disabled");
    }
  });

  $('.btn-xs, .btn-orange').on('click', function(e) {
    // find the comment box and change it to a text-input form
    $('.btn-xs, .btn-orange').addClass('disabled');

    commentBox = $(this).parent().prev();
    comment = commentBox.find('p');

    commentId = $(this).parent().prev().find('#comment-id').attr('value');
    commentForm = $(this).closest('.panel-info').next().find('form');
    
    updateButton = commentForm.find('input').last();
    updateButton.addClass("btn-orange");
    updateButton.removeClass("btn-info");
    updateButton.attr('value',"수정");
    updateButton.attr('type','button');
    updateButton.attr('id','comment-update-btn');

    // Change Form attributes to Work as updates
    var action = commentForm.attr('action') +"/"+ commentId;
    commentForm.attr('action', action);

    if( commentForm.find('_method') )
      commentForm.find('_method').remove();

    var putInput = $('<input type="hidden" name="_method" value="patch"></input>');
    commentForm.append(putInput);

    commentForm.find('.comment_input').attr('value',comment.text()).attr('id','#comment-update-input');

    $(this).parent().find('.btn').first().remove();
    
  });

});
