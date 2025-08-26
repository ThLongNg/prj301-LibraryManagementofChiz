package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import dao.StudentDAO;
import dto.StudentDTO;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SearchController", urlPatterns = {"/SearchController"})
public class SearchController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "search.jsp";
        String searchValue = request.getParameter("searchValue");
        StudentDAO dao = new StudentDAO();

        try {
            // Lấy session
            HttpSession session = request.getSession();
            
            // Xử lý khi nhấn nút tìm kiếm từ form POST
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                session.setAttribute("LAST_SEARCH_VALUE", searchValue);
            } else {
                // Xử lý khi quay lại từ Delete/Update hoặc truy cập trực tiếp
                // Nếu không có searchValue từ URL, lấy từ session
                if (searchValue == null || searchValue.isEmpty()) {
                    searchValue = (String) session.getAttribute("LAST_SEARCH_VALUE");
                }
            }

            List<StudentDTO> result = dao.searchByLastName(searchValue);
            request.setAttribute("SEARCH_RESULT", result);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
