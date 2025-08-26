<%-- 
    Document   : footer
    Created on : Jul 23, 2025, 3:15:01 AM
    Author     : MyPC
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
/* Footer nền anime */
.footer-bg-img {
    background-image: url('uploads/SG.png');
    background-size: cover;
    background-position: center;
    position: relative;
    color: #fff;
    margin-top: 50px;
}

/* Lớp phủ màu pastel */
.footer-overlay {
    background-color: rgba(255, 235, 245, 0.88);
    backdrop-filter: blur(6px);
    padding: 40px 20px;
    color: #6d2e69;
}

/* Logo + brand */
.footer-logo {
    width: 100px;
    border-radius: 50%;
    margin-bottom: 15px;
}

/* Tiêu đề */
.footer-overlay h5,
.footer-overlay h6 {
    font-size: 1.6rem;
    font-weight: bold;
    margin-bottom: 15px;
}

/* Link */
.footer-link {
    color: #6d2e69;
    text-decoration: none;
    margin-bottom: 8px;
    display: inline-block;
    font-size: 1.3rem;
    transition: all 0.3s ease;
}

.footer-link:hover {
    color: #c94fcf;
    text-decoration: underline;
}

/* Icon mạng xã hội */
.social-icon {
    border: 2px solid #c38dbb;
    background-color: rgba(255, 255, 255, 0.6);
    color: #6d2e69;
    width: 42px;
    height: 42px;
    margin-right: 10px;
    display: inline-flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    transition: all 0.3s ease;
    font-size: 1.3rem;
}

.social-icon:hover {
    background-color: #fcd4eb;
    color: white;
    border-color: #d36bb0;
}

/* Dòng bản quyền */
.footer-bottom {
    font-size: 1.1rem;
    margin-top: 30px;
    color: #7b517b;
}
</style>

<footer class="footer-bg-img">
  <div class="footer-overlay">
    <div class="container">
      <div class="row text-center text-md-start align-items-start">

        <!-- Cột 1: Logo -->
        <div class="col-md-4 mb-4 text-center">
          <img src="uploads/logocas.jpg" alt="Logo" class="footer-logo">
          <h5>MyLibrary</h5>
          <p class="fst-italic">Wibu land of stories ✨</p>
        </div>

        <!-- Cột 2: Menu -->
        <div class="col-md-4 mb-4 text-center">
          <h6>Explore</h6>
          <a href="#" class="footer-link">Home</a><br>
          <a href="#" class="footer-link">Genres</a><br>
          <a href="#" class="footer-link">Top Book</a><br>
          <a href="#" class="footer-link">Contact</a>
        </div>

        <!-- Cột 3: Mạng xã hội -->
        <div class="col-md-4 mb-4 text-center">
          <h6>Follow us</h6>
          <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
          <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
          <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
          <a href="#" class="social-icon"><i class="fab fa-discord"></i></a>
        </div>

      </div>

      <div class="text-center footer-bottom">
        <small>© 2025 MyLibrary. All rights reserved 🌸</small>
      </div>
    </div>
  </div>
</footer>
