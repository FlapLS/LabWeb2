<%@ page import="lab2.models.Point" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%
    List<Point> pointList = (List<Point>) getServletConfig().getServletContext().getAttribute("pointList");
%>
<html lang="ru">
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <title>Лабораторная работа №2</title>
    <link rel="stylesheet" href="style.css">
    <script type="text/javascript" src=" https://code.jquery.com/jquery-1.11.2.js "></script>
</head>
<body class="background">
<header>
    <div class="center">
        <div class="author column">
            Базанов Евгений Сеергеевич<br>
            Вариант 3173<br>
            Группа P3212
        </div>
        <div class="column labName">
            Лабораторная работа №2 по веб-программированию<br>
            <hr id="line">
        </div>
        <div class="img_zone">
            <img src="resources/itmo_logo.png" alt="itmo_logo">
        </div>
    </div>
</header>
<h2>Попадет ли точка в заданную область?</h2>
<div class="content">
    <div class="img_frame">
        <div id="canvas_container">
            <canvas height='320' width='320' id='area'></canvas>
            <script>
                let canvasContainer = document.getElementById("canvas_container");
                let canvas = document.getElementById("area");
                let ctx = canvas.getContext('2d');
                ctx.moveTo(20, 150);
                ctx.lineTo(310, 150);
                ctx.stroke();

                ctx.moveTo(160, 20);
                ctx.lineTo(160, 310);
                ctx.stroke();


                ctx.moveTo(300, 160);
                ctx.lineTo(310, 150);
                ctx.lineTo(300, 140);
                ctx.stroke();


                ctx.moveTo(150, 30);
                ctx.lineTo(160, 20);
                ctx.lineTo(170, 30);
                ctx.stroke();

                //деление врпава
                ctx.moveTo(210, 140);
                ctx.lineTo(210, 150);
                ctx.lineTo(210, 160);
                ctx.stroke();

                ctx.font = "italic 10pt Arial";
                ctx.fillText("R/2", 200, 130);

                ctx.moveTo(260, 140);
                ctx.lineTo(260, 150);
                ctx.lineTo(260, 160);
                ctx.stroke();

                ctx.font = "italic 10pt Arial";
                ctx.fillText("R", 255, 130);

                //деление влева
                ctx.moveTo(100, 140);
                ctx.lineTo(100, 150);
                ctx.lineTo(100, 160);
                ctx.stroke();

                ctx.font = "italic 10pt Arial";
                ctx.fillText("-R/2", 85, 130);

                ctx.moveTo(50, 140);
                ctx.lineTo(50, 150);
                ctx.lineTo(50, 160);
                ctx.stroke();

                ctx.font = "italic 10pt Arial";
                ctx.fillText("-R", 40, 130);

                //деление вниз
                ctx.moveTo(150, 210);
                ctx.lineTo(160, 210);
                ctx.lineTo(170, 210);
                ctx.stroke();

                ctx.font = "italic 10pt Arial";
                ctx.fillText("-R/2", 180, 215);

                ctx.moveTo(150, 260);
                ctx.lineTo(160, 260);
                ctx.lineTo(170, 260);
                ctx.stroke();

                ctx.font = "italic 10pt Arial";
                ctx.fillText("-R", 180, 265);
                //деление вверх
                ctx.moveTo(150, 100);
                ctx.lineTo(160, 100);
                ctx.lineTo(170, 100);
                ctx.stroke();

                ctx.font = "italic 10pt Arial";
                ctx.fillText("R/2", 180, 105);

                ctx.moveTo(150, 50);
                ctx.lineTo(160, 50);
                ctx.lineTo(170, 50);
                ctx.stroke();

                ctx.font = "italic 10pt Arial";
                ctx.fillText("R", 180, 55);

                //прямоугольник
                ctx.fillStyle = 'blue';
                ctx.globalAlpha = 0.2;
                let rect = {
                    x:50,
                    y:150,
                    width:110,
                    height:60
                };
                ctx.fillRect(rect.x,rect.y,rect.width,rect.height);

                //треугольник
                let triangle = {
                    x1: 160,
                    y1: 150,
                    x2: 210,
                    y2: 150,
                    x3: 160,
                    y3: 260
                };
                ctx.globalAlpha = 0.2;
                ctx.beginPath();
                ctx.moveTo(triangle.x1, triangle.y1);
                ctx.lineTo(triangle.x2, triangle.y2);
                ctx.lineTo(triangle.x3, triangle.y3);
                ctx.lineTo(triangle.x1, triangle.y1);
                ctx.closePath();
                ctx.stroke();
                ctx.fillStyle = 'blue';
                ctx.fill();
                //часть окружности
                let part_of_circle = {
                    x1:160,
                    y1:150,
                    radius:60
                };
                ctx.beginPath();
                ctx.moveTo(part_of_circle.x1, part_of_circle.y1);
                ctx.arc(part_of_circle.x1, part_of_circle.y1, part_of_circle.radius, Math.PI, Math.PI/-2, false);
                ctx.closePath();
                ctx.fillStyle = 'blue';
                ctx.fill();

                let width = 320;
                let canvasR = 117;

                canvas.addEventListener("click", function (e) {
                    let canvasX = e.pageX - this.offsetLeft,
                        canvasY = e.pageY - this.offsetTop;
                    if (checkR()) {
                        sendDataToForm(canvasX - width / 2, width / 2 - canvasY);
                        drawPoints(canvasX, canvasY);
                    }
                });

                window.onload = function () {
                    let coordX = document.querySelectorAll(".x_cell");
                    let coordY = document.querySelectorAll(".y_cell");
                    let coordR = document.querySelectorAll(".r_cell");
                    for (let i = 0; i < coordX.length; i++) {
                        //console.log(coordX[i].innerHTML * canvasR / coordR[i].innerHTML, coordY[i].innerHTML * canvasR / coordR[i].innerHTML);
                        drawPoints(coordX[i].innerHTML * canvasR / coordR[i].innerHTML + width / 2, width / 2 - coordY[i].innerHTML * canvasR / coordR[i].innerHTML);
                    }
                };

                function sendDataToForm(xVal, yVal) {
                    let r = document.querySelector('input[name="coordinateR"]:checked').value;
                    x.value = (xVal * r / canvasR).toFixed(3);
                    y.value = (yVal * r / canvasR).toString().substr(0, 6);
                    form.submit();
                }

                function drawPoints(canvasX, canvasY) {
                    ctx.beginPath();
                    ctx.arc(canvasX, canvasY, 3, 0, 2 * Math.PI);
                    ctx.fillStyle = "black";
                    ctx.fill();
                    //console.log(`${canvasX - width / 2} ${width / 2 - canvasY}`);
                    ctx.closePath();
                }
            </script>
        </div>
    </div>
    <div id="input_values">
        <form class="send_form" action="controller" method="post" autocomplete="off">
            <div class="inputY">
                <label>Y
                    <input id="coordinateY" type="text" name="coordinateY" placeholder="Введите число (-5;3)"
                           maxlength="6">
                </label>
            </div>
            <div class="inputXR">
                <div id="inputX">
                    <p>X</p>
                    <input type="button" value="-2.0" class="x_buttons" id="x_-2.0" onclick="changeX('-2.0')">
                    <input type="button" value="-1.5" class="x_buttons" id="x_-1.5" onclick="changeX('-1.5')">
                    <input type="button" value="-1.0" class="x_buttons" id="x_-1.0" onclick="changeX('-1.0')">
                    <input type="button" value="-0.5" class="x_buttons" id="x_-0.5" onclick="changeX('-0.5')">
                    <input type="button" value="0.0" class="x_buttons" id="x_0.0" onclick="changeX('0.0')">
                    <input type="button" value="0.5" class="x_buttons" id="x_0.5" onclick="changeX('0.5')">
                    <input type="button" value="1.0" class="x_buttons" id="x_1.0" onclick="changeX('1.0')">
                    <input type="button" value="1.5" class="x_buttons" id="x_1.5" onclick="changeX('1.5')">
                    <input type="button" value="2.0" class="x_buttons" id="x_2.0" onclick="changeX('2.0')">
                    <input type="hidden" id="x_select" name="coordinateX"></div>
                <div id="inputR">
                    <p>R</p>
                    <input type="radio" name="coordinateR" value="1.0">1.0
                    <input type="radio" name="coordinateR" value="1.5">1.5
                    <input type="radio" name="coordinateR" value="2.0">2.0
                    <input type="radio" name="coordinateR" value="2.5">2.5
                    <input type="radio" name="coordinateR" value="3.0">3.0
                    <input type="hidden" name="r_select" id="r_select">
                </div>
            </div>
            <div class="button">
                <button type="submit">Отправить данные</button>
            </div>
        </form>
    </div>
    <div class="result_table">
        <table class="tableZone">
            <tr>
                <td>X</td>
                <td>Y</td>
                <td>R</td>
                <td>Результат</td>
                <td>Время</td>
            </tr>
            <%
                if (pointList != null)
                    for (Point point : pointList) {
            %>
            <tr>
                <td class="x_cell"><%= point.getX() %>
                </td>
                <td class="y_cell"><%= point.getY() %>
                </td>
                <td class="r_cell"><%= point.getR() %>
                </td>
                <td><%= point.getResult() %>
                </td>
                <td><%= point.getCurrentTime() %>
                </td>
            </tr>
            <%}%>
        </table>
    </div>
</div>
<script src="js/validation.js"></script>
</body>
</html>