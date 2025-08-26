<%-- 
    Document   : update
    Created on : Aug 20, 2025, 11:49:29 AM
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
        <%@ page import="dto.StudentDTO" %>
        <% 
            StudentDTO student = (StudentDTO) request.getAttribute("STUDENT_INFO"); 
            if (student == null) {
        
                response.sendRedirect("MainController?action=Search");
                return;
            }
        %>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="Update">
            <input type="hidden" name="id" value="<%= student.getId() %>">

            <h2>Update Student Information</h2>
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" value="<%= student.getFirstName() %>" required><br><br>
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" value="<%= student.getLastName() %>" required><br><br>
            <input type="submit" value="Update">
        </form>
    </body>
</html>
