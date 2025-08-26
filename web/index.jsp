<%-- 
    Document   : index
    Created on : May 31, 2025, 3:46:30 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="java.util.ArrayList,dto.Book" %>
<%@ page import="dto.User" %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyLibrary</title>
        <link href="css/style.css" rel="stylesheet">
        <style>
            .avatar-menu {
                display: flex;

                align-items: center;

                position: absolute;
                top: 129px;
                right: 5px;
                z-index: 1000;
                gap: 15px;
                background-color: #f7f7ff;
                padding: 5px 3px 5px 25px;
                border-radius: 45px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 1px solid #e0b7ff;
            }

            .welcome-text {
                gap:8px;
                font-family: 'Zen Maru Gothic', sans-serif;
                display: flex;
                flex-direction: column;
                text-align: right;
            }

            .user-name {
                margin: 0;
                font-family: 'Zen Maru Gothic', sans-serif;
                white-space: nowrap;
                font-weight: bold;
                font-size: 1.1rem;
                color: #E0B7FF;
            }

            .okaeri {
                font-family: 'Zen Maru Gothic', sans-serif;
                margin: 0;
                white-space: nowrap;
                font-size: 0.9rem;
                color: #777;
            }

            .avatar-img {

                width: 60px;
                height: 60px;
                border-radius: 50%;
                cursor: pointer;
                border: 3px solid #ddd;
                object-fit: cover;
                box-shadow: none;
            }

            .dropdown-menu {

                display: none;
                position: absolute;
                top: calc(100% + 14px); /* Đặt bên dưới avatar một chút */
                right: 0px;
                border: none;
                z-index: 1001;
                transform: none;
                background-color:#f7f7ff;
            }
            .avatar-img {
                width: 70px;

                height: 70px;
                border-radius: 50%;
                cursor: pointer;
                border: 5px solid #ddd;
            }

            .dropdown-menu a {

                border-radius: 5px;
                display: block;
                padding: 10px 20px;
                text-decoration: none;
                color: #333;
                background: linear-gradient(90deg, #c084fc, #f9a8d4);
                margin: 2px;
                padding: 10px 18px;
                border-radius: 20px;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 3px 6px rgba(0,0,0,0.15);
                border-color: #E0B7FF;
            }

            .dropdown-menu a:hover {
                background: linear-gradient(90deg, #f9a8d4, #c084fc);
                transform: translateY(-3px);
                box-shadow: 0 5px 12px rgba(0,0,0,0.2);
            }
            /*============search box================*/
            .row{
                padding-top: 30px;
            }
            .search-form-container {

                background-color: #f8f9fa;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 20px 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
                margin-bottom: 25px;
            }


            .search-form-container .form-control {
                border-color: #ced4da;
                transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            .search-form-container .form-control:focus {
                border-color: #80bdff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            .search-form-container .btn-outline-primary {
                color: #007bff;
                border-color: #007bff;
                transition: all 0.2s ease-in-out;
            }

            .search-form-container .btn-outline-primary:hover {
                color: #fff;
                background-color: #007bff;
                border-color: #007bff;
                transform: translateY(-1px);
                box-shadow: 0 2px 5px rgba(0, 123, 255, 0.2);
            }
            .product-grid {
                display: grid;

                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 25px;
                margin-top: 30px;
                padding: 0 15px;
            }
            .container.product-display {
                max-width: 1200px;
                margin: 30px auto;
                padding: 0 15px;
            }
            .product-card {

                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
                
                background-color: #FF9CF5;
                border: 1px solid #e0b7ff;
                border-radius: 12px;
                padding: 15px 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                justify-content: space-between;
            }

            /* Các thành phần bên trong */
            .product-card img {
                width: 100%;
                max-width: 120px;
                height: auto;
                border-radius: 8px;
                margin-bottom: 15px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .product-title {

                min-height: 2.6rem;
                font-family: 'Zen Maru Gothic', sans-serif;
                font-weight: bold;
                font-size: 1.1rem;
                color: #5F4C5B;
                margin: 0;
                line-height: 1.3;
            }

            .product-author {

                margin-top: auto;
                font-family: 'Zen Maru Gothic', sans-serif;
                font-size: 0.8rem;
                color: #6890FE;
                margin: 5px 0 0;
            </style>
        </head>
        <body>

            <jsp:include page="header.jsp"/> 
            <div class="row justify-content-center mb-4">

                <div class="col-md-6 search-form-container"> 
                    <form id="search-form" class="form-inline d-flex justify-content-center" action="MainController" method="get">
                        <input id="search-input" class="form-control mr-sm-2 w-75" type="search" name="keyword" placeholder="Search books..." 
                               value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>">
                        <button class="btn btn-outline-primary my-2 my-sm-0" type="submit" name="action" value="Search">Search</button>
                    </form>
                </div>
            </div>
            <div class="container product-display">
                <div id="searchResults"></div>
            </div>
            <%
                User user = (User) session.getAttribute("user");
                String avatarPath;
                if (user != null && user.getAvatar() != null) {
                    String avatarUrl = user.getAvatar();
        
                    if (avatarUrl.startsWith("http://") || avatarUrl.startsWith("https://")) {
                        avatarPath = avatarUrl;
                    } else {
            
                        avatarPath = "/my_webapp_uploads/" + avatarUrl;
                    }
                } else {
                    avatarPath = "uploads/defaultava.jpg";
                }
            %>

            <div class="avatar-menu">
                <%
                if (user != null && user.getName() != null) {
                    out.print("<div class='welcome-text'>");
                    out.print("<h4 class='user-name'>こんにちは: " + user.getName() +"</h4>");
                    out.print("<h5 class='okaeri'>お帰りなさい!!お疲れ様でした。</h5>");
                    out.print("</div>");
                }else{
                    out.print("<h4 class='user-name'>Login Here!"+ "👉"+ "</h4>");
                    }
                %>
                <img src="<%= avatarPath %>" alt="Avatar" class="avatar-img" id="avatarBtn">
                <div class="dropdown-menu" id="dropdownMenu">
                    <a href="Login.jsp"> ⛩  Sign In️</a>
                    <%
                        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
                    %>
                    <a href="AdminDashboard.jsp">👤 Admin Dashboard</a>
                    <%
                        } else {
                    %>
                    <a href="UserDashboard.jsp">👤 My Account</a>
                    <%
                        }
                    %>

                    <a href="LogoutController" id="logoutBtn">🔓 Logout</a>
                </div>
            </div>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const avatarBtn = document.getElementById("avatarBtn");
                    const dropdownMenu = document.getElementById("dropdownMenu");
                    const logoutBtn = document.getElementById("logoutBtn");


                    // Toggle menu
                    avatarBtn.addEventListener("click", function () {
                        dropdownMenu.style.display = (dropdownMenu.style.display === "block") ? "none" : "block";
                    });

                    // Click outside to close
                    document.addEventListener("click", function (e) {
                        if (!e.target.closest(".avatar-menu")) {
                            dropdownMenu.style.display = "none";
                        }
                    });

                    // Xác nhận logout
                    logoutBtn.addEventListener("click", function (e) {
                        e.preventDefault();
                        const confirmLogout = confirm("Bạn có chắc chắn muốn đăng xuất?");
                        if (confirmLogout) {
                            window.location.href = "LogoutController";
                        }
                    });

                    // ======= AJAX Search Functionality =========
                    const searchInput = document.getElementById("search-input");
                    const searchResultsDiv = document.getElementById("searchResults");
                    const searchButton = document.querySelector('button[name="action"][value="Search"]');
                    const searchForm = document.getElementById("search-form");
                    searchButton.style.display = "none";
                    searchInput.addEventListener("keydown", function (e) {
                        if (e.key === 'Enter') {
                            e.preventDefault();
                        }
                    });
                    let timer;

                    searchInput.addEventListener("keyup", function () {
                        clearTimeout(timer); 
                        const keyword = this.value;

                        timer = setTimeout(() => {
                            if (keyword.length > 0) {
                                fetch("SearchBookController?keyword=" + encodeURIComponent(keyword))
                                        .then(response => {
                                            if (!response.ok) {
                                                throw new Error('Network response was not ok');
                                            }
                                            return response.json();
                                        })
                                        .then(books => {
                                            let html = "";
                                            if (books.length > 0) {
                                                html += "<h3 class='text-center'>Books Available</h3>";
                                                html += '<div class="product-grid">'; 

                                                books.forEach(book => {
                                                    const bookUrl = 'bookDetails/bookDetails_' + book.id + '.jsp';
                                                    html += '<a href="' + bookUrl + '">';
                                                    html += '<div class="product-card">';
                                                    html += '   <p class="product-title">' + book.title + '</p>';
                                                    html += '   <p class="product-author">' + book.author + '</p>';
                                                    html += '</div>';
                                                });

                                                html += '</div>';
                                            } else {
                                                html = "<p class='text-center'>Không tìm thấy sách nào với từ khóa: '" + keyword + "'</p>";
                                            }
                                            searchResultsDiv.innerHTML = html;
                                        })
                                        .catch(error => {
                                            console.error("Lỗi khi tải dữ liệu:", error);
                                            searchResultsDiv.innerHTML = "<p>Đã xảy ra lỗi khi tìm kiếm.</p>";
                                        });
                            } else {
                                // Xóa kết quả nếu ô tìm kiếm trống
                                searchResultsDiv.innerHTML = "";
                            }
                        }, 300); // Đợi 300ms sau khi người dùng ngừng gõ
                    });
                });
            </script>
            <jsp:include page="productIndex.jsp"/> 
            <jsp:include page="footerIndex.jsp"/> 
        </body>
    </html>
