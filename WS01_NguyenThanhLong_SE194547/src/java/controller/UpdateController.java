package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import dao.StudentDAO;
import dto.StudentDTO;
@WebServlet(name = "UpdateController", urlPatterns = {"/UpdateController"})
public class UpdateController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            StudentDAO dao = new StudentDAO();
            try {
                StudentDTO student = dao.getStudentById(id);
                request.setAttribute("STUDENT_INFO", student);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("update.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        
        if (firstName == null || firstName.isEmpty() || lastName == null || lastName.isEmpty()) {
           
            return;
        }
        StudentDTO updatedStudent = new StudentDTO(id, firstName, lastName);
        StudentDAO dao = new StudentDAO();
        try {
            dao.updateStudent(updatedStudent);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("SearchController");
    }
}