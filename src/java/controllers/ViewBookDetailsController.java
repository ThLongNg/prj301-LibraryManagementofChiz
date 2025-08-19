package controllers;


import dao.BookDAO; // Import BookDAO của bạn
import dto.Book;     // Import Book DTO của bạn
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "ViewBookDetailsController", urlPatterns = {"/viewBookDetails"})
public class ViewBookDetailsController extends HttpServlet {

  private static final String BOOK_DETAILS_PAGE = "bookDetails.jsp";
    private static final String PRODUCT_INDEX_PAGE = "productIndex.jsp";
    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = PRODUCT_INDEX_PAGE;

        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.getBook(bookId);

            if (book != null) {
                request.setAttribute("BOOK_DETAIL", book);
                url = BOOK_DETAILS_PAGE;
            } else {
                request.setAttribute("ERROR_MESSAGE", "Không tìm thấy sách này.");
            }
        } catch (Exception e) {
            log("Error at BookDetailsController: " + e.toString());
            request.setAttribute("ERROR_MESSAGE", "Đã xảy ra lỗi khi xem chi tiết sách.");
            url = ERROR;
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