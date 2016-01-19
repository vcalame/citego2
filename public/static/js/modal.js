var Modal = function () {
    
};

Modal.load = function (href) {
    var $modalBody = $("#commonModal").find(".modal-content");
    $modalBody.load(href, function () {
        $commonModal = $("#commonModal");
        $commonModal.find("form").each(function () {
            var $this = $(this);
            var role = $this.data("role");
            if (role === "term-remove") {
                var id = $this.find("input[name='id']").val();
                $this.ajaxForm({
                    beforeSubmit: function () {
                        var confirmation = confirm("Confirmez-vous la suppression du descripteur ?");
                        if (!confirmation) {
                            $("#commonModal").modal('hide');
                            return false;
                        }
                    },
                    success: function () {
                        $("#descripteur_" + id).hide();
                        $("#commonModal").modal('hide');
                    }
                });
            }
        });
        $commonModal.find("[data-link-type='modal']").click(function () {
            Modal.load(this.href);
            return false;
        });
        $commonModal.modal('show');
    });
};


$(function () {
   var $modals = $("[data-link-type='modal']");
   $modals.click(function () {
       Modal.load(this.href);
       return false;
   });
});
