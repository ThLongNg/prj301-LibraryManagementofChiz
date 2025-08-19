<%-- 
    Document   : UserDashboard
    Created on : May 31, 2025, 3:57:05 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link href="css/style.css" rel="stylesheet">

    <!-- Font Quicksand -->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(135deg, #f8e1f4, #e3d5ff);
            margin: 0;
            padding: 0;
            color: #4a3f72;
        }

        /* Tiêu đề welcome */
        h4 {
            text-align: center;
            margin-top: 40px;
            font-size: 1.8rem;
            color: #6a4c93;
            background: rgba(255, 255, 255, 0.7);
            padding: 10px 20px;
            border-radius: 12px;
            display: inline-block;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        /* Các link trong dashboard */
        p {
            
            text-align: center;
            margin-top: 40px ;
        }

        a {
            gap: 10px;
            text-decoration: none;
            color: white;
            background: linear-gradient(90deg, #c084fc, #f9a8d4);
            padding: 10px 18px;
            border-radius: 20px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        }

        a:hover {
            background: linear-gradient(90deg, #f9a8d4, #c084fc);
            transform: translateY(-3px);
            box-shadow: 0 5px 12px rgba(0,0,0,0.2);
        }

        /* Căn giữa toàn bộ nội dung */
        body > * {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Avatar */
        .avatar-img {
            display: block;
            position: absolute;
            top: 90px;
            left: 190px;
            width: 200px;
            border-radius: 50%;
            cursor: pointer;
            border: 10px solid #ddd;
            text-align: center;
            object-fit: cover;
        }

        /* Dashboard background */
        .dashboard {
            background-image: radial-gradient(circle at top left, #f9a8d4, #c084fc);
            min-height: 47vh;
            padding: 20px;
        }
                .home {
            margin: 5px 5px 10px 5px;
            border-radius: 0px;
        }
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    String avatarPath;

    if (user != null && user.getAvatar() != null) {
        String avatarUrl = user.getAvatar();
        if (avatarUrl.startsWith("http://") || avatarUrl.startsWith("https://")) {
            avatarPath = avatarUrl;
        } else {
            avatarPath = "/my_webapp_uploads/" + avatarUrl;
        }
    } else {
        avatarPath = "uploads/defaultava.jpg";
    }
%>
<a class="home" href='index.jsp'>Home Page</a>
<div class="dashboard">
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
    } else {
        User us = (User) session.getAttribute("user");
        out.print("<h4>Welcome " + us.getName() + " comeback</h4>");
        out.print("<img src='" + avatarPath + "' alt='Avatar' class='avatar-img' id='avatarBtn'>");
        out.print("<p><a href='LogoutController'>Logout</a></p>");
        out.print("<p><a href='ViewProfile.jsp'>Change Profile</a></p>");
        out.print("<p><a href='UserRequests.jsp'>View Borrow Request</a></p>");
    }
%>
</div>
</body>
</html>
