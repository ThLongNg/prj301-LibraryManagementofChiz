package controllers;


import dao.BookDAO;
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
import java.util.List;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    private static final String LOGIN_PAGE = "Login.jsp";
    private static final String VIEW_CART_PAGE = "viewCart.jsp";
    private static final String PRODUCT_INDEX_PAGE = "productIndex.jsp";
     private static final String INDEX_PAGE = "index.jsp";
    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = PRODUCT_INDEX_PAGE;
        String action = request.getParameter("action");

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            List<Book> cart = (List<Book>) session.getAttribute("CART");

            if (user == null) {
                request.setAttribute("ERROR_MESSAGE", "Vui lòng đăng nhập để thực hiện tác vụ này.");
                url = LOGIN_PAGE;
            } else {
                if (cart == null) {
                    cart = new ArrayList<>();
                    session.setAttribute("CART", cart);
                }

                switch (action) {
                    case "addToCart":
                        int bookId = Integer.parseInt(request.getParameter("bookId"));
                        BookDAO bookDAO = new BookDAO();
                        Book book = bookDAO.getBook(bookId);

                        if (book != null) {
                            cart.add(book);
                            request.setAttribute("SUCCESS_MESSAGE", "Đã thêm '" + book.getTitle() + "' vào giỏ hàng.");
                        } else {
                            request.setAttribute("ERROR_MESSAGE", "Không tìm thấy sách.");
                        }
                        url = INDEX_PAGE;
                        break;
                    case "removeFromCart":
                        int removeId = Integer.parseInt(request.getParameter("bookId"));
                        cart.removeIf(b -> b.getId() == removeId);
                        request.setAttribute("SUCCESS_MESSAGE", "Đã xóa sách khỏi giỏ hàng.");
                        url = VIEW_CART_PAGE;
                        break;
                    case "showCart":
                        url = VIEW_CART_PAGE;
                        break;
                    default:
                        request.setAttribute("ERROR_MESSAGE", "Hành động không hợp lệ.");
                        url = ERROR;
                        break;
                }
            }
        } catch (Exception e) {
            log("Error at CartController: " + e.toString());
            request.setAttribute("ERROR_MESSAGE", "Đã xảy ra lỗi khi xử lý giỏ hàng.");
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