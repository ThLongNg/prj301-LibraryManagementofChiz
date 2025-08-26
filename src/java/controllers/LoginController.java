package controllers;

import dao.UserDAO;
import dto.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException; // Import SQLException

/**
 *
 * @author user
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("utf-8"); 
        String url = "Login.jsp"; 

        try {
            String loginInfo = request.getParameter("loginInfo");
            String password = request.getParameter("password");

            // Kiểm tra các tham số đầu vào có null không
            if (loginInfo == null || loginInfo.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("ERROR", "Vui lòng nhập tên đăng nhập/email và mật khẩu.");
                request.getRequestDispatcher(url).forward(request, response);
                return;
            }

            // Khởi tạo UserDAO và gọi phương thức login 
            UserDAO d = new UserDAO();
            User us = d.getUserByLoginInfoAndPassword(loginInfo.trim(), password.trim());

            if (us != null) {
                HttpSession s = request.getSession();
                s.setAttribute("user", us);

                if (us.getRole().equalsIgnoreCase("admin")) {
                    response.sendRedirect("AdminDashboard.jsp");
                } else {
                    response.sendRedirect("index.jsp"); 
                }
                return; 
            } else {
                request.setAttribute("ERROR", "Tên đăng nhập, email hoặc mật khẩu không đúng.");
                request.getRequestDispatcher(url).forward(request, response);
                return;
            }
        }catch (Exception e) { // Bắt các lỗi chung khác
            request.setAttribute("ERROR", "Đã xảy ra lỗi không mong muốn trong quá trình đăng nhập: " + e.getMessage());
            e.printStackTrace(); 
            request.getRequestDispatcher(url).forward(request, response);
            return;
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Handles user login functionality.";
    }
}