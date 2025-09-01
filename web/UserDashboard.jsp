<%--
    Document   : UserDashboard
    Created on : May 31, 2025, 3:57:05 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.User" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link href="css/style.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6a4c93;
            --secondary-color: #f9a8d4;
            --background-start: #f8e1f4;
            --background-end: #e3d5ff;
            --card-bg: rgba(255, 255, 255, 0.85);
            --text-color: #4a3f72;
            --shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(135deg, var(--background-start), var(--background-end));
            min-height: 100vh;
            margin: 0;
            padding: 0;
            color: var(--text-color);
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .dashboard-container {
            width: 90%;
            max-width: 700px;
            padding: 2rem;
            background-color: var(--card-bg);
            border-radius: 20px;
            box-shadow: var(--shadow);
            text-align: center;
        }

        .header-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 2rem;
        }

        .avatar-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 5px solid var(--secondary-color);
            object-fit: cover;
            margin-bottom: 1rem;
            transition: transform 0.3s ease;
        }

        .avatar-img:hover {
            transform: scale(1.05);
        }

        .welcome-text {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary-color);
            margin: 0;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .nav-link {
            text-decoration: none;
            color: white;
            padding: 1rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
            background: linear-gradient(45deg, #a78bfa, #f9a8d4);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .nav-link i {
            margin-right: 10px;
        }

        .nav-link:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 12px rgba(0,0,0,0.2);
            background: linear-gradient(45deg, #f9a8d4, #a78bfa);
        }
    </style>
</head>
<body>
    <%
        // Kiểm tra phiên đăng nhập
        if (session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        User us = (User) session.getAttribute("user");
        String avatarPath;
        if (us != null && us.getAvatar() != null && (us.getAvatar().startsWith("http://") || us.getAvatar().startsWith("https://"))) {
            avatarPath = us.getAvatar();
        } else if (us != null && us.getAvatar() != null) {
            avatarPath = "/my_webapp_uploads/" + us.getAvatar();
        } else {
            avatarPath = "uploads/defaultava.jpg";
        }
    %>
    <div class="dashboard-container">
        <div class="header-content">
            <img src="<%= avatarPath %>" alt="Avatar" class="avatar-img">
            <h4 class="welcome-text">Chào mừng trở lại, <%= us.getName().toUpperCase() %>!</h4>
        </div>
        <div class="nav-links">
            <a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> Trang chủ</a>
            <a href="ViewProfile.jsp" class="nav-link"><i class="fas fa-user-circle"></i> Hồ sơ</a>
            <a href="ViewRequestsController" class="nav-link"><i class="fas fa-book"></i> Yêu cầu mượn sách</a>
            <a href="LogoutController" class="nav-link"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>
</body>
</html>