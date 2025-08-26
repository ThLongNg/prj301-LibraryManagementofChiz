package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import dao.StudentDAO;

@WebServlet(name = "DeleteController", urlPatterns = {"/DeleteController"})
public class DeleteController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                StudentDAO dao = new StudentDAO();
                dao.deleteStudent(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("SearchController");
    }
}