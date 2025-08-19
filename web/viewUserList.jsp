<%-- 
    Document   : viewUserList
    Created on : Jul 26, 2025, 1:10:29 PM
    Author     : MyPC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, dto.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Quản lý Người dùng</title>
        <link href="css/style.css" rel="stylesheet">
        <style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(to right, #fce4ec, #f8bbd0); /* Gradient hồng nhạt */
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column; /* Để footer và các phần khác nằm dưới */
    align-items: center; /* Căn giữa nội dung chính */
    min-height: 100vh; /* Chiếm toàn bộ chiều cao màn hình */
    padding-top: 30px; /* Thêm padding trên để không dính sát top */
    padding-bottom: 30px; /* Thêm padding dưới */
}

/* --- Container chính cho trang quản lý người dùng --- */
.user-management-container {
    background-color: #fffafa; /* Màu trắng ngà, rất nhẹ */
    padding: 2.5rem 3.5rem;
    border-radius: 20px; /* Bo tròn đáng yêu hơn */
    box-shadow: 0 10px 30px rgba(255, 182, 193, 0.4); /* Bóng mềm mại, có tông hồng */
    width: 95%; /* Chiếm nhiều chiều rộng hơn trên màn hình lớn */
    max-width: 1300px; /* Max width lớn hơn cho bảng rộng */
    margin: 30px auto; /* Căn giữa và có khoảng cách */
    text-align: center;
    border: 2px solid #ffc0cb; /* Viền hồng nhạt */
    box-sizing: border-box; /* Đảm bảo padding và border không làm tăng kích thước */
}

/* --- Tiêu đề trang (H1) --- */
h1 {
    text-align: center;
    color: #e75480; /* Màu hồng đậm hơn, nổi bật */
    font-weight: 700; /* In đậm */
    font-size: 3em; /* Kích thước lớn */
    text-shadow: 2px 2px 5px rgba(255, 192, 203, 0.7); /* Bóng chữ mềm và rõ nét */
    margin-bottom: 35px;
    letter-spacing: 1.5px; /* Khoảng cách chữ nhẹ */
}

/* --- Thông báo thành công/lỗi --- */
.message-success, .message-error {
    padding: 15px 20px;
    margin-bottom: 25px;
    border-radius: 12px; /* Bo tròn đáng yêu */
    font-weight: 600;
    font-size: 1.1em;
    animation: fadeIn 0.5s ease-out; /* Hiệu ứng mờ dần khi xuất hiện */
    box-shadow: 0 2px 8px rgba(0,0,0,0.1); /* Bóng nhẹ */
}

.message-success {
    background-color: #d4edda; /* Xanh lá cây nhạt */
    color: #155724; /* Xanh lá cây đậm */
    border: 1px solid #c3e6cb;
}

.message-error {
    background-color: #f8d7da; /* Đỏ nhạt */
    color: #721c24; /* Đỏ đậm */
    border: 1px solid #f5c6cb;
}

/* --- Bảng --- */
table {
    width: 100%;
    border-collapse: separate; /* Để dùng border-radius cho ô */
    border-spacing: 0;
    margin-top: 30px;
    box-shadow: 0 5px 20px rgba(255, 182, 193, 0.2); /* Bóng mềm mại hơn cho bảng */
    border-radius: 15px; /* Bo tròn bảng */
    overflow: hidden; /* Đảm bảo nội dung không tràn ra ngoài bo góc */
}

th, td {
    border: 1px solid #ffe0f7; /* Viền hồng nhạt hơn */
    padding: 14px 18px;
    text-align: left;
    vertical-align: middle; /* Căn giữa theo chiều dọc */
}

th {
    background-color: #ffe8f0; /* Hồng nhạt hơn cho header */
    color: #e75480; /* Màu chữ hồng nổi bật */
    font-weight: 700;
    text-transform: uppercase;
    font-size: 0.95em;
    letter-spacing: 0.5px;
}

/* Bo góc cho header và footer của bảng */
th:first-child { border-top-left-radius: 15px; }
th:last-child { border-top-right-radius: 15px; }
tr:last-child td:first-child { border-bottom-left-radius: 15px; }
tr:last-child td:last-child { border-bottom-right-radius: 15px; }


tbody tr:nth-child(odd) { /* Hàng lẻ, để hàng chẵn là màu nền mặc định (trắng) */
    background-color: #fffafa; /* Rất nhạt, gần trắng */
}

tbody tr:nth-child(even) {
    background-color: #fff0f5; /* Hồng phấn nhạt cho hàng chẵn */
}


tbody tr:hover {
    background-color: #ffebeb; /* Hồng đậm hơn khi hover */
    transition: background-color 0.3s ease;
}

/* --- Ảnh Avatar trong bảng --- */
.avatar-col {
    width: 60px; /* Lớn hơn một chút */
    height: 60px;
    border-radius: 50%; /* Tròn hoàn hảo */
    object-fit: cover;
    border: 3px solid #ffc0cb; /* Viền hồng nhạt */
    box-shadow: 0 2px 10px rgba(255, 192, 203, 0.3); /* Bóng mềm mại */
}

/* --- Nút hành động (Sửa, Xóa) --- */
.edit-btn, .delete-btn {
    padding: 10px 18px;
    margin: 5px;
    border: none;
    border-radius: 20px; /* Bo tròn đáng yêu */
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1); /* Bóng nhẹ cho nút */
    letter-spacing: 0.5px;
}

.edit-btn {
    background-color: #e0b7ff; /* Tím lavender */
    color: white;
}

.edit-btn:hover {
    background-color: #cc99ff; /* Tím đậm hơn khi hover */
    transform: translateY(-3px); /* Nảy lên nhẹ */
    box-shadow: 0 6px 15px rgba(224, 183, 255, 0.5); /* Bóng tím */
}

.delete-btn {
    background-color: #f06292; /* Hồng đậm */
    color: white;
}

.delete-btn:hover {
    background-color: #ec407a; /* Hồng đậm hơn khi hover */
    transform: translateY(-3px); /* Nảy lên nhẹ */
    box-shadow: 0 6px 15px rgba(240, 98, 146, 0.5); /* Bóng hồng */
}

/* --- Form xóa (đảm bảo hiển thị inline với nút Sửa) --- */
.action-form {
    display: inline-block; /* Để nút "Xóa" nằm cạnh "Sửa" */
    margin-left: 5px; /* Khoảng cách giữa các nút */
}

/* --- Form chỉnh sửa ẩn hiện --- */
.edit-form-toggle-row td {
    padding: 0; /* Xóa padding mặc định của td bao quanh div editForm */
    border: none; /* Xóa border của td này */
}

div[id^='editForm_'] { /* Chọn các div có ID bắt đầu bằng 'editForm_' */
    padding: 15px;
    margin: 15px; /* Tạo khoảng cách với viền bảng */
    border: 1px dashed #f8bbd0; /* Viền nét đứt hồng */
    background-color: #fffefa; /* Nền rất nhạt cho form */
    border-radius: 12px; /* Bo tròn form */
    box-shadow: inset 0 0 8px rgba(255, 192, 203, 0.2); /* Bóng mờ bên trong */
    text-align: left; /* Căn trái nội dung form */
    box-sizing: border-box; /* Đảm bảo padding không làm tăng kích thước */
}

div[id^='editForm_'] p {
    margin-bottom: 12px;
    font-size: 1em;
    color: #e75480; /* Màu chữ hồng */
    font-weight: 500;
}

div[id^='editForm_'] input[type="text"],
div[id^='editForm_'] select {
    width: calc(100% - 25px); /* Chiều rộng gần đầy đủ */
    padding: 10px 12px;
    margin-top: 5px;
    border: 1px solid #f8bbd0;
    border-radius: 8px; /* Bo tròn nhẹ */
    font-family: 'Poppins', sans-serif;
    font-size: 0.95em;
    color: #333;
    background-color: #fff;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
    box-sizing: border-box; /* Đảm bảo padding không làm tăng kích thước */
}

div[id^='editForm_'] input[type="text"]:focus,
div[id^='editForm_'] select:focus {
    border-color: #e75480;
    outline: none;
    box-shadow: 0 0 8px rgba(231, 84, 128, 0.4); /* Bóng hồng khi focus */
}

div[id^='editForm_'] button {
    padding: 10px 20px;
    border: none;
    border-radius: 15px; /* Bo tròn các nút trong form */
    font-size: 1em;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
    margin-top: 15px;
    margin-right: 10px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
}

div[id^='editForm_'] button[type="submit"] {
    background-color: #f06292; /* Nút Lưu */
    color: white;
}

div[id^='editForm_'] button[type="submit"]:hover {
    background-color: #ec407a;
    transform: translateY(-2px);
    box-shadow: 0 5px 12px rgba(240, 98, 146, 0.4);
}

div[id^='editForm_'] button[type="button"] { /* Nút Hủy */
    background-color: #ccc; /* Xám nhẹ */
    color: #333;
}

div[id^='editForm_'] button[type="button"]:hover {
    background-color: #bbb;
    transform: translateY(-2px);
    box-shadow: 0 5px 12px rgba(187, 187, 187, 0.4);
}

/* --- Liên kết quay lại Dashboard --- */
.back-link {
    text-align: center;
    margin-top: 40px;
    font-size: 1.1em;
}

.back-link a {
    color: #e75480; /* Màu hồng */
    text-decoration: none;
    font-weight: 600;
    padding: 10px 20px;
    border: 2px solid #e75480;
    border-radius: 15px;
    transition: all 0.3s ease;
    display: inline-block; /* Để padding và margin hoạt động */
    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
}

.back-link a:hover {
    background-color: #e75480;
    color: white;
    box-shadow: 0 5px 15px rgba(231, 84, 128, 0.4);
    transform: translateY(-3px);
}

/* Keyframe cho hiệu ứng fadeIn */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* --- Responsive Design (để bảng hiển thị tốt trên thiết bị di động) --- */
@media (max-width: 992px) {
    .user-management-container {
        padding: 1.5rem 2rem;
        width: 98%;
    }
    h1 {
        font-size: 2.5em;
    }
    th, td {
        padding: 10px 12px;
    }
}

@media (max-width: 768px) {
    .user-management-container {
        padding: 1rem 1.5rem;
    }
    h1 {
        font-size: 2em;
        margin-bottom: 25px;
    }
    .message-success, .message-error {
        font-size: 1em;
        padding: 10px 15px;
    }
    .user-table, .user-table thead, .user-table tbody, .user-table th, .user-table td, .user-table tr {
        display: block;
        width: 100%;
    }
    .user-table thead tr {
        position: absolute;
        top: -9999px;
        left: -9999px;
    }
    .user-table tr {
        border: 1px solid #ffe0f7;
        border-radius: 12px;
        margin-bottom: 15px;
        box-shadow: 0 3px 10px rgba(255, 182, 193, 0.2);
        overflow: hidden; /* Cần thiết cho border-radius */
    }
    .user-table td {
        border: none;
        border-bottom: 1px solid #ffe8f0;
        position: relative;
        padding-left: 50%; /* Tạo không gian cho label giả */
        text-align: right;
    }
    .user-table td:last-child {
        border-bottom: none;
    }
    .user-table td:before {
        content: attr(data-label); /* Sử dụng thuộc tính data-label */
        position: absolute;
        top: 0;
        left: 6px;
        width: 45%;
        padding-right: 10px;
        white-space: nowrap;
        font-weight: 600;
        text-align: left;
        color: #e75480;
    }
    .avatar-col {
        display: block;
        margin: 5px auto;
    }
    .actions-cell {
        text-align: center;
        display: flex; /* Sử dụng flexbox để căn giữa nút */
        justify-content: center;
        align-items: center;
        flex-wrap: wrap; /* Cho phép các nút xuống dòng nếu cần */
        padding-left: 0 !important; /* Xóa padding-left 50% của td */
    }
    .actions-cell .action-form {
        margin-left: 0;
        margin-top: 5px; /* Khoảng cách giữa các nút */
    }
    div[id^='editForm_'] {
        padding: 10px;
        margin-top: 10px;
    }
    div[id^='editForm_'] input[type="text"],
    div[id^='editForm_'] select {
        width: calc(100% - 20px);
        padding: 8px 10px;
    }
    div[id^='editForm_'] button {
        width: calc(50% - 15px); /* Hai nút trên một hàng */
        margin: 5px;
    }
}

@media (max-width: 480px) {
    h1 {
        font-size: 1.8em;
    }
    .user-management-container {
        padding: 1rem;
    }
    .edit-btn, .delete-btn {
        padding: 8px 12px;
        font-size: 0.85em;
    }
    div[id^='editForm_'] button {
        width: 100%; /* Mỗi nút một hàng */
        margin: 5px 0;
    }
}
        </style>
        <script>
            // JavaScript để hiển thị/ẩn form chỉnh sửa
            function toggleEditForm(id) {
                const form = document.getElementById('editForm_' + id);
                if (form) {
                    form.style.display = form.style.display === 'none' ? 'block' : 'none';
                }
            }

            // Xác nhận xóa
            function confirmDelete(username) {
                return confirm("Bạn có chắc chắn muốn xóa người dùng '" + username + "' này không?");
            }
        </script>
    </head>
    <body>
        <h1>Quản lý Người dùng</h1>

        <%
            // Hiển thị thông báo (nếu có)
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");

            if (message != null) {
                out.print("<p class='message-success'>" + message + "</p>");
            }
            if (error != null) {
                out.print("<p class='message-error'>" + error + "</p>");
            }

            // Lấy danh sách người dùng từ request attribute
            ArrayList<User> userList = (ArrayList<User>) request.getAttribute("USER_LIST");

            if (userList != null && !userList.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Avatar</th>
                    <th>Tên người dùng</th>
                    <th>Email</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <% for (User user : userList) { %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td>
                        <img src="<%= user.getAvatar() != null && !user.getAvatar().isEmpty() ? "uploads/" + user.getAvatar() : "uploads/default-avatar.png" %>" 
                             alt="Avatar" class="avatar-col">
                    </td>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getRole() %></td>
                    <td><%= user.getStatus() %></td>
                    <td>
                        <button class="edit-btn" onclick="toggleEditForm('<%= user.getId() %>')">Chỉnh sửa</button>

                        <form class="action-form" action="AdminUserController" method="post" onsubmit="return confirmDelete('<%= user.getName() %>');">
                            <input type="hidden" name="action" value="deleteUser">
                            <input type="hidden" name="id" value="<%= user.getId() %>">
                            <button type="submit" class="delete-btn">Xóa</button>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <div id="editForm_<%= user.getId() %>" style="display:none; padding: 10px; border-top: 1px solid #eee; background-color: #f9f9f9;">
                            <form action="AdminUserController" method="post">
                                <input type="hidden" name="action" value="editUser">
                                <input type="hidden" name="id" value="<%= user.getId() %>">
                                
                                <p>
                                    Tên người dùng mới: <input type="text" name="newUserName" value="<%= user.getName() %>" required>
                                </p>
                                <p>
                                    Vai trò mới: 
                                    <select name="newRole">
                                        <option value="user" <%= "user".equalsIgnoreCase(user.getRole()) ? "selected" : "" %>>User</option>
                                        <option value="admin" <%= "admin".equalsIgnoreCase(user.getRole()) ? "selected" : "" %>>Admin</option>
                                        </select>
                                </p>
                                <button type="submit">Lưu thay đổi</button>
                                <button type="button" onclick="toggleEditForm('<%= user.getId() %>')">Hủy</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p style="text-align: center;">Không có người dùng nào để hiển thị.</p>
        <% } %>

        <p class="back-link"><a href="AdminDashboard.jsp">Quay lại Admin Dashboard</a></p>
    </body>
</html>