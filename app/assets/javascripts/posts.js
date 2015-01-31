$(document).on('ready page:load', function () {
  $(".btn-post-close").on('click', function (e) {
    $(this).addClass('disabled');
  });


  $(".post-thumbnail").each(function (i, thumbnail) {
    $.ajax({
      url: "/posts/" + $(this).data('post-id') + "/thumbnail"
    }).done(function (result) {
      $(thumbnail).find('.post-thumbnail-image').prepend($('<img />', {
        src: result.images[0].src
      }));
      $(thumbnail).find('.post-thumbnail-title').text(result.title);
      $(thumbnail).find('.post-thumbnail-description').text(result.description);
    });
  });
});