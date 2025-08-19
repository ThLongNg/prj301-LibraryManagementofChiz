<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết sách: Weathering With You - Shinkai Makoto</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
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
            color: #ff69b4; /* Pink accent */
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
            border-bottom: 2px solid #ff69b4; /* Pink accent */
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
            width: 120px; /* Align labels */
        }
        .progress {
            height: 20px;
            background-color: #e9ecef;
            border-radius: .25rem;
        }
        .progress-bar {
            background-color: #ff69b4; /* Pink accent */
        }
        .action-buttons {
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <%-- Display Messages --%>
    <%
        String successMessage = (String) request.getAttribute("SUCCESS_MESSAGE");
        String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
        if (successMessage != null) {
    %>
        <div class="alert alert-success text-center mt-3" role="alert">
            <%= successMessage %>
        </div>
    <%
        }
        if (errorMessage != null) {
    %>
        <div class="alert alert-danger text-center mt-3" role="alert">
            <%= errorMessage %>
        </div>
    <%
        }
    %>

    <div class="container">
        <div class="book-goodreads-container">
            <div class="row">
                <div class="col-md-4 text-center">
                    <img src="<%= request.getContextPath() %>/uploads/WeatheringWithYou.webp" class="book-cover-img" alt="Weathering With You">
                </div>

                <div class="col-md-8">
                    <h1 class="book-title">Weathering With You (天気の子)</h1>
                    <h3 class="book-author">của Shinkai Makoto</h3>

                    <div class="rating-summary">
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star" style="color:#e0e0e0;"></span>
                        <span>4.00 trung bình</span>
                        <span class="rating-count">(Hơn 30,000 lượt đánh giá)</span>
                        <span class="review-count"> - (Hơn 1,000 lượt bình luận)</span>
                    </div>

                    <div class="action-buttons">
                        <form action="<%= request.getContextPath() %>/MainController" method="post" style="display:inline-block; margin-right: 15px;">
                            <input type="hidden" name="action" value="addToCart">
                            <input type="hidden" name="bookId" value="32">
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
                        Khao khát thoát khỏi ngôi nhà trên đảo của mình, một cậu bé tên là Hodaka chạy trốn trong mùa hè đầu tiên của trường trung học để tìm một cuộc sống mới ở Tokyo. Khi mưa rơi trong nhiều ngày liên tục và Hodaka phải vật lộn để thích nghi, anh gặp một cô gái tên là Hina, người nắm giữ một sức mạnh bí ẩn: Chỉ với một lời cầu nguyện, cô ấy có thể chia cắt những đám mây và mang mặt trời trở lại. Nhưng sức mạnh của cô ấy phải trả giá, và khi thời tiết ngày càng vượt khỏi tầm kiểm soát, họ phải chọn tương lai mà họ thực sự muốn cho mình.
                        <br><br>
                        Được viết đồng thời với việc sản xuất bộ phim "Weathering With You" năm 2019, cuốn tiểu thuyết này đến trực tiếp từ đạo diễn Makoto Shinkai, tâm trí đằng sau hit "your name" năm 2016!
                    </p>

                    <h2 class="section-title">Thông tin chi tiết</h2>
                    <ul class="book-details-list">
                        <li><strong>ID sách:</strong> 32</li>
                        <li><strong>Thể loại:</strong> Tiểu thuyết, Giả tưởng, Lãng mạn</li>
                        <li><strong>Số trang:</strong> 256</li>
                        <li><strong>Nhà xuất bản:</strong> IPM</li>
                        <li><strong>Ngày xuất bản:</strong> 2019</li>
                        <li><strong>ISBN:</strong> 978-604-972-736-1</li>
                        <li>
                            <strong>Tình trạng có sẵn:</strong> 
                            <span class="text-info">40%</span> (40/100 bản)
                        </li>
                        <li>
                            <div class="progress" style="height: 20px;">
                                <div class="progress-bar" role="progressbar" style="width: 40%;" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
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