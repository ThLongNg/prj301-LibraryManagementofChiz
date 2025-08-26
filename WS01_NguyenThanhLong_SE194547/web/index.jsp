<%-- 
    Document   : index.jsp
    Created on : Aug 20, 2025, 11:48:42 AM
    Author     : MyPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%
    String firstName = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("firstName")) {
                firstName = cookie.getValue();
                break;
            }
        }
    }
%>
<h2>Welcome, <%= firstName %>!</h2>
<p>You have successfully logged in.</p>
<br>
<a href="MainController?action=Search">Go to Search Page</a>
    </body>
</html>
