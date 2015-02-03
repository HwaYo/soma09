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

  $('#edit-comment').on('click', function(e) {
    // find the comment box and change it to a text-input form
    commentBox = $(this).parent().prev();
    comment = commentBox.find('p');

    commentId = $(document).find('#comment-id').attr('value');
    commentForm = $(this).closest('.panel-info').next().find('form');
    
    updateButton = commentForm.find('input').last();
    updateButton.addClass("btn-orange");
    updateButton.removeClass("btn-info");
    updateButton.attr('value',"수정");

    // Change Form attributes to Work as updates
    var action = commentForm.attr('action') +"/"+ commentId;
    commentForm.attr('action', action);
    commentForm.attr('method','PUT');
    commentForm.find('.comment_input').attr('value',comment.text());

    $(this).parent().find('.btn').first().remove();

    /* use ajax to send a PATCH request
utf8:✓
authenticity_token:OODm+lY2Aml13xHVGcGpN//Sd8N6hMY6wXRBOZ7Qy+Tke2/DY3LyKV6s/QI8hVz4/as0ilplpyJS07XkLs3qDA==
comment[post_id]:7
comment[content]:afadsf
commit:댓글
    */
    
  });

});
