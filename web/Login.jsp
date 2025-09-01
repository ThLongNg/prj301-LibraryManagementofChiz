<%-- 
    Document   : Login
    Created on : May 31, 2025, 3:47:44 PM
    Author     : user
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login</title>
  
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  
   <style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}


    .snowflake {
  position: fixed;
  top: -50px;
  pointer-events: none;
  z-index: -2;
  animation: fallAndSpin linear infinite;
}

@keyframes fallAndSpin {
  0% {
    transform: translate(0, -10px) rotate(0deg);
    opacity: 0.5;
  }
  25% {
    transform: translate(15px, 25vh) rotate(40deg);
  }
  50% {
    transform: translate(-15px, 50vh) rotate(0deg);
  }
  75% {
    transform: translate(15px, 75vh) rotate(-25deg);
  }
  100% {
    transform: translate(0, 100vh) rotate(0deg);
    opacity: 0.8;
  }
}

  </style>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
</head>
<body>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

  <div class="w-full max-w-sm bg-white p-8 rounded-lg shadow-xl transform transition-all duration-300 hover:scale-105">
    <h2 class="text-3xl font-bold text-center text-pink-500 mb-6">Chào mừng trở lại</h2>
    <p class="text-center text-gray-500 mb-6">Đăng nhập để tiếp tục khám phá thư viện.</p>

    <c:if test="${not empty requestScope.ERROR}">
        <div class="bg-red-100 border border-red-400 text-red-500 px-4 py-3 rounded relative mb-4" role="alert">
            <span class="block sm:inline">${requestScope.ERROR}</span>
        </div>
    </c:if>
    <c:if test="${not empty requestScope.SUCCESS_MESSAGE}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
            <span class="block sm:inline">${requestScope.SUCCESS_MESSAGE}</span>
        </div>
    </c:if>

    <form action="MainController" method="post" class="space-y-4">
      <div>
        <label for="loginInfo" class="block text-sm font-medium text-gray-700">Tên đăng nhập hoặc Email</label>
        <input type="text" id="loginInfo" name="loginInfo" placeholder="Nhập tên đăng nhập hoặc email của bạn" required
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-pink-500 focus:border-pink-500">
      </div>

      <div>
        <label for="password" class="block text-sm font-medium text-gray-700">Mật khẩu</label>
        <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-pink-500 focus:border-pink-500">
      </div>
      
      <button type="submit" name="action" value="Login"
              class="w-full py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-pink-500 hover:bg-pink-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-pink-500 transition-all duration-300">
        Đăng nhập
      </button>
    </form>
    
    <div class="mt-6 text-center">
      <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/demoJDBC/Auth/loginGoogleHandler&response_type=code&client_id=726122654661-6177q2sm525sghfq1s04sqamih2dan04.apps.googleusercontent.com&approval_prompt=force&access_type=offline"
         class="inline-flex items-center justify-center w-full py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition-all duration-300">
        <svg class="w-5 h-5 mr-2" viewBox="0 0 24 24" fill="currentColor">...</svg>
        Đăng nhập với Google
      </a>
    </div>

    <p class="mt-6 text-center text-sm text-gray-600">
      Chưa có tài khoản?
      <a href="signup.jsp" class="font-bold text-pink-500 hover:text-pink-600 hover:underline">
        Đăng ký tại đây
      </a>
    </p>
    <script>
function createSnowflake() {
  const snowflake = document.createElement("div");
  snowflake.classList.add("snowflake");
  snowflake.textContent = "🌸";
  snowflake.style.left = Math.random() * 100 + "vw";
  snowflake.style.fontSize = Math.random() * 30 + 10 + "px";
  snowflake.style.animationDuration = Math.random() * 8 + 5 + "s";
  snowflake.style.animationDelay = Math.random() * 5 + "s";
  snowflake.style.opacity = Math.random() * (0.7 - 0.4) + 0.4;
  document.body.appendChild(snowflake);
  setTimeout(() => snowflake.remove(), 15000);
}
setInterval(createSnowflake, 200);
</script>

</body>
</html>

