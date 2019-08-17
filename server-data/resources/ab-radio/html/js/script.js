$(document).ready(() => {
    let RadioChannel = '0.0';

    function closeGui() {
        if (RadioChannel < 0.1 || RadioChannel > 99.9) {
            RadioChannel = '0.0';
        }
        $.post('http://ab-radio/close', JSON.stringify({ channel: RadioChannel }));
    }

    window.addEventListener('message', (event) => {
        let item = event.data;
        if (item.reset == true) {
            closeGui();
        }
        if (event.data.open == true) {
            $("#radio").css("display", "block");
            if (RadioChannel != '0.0') {
                $('#radioChannel').val(RadioChannel);
            } else {
                $('#radioChannel').val('');
            }
        } else if (event.data.open == false) {
            $("#radio").css("display", "none");
        }
    });

    $('#radioForm').submit((e) => {e.preventDefault();});

    document.onkeyup = function (data){
        if (data.which == 27) {
            RadioChannel = $('#radioChannel').val();
            closeGui();
        }
    }
});