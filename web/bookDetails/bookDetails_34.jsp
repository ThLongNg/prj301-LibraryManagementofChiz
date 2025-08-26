<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết sách: Kimi No Na Wa</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        .book-detail-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .book-detail-img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .book-detail-info h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .book-detail-info p {
            font-size: 1.1em;
            margin-bottom: 10px;
        }
        .ratingbox .fa-star.checked {
            color: orange;
        }
        .progress {
            height: 20px;
            background-color: #e9ecef;
            border-radius: .25rem;
        }
        .progress-bar {
            background-color: #ff69b4; /* Pink color */
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
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="book-detail-container">
            <div class="row">
                <div class="col-md-5 text-center">
                    <img src="uploads/kiminonawa.webp" class="book-detail-img" alt="Kimi No Na Wa (君の名は)">
                </div>
                <div class="col-md-7 book-detail-info">
                    <h2>Kimi No Na Wa (君の名は)</h2>
                    <p><strong>ID:</strong> 30</p>
                    <p><strong>Tác giả:</strong> Shinkai Makoto</p>
                    <p><strong>Thể loại:</strong> Romcom Novel</p>
                    <p><strong>Tổng số bản:</strong> 100</p>
                    <p><strong>Bản có sẵn:</strong> 25</p>
                    <p><strong>Có sẵn:</strong> <span class="text-success">25%</span></p>
                    <div class="progress mb-3" style="height: 20px;">
                        <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <p><strong>Đánh giá:</strong>
                        <span class="ratingbox">
                            <span class="fa fa-star checked"></span>
                            <span class="fa fa-star checked"></span>
                            <span class="fa fa-star checked"></span>
                            <span class="fa fa-star checked"></span>
                            <span class="fa fa-star checked"></span>
                        </span> (5/5)
                    </p>
                    <div class="mt-4">
                        <form action="MainController" method="post" style="display:inline-block; margin-right: 10px;">
                            <input type="hidden" name="action" value="addToCart">
                            <input type="hidden" name="bookId" value="30">
                            <button type="submit" class="btn btn-pink btn-lg">
                                <i class="fas fa-shopping-cart"></i> Mượn sách
                            </button>
                        </form>
                        <a href="index.jsp" class="btn btn-secondary btn-lg">Quay lại trang chủ</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>