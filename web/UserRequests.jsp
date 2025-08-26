<%-- 
    Document   : UserRequests
    Created on : Aug 14, 2025, 1:12:05 PM
    Author     : MyPC
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.BookRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Yêu Cầu Mượn Sách Của Bạn</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 80%; margin: auto; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Các Yêu Cầu Mượn Sách Của Tôi</h1>
        
        <% 
            ArrayList<BookRequest> userRequests = (ArrayList<BookRequest>) request.getAttribute("userRequests");
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

            if (userRequests == null || userRequests.isEmpty()) {
        %>
            <p>Bạn chưa có yêu cầu mượn sách nào.</p>
        <%
            } else {
        %>
            <table>
                <thead>
                    <tr>
                        <th>ID Yêu Cầu</th>
                        <th>ID Sách</th>
                        <th>Ngày Yêu Cầu</th>
                        <th>Ngày Mượn</th>
                        <th>Ngày Trả</th>
                        <th>Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (BookRequest req : userRequests) { %>
                    <tr>
                        <td><%= req.getId() %></td>
                        <td><%= req.getBookId() %></td>
                        <td><%= (req.getRequestDate() != null ? sdf.format(req.getRequestDate()) : "N/A") %></td>
                        <td><%= (req.getBorrowDate() != null ? sdf.format(req.getBorrowDate()) : "N/A") %></td>
                        <td><%= (req.getReturnDate() != null ? sdf.format(req.getReturnDate()) : "N/A") %></td>
                        <td><%= req.getStatus() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <%
            }
        %>
    </div>
</body>
</html>