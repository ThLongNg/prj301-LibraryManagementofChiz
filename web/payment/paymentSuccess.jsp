<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thành công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .success-container {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 3rem 2rem;
            max-width: 500px;
            width: 100%;
        }
        .success-icon {
            color: #28a745;
            font-size: 4rem;
            animation: bounce 0.6s cubic-bezier(0.68, -0.55, 0.27, 1.55) forwards;
        }
        .success-title {
            color: #198754;
            font-weight: 700;
            margin-top: 1rem;
            margin-bottom: 0.5rem;
        }
        .success-message {
            color: #6c757d;
            font-size: 1.1rem;
            line-height: 1.6;
        }
        .countdown-text {
            margin-top: 2rem;
            color: #495057;
        }
        .countdown-timer {
            font-weight: bold;
            color: #0d6efd;
            font-size: 1.25rem;
        }
        .btn {
            border-radius: 8px;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            margin: 0 0.5rem;
            transition: transform 0.2s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        .btn-outline-secondary {
            border-color: #6c757d;
            color: #6c757d;
        }
        @keyframes bounce {
            0% { transform: scale(0); opacity: 0; }
            50% { transform: scale(1.2); opacity: 1; }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
<div class="success-container">
    <i class="fa-solid fa-circle-check success-icon"></i>
    <h1 class="success-title">Thanh toán thành công!</h1>
    <p class="success-message">Cảm ơn bạn đã thanh toán. Yêu cầu mượn sách của bạn đã được ghi nhận.</p>
    
    <c:if test="${not empty SUCCESS_MESSAGE}">
        <p class="text-success fw-bold mt-3">${SUCCESS_MESSAGE}</p>
    </c:if>

    <div class="countdown-text">
        <p>Tự động quay lại trang chủ sau <span id="countdown" class="countdown-timer">10</span> giây</p>
    </div>

    <div class="mt-4">
        <a href="index.jsp" class="btn btn-primary">Quay lại Trang Chủ</a>
        <a href="ManageBorrowRequestController?action=viewBorrowRequests" class="btn btn-outline-secondary">Xem Yêu Cầu Mượn</a>
    </div>
</div>

<script>
    let countdown = 10;
    const countdownElement = document.getElementById('countdown');

    const interval = setInterval(() => {
        countdown--;
        countdownElement.textContent = countdown;
        if (countdown <= 0) {
            clearInterval(interval);
            window.location.href = 'index.jsp';
        }
    }, 1000);
</script>
</body>
</html>