<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết sách: Sherlock Holmes - Tập 3</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <style>
        body { background-color: #f4f4f4; color: #333; }
        .container { padding-top: 50px; padding-bottom: 50px; }
        .book-goodreads-container { background-color: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); padding: 30px; }
        .book-cover-img { width: 100%; height: auto; border-radius: 4px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); }
        .book-title { font-size: 2.5em; font-weight: bold; color: #333; margin-bottom: 5px; }
        .book-author { font-size: 1.5em; color: #ff69b4; margin-bottom: 15px; }
        .rating-summary { font-size: 1.1em; margin-bottom: 20px; }
        .rating-summary .fa-star { color: orange; }
        .rating-count, .review-count { color: #666; margin-left: 10px; }
        .btn-pink { background-color: #ff69b4; border-color: #ff69b4; color: white; }
        .btn-pink:hover { background-color: #e05cb3; border-color: #e05cb3; }
        .section-title { font-size: 1.8em; color: #333; border-bottom: 2px solid #ff69b4; padding-bottom: 10px; margin-top: 30px; margin-bottom: 20px; }
        .book-description { line-height: 1.6; margin-bottom: 20px; }
        .book-details-list { list-style: none; padding: 0; }
        .book-details-list li { margin-bottom: 8px; font-size: 1.05em; }
        .book-details-list strong { color: #555; display: inline-block; width: 120px; }
        .progress { height: 20px; background-color: #e9ecef; border-radius: .25rem; }
        .progress-bar { background-color: #ff69b4; }
        .action-buttons { margin-top: 30px; }
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
                    <img src="<%= request.getContextPath() %>/uploads/sherlock3.webp" class="book-cover-img" alt="Sherlock Holmes Tập 3">
                </div>
                <div class="col-md-8">
                    <h1 class="book-title">Sherlock Holmes - Tuyển tập tập 3</h1>
                    <h3 class="book-author">của Arthur Conan Doyle</h3>
                    <div class="rating-summary">
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star-half-alt checked"></span>
                        <span>4.50 trung bình</span>
                        <span class="rating-count">(Hơn 200,000 lượt đánh giá)</span>
                        <span class="review-count"> - (Hơn 800 lượt bình luận)</span>
                    </div>
                    <div class="action-buttons">
                        <form action="<%= request.getContextPath() %>/MainController" method="post" style="display:inline-block; margin-right: 15px;">
                            <input type="hidden" name="action" value="addToCart">
                            <input type="hidden" name="bookId" value="35">
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
                        Đây là tập cuối cùng của series Sherlock Holmes, bao gồm tiểu thuyết **The Valley of Fear** (đã có trong tập 2 của một số phiên bản) cùng với các truyện ngắn từ **His Last Bow** và **The Case-Book of Sherlock Holmes**. Tập này khám phá các vụ án phức tạp và kỳ lạ nhất của Holmes, đồng thời hé lộ những bí ẩn cuối cùng trong sự nghiệp của thám tử lừng danh.
                    </p>
                    <h2 class="section-title">Thông tin chi tiết</h2>
                    <ul class="book-details-list">
                        <li><strong>ID sách:</strong> 35</li>
                        <li><strong>Thể loại:</strong> Trinh thám, Tiểu thuyết, Truyện ngắn</li>
                        <li><strong>Số trang:</strong> Khoảng 1200 (tùy phiên bản)</li>
                        <li><strong>Nhà xuất bản:</strong> Nhiều nhà xuất bản</li>
                        <li><strong>Ngày xuất bản:</strong> Tùy thuộc vào lần xuất bản</li>
                        <li><strong>ISBN:</strong> Tùy phiên bản</li>
                        <li>
                            <strong>Tình trạng có sẵn:</strong> 
                            <span class="text-info">60%</span> (60/100 bản)
                        </li>
                        <li>
                            <div class="progress" style="height: 20px;">
                                <div class="progress-bar" role="progressbar" style="width: 60%;" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
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