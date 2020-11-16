"use strict";
let form = document.querySelector('.send_form'),
    y = document.getElementById('coordinateY'),
    x = document.getElementById('x_select');
function checkY() {
    let yVal = y.value.replace(',', '.');
    if (yVal.trim() === "" || !isFinite(yVal) || (yVal <= -5 || yVal >= 3)) {
        y.classList.add("input_err");
        return false;
    }
    return true;
}

function checkX() {
    let buttons_x = document.querySelectorAll(".x_buttons");
    if (x.value === "") {
        buttons_x.forEach(buttons_x => buttons_x.classList.add("input_err"));
        return false;
    }
    buttons_x.forEach(buttons_x => buttons_x.classList.remove("input_err"));
    return true;
}

function changeX(xValue) {
    let buttonX = document.getElementById("x_" + xValue);
    if (!buttonX.classList.contains("selX")) {
        x.value = xValue;
        let oldSelectedButton = document.querySelector(".selX");
        if (oldSelectedButton !== null)
            oldSelectedButton.classList.remove("selX");
        buttonX.classList.add("selX");
        checkX();
    } else {
        x.value = "";
        buttonX.classList.remove("selX");
    }
}

function checkR() {
    let radioButtons = document.getElementsByName("coordinateR");
    for (let radio of radioButtons) {
        if (radio.checked) {
            return true
        }
    }
    alert("Введите переменную R");
    return false;
}

form.addEventListener("submit", function (e) {
    if (!checkX() || !checkY() || !checkR()) {
        e.preventDefault();
    }
});
y.addEventListener("input", function () {
    y.classList.remove("input_err");
});