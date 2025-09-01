<%-- 
    Document   : AddBook
    Created on : Aug 31, 2025, 11:35:22 PM
    Author     : MyPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm Sách Mới</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .container {
                max-width: 600px;
                margin-top: 50px;
            }
            .form-control {
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center mb-4">Thêm Sách Mới</h2>
            <form action="AddBookController" method="post">
                <div class="form-group">
                    <label for="title">Tên Sách:</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="author">Tác giả:</label>
                    <input type="text" class="form-control" id="author" name="author" required>
                </div>
                <div class="form-group">
                    <label for="isbn">Mã ISBN:</label>
                    <input type="text" class="form-control" id="isbn" name="isbn">
                </div>
                <div class="form-group">
                    <label for="category">Thể loại:</label>
                    <input type="text" class="form-control" id="category" name="category">
                </div>
                <div class="form-group">
                    <label for="published_year">Năm xuất bản:</label>
                    <input type="number" class="form-control" id="published_year" name="published_year">
                </div>
                <div class="form-group">
                    <label for="total_copies">Tổng số bản sao:</label>
                    <input type="number" class="form-control" id="total_copies" name="total_copies" required>
                </div>
                <div class="form-group">
                    <label for="available_copies">Số bản có sẵn:</label>
                    <input type="number" class="form-control" id="available_copies" name="available_copies" required>
                </div>
                <div class="form-group">
                    <label for="status">Trạng thái:</label>
                    <select class="form-control" id="status" name="status">
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Thêm Sách</button>
                    <a href="AdminDashboard.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
            </form>
        </div>
    </body>
</html>