<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ChizNg's Library</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
<!-- ======= Top Bar ======= -->
<div class="bg-light border-bottom py-2">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            
            <a class="text-muted mr-3" >Help</a>
            <a class="text-muted" >Support</a>
            
        </div>
        <div><a class="text-muted mr-3" >Welcome to my library, A place to improve knowledge.</a></div>
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
            <span style="color:#FF9CF5">ChizNg の</span> Library
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
                </c:choose>
            </ul>

            <!-- Search Form -->
        </div>
    </div>
</nav>
