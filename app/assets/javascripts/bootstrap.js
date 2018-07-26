$(function () {
  $('[data-toggle="popover"]').popover();
  $('a [data-popover-dismiss]').click(function() {
    alert("HERE");
    $(this).parent('[data-toggle=popover]').popover('toggle');
  });
})
