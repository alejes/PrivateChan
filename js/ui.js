'use strict';

function hide(element) {
    document.getElementById(element).style.display = "none";
}

function show(element) {
    document.getElementById(element).style.display = "block";
}

function show_hide(first, second) {
    show(first);
    hide(second);
}
