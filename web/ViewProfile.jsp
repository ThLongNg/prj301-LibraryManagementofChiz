<%-- 
    Document   : ViewProfile
    Created on : May 31, 2025, 4:25:14 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="dto.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Profile</title>
        <style>body {
                font-family: 'Segoe UI', 'Noto Sans JP', 'Comic Sans MS', cursive;
                margin: 0;
                padding: 40px 0;
                background-image: url('uploads/background.webp');
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
            }

            h1 {
                text-align: center;
                color: #e75480;
                font-weight: bold;
                font-size: 32px;
                text-shadow: 1px 1px #ffc0cb;
                margin-bottom: 30px;
            }

            form {
                max-width: 500px;
                margin: 0 auto;
                background-color: rgba(255, 240, 245, 0.9); /* pastel box */
                padding: 30px;
                border-radius: 20px;
                box-shadow: 0 0 15px rgba(255, 182, 193, 0.5);
                border: 2px dashed #f8b0c9;
            }

            form p {
                margin-bottom: 20px;
                font-weight: bold;
                color: #d63384;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px 15px;
                font-size: 16px;
                border: 1px solid #ffb6c1;
                border-radius: 10px;
                background-color: #fffafc;
                color: #6f1d4d;
                transition: all 0.3s;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                border-color: #e75480;
                outline: none;
                box-shadow: 0 0 5px #f8b0c9;
            }

            input[readonly] {
                background-color: #fceef5;
                color: #8b5d7a;
                font-style: italic;
            }

            input[type="submit"] {
                display: block;
                width: 100%;
                background: linear-gradient(145deg, #f8a5c2, #f78fb3);
                border: none;
                padding: 12px 0;
                color: white;
                font-weight: bold;
                font-size: 18px;
                border-radius: 15px;
                cursor: pointer;
                transition: 0.3s ease;
                box-shadow: 0 4px 10px rgba(248, 165, 194, 0.6);
            }

            input[type="submit"]:hover {
                background: linear-gradient(145deg, #f78fb3, #f8a5c2);
                transform: scale(1.02);
            }
            .avatar-container {
                text-align: center; /* Center the image and label */
                margin-bottom: 25px; /* Add some space below */
                padding: 15px;
                background-color: rgba(255, 250, 252, 0.7); /* Lighter pastel background */
                border-radius: 15px;
                border: 1px solid #ffdde2;
                box-shadow: 0 2px 8px rgba(255, 192, 203, 0.3);
            }

            .avatar-preview {
                width: 150px; /* Larger avatar */
                height: 150px;
                border-radius: 50%; /* Make it round */
                object-fit: cover; /* Ensure image covers the area without distortion */
                border: 3px solid #f8a5c2; /* Pink border */
                box-shadow: 0 0 10px rgba(248, 165, 194, 0.6); /* Soft pink shadow */
                margin-bottom: 15px;
                transition: transform 0.3s ease;
            }

            .avatar-preview:hover {
                transform: scale(1.05); /* Slight zoom on hover */
            }

            /* Hide the default file input */
            #newAvatar {
                display: none;
            }

            .file-input-label {
                display: inline-block; /* Make it behave like a button */
                background: linear-gradient(145deg, #ffd1dc, #ffc0cb); /* Lighter pink gradient */
                color: #fff;
                padding: 10px 20px;
                border-radius: 10px;
                cursor: pointer;
                font-weight: bold;
                font-size: 16px;
                transition: 0.3s ease;
                box-shadow: 0 3px 8px rgba(255, 215, 225, 0.5);
                border: 1px solid #ffb6c1; /* Matching border */
            }

            .file-input-label:hover {
                background: linear-gradient(145deg, #ffc0cb, #ffd1dc);
                transform: translateY(-2px); /* Slight lift on hover */
                box-shadow: 0 5px 12px rgba(255, 215, 225, 0.7);
            }
        </style>

    </head>
    <body>
        <jsp:include page="headerDetails.jsp"/> 
        <%
         if(session.getAttribute("user")==null){
                 response.sendRedirect("index.jsp");
             }
         else{
             User us=(User)session.getAttribute("user");
        %>   
        <h1>View Profile & Changer</h1>
        <form action="ChangeProfileController" method="post" enctype="multipart/form-data">
            <div class="avatar-container">
                <img id="avatarPreview" src="<%= (us.getAvatar() != null && (us.getAvatar().startsWith("http://") || us.getAvatar().startsWith("https://"))) ? us.getAvatar() : "/my_webapp_uploads/" + (us.getAvatar() != null && !us.getAvatar().isEmpty() ? us.getAvatar() : "default-avatar.png") %>" alt="User Avatar" class="avatar-preview">
                <br>
                <label for="newAvatar" class="file-input-label">Chọn ảnh đại diện mới</label>
                <input type="file" id="newAvatar" name="newAvatar" accept="image/*" onchange="previewImage(event);">
                <input type="hidden" name="currentAvatar" value="<%= us.getAvatar() != null ? us.getAvatar() : "default-avatar.png" %>">
            </div>
            <p>
                User Name:
                <input type="text" name="username" value="<%= us.getName() %>" required=""/>*
            </p>
            <p>
                Email:
                <input type="text" value="<%= us.getEmail() %>" readonly=""/>
                <span style="opacity: 0.5; font-size: 0.8em;">Sorry this attribute cannot change</span>
            </p> 
            <p>
                Password:
                <input type="password" name="password" value="<%= us.getPassword() %>" required=""/>*
            </p>
            <p>
                Role:
                <input type="text" value="<%= us.getRole() %>" readonly=""/>
                <span style="opacity: 0.5; font-size: 0.8em;">Sorry this attribute cannot change</span>
            </p>
            <p>
                Status:
                <input type="text" value="<%= us.getStatus() %>" readonly=""/>
                <span style="opacity: 0.5; font-size: 0.8em;">Sorry this attribute cannot change</span>
            </p>
            <p>
                <input type="submit" value="save" />
            </p>            
        </form>
                  <script>
            function previewImage(event) {
                var reader = new FileReader();
                reader.onload = function(){
                    var output = document.getElementById('avatarPreview');
                    output.src = reader.result;
                };
                reader.readAsDataURL(event.target.files[0]);
            }
        </script>

        <%} %>
    </body>
</html>
