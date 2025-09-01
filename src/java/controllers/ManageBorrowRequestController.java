package controllers;

import dao.BookDAO; // To update available copies
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
import java.sql.Date; // For java.sql.Date
import java.time.LocalDate; // For new date API
import java.sql.SQLException;

@WebServlet(name = "ManageBorrowRequestController", urlPatterns = {"/ManageBorrowRequestController"})
public class ManageBorrowRequestController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "AdminDashboard.jsp"; // Always redirect back to admin dashboard
        String message = "";

        try {
            HttpSession session = request.getSession();
            User adminUser = (User) session.getAttribute("user");

            // 1. Check if user is logged in and is an admin
            if (adminUser == null || !"admin".equalsIgnoreCase(adminUser.getRole())) {
                response.sendRedirect("index.jsp"); // Redirect if not authorized
                return;
            }

            // Lấy tham số id và action một cách an toàn
            String idParam = request.getParameter("id");
            String action = request.getParameter("action");

            // Chỉ xử lý khi các tham số id và action tồn tại và không rỗng
            if (idParam != null && !idParam.isEmpty() && action != null && !action.isEmpty()) {
                int id = Integer.parseInt(idParam);
                BookRequestDAO bookRequestDAO = new BookRequestDAO();

                if ("approve".equalsIgnoreCase(action)) {
                    BookRequest requestToUpdate = bookRequestDAO.getBookRequestById(id);

                    if (requestToUpdate == null) {
                        message = "Borrow request not found.";
                    } else {
                        String newStatus = "Approved";
                        Date borrowDate = Date.valueOf(LocalDate.now());
                        Date returnDate = Date.valueOf(LocalDate.now().plusDays(7));

                        BookDAO bookDAO = new BookDAO();
                        boolean decreasedCopies = bookDAO.decreaseAvailableCopies(requestToUpdate.getBookId());

                        if (decreasedCopies) {
                            boolean success = bookRequestDAO.updateBookRequestStatus(id, newStatus, borrowDate, returnDate);
                            if (success) {
                                message = "Borrow request " + id + " approved successfully! Book copies updated.";
                            } else {
                                message = "Failed to update borrow request status for " + id + ". Book copies might be decreased.";
                            }
                        } else {
                            message = "Failed to approve request " + id + ": No copies available or book not found for inventory update.";
                        }
                    }
                } else if ("reject".equalsIgnoreCase(action)) {
                    BookRequest requestToUpdate = bookRequestDAO.getBookRequestById(id);

                    if (requestToUpdate == null) {
                        message = "Borrow request not found.";
                    } else {
                        String newStatus = "Rejected";
                        boolean success = bookRequestDAO.updateBookRequestStatus(id, newStatus, null, null);
                        if (success) {
                            message = "Borrow request " + id + " rejected successfully.";
                        } else {
                            message = "Failed to reject borrow request " + id + ".";
                        }
                    }
                } else if ("delete".equalsIgnoreCase(action)) {
                    // Xử lý hành động xóa
                    try {
                        boolean success = bookRequestDAO.deleteBookRequestById(id);
                        if (success) {
                            message = "Request " + id + " deleted successfully.";
                        } else {
                            message = "Failed to delete request " + id + ".";
                        }
                    } catch (SQLException e) {
                        message = "An error occurred while deleting request " + id + ".";
                        e.printStackTrace();
                    }
                } else if ("return_book".equalsIgnoreCase(action)) { // Xử lý hành động trả sách
                    try {
                        boolean success = bookRequestDAO.returnBook(id);
                        if (success) {
                            message = "Sách của yêu cầu " + id + " đã được ghi nhận trả thành công.";
                        } else {
                            message = "Lỗi khi ghi nhận trả sách cho yêu cầu " + id + ".";
                        }
                    } catch (Exception e) {
                        message = "Đã xảy ra lỗi khi ghi nhận trả sách.";
                        e.printStackTrace();
                    }
                } else if ("refund".equalsIgnoreCase(action)) { // Thêm case mới cho hành động 'refund'
                    url = "AdminDashboard.jsp";
                    try {
                        // Lấy request từ DB để lấy transactionId
                        BookRequest requestToRefund = bookRequestDAO.getBookRequestById(id);
                        if (requestToRefund != null && "Paid".equalsIgnoreCase(requestToRefund.getPaymentStatus())) {
                            // Gọi phương thức mới để xử lý hoàn tiền trên Stripe
                             double bookPrice = 100000;
                            boolean refundSuccess = bookRequestDAO.refundBookRequestWithStripe(id, requestToRefund.getTransactionId(), bookPrice);
                            if (refundSuccess) {
                                message = "Đã hoàn tiền thành công cho yêu cầu " + id + ". Vui lòng kiểm tra lại Stripe Dashboard.";
                            } else {
                                message = "Lỗi khi hoàn tiền. Vui lòng kiểm tra Stripe Dashboard.";
                            }
                        } else {
                            message = "Không thể hoàn tiền: Yêu cầu không tồn tại hoặc chưa được thanh toán.";
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        message = "Đã xảy ra lỗi khi hoàn tiền: " + e.getMessage();
                        e.printStackTrace();
                    }
                } else {
                    message = "Invalid action.";
                }
            }

        } catch (NumberFormatException e) {
            message = "Invalid request ID format.";
            e.printStackTrace();
        } catch (Exception e) { // Catch all other exceptions
            message = "An unexpected error occurred: " + e.getMessage();
            e.printStackTrace();
        } finally {
            request.setAttribute("requestMessage", message); // Set message for AdminDashboard.jsp
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
        return "Handles admin actions for managing borrow requests (approve/reject/delete).";
    }
}
