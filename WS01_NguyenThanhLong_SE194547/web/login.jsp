<%-- 
    Document   : login
    Created on : Aug 20, 2025, 12:07:31 PM
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
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="Login">
            <h2>Student Login</h2>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            <input type="submit" value="Login">
            <span style="color:red">${requestScope.ERROR}</span>
        </form>

    </body>
</html>
