<%-- 
    Document   : headerBack
    Created on : Jul 23, 2025, 1:22:48 AM
    Author     : MyPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Library</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Favicon -->
    <link href="images/favicon.ico" rel="icon">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <!-- Bootstrap 4 -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">

</head>

<body>
<!-- ======= Top Bar ======= -->
<div class="bg-light border-bottom py-2">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <a class="text-muted mr-3" href="#">FAQs</a>
            <a class="text-muted mr-3" href="#">Help</a>
            <a class="text-muted" href="#">Support</a>
            <a>These function is going on!</a>
        </div>
        <div>
            <a class="text-muted mx-2" href="https://www.facebook.com/long.nguyen.07102005"><i class="fab fa-facebook-f"></i></a>
            <a class="text-muted mx-2" href="https://instagram.com/"><i class="fab fa-instagram"></i></a>
        </div>
    </div>
</div>

<!-- ======= Main Navigation ======= -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand font-weight-bold" href="index.jsp">
            <span class="text-primary">My</span> Library
        </a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MainController?action=showCart">Cart</a>
                </li>
                <c:choose>
                    <c:when test="${empty sessionScope.USER}">
                        <li class="nav-item">
                            <a class="nav-link" href="Login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="signup.jsp">Sign Up</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Hello, ${sessionScope.USER.fullName}
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="#">Profile</a>
                                <a class="dropdown-item" href="MainController?action=Logout">Logout</a>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <!-- Search Form -->

        </div>
    </div>
</nav>
