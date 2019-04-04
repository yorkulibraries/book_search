$(function () {
  $('[data-toggle="popover"]').popover();
  $('a [data-popover-dismiss]').click(function() {
    alert("HERE");
    $(this).parent('[data-toggle=popover]').popover('toggle');
  });
})


function bootstrap_modal_show(modal_id, content){
  var holder_id = modal_id + "_holder";

  $("#" + holder_id).remove();
  $("body").append("<div id='" + holder_id + "'></div>");
  $("#" + holder_id).append(content);

  $("#" + modal_id).modal({ show: true, backdrop: 'static' });
}

function bootstrap_modal_close(modal_id) {
  var holder_id = modal_id + "_holder";

  $("#" + modal_id).modal("hide");

  $("#" + modal_id).on('hidden.bs.modal', function() {
    $("#" + holder_id).remove();
  });

}

function bootstrap_modal_replace_body(modal_id, new_content) {
    $("#" + modal_id + " .modal-body").empty().append(new_content);
}
