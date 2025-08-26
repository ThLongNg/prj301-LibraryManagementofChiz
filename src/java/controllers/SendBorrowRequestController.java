package controllers; 

import dao.BookRequestDAO; 
import dto.Book; 
import dto.User; 
import java.io.IOException;
import java.io.PrintWriter; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.sql.SQLException;

/**
 *
 * @author user
 */
@WebServlet(name="SendBorrowRequestController", urlPatterns={"/SendBorrowRequestController"})
public class SendBorrowRequestController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8"); 
        String url = "index.jsp"; 
        String message = ""; 

        try {
            HttpSession session = request.getSession();
            User us = (User) session.getAttribute("user"); // Lấy người dùng từ session
            ArrayList<Book> list = (ArrayList<Book>) session.getAttribute("CART"); // Lấy danh sách sách từ "CART"

            if (us == null) {
                message = "Vui lòng đăng nhập để mượn sách.";
                url = "login.jsp"; 
            } else if (list == null || list.isEmpty()) {
                message = "Giỏ hàng của bạn trống. Vui lòng thêm sách vào giỏ để mượn.";
            } else {
                BookRequestDAO d = new BookRequestDAO();
                
                int rs = d.insertBorrowRequest(us.getId(), list); 

                if (rs > 0) { 
                    message = "Đã gửi " + rs + " yêu cầu mượn sách thành công! Đang chờ quản trị viên duyệt.";
                    session.removeAttribute("CART"); 
                } else {
                    message = "Gửi yêu cầu mượn sách thất bại. Vui lòng thử lại.";
                }
            }
        } catch (NumberFormatException e) {
            message = "Dữ liệu ID sách không hợp lệ.";
            e.printStackTrace();
        } catch (SQLException e) { // Bắt lỗi SQL từ DAO
            message = "Lỗi cơ sở dữ liệu khi gửi yêu cầu mượn: " + e.getMessage();
            e.printStackTrace();
        } catch (Exception e) { // Bắt các lỗi chung khác
            message = "Đã xảy ra lỗi không mong muốn: " + e.getMessage();
            e.printStackTrace();
        } finally {
            request.setAttribute("MESSAGE", message); // Đặt thông báo vào request scope
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

    @Override
    public String getServletInfo() {
        return "Servlet xử lý việc gửi yêu cầu mượn sách từ giỏ hàng.";
    }
}