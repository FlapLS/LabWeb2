package lab2.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class ControllerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("coordinateX") != null && req.getParameter("coordinateY") != null && req.getParameter("coordinateR") != null) {
            req.getRequestDispatcher("/areaCheck").forward(req,resp);
        }else {
            req.getRequestDispatcher("index.jsp");
        }
    }
}