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
import com.google.gson.Gson;

@WebServlet(name = "SearchBookController", urlPatterns = {"/SearchBookController"})
public class SearchBookController extends HttpServlet {

    private static final String HOME_PAGE = "index.jsp";
    private static final String ERROR = "error.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8"); // Đặt Content-Type là JSON
        
        String searchKeyword = request.getParameter("keyword");
        BookDAO bookDAO = new BookDAO();
        ArrayList<Book> searchResult;

        try {
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                searchResult = bookDAO.getBooks(searchKeyword.trim());
            } else {
                searchResult = new ArrayList<>(); // Trả về danh sách rỗng nếu không có từ khóa
            }

            // Chuyển đổi danh sách sách thành chuỗi JSON
            String json = new Gson().toJson(searchResult);
            response.getWriter().write(json); // Gửi chuỗi JSON về client
        } catch (Exception e) {
            log("Error at SearchBookController: " + e.toString());
            response.getWriter().write("[]"); // Trả về JSON rỗng nếu có lỗi
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