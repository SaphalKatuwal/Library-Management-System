<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LibrarySystem - Welcome</title>
    <link rel="stylesheet" href="css/landing.css">
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
        .hero { background: #457393; color: #fff; text-align: center; padding: 80px 20px 60px 20px; }
        .hero h1 { font-size: 3rem; margin-bottom: 18px; font-weight: 700; }
        .hero p { font-size: 1.3rem; margin-bottom: 32px; }
        .hero .cta { display: flex; justify-content: center; gap: 12px; margin-top: 18px; }
        .hero .cta .join-btn { background: #f39c12; color: #fff; border: none; padding: 14px 32px; border-radius: 5px; font-size: 1.1rem; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        .hero .cta .join-btn:hover { background: #d35400; }
        .hero .cta input { padding: 14px 18px; border-radius: 5px; border: none; font-size: 1.1rem; width: 260px; }
        .search-section { background: #f4f8fb; padding: 40px 0 0 0; text-align: center; }
        .search-section h2 { font-size: 2rem; margin-bottom: 18px; color: #1a3557; }
        .search-bar { display: flex; justify-content: center; gap: 10px; margin-bottom: 18px; }
        .search-bar input { padding: 12px 18px; border-radius: 5px; border: 1px solid #ccc; font-size: 1rem; width: 320px; }
        .tags { display: flex; justify-content: center; gap: 10px; flex-wrap: wrap; }
        .tag { background: #e3f0fa; color: #1976d2; padding: 8px 18px; border-radius: 20px; font-size: 1rem; margin-bottom: 8px; cursor: pointer; transition: background 0.2s; }
        .tag:hover { background: #1976d2; color: #fff; }
        .cta-section { background: #2d5c7f; color: #fff; text-align: center; padding: 60px 20px; }
        .cta-section h2 { font-size: 2.2rem; margin-bottom: 18px; font-weight: 700; }
        .cta-section p { font-size: 1.2rem; margin-bottom: 28px; }
        .cta-section .create-btn { background: #f39c12; color: #fff; border: none; padding: 14px 32px; border-radius: 5px; font-size: 1.1rem; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        .cta-section .create-btn:hover { background: #d35400; }
        .footer { background: #1a3557; color: #fff; padding: 40px 0 0 0; }
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
            <a href="index.jsp">Home</a>
            <a href="View/jsp/about.jsp">About</a>
            <a href="View/jsp/contact.jsp">Contact</a>
        </nav>
        <div class="auth">
            <a href="View/jsp/login.jsp" class="login">Sign In</a>
            <a href="View/jsp/register.jsp" class="register">Register</a>
        </div>
    </div>
    <div class="hero">
        <h1>Discover a World of Knowledge</h1>
        <p>Explore our vast collection of books and resources. Your journey to knowledge starts here.</p>
    </div>
    <div class="top-books-section" style="background:#f4f8fb;padding:60px 0 40px 0;">
        <h2 style="text-align:center;color:#1a3557;font-size:2rem;margin-bottom:36px;">Top Rated Books</h2>
        <div style="display:flex;justify-content:center;gap:32px;flex-wrap:wrap;">
            <div class="book-card" style="background:#fff;border-radius:12px;box-shadow:0 2px 8px rgba(0,0,0,0.07);width:220px;padding:24px 18px;text-align:center;">
                <img src="images/book1.webp" alt="Book 1" style="width:90px;height:130px;object-fit:cover;border-radius:6px;margin-bottom:14px;">
                <h3 style="font-size:1.1rem;margin:10px 0 6px 0;">The Great Gatsby</h3>
                <div style="color:#888;font-size:0.97rem;">F. Scott Fitzgerald</div>
                <div style="margin:8px 0 0 0;color:#f39c12;">
                    <i class="fa fa-star"></i> 4.8
                </div>
            </div>
            <div class="book-card" style="background:#fff;border-radius:12px;box-shadow:0 2px 8px rgba(0,0,0,0.07);width:220px;padding:24px 18px;text-align:center;">
                <img src="images/book2.webp" alt="Book 2" style="width:90px;height:130px;object-fit:cover;border-radius:6px;margin-bottom:14px;">
                <h3 style="font-size:1.1rem;margin:10px 0 6px 0;">To Kill a Mockingbird</h3>
                <div style="color:#888;font-size:0.97rem;">Harper Lee</div>
                <div style="margin:8px 0 0 0;color:#f39c12;">
                    <i class="fa fa-star"></i> 4.7
                </div>
            </div>
            <div class="book-card" style="background:#fff;border-radius:12px;box-shadow:0 2px 8px rgba(0,0,0,0.07);width:220px;padding:24px 18px;text-align:center;">
                <img src="images/book3.webp" alt="Book 3" style="width:90px;height:130px;object-fit:cover;border-radius:6px;margin-bottom:14px;">
                <h3 style="font-size:1.1rem;margin:10px 0 6px 0;">1984</h3>
                <div style="color:#888;font-size:0.97rem;">George Orwell</div>
                <div style="margin:8px 0 0 0;color:#f39c12;">
                    <i class="fa fa-star"></i> 4.7
                </div>
            </div>
            <div class="book-card" style="background:#fff;border-radius:12px;box-shadow:0 2px 8px rgba(0,0,0,0.07);width:220px;padding:24px 18px;text-align:center;">
                <img src="images/book4.webp" alt="Book 4" style="width:90px;height:130px;object-fit:cover;border-radius:6px;margin-bottom:14px;">
                <h3 style="font-size:1.1rem;margin:10px 0 6px 0;">Pride and Prejudice</h3>
                <div style="color:#888;font-size:0.97rem;">Jane Austen</div>
                <div style="margin:8px 0 0 0;color:#f39c12;">
                    <i class="fa fa-star"></i> 4.6
                </div>
            </div>
            <div class="book-card" style="background:#fff;border-radius:12px;box-shadow:0 2px 8px rgba(0,0,0,0.07);width:220px;padding:24px 18px;text-align:center;">
                <img src="images/book5.webp" alt="Book 5" style="width:90px;height:130px;object-fit:cover;border-radius:6px;margin-bottom:14px;">
                <h3 style="font-size:1.1rem;margin:10px 0 6px 0;">The Hobbit</h3>
                <div style="color:#888;font-size:0.97rem;">J.R.R. Tolkien</div>
                <div style="margin:8px 0 0 0;color:#f39c12;">
                    <i class="fa fa-star"></i> 4.6
                </div>
            </div>
        </div>
    </div>
    <div class="footer" id="footer">
        <div class="footer-content">
            <div class="footer-section">
                <div class="logo" style="color:#fff;"><i class="fa fa-book"></i> LibrarySystem</div>
                <p>Your gateway to knowledge and discovery. Explore our vast collection of books and resources.</p>
                <div class="socials">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="View/jsp/books.jsp">Search Books</a></li>
                    <li><a href="View/jsp/about.jsp">About Us</a></li>
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
                    <li>123 Library Street, Booktown, BK 12345</li>
                    <li>(123) 456-7890</li>
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