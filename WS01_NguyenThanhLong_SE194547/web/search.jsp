<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="Search">
            Search by Last Name: <input type="text" name="searchValue" value="${param.searchValue}">
            <input type="submit" value="Search">
        </form>
        <br>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th colspan="2">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="student" items="${requestScope.SEARCH_RESULT}">
                    <tr>
                        <td>${student.id}</td>
                        <td>${student.firstName}</td>
                        <td>${student.lastName}</td>
                        <td>
                            <form action="MainController" method="post">
                                <input type="hidden" name="action" value="Delete">
                                <input type="hidden" name="id" value="${student.id}">
                                <input type="submit" value="Delete">
                            </form>
                        </td>
                        <td>
                            <a href="MainController?action=Update&id=${student.id}">Update</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="SearchController?action=BackToIndex">Go back to Index</a>        
    </body>
</html>