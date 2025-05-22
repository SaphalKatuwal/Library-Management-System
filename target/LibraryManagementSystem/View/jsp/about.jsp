<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - LibrarySystem</title>
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
        .about-main { max-width: 1200px; margin: 40px auto 0 auto; background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.07); padding: 40px 32px 32px 32px; }
        .about-title { font-size: 2rem; color: #222; font-weight: 700; margin-bottom: 8px; }
        .about-subtitle { color: #444; margin-bottom: 32px; font-size: 1.1rem; }
        .about-content-row { display: flex; gap: 40px; }
        .about-left { flex: 2; }
        .about-section-title { font-size: 1.15rem; font-weight: 600; margin-top: 18px; margin-bottom: 6px; color: #222; }
        .about-section-text { color: #555; font-size: 1.04rem; margin-bottom: 18px; line-height: 1.6; }
        .about-right { flex: 1; display: flex; align-items: flex-start; justify-content: center; }
        .about-image-placeholder { width: 100%; max-width: 340px; height: 180px; background: #f0f0f0; border-radius: 12px; display: flex; align-items: center; justify-content: center; border: 2px dashed #ccc; margin-top: 18px; }
        .about-image-placeholder i { color: #bbb; font-size: 2.5rem; }
        .about-services-title { font-size: 1.2rem; color: #222; font-weight: 600; margin: 40px 0 18px 0; }
        .about-services-row { display: flex; gap: 24px; flex-wrap: wrap; }
        .service-card { background: #f8fafc; border-radius: 10px; box-shadow: 0 1px 6px rgba(0,0,0,0.04); padding: 28px 22px; flex: 1 1 260px; min-width: 220px; display: flex; flex-direction: column; align-items: flex-start; }
        .service-card i { font-size: 1.7rem; color: #1976d2; margin-bottom: 10px; }
        .service-card-title { font-size: 1.08rem; font-weight: 600; color: #1976d2; margin-bottom: 8px; }
        .service-card-desc { color: #444; font-size: 0.98rem; }
    @media (max-width: 900px) {
            .about-content-row { flex-direction: column; gap: 18px; }
            .about-main { padding: 18px 6px; }
            .about-services-row { flex-direction: column; gap: 18px; }
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
            <a href="about.jsp" class="active">About</a>
            <a href="contact.jsp">Contact</a>
    </nav>
        <div class="auth">
            <a href="login.jsp" class="login">Sign In</a>
            <a href="register.jsp" class="register">Register</a>
        </div>
    </div>
    <div class="about-main">
        <div class="about-title">About Our Library</div>
        <div class="about-subtitle">Learn about our mission, history, and the services we provide to our community</div>
        <div class="about-content-row">
            <div class="about-left">
                <div class="about-section-title">Our Mission</div>
                <div class="about-section-text">
                    Our mission is to provide free and equal access to information, knowledge, and resources to all members of our community. We strive to create a welcoming environment that encourages learning, exploration, and personal growth.<br><br>
                    We believe that libraries are essential institutions that empower individuals through access to information and technology. Our library serves as a community hub where people can connect, learn, and engage with ideas and each other.
  </div>
                <div class="about-section-title">Our History</div>
                <div class="about-section-text">
                    Founded in 1950, our library has been serving the community for over 70 years. What began as a small collection of books in a single room has grown into a comprehensive resource center with thousands of books, digital resources, and community programs.<br><br>
                    Throughout our history, we have adapted to the changing needs of our community and embraced new technologies while maintaining our commitment to providing access to information for all.
      </div>
      </div>
            <div class="about-right">
                <div class="about-image-real" style="width:100%;max-width:420px;height:360px;background:#f0f0f0;border-radius:14px;display:flex;align-items:center;justify-content:center;overflow:hidden;margin-top:18px;">
                    <img src="../../images/library.jpeg" alt="Library" style="width:100%;height:100%;object-fit:cover;">
  </div>
</div>
        </div>
        <div class="about-services-title">Our Services</div>
        <div class="about-services-row">
            <div class="service-card">
                <i class="fa fa-book-open"></i>
                <div class="service-card-title">Book Lending</div>
                <div class="service-card-desc">Borrow from a wide selection of books and resources, both physical and digital, to support your learning and interests.</div>
            </div>
            <div class="service-card">
                <i class="fa fa-tablet-alt"></i>
                <div class="service-card-title">Digital Resources</div>
                <div class="service-card-desc">Access e-books, online journals, research databases, and other digital materials from anywhere, anytime.</div>
            </div>
            <div class="service-card">
                <i class="fa fa-users"></i>
                <div class="service-card-title">Community Programs</div>
                <div class="service-card-desc">Participate in workshops, reading clubs, and events designed to bring our community together and foster lifelong learning.</div>
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
</body>
</html>