<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết sách: Đông Cung - Phỉ Ngã Tư Tồn</title>
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

    <div class="container">
        <div class="book-goodreads-container">
            <div class="row">
                <div class="col-md-4 text-center">
                    <img src="<%= request.getContextPath() %>/uploads/dongcung.webp" class="book-cover-img" alt="Đông Cung (Bộ 2 Tập)">
                </div>

                <div class="col-md-8">
                    <h1 class="book-title">Đông Cung (Bộ 2 Tập)</h1>
                    <h3 class="book-author">của Phỉ Ngã Tư Tồn</h3>

                    <div class="rating-summary">
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star" style="color:#e0e0e0;"></span> <span>4.14 trung bình</span>
                        <span class="rating-count">(33,397 lượt đánh giá)</span>
                        <span class="review-count"> - (1,396 lượt bình luận)</span>
                    </div>

                    <div class="action-buttons">
 <form action="<%= request.getContextPath() %>/MainController" method="post" style="display:inline-block; margin-right: 15px;">
    <input type="hidden" name="action" value="addToCart">
    <input type="hidden" name="bookId" value="29">
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
                        "Đông Cung" là một tiểu thuyết ngôn tình nổi tiếng của nhà văn Phỉ Ngã Tư Tồn, kể về câu chuyện tình yêu đầy bi kịch và đau khổ giữa công chúa Tiểu Phong của Tây Lương và thái tử Lý Thừa Ngân của Trung Nguyên. Truyện bắt đầu với cuộc hôn nhân chính trị, nơi cả hai đều mang trong mình những bí mật, thù hận và mục đích riêng. Tình yêu nảy nở giữa họ nhưng lại bị vùi dập bởi âm mưu, quyền lực và những hiểu lầm chồng chất. Cuộc đời Tiểu Phong là một chuỗi bi kịch từ khi nàng đặt chân vào Đông Cung, đánh đổi mọi thứ để yêu và để rồi nhận lấy sự đau đớn tột cùng. Cuốn sách khắc họa sâu sắc những cung bậc cảm xúc từ ngọt ngào, lãng mạn đến tuyệt vọng, đau thương, để lại ấn tượng sâu sắc trong lòng độc giả về một tình yêu không thể có hậu.
                    </p>

                    <h2 class="section-title">Thông tin chi tiết</h2>
                    <ul class="book-details-list">
                        <li><strong>ID sách:</strong> 29</li>
                        <li><strong>Thể loại:</strong> Ngôn tình, Cổ trang, Bi kịch</li>
                        <li><strong>Số trang:</strong> 848 (cho bộ 2 tập)</li>
                        <li><strong>Nhà xuất bản:</strong> Văn Học</li>
                        <li><strong>Ngày xuất bản:</strong> 2017</li>
                        <li><strong>ISBN:</strong> 978-604-928-063-1</li>
                        <li>
                            <strong>Tình trạng có sẵn:</strong> 
                            <span class="text-success">50%</span> (50/100 bản)
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
                <a href="/demoJDBC/index.jsp" class="btn btn-secondary btn-lg">Quay lại trang chủ</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>