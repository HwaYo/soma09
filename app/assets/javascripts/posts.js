$(document).on('ready page:load', function () {
  $(".btn-post-close").on('click', function (e) {
    $(this).addClass('disabled');
  });

  $(".post-thumbnail").each(function (i, thumbnail) {
    $.ajax({
      url: "/posts/" + $(this).data('post-id') + "/thumbnail"
    }).done(function (result) {
      $(thumbnail).find('.post-thumbnail-image').prepend($('<img />', {
        src: result.images[0] || '',
      }));
      $(thumbnail).find('.post-thumbnail-title').text(result.title || 'No title');
      $(thumbnail).find('.post-thumbnail-description').text(result.description || 'No description');
    });
  });

  editModal.init();
});

var editModal = {
  init: function(){
    this.loadInitContent();
    $("#edit-modal").on("shown.bs.modal", function(e) {
      editModal.setValidationEvent();
    });
  },

  loadInitContent: function(){
    $(".btn-post-edit").on("click", function(e){
      var link = $(e.target);
      var postId = link.data('post');

      $.ajax({
        url: "posts/" + postId + "/edit"
      }).success(function(html){
        $('.modal-body').html(html);
      });
    });
  },

  setValidationEvent: function(){
    $('#edit-modal form').on('ajax:success', function(xhr, status, error){
      location.reload();
    }).on('ajax:error',function(xhr, status, error){
      $('.modal-body').html(status.responseText);
      editModal.setValidationEvent();
    });
  }


}