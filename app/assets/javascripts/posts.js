$(document).on('ready page:load', function () {
  $(".btn-post-close").on('click', function (e) {
    $(this).addClass('disabled');
  });
});