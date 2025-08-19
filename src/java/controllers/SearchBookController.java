package controllers;

import dao.BookDAO;
import dto.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "SearchBookController", urlPatterns = {"/SearchBookController"})
public class SearchBookController extends HttpServlet {

    private static final String HOME_PAGE = "index.jsp";
    private static final String PRODUCT_INDEX_PAGE = "productIndex.jsp";
    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = HOME_PAGE;

        try {
            String searchKeyword = request.getParameter("keyword");
            BookDAO bookDAO = new BookDAO();
            ArrayList<Book> searchResult;

            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                searchResult = bookDAO.getBooks(searchKeyword.trim());
                if (searchResult.isEmpty()) {
                    request.setAttribute("ERROR_MESSAGE", "Không tìm thấy sách nào với từ khóa: '" + searchKeyword + "'");
                } else {
                    request.setAttribute("SUCCESS_MESSAGE", "Tìm thấy " + searchResult.size() + " sách với từ khóa: '" + searchKeyword + "'");
                }
            } else {
                searchResult = bookDAO.getAllBooks();
                request.setAttribute("ERROR_MESSAGE", "Vui lòng nhập từ khóa tìm kiếm. Hiển thị tất cả sách.");
            }
            request.setAttribute("BOOK_LIST", searchResult);
            request.setAttribute("keyword", searchKeyword);
        } catch (Exception e) {
            log("Error at SearchBookController: " + e.toString());
            request.setAttribute("ERROR_MESSAGE", "Đã xảy ra lỗi khi tìm kiếm.");
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