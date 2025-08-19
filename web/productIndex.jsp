<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.Book" %>
<%@page import="java.util.List" %>
<%@page import="dao.BookDAO" %>
<%--
    Document   : productIndex
    Created on : Jul 23, 2025
    Author     : MyPC
--%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Product Index</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

<div class="container-fluid py-5">

    <%-- Display Messages --%>
    <%
        String successMessage = (String) request.getAttribute("SUCCESS_MESSAGE");
        String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
        if (successMessage != null) {
    %>
        <div class="alert alert-success text-center" role="alert">
            <%= successMessage %>
        </div>
    <%
        }
        if (errorMessage != null) {
    %>
        <div class="alert alert-danger text-center" role="alert">
            <%= errorMessage %>
        </div>
    <%
        }
    %>

    <div class="text-center mb-5">
        <h2 class="section-title px-5"><span class="px-2">Romcom Novel</span></h2>
    </div>

    <div class="row gx-4 gy-4 px-4 justify-content-center">
        <%-- Trong thực tế, bạn sẽ lấy dữ liệu sách từ Database và dùng vòng lặp --%>
        <%-- Hiện tại để đơn giản, tôi giữ nguyên cấu trúc cứng mà bạn đã cung cấp --%>

        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="card product-item border-0 h-100">
                <div class="card-header p-0 bg-transparent border overflow-hidden">
                    <img class="img-fluid w-100" src="uploads/dongcung.webp" alt="Đông Cung (Bộ 2 Tập)">
                </div>
                <div class="card-body text-center p-3">
                    <h6 class="text-truncate mb-2">Đông Cung (Bo 2 Tap)</h6>
                    <div class="mb-2">
                        <%-- Giả định tỷ lệ sách có sẵn, bạn có thể tính toán từ total_copies và available_copies --%>
                        Có sẵn: <span class="text-success">50%</span> 
                    </div>
                    <div class="progress mb-2">
                        <div class="progress-bar" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <div class="ratingbox mb-2">
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star"></span>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light px-2 py-2">
                    <a href="bookDetails/bookDetails_29.jsp" class="btn btn-sm btn-pink"><i class="fas fa-eye"></i> Xem</a>
                    <form action="MainController?action=addToCart" method="post">
                        <input type="hidden" name="bookId" value="29">
                        <button type="submit" class="btn btn-sm btn-pink">
                            <i class="fas fa-shopping-cart"></i> Mượn
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="card product-item border-0 h-100">
                <div class="card-header p-0 bg-transparent border overflow-hidden">
                    <img class="img-fluid w-100" src="uploads/kiminonawa.webp" alt="Kimi No Na Wa (君の名は)">
                </div>
                <div class="card-body text-center p-3">
                    <h6 class="text-truncate mb-2">Kimi No Na Wa (君の名は)</h6>
                    <div class="mb-2">
                        Có sẵn: <span class="text-success">25%</span>
                    </div>
                    <div class="progress mb-2">
                        <div class="progress-bar" role="progressbar" style="width: 25%;"></div>
                    </div>
                    <div class="ratingbox mb-2">
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light px-2 py-2">
                    <a href="bookDetails/bookDetails_30.jsp" class="btn btn-sm btn-pink"><i class="fas fa-eye"></i> Xem</a>
                    <form action="MainController?action=addToCart" method="post">
                        <input type="hidden" name="bookId" value="30">
                        <button type="submit" class="btn btn-sm btn-pink">
                            <i class="fas fa-shopping-cart"></i> Mượn
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="card product-item border-0 h-100">
                <div class="card-header p-0 bg-transparent border overflow-hidden">
                    <img class="img-fluid w-100" src="uploads/xinloieclcd.jpg" alt="Xin Loi Em Chi Là Con Đi">
                </div>
                <div class="card-body text-center p-3">
                    <h6 class="text-truncate mb-3">Xin Loi Em Chi Là Con Đi</h6>
                    <div class="mb-2">
                        Có sẵn: <span class="text-success">75%</span>
                    </div>
                    <div class="progress mb-2">
                        <div class="progress-bar" role="progressbar" style="width: 75%;"></div>
                    </div>
                    <div class="ratingbox mb-2">
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light px-2 py-2">
                    <a href="bookDetails/bookDetails_31.jsp" class="btn btn-sm btn-pink"><i class="fas fa-eye"></i> Xem</a>
                    <form action="MainController?action=addToCart" method="post">
                        <input type="hidden" name="bookId" value="31">
                        <button type="submit" class="btn btn-sm btn-pink">
                            <i class="fas fa-shopping-cart"></i> Mượn
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="card product-item border-0 h-100">
                <div class="card-header p-0 bg-transparent border overflow-hidden">
                    <img class="img-fluid w-100" src="uploads/WeatheringWithYou.webp" alt="Weathering With You (天気の子)">
                </div>
                <div class="card-body text-center p-3">
                    <h6 class="text-truncate mb-3">Weathering With You (天気の子)</h6>
                    <div class="mb-2">
                        Có sẵn: <span class="text-success">20%</span>
                    </div>
                    <div class="progress mb-2">
                        <div class="progress-bar" role="progressbar" style="width: 20%;"></div>
                    </div>
                    <div class="ratingbox mb-2">
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                        <span class="fa fa-star"></span>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light px-2 py-2">
                    <a href="bookDetails/bookDetails_32.jsp" class="btn btn-sm btn-pink"><i class="fas fa-eye"></i> Xem</a>
                    <form action="MainController?action=addToCart" method="post">
                        <input type="hidden" name="bookId" value="32">
                        <button type="submit" class="btn btn-sm btn-pink">
                            <i class="fas fa-shopping-cart"></i> Mượn
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="text-center mt-5 mb-4">
        <h2 class="section-title px-5"><span class="px-2">Sherlock Holmes Series</span></h2>
    </div>

    <div class="row gx-4 gy-4 px-4 justify-content-center">
        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="card product-item border-0 h-100">
                <div class="card-header p-0 bg-transparent border overflow-hidden">
                    <img class="img-fluid w-100" src="uploads/sherlock1.webp" alt="Sherlock Holmes - Chapter 1">
                </div>
                <div class="card-body text-center p-3">
                    <h6 class="text-truncate mb-2">Sherlock Holmes - Chapter 1</h6>
                    <div class="mb-2">
                        Có sẵn: <span class="text-success">80%</span>
                    </div>
                    <div class="progress mb-2">
                        <div class="progress-bar" role="progressbar" style="width: 80%;"></div>
                    </div>
                    <div class="ratingbox mb-2">
                        <span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light px-2 py-2">
                    <a href="#" class="btn btn-sm btn-pink"><i class="fas fa-eye"></i> Xem</a>
                    <form action="MainController?action=addToCart" method="post">
                        <input type="hidden" name="bookId" value="33">
                        <button type="submit" class="btn btn-sm btn-pink">
                            <i class="fas fa-shopping-cart"></i> Mượn
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="card product-item border-0 h-100">
                <div class="card-header p-0 bg-transparent border overflow-hidden">
                    <img class="img-fluid w-100" src="uploads/sherlock2.jpg" alt="Sherlock Holmes - Chapter 2">
                </div>
                <div class="card-body text-center p-3">
                    <h6 class="text-truncate mb-2">Sherlock Holmes - Chapter 2</h6>
                    <div class="mb-2">
                        Có sẵn: <span class="text-success">80%</span>
                    </div>
                    <div class="progress mb-2">
                        <div class="progress-bar" role="progressbar" style="width: 80%;"></div>
                    </div>
                    <div class="ratingbox mb-2">
                        <span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light px-2 py-2">
                    <a href="#" class="btn btn-sm btn-pink"><i class="fas fa-eye"></i> Xem</a>
                    <form action="MainController?action=addToCart" method="post">
                        <input type="hidden" name="bookId" value="34">
                        <button type="submit" class="btn btn-sm btn-pink">
                            <i class="fas fa-shopping-cart"></i> Mượn
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="card product-item border-0 h-100">
                <div class="card-header p-0 bg-transparent border overflow-hidden">
                    <img class="img-fluid w-100" src="uploads/sherlock3.webp" alt="Sherlock Holmes - Chapter 3">
                </div>
                <div class="card-body text-center p-3">
                    <h6 class="text-truncate mb-2">Sherlock Holmes - Chapter 3</h6>
                    <div class="mb-2">
                        Có sẵn: <span class="text-success">80%</span>
                    </div>
                    <div class="progress mb-2">
                        <div class="progress-bar" role="progressbar" style="width: 80%;"></div>
                    </div>
                    <div class="ratingbox mb-2">
                        <span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light px-2 py-2">
                    <a href="#" class="btn btn-sm btn-pink"><i class="fas fa-eye"></i> Xem</a>
                    <form action="MainController?action=addToCart" method="post">
                        <input type="hidden" name="bookId" value="35">
                        <button type="submit" class="btn btn-sm btn-pink">
                            <i class="fas fa-shopping-cart"></i> Mượn
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="card product-item border-0 h-100">
                <div class="card-header p-0 bg-transparent border overflow-hidden">
                    <img class="img-fluid w-100" src="uploads/shertb.webp" alt="Sherlock Holmes - Tron Bo 3 tap">
                </div>
                <div class="card-body text-center p-3">
                    <h6 class="text-truncate mb-2">Sherlock Holmes - Tron Bo 3 tap</h6>
                    <div class="mb-2">
                        Có sẵn: <span class="text-success">80%</span>
                    </div>
                    <div class="progress mb-2">
                        <div class="progress-bar" role="progressbar" style="width: 80%;"></div>
                    </div>
                    <div class="ratingbox mb-2">
                        <span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>
                        <span class="fa fa-star checked"></span>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between bg-light px-2 py-2">
                    <a href="#" class="btn btn-sm btn-pink"><i class="fas fa-eye"></i> Xem</a>
                    <form action="MainController?action=addToCart" method="post">
                        <input type="hidden" name="bookId" value="36">
                        <button type="submit" class="btn btn-sm btn-pink">
                            <i class="fas fa-shopping-cart"></i> Mượn
                        </button>
                    </form>
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