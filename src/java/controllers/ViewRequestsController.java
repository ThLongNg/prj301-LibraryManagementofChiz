package controllers;


import dao.BookRequestDAO;
import dto.BookRequest;
import dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ViewRequestsController", urlPatterns = {"/ViewRequestsController"})
public class ViewRequestsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "UserRequests.jsp"; 

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            System.out.println("Current logged-in user ID: " + user.getId());
            BookRequestDAO bookRequestDAO = new BookRequestDAO();
            ArrayList<BookRequest> userRequests = bookRequestDAO.getBookRequestsByUserId(user.getId());

            request.setAttribute("userRequests", userRequests);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}