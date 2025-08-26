package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "index.jsp"; // Trang mặc định
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            // Chuyển hướng đến trang chủ hoặc trang liệt kê sách mặc định
            url = "SearchBookController";
        } else {
            switch (action) {
                case "Search":
                    url = "SearchBookController";
                    break;
                case "Login":
                    url = "LoginController";
                    break;
                case "Logout":
                    url = "LogoutController";
                    break;
                case "Register":
                    url = "RegisterController";
                    break;
                case "borrow":
                    url = "BorrowController";
                    break;
                case "adminUser":
                    url = "AdminUserController";
                    break;
                case "manageBorrowRequest":
                    url = "ManageBorrowRequestController";
                    break;
                case "changeProfile":
                    url = "ChangeProfileController";
                    break;
                case "sendBorrowRequest":
                    url = "SendBorrowRequestController";
                    break;
                case "addToCart":
                    url = "CartController";
                    break;
                case "removeFromCart":
                case "showCart":
                    url = "CartController";
                    break;
                case "viewBookDetails":
                    url = "BookDetailsController";
                    break;
                default:
                    url = "error.jsp";
                    break;
            }
        }
        
        request.getRequestDispatcher(url).forward(request, response);
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