$(function () {
   var $modals = $("[data-link-type='modal']");
   $modals.click(function () {
       $modalBody = $("#commonModal").find(".modal-content");
       $modalBody.load(this.href, function () {
           $("#commonModal").modal('show');
       });
       return false;
   });
});
