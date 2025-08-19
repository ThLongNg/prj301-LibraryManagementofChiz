<%-- 
    Document   : Login
    Created on : May 31, 2025, 3:47:44 PM
    Author     : user
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login</title>
   <style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  background: linear-gradient(to right, #fce4ec, #f8bbd0);
  font-family: 'Poppins', sans-serif;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
}

.login-container {
  background-color: #fffafa;
  padding: 2rem 3rem;
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(255, 182, 193, 0.3);
  width: 100%;
  max-width: 400px;
  text-align: center;
  border: 2px dashed #f7c6d9;
}

.login-container h2 {
  margin-bottom: 1.5rem;
  color: #e91e63;
}

.form-group {
  text-align: left;
  margin-bottom: 1.2rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.4rem;
  font-weight: 500;
  color: #e91e63;
}

.form-group input[type="text"],
.form-group input[type="password"] {
  width: 100%;
  padding: 0.7rem;
  border: 1px solid #f8bbd0;
  border-radius: 8px;
  background-color: #fff0f5;
  font-size: 1rem;
  transition: 0.3s;
}

.form-group input:focus {
  border-color: #f06292;
  outline: none;
  background-color: #fff;
}

.btn {
  width: 100%;
  padding: 0.8rem;
  background-color: #f06292;
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-top: 1rem;
}

.btn:hover {
  background-color: #ec407a;
}
.login-container h3{

  color: #bfbfbf;
}
.signup-link {
  margin-top: 1rem;
  font-size: 0.9rem;
  color: #e91e63;
}

.signup-link a {
  color: #d81b60;
  text-decoration: none;
  font-weight: bold;
}

.signup-link a:hover {
  text-decoration: underline;
}

    .snowflake {
  position: fixed;
  top: -50px;
  pointer-events: none;
  z-index: -2;
  animation: fallAndSpin linear infinite;
}
.google{
  width: 100%;
  padding: 0.8rem;
  background-color: #28a745;
  color: wheat;
  border: none;
  border-radius: 10px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-top: 1rem;
}
.google:hover{
    background-color: #adbfff;
    color:red;
    
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
  <div class="login-container">
    <h3>Welcome to My Library️</h3>
    <h2>Sign In </h2>
    <form action="LoginController" method="post">
      <div class="form-group">
        <label for="username">Username or Email</label>
        <input type="text" id="username" name="loginInfo" placeholder="Enter your waifu name or her email..." required>
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Your secret..." required>
      </div>

      <button type="submit" class="btn"> Log In </button>
      <p class="signup-link">Don’t have an account? <a href="signup.jsp">Sign up here</a></p>
    </form>
        <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/demoJDBC/Auth/loginGoogleHandler&response_type=code&client_id=726122654661-6177q2sm525sghfq1s04sqamih2dan04.apps.googleusercontent.com&approval_prompt=force&access_type=offline" class="google-btn">
            <button class="google" style="width: 90%; padding: 10px;">Đăng nhập với Google</button>
        </a>
  </div>
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

