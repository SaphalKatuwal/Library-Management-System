<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - LibrarySystem</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { margin: 0; font-family: 'Segoe UI', Arial, sans-serif; background: #f4f8fb; }
        .header { background: #fff; padding: 20px 40px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 8px rgba(0,0,0,0.03); }
        .header .logo { font-size: 2rem; font-weight: bold; color: #1976d2; display: flex; align-items: center; }
        .header .logo i { margin-right: 10px; }
        .header nav a { margin: 0 18px; color: #222; text-decoration: none; font-weight: 500; }
        .header .auth { display: flex; gap: 12px; }
        .header .auth a { padding: 8px 18px; border-radius: 5px; text-decoration: none; font-weight: 500; transition: background 0.2s; }
        .header .auth .login { color: #222; border: 1px solid #1976d2; background: #fff; }
        .header .auth .login:hover { background: #e3f0fa; }
        .header .auth .register { color: #fff; background: #1976d2; border: none; }
        .header .auth .register:hover { background: #125ea7; }
        .contact-container { max-width: 1200px; margin: 40px auto 0 auto; background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.07); padding: 40px 32px 32px 32px; display: flex; gap: 40px; }
        .contact-info { flex: 1.1; }
        .contact-info h2 { color: #1976d2; font-size: 1.5rem; margin-bottom: 18px; }
        .contact-info p { color: #444; margin-bottom: 24px; }
        .contact-info .info-item { display: flex; align-items: flex-start; gap: 14px; margin-bottom: 18px; }
        .contact-info .info-item i { color: #1976d2; font-size: 1.2rem; margin-top: 3px; }
        .contact-info .info-label { font-weight: 600; color: #222; }
        .contact-info .info-value { color: #444; }
        .contact-info .hours { margin-top: 24px; }
        .contact-info .hours-title { font-weight: 600; color: #1976d2; margin-bottom: 8px; }
        .contact-info .hours-list { color: #444; font-size: 0.98rem; }
        .contact-form-section { flex: 2; }
        .contact-form-box { background: #f8fafc; border-radius: 10px; padding: 32px 28px; box-shadow: 0 1px 6px rgba(0,0,0,0.04); }
        .contact-form-box h3 { font-size: 1.3rem; margin-bottom: 10px; color: #222; }
        .contact-form-box p { color: #666; font-size: 1rem; margin-bottom: 18px; }
        .contact-form { display: flex; flex-direction: column; gap: 16px; }
        .contact-form-row { display: flex; gap: 16px; }
        .contact-form input, .contact-form textarea { font-size: 1rem; padding: 12px 14px; border-radius: 5px; border: 1px solid #cfd8dc; background: #fff; transition: border 0.2s; width: 100%; }
        .contact-form input:focus, .contact-form textarea:focus { border: 1.5px solid #1976d2; outline: none; }
        .contact-form textarea { min-height: 90px; resize: vertical; }
        .contact-form button { background: #1976d2; color: #fff; border: none; padding: 12px 28px; border-radius: 5px; font-size: 1.08rem; font-weight: 600; cursor: pointer; align-self: flex-start; transition: background 0.2s; display: flex; align-items: center; gap: 8px; }
        .contact-form button:hover { background: #125ea7; }
        @media (max-width: 900px) {
            .contact-container { flex-direction: column; padding: 24px 8px; gap: 24px; }
        }
        .footer { background: #1a3557; color: #fff; padding: 40px 0 0 0; margin-top: 60px; }
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
    <div class="contact-container">
        <div class="contact-info">
            <h1 style="font-size:2rem;color:#222;margin-bottom:8px;">Contact Us</h1>
            <p style="color:#444;margin-bottom:28px;">Have questions or feedback? We'd love to hear from you</p>
            <h2>Get in Touch</h2>
            <p>We're an online library service based in Itahari, Nepal. We're here to help and answer any questions you might have. We look forward to hearing from you.</p>
            <div class="info-item"><i class="fa fa-map-marker-alt"></i><div><span class="info-label">Address</span><br><span class="info-value">Itahari, Sunsari 56705, Nepal</span></div></div>
            <div class="info-item"><i class="fa fa-phone"></i><div><span class="info-label">Phone</span><br><span class="info-value">+977 980-0000000</span></div></div>
            <div class="info-item"><i class="fa fa-envelope"></i><div><span class="info-label">Email</span><br><span class="info-value">info@librarysystem.com</span></div></div>
            <div class="hours">
                <div class="hours-title">Library Hours</div>
                <div class="hours-list">
                    Monday - Friday: 9:00 AM - 8:00 PM<br>
                    Saturday: 10:00 AM - 6:00 PM<br>
                    Sunday: 12:00 PM - 5:00 PM
                </div>
            </div>
        </div>
        <div class="contact-form-section">
            <div class="contact-form-box">
                <h3>Send us a Message</h3>
                <p>Fill out the form below and we'll get back to you as soon as possible</p>
                <form class="contact-form">
                    <div class="contact-form-row">
                        <input type="text" placeholder="Name *" required>
                        <input type="email" placeholder="Email *" required>
                    </div>
                    <input type="text" placeholder="Subject">
                    <textarea placeholder="Message *" required></textarea>
                    <button type="submit"><i class="fa fa-paper-plane"></i> Send Message</button>
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
                    <li><a href="../index.jsp">Home</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                    <li><a href="#footer">Contact</a></li>
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
</body>
</html> 