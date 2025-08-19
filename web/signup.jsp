<%-- 
    Document   : signup
    Created on : Jul 22, 2025, 9:54:36 PM
    Author     : MyPC
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Sign Up</title>
  
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
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

.signup-container {
  background-color: #fffafa;
  padding: 2rem 3rem;
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(255, 182, 193, 0.3);
  width: 100%;
  max-width: 420px;
  text-align: center;
  border: 2px dashed #f7c6d9;
}

.signup-container h2 {
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
.form-group input[type="email"],
.form-group input[type="password"],
.form-group input[type="file"] {
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
}

.btn:hover {
  background-color: #ec407a;
}
.signup-container p{
    color: #f06292;
}
  </style>
</head>
<body>
  <div class="signup-container">
    <h2>Sign Up</h2>
    <form action="RegisterController" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" placeholder="Your waifu name..." required>
      </div>

      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="you@example.com" required>
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Secret like Rem's love..." required>
      </div>

      <div class="form-group">
        <label for="avatar"> Avatar Upload</label>
        <input type="file" id="avatar" name="avatar" accept="image/*">
      </div>

      <button type="submit" class="btn">Sign Up Now</button>
    </form>
    <p class="signup-link">Already have an account? <a href="Login.jsp">Sign in here</a></p>
  </div>
</body>
</html>