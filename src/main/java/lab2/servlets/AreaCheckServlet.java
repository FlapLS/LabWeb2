package lab2.servlets;

import lab2.models.Point;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static java.lang.Math.pow;

public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            resp.setCharacterEncoding("UTF-8");
            ServletContext context = req.getServletContext();
            List<Point> pointList = context.getAttribute("pointList") == null ? new ArrayList<Point>() : (List<Point>) context.getAttribute("pointList");
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("H:m:s");
            String currentTime = dateFormat.format(date);
            double x = Double.parseDouble(req.getParameter("coordinateX").replace(',', '.'));
            String yValue = req.getParameter("coordinateY").replace(',', '.');
            if (yValue.length() > 6) {
                yValue = yValue.substring(0, 6);
            }
            double y = Double.parseDouble(yValue);
            double r = Double.parseDouble(req.getParameter("coordinateR").replace(',', '.'));
            if (checkValues(x,y,r)){
                String result = checkArea(x, y, r) ? "<span style='color: #439400'>Попала</span>" : "<span style='color: #94002D'>Не попала</span>";
                Point point = new Point(x,y,r,result,currentTime);
                pointList.add(point);
                context.setAttribute("pointList",pointList);
            }
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }catch (NumberFormatException e){
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }

    }

    private boolean checkValues(double x, double y, double r) {
        return (Arrays.asList(-2.0, -1.5, -1.0, -0.5, 0.0, 0.5, 1.0, 1.5, 2.0).contains(x) ||(x < 2 && x > -2)) &&
                (y < 3 && y > -5) &&
                Arrays.asList(1.0, 1.5, 2.0, 2.5, 3.0).contains(r);
    }

    private boolean checkArea(double x, double y, double r) {
        if (x >= 0) {
            if (y <= 0) {
                return (y < x / 2 + r / 2);
            }else {
                return false;
            }
        } else {
            if (y >= 0) {
                return pow(x, 2) + pow(y, 2) <= pow(r / 2, 2);
            } else {
                return x >= -r && y >= -r/2;
            }
        }
    }
}
