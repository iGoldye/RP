var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;

function UpdateCursorPos() {
    cursor.style.left = cursorX;
    cursor.style.top = cursorY;
}

function Click(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
}

function round(value, precision) {
    if (Number.isInteger(precision)) {
      var shift = Math.pow(10, precision);
      return Math.round(value * shift) / shift;
    } else {
      return Math.round(value);
    }
  } 

function updateSkillBar(skillName, value) {
            var elem = document.getElementById(skillName+"Bar");
            var elem_info = document.getElementById(skillName+"Info");

            if (elem !== undefined && elem_info !== undefined) {
                    var width = round(value, 2);
                    elem_info.innerHTML = width + '%';
                    elem.style.width = width + '%';
                    elem_info.value = width + '%';
            } else {
                    console.error("Skill block not exists: "+skillName);
            }
}

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {

            cursor.style.display = event.data.enable ? "block" : "none";
            document.body.style.display = event.data.enable ? "block" : "none";

            updateSkillBar("driving", event.data.driving)
            updateSkillBar("shooting", event.data.shooting)
            updateSkillBar("stamina", event.data.stamina)
            updateSkillBar("strength", event.data.strength)
            updateSkillBar("fishing", event.data.fishing)
            updateSkillBar("drugs", event.data.drugs)

        } else if (event.data.type == "click") {
            // Avoid clicking the cursor itself, click 1px to the top/left;
            Click(cursorX - 1, cursorY - 1);
        }
    });

    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
        UpdateCursorPos();
    });

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://stadus_skills/escape', JSON.stringify({}));
        }
    };
});
