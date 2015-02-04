$(document).ready(function() {
  
  $('.comment-input').on('keypress', function(e) {
    
    if ($(this).val().length != 0) {
      $(this).parent().find('.comment-submit').removeClass("disabled");
    } else if(e.keyCode == 13) {
      e.preventDefault();
      return false;
    } else {
      $(this).parent().find('.comment-submit').addClass("disabled");
    }
  });

  $('.btn-comment-update').on('click', function(e) {
    // find the comment box and change it to a text-input form

    commentBox = $(this).parent().prev();
    comment = commentBox.find('p');

    // comment Id for update form submission
    commentId = $(this).parent().prev().find('#comment-id').attr('value');
    commentForm = $(this).closest('.panel-info').next().find('form');
    
    commentButton = commentForm.find('.comment-submit');
    // Change the comment button to an Update button
    commentButton.addClass('btn-orange');
    commentButton.removeClass('btn-info');
    commentButton.attr('value','수정');

    quitUpdate = commentForm.find('.btn-comment-quit');
    quitUpdate.attr('type','button');

    commentForm.find('.comment-input').attr('value',comment.text());

    // Change Form attributes to Work as updates(patch /posts/:id/comments/:id)
    updateAction = commentForm.attr('action') +"/"+ commentId;
    commentForm.attr('action', updateAction);

    patchInput = $('<input type="hidden" name="_method" value="patch"></input>');
    commentForm.append(patchInput);

    $('.btn-comment-update').addClass('disabled');
    
  });

  $('.btn-comment-quit').on('click', function(e) {

    updateButton = $(this).prev();
    // Change Update button to an comment button
    updateButton.addClass("btn-info");
    updateButton.removeClass("btn-orange");
    updateButton.attr('value',"댓글");

    commentForm = $(this).closest('form');

    updateAction = commentForm.attr('action');
    submitAction = updateAction.slice(0, updateAction.lastIndexOf('/')+1 );

    commentForm.attr('action',submitAction);
    commentForm.find('input').last().remove();
    commentForm.find('.comment-input').removeAttr('value');

    $(this).attr('type','hidden');
    $('.btn-comment-update').removeClass('disabled');

  });

});
