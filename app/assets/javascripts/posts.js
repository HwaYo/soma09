$(document).on('ready page:load', function () {
  $(".btn-post-close").on('click', function (e) {
    $(this).addClass('disabled');
  });

  $(".btn-post-edit").on("click", function(e){
    var link = $(e.target);
    var post_id = link.data('post');
    
    $.ajax({
      url: "posts/" + post_id + "/edit"
    }).success(function(html){
        $('.modal-body').html(html);
    });
  });

  $("#editModal").on("shown.bs.modal", function(e) {
    $('.modal-footer input[type="submit"]').on("click", function(e){
      if($('.modal-body textarea[name$="[content]"]').val() != "" && $('.modal-body input[name$="[link]"]').val() != "") {
        $('#editModal form').submit();
      }
      else {
        e.preventDefault();
        alert("빈 칸을 채워주세요.");
      }
    });
  });
});