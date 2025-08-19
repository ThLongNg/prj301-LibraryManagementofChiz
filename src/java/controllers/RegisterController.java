/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;
import java.io.File;
import java.nio.file.Paths;
import jakarta.servlet.http.Part;
import dao.UserDAO;
import dto.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.UUID;

/**
 *
 * @author user
 */
@MultipartConfig
public class RegisterController extends HttpServlet {

    


private static final String UPLOAD_DIRECTORY = "D:" + File.separator + "FPT" + File.separator + "uploads"; 

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");

    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String avatarFileName = "default-avatar.png";
    String role= "user";
        try {
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = "";
                int dotIndex = originalFileName.lastIndexOf('.');
                if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
                    fileExtension = originalFileName.substring(dotIndex);
                }
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

                // Tạo thư mục uploads 
                File uploadDir = new File(UPLOAD_DIRECTORY);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Lưu file vào thư mục cố định
                File file = new File(uploadDir, uniqueFileName);
                filePart.write(file.getAbsolutePath());
                avatarFileName = uniqueFileName; // Lưu tên file duy nhất vào DB
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải ảnh lên: " + e.getMessage());
        }
    if (username != null && email != null && password != null) {
        UserDAO dao = new UserDAO();
        User existingUser = dao.getUserByEmail(email);
        if (existingUser != null) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            int result = dao.insertNewUser(username, email, password, role, avatarFileName);
            if (result >= 1) {
                
                response.sendRedirect("Login.jsp");
            } else {
                request.setAttribute("error", "Failed to register!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        }
    }

}
}