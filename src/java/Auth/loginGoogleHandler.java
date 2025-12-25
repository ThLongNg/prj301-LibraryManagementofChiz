package Auth;



import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import dao.UserDAO;
import dto.User;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginGoogleHandler", urlPatterns = {"/Auth/loginGoogleHandler"}) 
public class loginGoogleHandler extends HttpServlet {

    private static final String CLIENT_ID = "";
    private static final String CLIENT_SECRET = "";
    private static final String REDIRECT_URI = "http://localhost:8080/demoJDBC/Auth/loginGoogleHandler";
    private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String code = request.getParameter("code");

        if (code != null && !code.isEmpty()) {
            try {
                GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                        HTTP_TRANSPORT,
                        JSON_FACTORY,
                        CLIENT_ID,
                        CLIENT_SECRET,
                        code,
                        REDIRECT_URI)
                        .execute();

                GoogleIdToken idToken = tokenResponse.parseIdToken();
                GoogleIdToken.Payload payload = idToken.getPayload();

                String email = payload.getEmail();
                String name = (String) payload.get("name");
                String pictureUrl = (String) payload.get("picture");

                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByEmail(email);

                if (user == null) {
                    user = new User();
                    user.setEmail(email);
                    user.setName(name);
                    user.setAvatar(pictureUrl);
                    user.setRole("user");
                    user.setStatus("active");
                    user.setPassword("GOOGLE_USER");

                    boolean created = userDAO.newGoogleUser(user);
                    if (!created) {
                        throw new Exception("Không thể tạo người dùng mới trong database.");
                    }
                    user = userDAO.getUserByEmail(email);
                } else {
                    user.setName(name);
                    user.setAvatar(pictureUrl);
                    user.setStatus("active");
                    userDAO.updateGoogleUser(user);
                }

                HttpSession session = request.getSession();
                session.setAttribute("user", user); // Đã sửa tên attribute thành "user" để khớp với AdminUserController

                response.sendRedirect(request.getContextPath() + "/index.jsp");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu khi đăng nhập Google: " + e.getMessage());
                request.getRequestDispatcher("/Login.jsp").forward(request, response);
            } catch (IOException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi giao tiếp với Google: " + e.getMessage());
                request.getRequestDispatcher("/Login.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Đã xảy ra lỗi không mong muốn khi đăng nhập Google: " + e.getMessage());
                request.getRequestDispatcher("/Login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Đăng nhập Google không thành công. Vui lòng thử lại.");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }
}
