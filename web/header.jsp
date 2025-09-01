<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ChizNg's Library</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/style.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
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
<nav class="bg-white shadow-sm">
    <div class="container mx-auto px-4 py-2 flex justify-between items-center">
        <a class="text-xl font-bold" href="index.jsp">
            <span class="text-[#FF9CF5]">ChizNg の</span> Library
        </a>
        <div class="flex items-center space-x-4">
            <a class="text-gray-600 hover:text-gray-900" href="index.jsp">Home</a>
            <a class="text-gray-600 hover:text-gray-900" href="MainController?action=showCart">Cart</a>
            <c:choose>
                <c:when test="${empty sessionScope.USER}">
                    <a class="text-gray-600 hover:text-gray-900" href="Login.jsp">Login</a>
                    <a class="text-gray-600 hover:text-gray-900" href="signup.jsp">Sign Up</a>
                </c:when>
            </c:choose>
        </div>
    </div>
</nav>
