<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - LibrarySystem</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { margin: 0; font-family: 'Segoe UI', Arial, sans-serif; background: #f4f8fb; }
        .header { background: #fff; padding: 20px 40px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 8px rgba(0,0,0,0.03); }
        .header .logo { font-size: 2rem; font-weight: bold; color: #1976d2; display: flex; align-items: center; }
        .header .logo i { margin-right: 10px; }
        .header nav a { margin: 0 18px; color: #222; text-decoration: none; font-weight: 500; }
        .header nav a.active, .header nav a:hover { color: #1976d2; text-decoration: underline; }
        .header .auth { display: flex; gap: 12px; }
        .header .auth a { padding: 8px 18px; border-radius: 5px; text-decoration: none; font-weight: 500; transition: background 0.2s; }
        .header .auth .login { color: #222; border: 1px solid #1976d2; background: #fff; }
        .header .auth .login:hover { background: #e3f0fa; }
        .header .auth .register { color: #fff; background: #1976d2; border: none; }
        .header .auth .register:hover { background: #125ea7; }
        .register-main { display: flex; min-height: 90vh; }
        .register-left { flex: 1.1; background: #7da1b7; color: #fff; display: flex; flex-direction: column; justify-content: center; align-items: flex-start; padding: 60px 48px; position: relative; }
        .register-left h1 { font-size: 2.2rem; font-weight: 700; margin-bottom: 18px; }
        .register-left p { font-size: 1.15rem; margin-bottom: 32px; }
        .register-left .feature-list { margin-top: 18px; }
        .register-left .feature-item { display: flex; align-items: center; gap: 10px; font-size: 1.05rem; margin-bottom: 10px; }
        .register-left .feature-item i { color: #ffd600; font-size: 1.1rem; }
        .register-left .img-placeholder { position: absolute; right: 40px; bottom: 40px; opacity: 0.12; font-size: 7rem; }
        .register-right { flex: 1.2; background: #fff; display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 48px 0; }
        .register-form-box { width: 100%; max-width: 420px; background: #fff; border-radius: 10px; box-shadow: 0 2px 12px rgba(0,0,0,0.04); padding: 36px 32px; }
        .register-form-box h2 { color: #1976d2; font-size: 1.5rem; font-weight: 700; margin-bottom: 8px; text-align: center; }
        .register-form-box p { color: #666; font-size: 1rem; margin-bottom: 18px; text-align: center; }
        .register-form-box form {
            margin-top: 18px;
        }
        .register-form .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 18px;
        }
        .register-form label {
            font-size: 1.01rem;
            color: #1976d2;
            font-weight: 500;
            margin-bottom: 6px;
            letter-spacing: 0.01em;
        }
        .register-form input[type="text"],
        .register-form input[type="email"],
        .register-form input[type="password"],
        .register-form select {
            padding: 13px 15px;
            border-radius: 7px;
            border: 1.5px solid #cfd8dc;
            background: #f8fafc;
            font-size: 1.07rem;
            transition: border 0.2s, box-shadow 0.2s;
            box-shadow: 0 1px 4px rgba(25, 118, 210, 0.04);
        }
        .register-form input:focus,
        .register-form select:focus {
            border: 1.5px solid #1976d2;
            box-shadow: 0 2px 8px #1976d233;
            background: #fff;
            outline: none;
        }
        .register-form input[type="file"] {
            border: none;
            background: none;
            font-size: 1rem;
            margin-top: 4px;
        }
        .register-form button {
            background: linear-gradient(90deg, #1976d2 0%, #125ea7 100%);
            color: #fff;
            border: none;
            padding: 13px 0;
            border-radius: 7px;
            font-size: 1.13rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 8px;
            box-shadow: 0 2px 8px #1976d233;
            transition: background 0.2s, box-shadow 0.2s, transform 0.15s;
        }
        .register-form button:hover {
            background: linear-gradient(90deg, #125ea7 0%, #1976d2 100%);
            box-shadow: 0 4px 16px #1976d233;
            transform: scale(1.03);
        }
        .register-form .form-footer {
            text-align: center;
            margin-top: 18px;
            font-size: 0.98rem;
        }
        .register-form .form-footer a {
            color: #1976d2;
            text-decoration: none;
            font-weight: 500;
        }
        .register-form .form-footer a:hover {
            text-decoration: underline;
        }
        .form-message {
            min-height: 18px;
            font-size: 1.01rem;
            color: #d32f2f;
            margin-bottom: 8px;
            text-align: center;
        }
        @media (max-width: 900px) {
            .register-main { flex-direction: column; }
            .register-left, .register-right { padding: 32px 12px; }
            .register-left { align-items: center; text-align: center; }
            .register-left .img-placeholder { display: none; }
        }
        .footer { background: #1a3557; color: #fff; padding: 40px 0 0 0; margin-top: 0; }
        .footer-content { display: flex; flex-wrap: wrap; justify-content: space-around; padding: 0 40px 30px 40px; }
        .footer-section { flex: 1 1 220px; margin-bottom: 18px; }
        .footer-section h3 { color: #f39c12; margin-bottom: 12px; }
        .footer-section ul { list-style: none; padding: 0; }
        .footer-section ul li { margin-bottom: 8px; }
        .footer-section ul li a { color: #fff; text-decoration: none; transition: color 0.2s; }
        .footer-section ul li a:hover { color: #f39c12; }
        .footer .footer-bottom { text-align: center; padding: 18px 0; background: #16243a; font-size: 0.95rem; }
        .footer .socials a { color: #fff; margin-right: 12px; font-size: 1.2rem; transition: color 0.2s; }
        .footer .socials a:hover { color: #f39c12; }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo"><i class="fa fa-book"></i> LibrarySystem</div>
        <nav>
            <a href="../../index.jsp">Home</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
        </nav>
        <div class="auth">
            <a href="login.jsp" class="login">Sign In</a>
            <a href="register.jsp" class="register">Register</a>
        </div>
    </div>
    <div class="register-main">
        <div class="register-left">
            <h1>Join Our Library Community</h1>
            <p>Create an account to access our vast collection of books, manage your loans, and discover new titles.</p>
            <div class="feature-list">
                <div class="feature-item"><i class="fa fa-check-circle"></i> Free membership</div>
                <div class="feature-item"><i class="fa fa-check-circle"></i> Access to thousands of books</div>
                <div class="feature-item"><i class="fa fa-check-circle"></i> Personalized recommendations</div>
            </div>
            <div class="img-placeholder"><i class="fa fa-image"></i></div>
        </div>
        <div class="register-right">
            <div class="register-form-box">
                <h2><i class="fa fa-book"></i> LibrarySystem</h2>
                <p>Create an account<br><span style="font-size:0.98rem;color:#888;">Enter your information to register</span></p>
                <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" enctype="multipart/form-data" class="register-form">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" placeholder="Full Name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" placeholder="Email" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Password" required>
                    </div>
                    <div class="form-group">
                        <label for="role">Role</label>
                        <select id="role" name="role" required>
            <option value="user">User</option>
            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="image">Profile Image</label>
                        <input type="file" id="image" name="image" accept="image/*" onchange="previewProfileImage(event)">
                        <div id="profileImagePreview" style="margin-top:10px;text-align:center;"></div>
                    </div>
                    <div class="form-message" id="formMessage"></div>
                    <button type="submit">Create account</button>
                    <div class="form-footer">Already have an account? <a href="${pageContext.request.contextPath}/View/jsp/login.jsp">Sign in</a></div>
    </form>
            </div>
        </div>
    </div>
    <div class="footer" id="footer">
        <div class="footer-content">
            <div class="footer-section">
                <div class="logo" style="color:#fff;"><i class="fa fa-book"></i> LibrarySystem</div>
                <p>Your gateway to knowledge and discovery. Explore our vast collection of books and resources online from Itahari, Nepal.</p>
                <div class="socials">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="../../index.jsp">Home</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Library Hours</h3>
                <ul>
                    <li>Monday - Friday: 9:00 AM - 8:00 PM</li>
                    <li>Saturday: 10:00 AM - 6:00 PM</li>
                    <li>Sunday: 12:00 PM - 5:00 PM</li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact Us</h3>
                <ul>
                    <li>Itahari, Sunsari 56705, Nepal</li>
                    <li>+977 980-0000000</li>
                    <li>info@librarysystem.com</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2025 Library Management System. All rights reserved.
        </div>
</div>
<script>
function previewProfileImage(event) {
  const preview = document.getElementById('profileImagePreview');
  preview.innerHTML = '';
  if (event.target.files && event.target.files[0]) {
    const reader = new FileReader();
    reader.onload = function(e) {
      preview.innerHTML = '<img src="' + e.target.result + '" style="width:90px;height:90px;border-radius:50%;object-fit:cover;border:2px solid #2563eb;box-shadow:0 2px 8px #2563eb33;" />';
    };
    reader.readAsDataURL(event.target.files[0]);
  }
}
</script>
</body>
</html> 