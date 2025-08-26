package controller;

import dao.StudentDAO;
import dto.StudentDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
       StudentDAO dao = new StudentDAO();
        StudentDTO user = dao.checkLogin(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("USER", user);
             session.removeAttribute("LAST_SEARCH_VALUE");
            Cookie usernameCookie = new Cookie("firstName", user.getFirstName());
            response.addCookie(usernameCookie);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("ERROR", "Invalid user or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
}}