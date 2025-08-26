<%-- 
    Document   : AdminDashboard
    Created on : May 31, 2025, 3:56:42 PM
    Author     : user
--%>
<%--
    Document   : AdminDashboard
    Created on : May 31, 2025, 3:56:42 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.User"%>
<%@page import="dto.BookRequest"%>
<%@page import="dao.BookRequestDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .action-buttons button {
                padding: 5px 10px;
                margin-right: 5px;
                cursor: pointer;
            }
            .approve-btn {
                background-color: #4CAF50; /* Green */
                color: white;
                border: none;
            }
            .reject-btn {
                background-color: #f44336; /* Red */
                color: white;
                border: none;
            }
            .success-message {
                color: green;
                font-weight: bold;
                margin-top: 10px;
            }
            .error-message {
                color: red;
                font-weight: bold;
                margin-top: 10px;
            }


            .delete-btn:hover {
                color: white;
                background-color: #d32f2f; /* Darker red on hover */
            }
            .delete-btn  { 
                
                color: red; /* White text for better contrast */
                font-size: 14px; /* Adjust font size for clarity */
                font-weight: bold; /* Bold the 'x' to make it stand out */
                
                border-radius: 50%; /* Makes the button perfectly round */
                font-size: 1em; /* Adjust the icon size relative to the button */ }
        </style>
    </head>
    <body>
        <jsp:include page="headerDetails.jsp"/> 
        <%
            // Check if user is logged in and is an admin (assuming 'role' attribute exists in User DTO)
            User us = (User) session.getAttribute("user");
            if (us == null || !"admin".equalsIgnoreCase(us.getRole())) {
                response.sendRedirect("index.jsp"); 
                return; 
            }

            // Display welcome message for admin
            out.print("<h4>Welcome " + us.getName() + " back, Admin!</h4>");
            out.print("<p><a href='LogoutController'>Sign Out</a></p>");
            out.print("<p><a href='ViewProfile.jsp'>Change Profile</a></p>");
            out.print("<p><a href='index.jsp'>BackToIndexPage</a><p>");
        %>

        <hr/>

        <h3>Manage Book Borrow Requests</h3>

        <%
            
            String message = (String) request.getAttribute("requestMessage");
            if (message != null) {
                if (message.contains("successfully")) {
        %>
        <p class="success-message"><%= message%></p>
        <%
                } else {
        %>
        <p class="error-message"><%= message%></p>
        <%
                }
            }
        %>

        <%
            // Fetch pending book requests
            BookRequestDAO requestDAO = new BookRequestDAO();
            ArrayList<BookRequest> pendingRequests = requestDAO.getAllBookRequests();

            if (pendingRequests != null && !pendingRequests.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Book ID</th>
                    <th>User ID</th>
                    <th>Request Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    for (BookRequest req : pendingRequests) {
                %>
                <tr>
                    <td><%= req.getId()%></td>
                    <td><%= req.getBookId()%></td>
                    <td><%= req.getUserId()%></td>
                    <td><%= (req.getRequestDate() != null ? sdf.format(req.getRequestDate()) : "N/A")%></td>
                    <td><%= req.getStatus()%></td>
                    <td class="action-buttons">
                        <% if ("Pending".equalsIgnoreCase(req.getStatus())) { %>
                        <form action="ManageBorrowRequestController" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= req.getId()%>">
                            <input type="hidden" name="action" value="approve">
                            <button type="submit" class="approve-btn">Approve</button>
                        </form>
                        <form action="ManageBorrowRequestController" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= req.getId()%>">
                            <input type="hidden" name="action" value="reject">
                            <button type="submit" class="reject-btn">Reject</button>
                        </form>
                        <% } else if ("Approved".equalsIgnoreCase(req.getStatus())) { %>
                        <form action="ManageBorrowRequestController" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= req.getId()%>">
                            <input type="hidden" name="action" value="return_book">
                            <button type="submit" class="return-btn">Ghi nhận trả sách</button>
                        </form>
                        <% } else if ("Rejected".equalsIgnoreCase(req.getStatus()) || "Returned".equalsIgnoreCase(req.getStatus())) { %>
                        <%= req.getStatus()%>
                        <form action="ManageBorrowRequestController" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= req.getId()%>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="delete-btn"><i class="fas fa-times"></i></button>
                        </form>
                        <% } else { %>
                        <%= req.getStatus()%>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <p>No pending, approved, or overdue book requests found.</p>
        <%
            }
        %>
        <p><a href="AdminUserController?action=viewUsers">Users Management</a></p>
        <p><a href='#'>Other Admin Actions...</a></p>

        <p><a href='ConfigController'>View System Config</a></p>

    </body>
</html>