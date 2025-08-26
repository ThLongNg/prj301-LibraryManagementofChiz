package controllers;


import dao.UserDAO;
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

/**
 *
 * @author user
 */
@WebServlet(name = "AdminUserController", urlPatterns = {"/AdminUserController"})
public class AdminUserController extends HttpServlet {

    private static final String ERROR = "error.jsp"; 
    private static final String ADMIN_USER_LIST_PAGE = "viewUserList.jsp"; 
    private static final String LOGIN_PAGE = "Login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        boolean redirected = false;
        String url = ERROR; // Mặc định là trang lỗi
        String action = request.getParameter("action"); // Lấy action từ request

        try {
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("user");

            // Kiểm tra xem người dùng đã đăng nhập và có phải là admin không
            if (loggedInUser == null || !loggedInUser.getRole().equalsIgnoreCase("admin")) {
                response.sendRedirect(LOGIN_PAGE); // Chuyển hướng về trang đăng nhập nếu không phải admin
                redirected= true;
                return;
            }

            UserDAO userDAO = new UserDAO();

            if (action == null || action.equalsIgnoreCase("viewUsers")) {
                // Action: Hiển thị danh sách người dùng
                ArrayList<User> userList = userDAO.getAllUsers();
                request.setAttribute("USER_LIST", userList);
                url = ADMIN_USER_LIST_PAGE;
            } else if (action.equalsIgnoreCase("editUser")) {
                // Action: Chỉnh sửa thông tin người dùng
                String idStr = request.getParameter("id");
                String newUserName = request.getParameter("newUserName");
                String newRole = request.getParameter("newRole");

                if (idStr != null && !idStr.isEmpty() && newUserName != null && newRole != null){
                    int id = Integer.parseInt(idStr);
                    boolean success = userDAO.updateUserByAdmin(id, newUserName, newRole);
                    if (success) {
                        request.setAttribute("message", "Cập nhật người dùng thành công!");
                    } else {
                        request.setAttribute("error", "Cập nhật người dùng thất bại!");
                    }
                } else {
                    request.setAttribute("error", "Thiếu thông tin để cập nhật người dùng.");
                }
                // Sau khi chỉnh sửa, quay lại trang danh sách người dùng
                ArrayList<User> userList = userDAO.getAllUsers();
                request.setAttribute("USER_LIST", userList);
                url = ADMIN_USER_LIST_PAGE;

            } else if (action.equalsIgnoreCase("deleteUser")) {
                
                String idStr = request.getParameter("id");

                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    
                    if (loggedInUser.getId()==id) {
                        
                        request.setAttribute("error", "Bạn không thể tự xóa tài khoản của mình!");
                    } else {
                        boolean success = userDAO.deleteUser(id);
                        if (success) {
                            request.setAttribute("message", "Xóa người dùng thành công!");
                        } else {
                            request.setAttribute("error", "Xóa người dùng thất bại. Có thể người dùng không tồn tại hoặc có ràng buộc dữ liệu.");
                        }
                    }
                } else {
                    request.setAttribute("error", "Không tìm thấy ID người dùng để xóa.");
                }
                // Sau khi xóa, quay lại trang danh sách người dùng
                ArrayList<User> userList = userDAO.getAllUsers();
                request.setAttribute("USER_LIST", userList);
                url = ADMIN_USER_LIST_PAGE;
            } else {
                request.setAttribute("error", "Hành động không hợp lệ.");
                url = ADMIN_USER_LIST_PAGE; // Quay về trang danh sách với lỗi
            }

        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if(!redirected){
            request.getRequestDispatcher(url).forward(request, response);
        }}
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
        return "Admin controller for user management (view, edit, delete).";
    }
}