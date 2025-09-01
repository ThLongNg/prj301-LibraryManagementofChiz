package controllers;
// File: controllers/AddBookController.java


import dao.BookDAO;
import dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AddBookController", urlPatterns = {"/AddBookController"})
public class AddBookController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "AdminDashboard.jsp";
        String message = "";

        try {
            HttpSession session = request.getSession();
            User adminUser = (User) session.getAttribute("user");

            // Kiểm tra xem người dùng có phải là admin không
            if (adminUser == null || !"admin".equalsIgnoreCase(adminUser.getRole())) {
                response.sendRedirect("index.jsp"); // Chuyển hướng nếu không phải admin
                return;
            }

            // Lấy dữ liệu từ form
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String isbn = request.getParameter("isbn");
            String category = request.getParameter("category");
            int publishedYear = Integer.parseInt(request.getParameter("published_year"));
            int totalCopies = Integer.parseInt(request.getParameter("total_copies"));
            int availableCopies = Integer.parseInt(request.getParameter("available_copies"));
            String status = request.getParameter("status");

            // Gọi DAO để thêm sách
            BookDAO bookDao = new BookDAO();
            boolean success = bookDao.addBook(title, author, isbn, category, publishedYear, totalCopies, availableCopies, status);

            if (success) {
                message = "Sách " + title + " đã được thêm thành công!";
            } else {
                message = "Không thể thêm sách. Vui lòng thử lại.";
            }

        } catch (NumberFormatException e) {
            message = "Lỗi định dạng dữ liệu. Vui lòng kiểm tra lại các trường số.";
        } catch (Exception e) {
            message = "Đã xảy ra lỗi hệ thống: " + e.getMessage();
            e.printStackTrace();
        } finally {
            request.setAttribute("addBookMessage", message);
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}