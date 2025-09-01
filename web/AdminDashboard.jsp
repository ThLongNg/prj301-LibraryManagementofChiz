<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.User"%>
<%@page import="dto.BookRequest"%>
<%@page import="dao.BookRequestDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #FFC9E2; /* Light grey background */
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                display: flex;
            }
            #sidebar {
                width: 250px;
                background-color: #FF8AE2;
                color: #150844;
                padding-top: 2rem;
                min-height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1000;
            }
            #sidebar .list-group-item {
                background-color: transparent;
                color: #4B4B4B; /* Lighter pastel purple */
                border: none;
                padding: 1rem 1.5rem;
                transition: all 0.3s;
            }
            #sidebar .list-group-item:hover,
            #sidebar .list-group-item.active {
                color: #fff;
                background-color: #B57EDC; /* A slightly darker purple for hover/active */
                border-left: 4px solid #fff;
                padding-left: 1.5rem;
            }
            #sidebar .list-group-item i {
                margin-right: 10px;
            }
            #content {
                flex-grow: 1;
                margin-left: 250px; /* Adjust to match sidebar width */
                padding: 2rem;
            }
            .admin-header {
                background-color: #fff;
                border-radius: 10px;
                padding: 1.5rem;
                margin-bottom: 2rem;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            }
            .admin-header h4 {
                font-weight: 700;
            }
            .table-responsive {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
                padding: 1rem;
            }
            .table thead th {
                background-color: #e9ecef;
                font-weight: 600;
            }
            .table tbody tr:hover {
                background-color: #f1f1f1;
            }
            .badge {
                font-size: 0.85em;
                padding: 0.5em 0.8em;
                font-weight: 500;
            }
            /* Pastel color styles for buttons and badges */
            .btn-approve {
                background-color: #98fb98;
                color: #212529;
                border: none;
            } /* Light green */
            .btn-reject {
                background-color: #ffb6c1;
                color: #212529;
                border: none;
            } /* Light pink */
            .btn-return {
                background-color: #add8e6;
                color: #212529;
                border: none;
            } /* Light blue */
            .btn-refund {
                background-color: #ffdead;
                color: #212529;
                border: none;
            } /* Peach */
            .btn-delete {
                color: #dc3545;
                font-size: 1.1em;
            } /* Red for deletion, keep it striking */

            .btn-approve:hover {
                background-color: #8fbc8f;
            }
            .btn-reject:hover {
                background-color: #f08080;
            }
            .btn-return:hover {
                background-color: #87ceeb;
            }
            .btn-refund:hover {
                background-color: #ffb78f;
            }
            .btn-delete:hover {
                color: #c82333;
            }

            /* Pastel badge colors for consistency */
            .badge-pending {
                background-color: #ffd700;
                color: #212529;
            } /* Gold */
            .badge-approved {
                background-color: #98fb98;
                color: #212529;
            } /* Light green */
            .badge-rejected {
                background-color: #ffb6c1;
                color: #212529;
            } /* Light pink */
            .badge-returned {
                background-color: #add8e6;
                color: #212529;
            } /* Light blue */
            .badge-paid {
                background-color: #b0e0e6;
                color: #212529;
            } /* Powder blue */
            .badge-unpaid {
                background-color: #e6e6fa;
                color: #212529;
            } /* Lavender */
            .badge-refunded {
                background-color: #FF9800;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <%
            User us = (User) session.getAttribute("user");
            if (us == null || !"admin".equalsIgnoreCase(us.getRole())) {
                response.sendRedirect("index.jsp");
                return;
            }
        %>

        <%-- SideBar --%>

        <div id="sidebar" class="d-flex flex-column align-items-center">
            <h4 class="mb-4 text-center">Admin Panel</h4>
            <div class="list-group list-group-flush w-100">
                <a href="AdminDashboard.jsp" class="list-group-item list-group-item-action active">
                    <i class="fas fa-book-reader"></i> Quản lý Yêu cầu
                </a>
                <a href="AdminUserController?action=viewUsers" class="list-group-item list-group-item-action">
                    <i class="fas fa-users"></i> Quản lý Người dùng
                </a>
                <a href="ConfigController" class="list-group-item list-group-item-action">
                    <i class="fas fa-cogs"></i> Cấu hình Hệ thống
                </a>
                <a href="index.jsp" class="list-group-item list-group-item-action mt-auto">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <a href="LogoutController" class="list-group-item list-group-item-action">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
                <a href="AddBook.jsp" class="list-group-item list-group-item-action">
                     <i class="fas fa-add"></i>Thêm Sách Mới
                </a>
            </div>
        </div>

        <div id="content">
            <div class="admin-header d-flex justify-content-between align-items-center">
                <h4>Chào mừng trở lại, <span style="color: #C8A2C8;"><%= us.getName().toUpperCase()%></span>!</h4>
                <div>
                    <a href="ViewProfile.jsp" class="btn btn-outline-primary"><i class="fas fa-user-circle"></i> Hồ sơ</a>
                </div>
            </div>

            <h3 class="mt-4 mb-4 text-center">Quản lý Yêu cầu Mượn sách</h3>

            <%
                String message = (String) request.getAttribute("requestMessage");
                if (message != null) {
                    boolean isSuccess = message.contains("successfully") || message.contains("thành công");
            %>
            <div class="alert alert-<%= isSuccess ? "success" : "danger"%> alert-dismissible fade show" role="alert">
                <%= message%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                }
            %>

            <div class="table-responsive">
                <%
                    BookRequestDAO requestDAO = new BookRequestDAO();
                    ArrayList<BookRequest> allRequests = requestDAO.getAllBookRequests();
                    if (allRequests != null && !allRequests.isEmpty()) {
                %>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Book ID</th>
                            
                            <th>User ID</th>
                            <th>Request Date</th>
                            <th>Payment Status</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            for (BookRequest req : allRequests) {
                        %>
                        <tr>
                            <td><%= req.getId()%></td>
                            <td><%= req.getBookId()%></td>
                            <td><%= req.getUserId()%></td>
                            <td><%= (req.getRequestDate() != null ? sdf.format(req.getRequestDate()) : "N/A")%></td>
                            <td>
                                <% if ("Paid".equalsIgnoreCase(req.getPaymentStatus())) { %>
                                <span class="badge badge-paid">Đã thanh toán</span>
                                <% } else if ("Refunded".equalsIgnoreCase(req.getPaymentStatus())) { %>
                                <span class="badge badge-refunded">Đã hoàn tiền</span>
                                <% } else { %>
                                <span class="badge badge-unpaid">Chưa thanh toán</span>
                                <% } %>
                            </td>
                            <td>
                                <% if ("Pending".equalsIgnoreCase(req.getStatus())) { %>
                                <span class="badge badge-pending"><%= req.getStatus()%></span>
                                <% } else if ("Approved".equalsIgnoreCase(req.getStatus())) { %>
                                <span class="badge badge-approved"><%= req.getStatus()%></span>
                                <% } else if ("Rejected".equalsIgnoreCase(req.getStatus())) { %>
                                <span class="badge badge-rejected"><%= req.getStatus()%></span>
                                <% } else if ("Returned".equalsIgnoreCase(req.getStatus())) { %>
                                <span class="badge badge-returned"><%= req.getStatus()%></span>
                                <% } else { %>
                                <%= req.getStatus()%>
                                <% } %>
                            </td>
                            <td class="action-buttons">
                                <% if ("Pending".equalsIgnoreCase(req.getStatus())) { %>
                                <form action="ManageBorrowRequestController" method="post" class="d-inline-block">
                                    <input type="hidden" name="id" value="<%= req.getId()%>">
                                    <input type="hidden" name="action" value="approve">
                                    <button type="submit" class="btn btn-approve btn-sm me-1">Approve</button>
                                </form>
                                <form action="ManageBorrowRequestController" method="post" class="d-inline-block">
                                    <input type="hidden" name="id" value="<%= req.getId()%>">
                                    <input type="hidden" name="action" value="reject">
                                    <button type="submit" class="btn btn-reject btn-sm">Reject</button>
                                </form>
                                <% } else if ("Approved".equalsIgnoreCase(req.getStatus())) { %>
                                <form action="ManageBorrowRequestController" method="post" class="d-inline-block">
                                    <input type="hidden" name="id" value="<%= req.getId()%>">
                                    <input type="hidden" name="action" value="return_book">
                                    <button type="submit" class="btn btn-return btn-sm">Ghi nhận trả sách</button>
                                </form>
                                <% } else if ("Rejected".equalsIgnoreCase(req.getStatus()) && "Paid".equalsIgnoreCase(req.getPaymentStatus())) { %>
                                <form action="ManageBorrowRequestController" method="post" class="d-inline-block">
                                    <input type="hidden" name="id" value="<%= req.getId()%>">
                                    <input type="hidden" name="action" value="refund">
                                    <button type="submit" class="btn btn-refund btn-sm">Hoàn tiền</button>
                                </form>
                                <% } %>
                                <%-- Xử lý nút xóa --%>
                                <% if ("Rejected".equalsIgnoreCase(req.getStatus()) || "Returned".equalsIgnoreCase(req.getStatus()) || "Refunded".equalsIgnoreCase(req.getStatus())) { %>
                                <form action="ManageBorrowRequestController" method="post" class="d-inline-block">
                                    <input type="hidden" name="id" value="<%= req.getId()%>">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="btn btn-delete"><i class="fas fa-times"></i></button>
                                </form>
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
                <div class="alert alert-info text-center mt-4" role="alert">
                    Không tìm thấy yêu cầu mượn sách nào.
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>