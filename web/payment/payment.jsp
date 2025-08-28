<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán mượn sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://js.stripe.com/v3/"></script>
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .payment-container {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 3rem;
        }
        .card-header {
            background-color: transparent;
            border-bottom: none;
            padding: 0;
        }
        .accordion-button {
            font-weight: 600;
            color: #333;
            background-color: #f8f9fa;
            border-radius: 10px !important;
            transition: all 0.3s ease;
            box-shadow: none !important;
        }
        .accordion-button:not(.collapsed) {
            color: #fff;
            background-color: #007bff;
            border-bottom-left-radius: 0 !important;
            border-bottom-right-radius: 0 !important;
        }
        .accordion-button .d-flex span {
            flex-grow: 1;
        }
        .accordion-body {
            background-color: #fafafa;
            border: 1px solid #e9ecef;
            border-top: none;
            border-radius: 0 0 10px 10px;
            padding: 1.5rem;
        }
        .summary-card {
            background: #fff;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        .summary-card h5 {
            font-weight: 600;
            color: #343a40;
            margin-bottom: 1.5rem;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 1rem;
            color: #555;
        }
        .summary-item .label {
            font-weight: 500;
        }
        .summary-item .value {
            font-weight: 600;
            color: #000;
        }
        .summary-total {
            border-top: 1px dashed #ced4da;
            padding-top: 1rem;
            margin-top: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .summary-total .label {
            font-weight: 600;
            font-size: 1.2rem;
            color: #000;
        }
        .summary-total .value {
            font-weight: bold;
            font-size: 1.2rem;
            color: #007bff;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            font-weight: 600;
            transition: background-color 0.3s ease, transform 0.2s ease;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            transform: translateY(-2px);
        }
        .stripe-powered {
            font-size: 0.8rem;
            color: #777;
            margin-top: 1.5rem;
            text-align: center;
        }
        #card-element {
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            background-color: #f8f9fa;
        }
        .alert {
            margin-top: 1rem;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<div class="container payment-container">
    <div class="row g-5">
        <div class="col-lg-7">
            <h4 class="mb-4">Phương thức thanh toán</h4>
            <div class="accordion" id="paymentAccordion">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="paypalHeading">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapsePaypal" aria-expanded="false" aria-controls="collapsePaypal">
                            <span class="me-auto">PayPal</span>
                            <img src="https://i.imgur.com/7kQEsHU.png" width="30" alt="PayPal Icon">
                        </button>
                    </h2>
                    <div id="collapsePaypal" class="accordion-collapse collapse" aria-labelledby="paypalHeading" data-bs-parent="#paymentAccordion">
                        <div class="accordion-body">
                            <p class="text-muted">Tích hợp thanh toán PayPal sẽ được thực hiện sau. Vui lòng sử dụng thẻ tín dụng.</p>
                        </div>
                    </div>
                </div>

                <div class="accordion-item mt-3">
                    <h2 class="accordion-header" id="cardHeading">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCard" aria-expanded="true" aria-controls="collapseCard">
                            <span class="me-auto">Thẻ tín dụng / Ghi nợ</span>
                            <div class="icons">
                                <img src="https://i.imgur.com/2ISgYja.png" width="30" alt="Visa">
                                <img src="https://i.imgur.com/W1vtnOV.png" width="30" alt="Mastercard">
                                <img src="https://i.imgur.com/35tC99g.png" width="30" alt="Amex">
                                <img src="https://i.imgur.com/2ISgYja.png" width="30" alt="Discover">
                            </div>
                        </button>
                    </h2>
                    <div id="collapseCard" class="accordion-collapse collapse show" aria-labelledby="cardHeading" data-bs-parent="#paymentAccordion">
                        <div class="accordion-body">
                            <form id="payment-form" action="PaymentController" method="post">
                                <div class="mb-3">
                                    <label for="card-element" class="form-label">Thông tin thẻ tín dụng/Visa</label>
                                    <div id="card-element"></div>
                                    <div id="card-errors" role="alert" class="alert alert-danger" style="display: none;"></div>
                                </div>
                                <input type="hidden" id="ids" name="ids" value="<c:out value="${ids}"/>">
                                <input type="hidden" id="amount-hidden" name="amount" value="${totalAmount}">
                                <button class="btn btn-primary w-100" id="submit-button">Thanh toán</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="summary-card">
                <h5>Tóm tắt đơn hàng</h5>
                <div class="summary-item">
                    <span class="label">Số lượng sách</span>
                    <span class="value"><c:out value="${totalBooks}"/></span>
                </div>
                <div class="summary-total">
                    <span class="label">Tổng tiền</span>
                    <span class="value">
                        <fmt:formatNumber value="${totalAmount}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                    </span>
                </div>
                <div class="stripe-powered">
                    <small>Giao dịch của bạn được bảo mật bởi Stripe.</small>
                                    </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    var stripe = Stripe('pk_test_51S0xg5HmOs8sEpKXxrvCbvhjtR4A3NW5rRCvmQGUO9IwndHy9aWbGnawtqKxMnDmU3Zljeit1xLu9sf2g32d9OHN00nF053Iam');
    var elements = stripe.elements();
    var card = elements.create('card', {
        style: {
            base: {
                fontSize: '16px',
                color: '#495057',
                '::placeholder': {
                    color: '#a0a0a0',
                },
            },
        },
    });
    card.mount('#card-element');

    card.addEventListener('change', function(event) {
        var displayError = document.getElementById('card-errors');
        if (event.error) {
            displayError.textContent = event.error.message;
            displayError.style.display = 'block';
        } else {
            displayError.style.display = 'none';
        }
    });

    var form = document.getElementById('payment-form');
    var submitButton = document.getElementById('submit-button');

    submitButton.addEventListener('click', function(event) {
        event.preventDefault();
        stripe.createToken(card).then(function(result) {
            if (result.error) {
                var errorElement = document.getElementById('card-errors');
                errorElement.textContent = result.error.message;
                errorElement.style.display = 'block';
            } else {
                var tokenInput = document.createElement('input');
                tokenInput.setAttribute('type', 'hidden');
                tokenInput.setAttribute('name', 'stripeToken');
                tokenInput.setAttribute('value', result.token.id);
                form.appendChild(tokenInput);
                form.submit();
            }
        });
    });
</script>
</body>
</html>