package controllers; 

import dao.BookRequestDAO; 
import dto.Book; 
import dto.User; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name="SendBorrowRequestController", urlPatterns={"/SendBorrowRequestController"})
public class SendBorrowRequestController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8"); 
        String url = "index.jsp"; 
        String message = ""; 

        try {
            HttpSession session = request.getSession();
            User us = (User) session.getAttribute("user"); 
            ArrayList<Book> list = (ArrayList<Book>) session.getAttribute("CART"); 

            if (us == null) {
                message = "Vui lòng đăng nhập để mượn sách.";
                url = "Login.jsp"; 
            } else if (list == null || list.isEmpty()) {
                message = "Giỏ hàng của bạn trống. Vui lòng thêm sách vào giỏ để mượn.";
                url = "viewCart.jsp"; 
            } else {
                // Tính toán tổng số tiền
                int totalCostPerBook = 100000;
                long totalAmount = (long) list.size() * totalCostPerBook;

                // Chuyển hướng đến trang thanh toán, mang theo tổng số tiền
                request.setAttribute("totalAmount", totalAmount);
                request.setAttribute("totalBooks", list.size());
                
                // Giữ lại CART trong session để sử dụng sau khi thanh toán thành công
                // session.setAttribute("CART", list); // Không cần thiết vì nó đã ở đó

                url = "payment/payment.jsp"; // Chuyển đến trang thanh toán
            }
        } catch (Exception e) { 
            message = "Đã xảy ra lỗi không mong muốn: " + e.getMessage();
            e.printStackTrace();
        } finally {
            request.setAttribute("MESSAGE", message);
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