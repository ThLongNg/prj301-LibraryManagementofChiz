<%-- 
    Document   : paymentError
    Created on : Aug 28, 2025, 1:09:01 PM
    Author     : MyPC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi thanh toán</title>
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
        .error-container {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 3rem 2rem;
            max-width: 500px;
            width: 100%;
        }
        .error-icon {
            color: #dc3545;
            font-size: 4rem;
            animation: shake 0.5s;
            animation-iteration-count: 1;
        }
        .error-title {
            color: #dc3545;
            font-weight: 700;
            margin-top: 1rem;
            margin-bottom: 0.5rem;
        }
        .error-message {
            color: #6c757d;
            font-size: 1.1rem;
            line-height: 1.6;
        }
        .error-details {
            text-align: left;
            margin-top: 2rem;
            padding: 1.5rem;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
        }
        .error-details h5 {
            color: #721c24;
            font-weight: 600;
        }
        .error-details ul {
            list-style-type: none;
            padding-left: 0;
            margin-bottom: 0;
        }
        .error-details li {
            margin-bottom: 0.5rem;
            color: #721c24;
        }
        .btn {
            border-radius: 8px;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            margin-top: 2rem;
            transition: transform 0.2s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
    </style>
</head>
<body>
<div class="error-container">
    <i class="fa-solid fa-circle-xmark error-icon"></i>
    <h1 class="error-title">Thanh toán thất bại!</h1>
    <p class="error-message">Đã xảy ra lỗi trong quá trình xử lý thanh toán của bạn. Vui lòng thử lại sau hoặc liên hệ bộ phận hỗ trợ.</p>
    
    <c:if test="${not empty ERROR_MESSAGES}">
        <div class="error-details">
            <h5>Chi tiết lỗi:</h5>
            <ul>
                <c:forEach var="error" items="${ERROR_MESSAGES}">
                    <li><i class="fa-solid fa-circle-exclamation me-2"></i><c:out value="${error}"/></li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <a href="index.jsp" class="btn btn-primary">Quay lại Trang Chủ</a>
</div>
</body>
</html>