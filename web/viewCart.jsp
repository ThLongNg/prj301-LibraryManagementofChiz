<%-- 
    Document   : viewcart
    Created on : Jun 11, 2025, 4:03:39 PM
    Author     : user
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="java.util.ArrayList, dto.Book" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
           <link href="css/style.css" rel="stylesheet">
    <style>
body {
    font-family: 'Quicksand', sans-serif;
    background: linear-gradient(135deg, #f8e1f4, #e3d5ff);
    margin: 0;
    padding: 20px;
    color: #4a3f72;
}

/* Container chính */
.container {
    max-width: 900px;
    margin: auto;
    background: rgba(255, 255, 255, 0.85);
    padding: 25px 30px;
    border-radius: 20px;
    box-shadow: 0 8px 20px rgba(192, 132, 252, 0.3);
}

/* Tiêu đề */
h1 {
    text-align: center;
    color: #6a4c93;
    margin-bottom: 25px;
    font-size: 1.8rem;
}

/* Bảng */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

th, td {
    padding: 14px 12px;
    text-align: center;
}

th {
    background: linear-gradient(90deg, #c084fc, #f9a8d4);
    color: white;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #fdf5ff;
}

tr:hover {
    background-color: #fce7f3;
}

/* Nút Remove */
td a {
    color: #fff;
    background: linear-gradient(90deg, #f9a8d4, #c084fc);
    padding: 8px 14px;
    border-radius: 20px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

td a:hover {
    background: linear-gradient(90deg, #c084fc, #f9a8d4);
    transform: translateY(-2px);
}

/* Nút Home */
.Home {
    display: inline-block;
    margin-bottom: 20px;
    text-decoration: none;
    color: white;
    background: linear-gradient(90deg, #c084fc, #f9a8d4);
    padding: 10px 18px;
    border-radius: 20px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 3px 6px rgba(0,0,0,0.15);
}

.Home:hover {
    background: linear-gradient(90deg, #f9a8d4, #c084fc);
    transform: translateY(-3px);
}

/* Form submit */
input[type="submit"] {
    background: linear-gradient(90deg, #c084fc, #f9a8d4);
    color: white;
    border: none;
    padding: 12px 25px;
    font-size: 16px;
    margin-top: 15px;
    cursor: pointer;
    border-radius: 25px;
    font-weight: 600;
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    transition: all 0.3s ease;
}

input[type="submit"]:hover {
    background: linear-gradient(90deg, #f9a8d4, #c084fc);
    transform: translateY(-3px);
}

/* Thông báo */
.message {
    padding: 10px;
    border-radius: 10px;
    margin-bottom: 15px;
    text-align: center;
    font-weight: 500;
}

.success-message {
    background-color: #e0ffe7;
    color: #256d3d;
    border: 1px solid #9de7b7;
}

.error-message {
    background-color: #ffe0e0;
    color: #721c24;
    border: 1px solid #f5a6a6;
}

/* Giỏ hàng trống */
.empty-cart-message {
    text-align: center;
    font-size: 1.2em;
    color: #777;
    margin-top: 50px;
}

    </style>
    </head>
    <body>
        <a class="Home" href='index.jsp'>Home Page</a>
        <%
           ArrayList<Book> list=(ArrayList)session.getAttribute("CART");
           String message = (String) request.getAttribute("MESSAGE");
           if (message != null && !message.isEmpty()) {
               out.print("<p style='color: green;'>" + message + "</p>");
           }
           String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
           if (errorMessage != null && !errorMessage.isEmpty()) {
               out.print("<p style='color: red;'>" + errorMessage + "</p>");
           }
           if(list!=null && !list.isEmpty()){
        %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(Book b:list){
                %>
                <tr>
                    <td><%= b.getId() %></td>
                    <td><%= b.getTitle() %></td>
                    <td><%= b.getAuthor() %></td>
                    <td><a href="MainController?action=removeFromCart&bookId=<%= b.getId() %>">remove</a></td>
                </tr>
                <%
                    }
                %>          
            </tbody>
        </table>
           <form action="MainController" method="post">
                <input type="hidden" name="action" value="sendBorrowRequest"/>
                <input type="submit" value="submit borrow request"/>
           </form>        
        <%
           }
           else{
             out.print("<p>Giỏ hàng của bạn trống. Hãy quay trở lại trang chủ để chọn sách thêm vào giỏ hàng</p>");
           }
        %>
    </body>
</html>