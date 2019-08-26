$(document).ready(() => {
    let RadioChannel = '0.0';
    let Powered = false;

    function closeGui() {
        if (RadioChannel < 0.1 || RadioChannel > 99.9) {
            RadioChannel = '0.0';
        }
        $.post('http://ab-radio/close', JSON.stringify({ channel: RadioChannel }));
    }

    window.addEventListener('message', (event) => {
        if (event.data.open == true) {
            $(".full-screen").css("display", "flex");
            if (RadioChannel != '0.0' && Powered) {
                $('#radioChannel').val(RadioChannel);
            } else {
                $('#radioChannel').val('');
            }
        } else if (event.data.open == false) {
            $(".full-screen").css("display", "none");
        }
    });

    $('#radioForm').submit((e) => {e.preventDefault();});
    $('#power').click(() => {
        if (Powered === true) {
            $('#radioChannel').val(RadioChannel);
        } else {
            $.post('http://ab-radio/close', JSON.stringify({ channel: '0.0' }));
            closeGui();
        }
     });

    document.onkeyup = function (data){
        if (data.which == 27) {
            RadioChannel = $('#radioChannel').val();
            closeGui();
        }
    }
    $('#freq-up').click(() => {
        let oldVal = $('#radioChannel').val();
        if(oldVal === '') {
            $('#radioChannel').val('0.0');
        } else if (oldVal === '99.9') {
            $('#radioChannel').val('99.9');
        } else {
            let newVal = (parseFloat(oldVal) + 0.1).toFixed(1);
            $('#radioChannel').val(newVal);
        }
    });
    $('#freq-down').click(() => {
        let oldVal = $('#radioChannel').val();
        if(oldVal === '' || oldVal === '0.0') {
            $('#radioChannel').val('0.0');
        } else {
            let newVal = (parseFloat(oldVal) - 0.1).toFixed(1);
            $('#radioChannel').val(newVal);
        }
    });
});