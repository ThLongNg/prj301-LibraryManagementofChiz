package controllers;

import dao.UserDAO;
import dto.User;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID; // Import để tạo tên file duy nhất
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 *
 * @author user
 */
@WebServlet(name="ChangeProfileController", urlPatterns={"/ChangeProfileController"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ChangeProfileController extends HttpServlet {
   private static final String UPLOAD_DIRECTORY = "D:" + File.separator + "FPT" + File.separator + "uploads"; 

   private static final String SUCCESS_URL = "ViewProfile.jsp";
   private static final String ERROR_URL = "ViewProfile.jsp";
   private static final String LOGIN_PAGE = "Login.jsp";

   public void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       
       response.setContentType("text/html;charset=UTF-8");
       request.setCharacterEncoding("UTF-8");

       String url = ERROR_URL;
       String message = "";

       try {
           HttpSession session = request.getSession();
           User loggedInUser = (User) session.getAttribute("user");

           if (loggedInUser == null) {
               response.sendRedirect(LOGIN_PAGE);
               return;
           }

           String newUsername = request.getParameter("username");
           String newPassword = request.getParameter("password");
           String role = loggedInUser.getRole(); // Lấy role từ session, không thay đổi từ form
           String avatarFileName = loggedInUser.getAvatar();

           if (newUsername == null || newUsername.trim().isEmpty() || 
               newPassword == null || newPassword.trim().isEmpty()) {
               message = "Tên người dùng và mật khẩu không được để trống.";
               request.setAttribute("profileMessage", message);
               request.getRequestDispatcher(ERROR_URL).forward(request, response);
               return;
           }

           // Xử lý tải lên file avatar mới
             try {
               Part filePart = request.getPart("newAvatar");
               
               if (filePart != null && filePart.getSize() > 0 && 
                   filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                   
                   String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                   String fileExtension = "";
                   int dotIndex = originalFileName.lastIndexOf('.');
                   if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
                       fileExtension = originalFileName.substring(dotIndex);
                   }
                   
                   String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

                   File uploadDir = new File(UPLOAD_DIRECTORY);
                   if (!uploadDir.exists()) {
                       uploadDir.mkdirs();
                   }

                   File file = new File(uploadDir, uniqueFileName);
                   filePart.write(file.getAbsolutePath());
                   avatarFileName = uniqueFileName;
               }
           }
           catch (Exception e) {
               System.err.println("Error uploading avatar: " + e.getMessage());
               e.printStackTrace();
               message = "Lỗi khi tải lên ảnh đại diện: " + e.getMessage();
           }

           UserDAO dao = new UserDAO();
           // Gọi phương thức UpdateUser 
           int result = dao.UpdateUser(loggedInUser.getId(), newUsername, newPassword, role, avatarFileName);

           if (result == 1) {
               // Cập nhật lại đối tượng User trong session sau khi update thành công
               loggedInUser.setName(newUsername);
               loggedInUser.setPassword(newPassword);
               loggedInUser.setAvatar(avatarFileName); 
               session.setAttribute("user", loggedInUser); // Lưu lại User object đã cập nhật vào session
               
               message = "Cập nhật thông tin thành công!";
               url = SUCCESS_URL; // Quay lại trang ViewProfile để thấy thay đổi
           } else {
               message = "Cập nhật thông tin thất bại. Vui lòng thử lại.";
               url = ERROR_URL;
           }

       } catch (Exception e) {
           System.err.println("Đã xảy ra lỗi không mong muốn trong ChangeProfileController: " + e.getMessage());
           e.printStackTrace();
           message = "Đã xảy ra lỗi không mong muốn: " + e.getMessage();
           url = ERROR_URL;
       } finally {
           request.setAttribute("profileMessage", message);
           request.getRequestDispatcher(url).forward(request, response);
       }
   }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("ViewProfile.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Handles user profile updates, including avatar.";
    }
}