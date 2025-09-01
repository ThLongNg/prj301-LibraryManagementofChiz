<%-- 
    Document   : bookDetails_38
    Created on : Aug 31, 2025, 11:46:52 PM
    Author     : MyPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết sách: Khu vườn bí mật - Frances Hodgson Burnett</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f4;
            color: #333;
        }
        .container {
            padding-top: 50px;
            padding-bottom: 50px;
        }
        .book-goodreads-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .book-cover-img {
            width: 100%;
            height: auto;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .book-title {
            font-size: 2.5em;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .book-author {
            font-size: 1.5em;
            color: #ff69b4;
            margin-bottom: 15px;
        }
        .rating-summary {
            font-size: 1.1em;
            margin-bottom: 20px;
        }
        .rating-summary .fa-star {
            color: orange;
        }
        .rating-count, .review-count {
            color: #666;
            margin-left: 10px;
        }
        .btn-pink {
            background-color: #ff69b4;
            border-color: #ff69b4;
            color: white;
        }
        .btn-pink:hover {
            background-color: #e05cb3;
            border-color: #e05cb3;
        }
        .section-title {
            font-size: 1.8em;
            color: #333;
            border-bottom: 2px solid #ff69b4;
            padding-bottom: 10px;
            margin-top: 30px;
            margin-bottom: 20px;
        }
        .book-description {
            line-height: 1.6;
            margin-bottom: 20px;
        }
        .book-details-list {
            list-style: none;
            padding: 0;
        }
        .book-details-list li {
            margin-bottom: 8px;
            font-size: 1.05em;
        }
        .book-details-list strong {
            color: #555;
            display: inline-block;
            width: 120px;
        }
        .progress {
            height: 20px;
            background-color: #e9ecef;
            border-radius: .25rem;
        }
        .progress-bar {
            background-color: #ff69b4;
        }
        .action-buttons {
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="book-goodreads-container">
            <div class="row">
                <div class="col-md-4 text-center">
                    <img src="<%= request.getContextPath() %>/uploads/the_secret_garden.jpg" class="book-cover-img" alt="The Secret Garden">
                </div>

                <div class="col-md-8">
                    <h1 class="book-title">The Secret Garden</h1>
                    <h3 class="book-author">của Frances Hodgson Burnett</h3>

                    <div class="rating-summary">
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star" style="color:#e0e0e0;"></span> <span>4.18 trung bình</span>
                        <span class="rating-count">(3.234.123 lượt đánh giá)</span>
                        <span class="review-count"> - (87.654 lượt bình luận)</span>
                    </div>

                    <div class="action-buttons">
                        <form action="<%= request.getContextPath() %>/MainController" method="post" style="display:inline-block; margin-right: 15px;">
                            <input type="hidden" name="action" value="addToCart">
                            <input type="hidden" name="bookId" value="38">
                            <button type="submit" class="btn btn-pink btn-lg">
                                <i class="fas fa-shopping-cart"></i> Mượn sách
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <hr class="my-4">

            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">Mô tả</h2>
                    <p class="book-description">
                        "Khu vườn bí mật" là một tiểu thuyết thiếu nhi kinh điển của tác giả Frances Hodgson Burnett. Câu chuyện kể về cô bé mồ côi Mary Lennox, người đã được gửi đến Anh để sống cùng chú của mình tại một trang viên rộng lớn, u ám và đầy bí ẩn. Tại đây, Mary phát hiện ra một khu vườn bị khóa kín và lãng quên. Cùng với Dickon, một cậu bé hòa đồng, và Colin, người anh họ ốm yếu, cô đã cùng nhau hồi sinh khu vườn. Quá trình hồi sinh khu vườn cũng chính là quá trình các nhân vật chữa lành tâm hồn và tìm thấy niềm vui, hy vọng trong cuộc sống.
                    </p>

                    <h2 class="section-title">Thông tin chi tiết</h2>
                    <ul class="book-details-list">
                        <li><strong>ID sách:</strong> 30</li>
                        <li><strong>Thể loại:</strong> Tiểu thuyết, Thiếu nhi, Lãng mạn</li>
                        <li><strong>Số trang:</strong> 368</li>
                        <li><strong>Nhà xuất bản:</strong> HarperCollins</li>
                        <li><strong>Ngày xuất bản:</strong> 1911</li>
                        <li><strong>ISBN:</strong> 978-0064401884</li>
                        <li>
                            <strong>Tình trạng có sẵn:</strong> 
                            <span class="text-success">50%</span> (50 / 100 bản)
                        </li>
                        <li>
                            <div class="progress" style="height: 20px;">
                                <div class="progress-bar" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <hr class="my-4">

            <div class="text-center mt-4">
                <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-secondary btn-lg">Quay lại trang chủ</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>