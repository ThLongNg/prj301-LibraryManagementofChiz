package controllers;

import com.stripe.Stripe;
import com.stripe.model.Charge;
import com.stripe.exception.StripeException;
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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "PaymentController", urlPatterns = {"/PaymentController"})
public class PaymentController extends HttpServlet {

    private static final String SUCCESS_PAGE = "payment/paymentSuccess.jsp";
    private static final String ERROR_PAGE = "payment/paymentError.jsp";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Stripe.apiKey = "sk_test_51S0xg5HmOs8sEpKXlImB9LemyeFS4zSFT2RZIFRRRqWVSUPMva1nHwtH4PeVLpdHT4EeO6Le53we9GhaqMr77OKQ00WC6xO9YS";

        String url = ERROR_PAGE;
        String message = "";
        
        try {
            HttpSession session = request.getSession();
            User us = (User) session.getAttribute("user");
            ArrayList<Book> list = (ArrayList<Book>) session.getAttribute("CART");
            
            // 1. Kiểm tra session và người dùng
            if (us == null || list == null || list.isEmpty()) {
                message = "Không tìm thấy thông tin giỏ hàng hoặc người dùng. Vui lòng thử lại.";
                request.setAttribute("ERROR_MESSAGE", message);
                request.getRequestDispatcher(url).forward(request, response);
                return;
            }

            String stripeToken = request.getParameter("stripeToken");
            long amount = Long.parseLong(request.getParameter("amount"));

            Map<String, Object> params = new HashMap<>();
            params.put("amount", amount);
            params.put("currency", "vnd");
            params.put("source", stripeToken);
            params.put("description", "Payment for multiple book requests.");

            // 2. Xử lý giao dịch với Stripe
            Charge charge = Charge.create(params);
            
            if ("succeeded".equalsIgnoreCase(charge.getStatus())) {
                BookRequestDAO bookRequestDAO = new BookRequestDAO();
                List<Integer> ids = new ArrayList<>();
                boolean allRequestsCreated = true;

                // 3. Nếu thanh toán thành công, tạo yêu cầu mượn sách trong DB
                for (Book book : list) {
                    try {
                        int id = bookRequestDAO.createBookRequestWithPaymentInfo(book.getId(), us.getId());
                        if (id > 0) {
                            // Cập nhật trạng thái thanh toán và lưu ID giao dịch của Stripe
                            boolean updateSuccess = bookRequestDAO.updatePaymentStatus(id, "Paid", charge.getId());
                            if (!updateSuccess) {
                                allRequestsCreated = false;
                                Logger.getLogger(PaymentController.class.getName()).log(Level.SEVERE, "Could not update payment status for request ID: " + id);
                            } else {
                                ids.add(id);
                            }
                        } else {
                             allRequestsCreated = false;
                        }
                    } catch (SQLException e) {
                        allRequestsCreated = false;
                        Logger.getLogger(PaymentController.class.getName()).log(Level.SEVERE, "SQL Error creating request for book: " + book.getTitle(), e);
                    }
                }
                
                // Xóa giỏ hàng sau khi đã xử lý yêu cầu
                session.removeAttribute("CART");

                if (allRequestsCreated) {
                    message = "Thanh toán thành công! Giao dịch ID: " + charge.getId() + ". Yêu cầu của bạn đã được gửi tới quản trị viên.";
                    request.setAttribute("SUCCESS_MESSAGE", message);
                    request.setAttribute("requestIds", ids); // Có thể dùng để hiển thị trên trang thành công
                    url = SUCCESS_PAGE;
                } else {
                    message = "Thanh toán thành công nhưng không thể tạo một số yêu cầu mượn. Vui lòng liên hệ hỗ trợ. Giao dịch ID: " + charge.getId();
                    request.setAttribute("ERROR_MESSAGE", message);
                    url = ERROR_PAGE;
                }
            } else {
                message = "Thanh toán thất bại: " + charge.getFailureMessage();
                request.setAttribute("ERROR_MESSAGE", message);
                url = ERROR_PAGE;
            }
            
        } catch (NumberFormatException | StripeException | ClassNotFoundException e) {
            message = "Đã xảy ra lỗi trong quá trình thanh toán: " + e.getMessage();
            request.setAttribute("ERROR_MESSAGE", message);
            e.printStackTrace();
            url = ERROR_PAGE;
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }
}