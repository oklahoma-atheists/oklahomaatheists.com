var init = function() {
    $("#contact_form").submit( function(event) {
        event.preventDefault();
        var form = $(this);
        var button = $("#contact_form input[type=submit]");
        $.ajax( {
            url:        form.attr("action"),
            type:       form.attr("method"),
            data:       form.serialize(),
            beforeSend: function(xhr, settings) {
                button.val("Sending\u2026");
                button.prop("disabled", true);
            },
            success: function(data, status, xhr) {
                button.val("Message Sent");
                button.addClass("message_sent");
                button.prop("disabled", true);
            },
            error: function(xhr, status, error) {
                button.val("Could Not Send");
                button.prop("disabled", false);
            }
        } );
    } );
};

$(document).ready(init);
$(document).on('page:load', init);
