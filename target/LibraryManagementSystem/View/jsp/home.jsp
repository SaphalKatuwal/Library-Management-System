<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - LibrarySystem</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { margin: 0; font-family: 'Segoe UI', Arial, sans-serif; background: #f4f8fb; }
        .header { background: #fff; padding: 20px 40px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 8px rgba(0,0,0,0.03); }
        .header .logo { font-size: 2rem; font-weight: bold; color: #1976d2; display: flex; align-items: center; }
        .header .logo i { margin-right: 10px; }
        .header nav a { margin: 0 18px; color: #222; text-decoration: none; font-weight: 500; }
        .header nav a.active, .header nav a:hover { color: #1976d2; text-decoration: underline; }
        .header .auth, .header .profile { display: flex; gap: 12px; align-items: center; }
        .header .auth a { padding: 8px 18px; border-radius: 5px; text-decoration: none; font-weight: 500; transition: background 0.2s; }
        .header .auth .login { color: #222; border: 1px solid #1976d2; background: #fff; }
        .header .auth .login:hover { background: #e3f0fa; }
        .header .auth .register { color: #fff; background: #1976d2; border: none; }
        .header .auth .register:hover { background: #125ea7; }
        .header .profile-img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 2px solid #1976d2; box-shadow: 0 2px 8px #1976d233; }
        .header .profile-info { display: flex; flex-direction: column; align-items: flex-start; margin-left: 10px; }
        .header .profile-name { font-size: 1.08em; font-weight: 600; color: #1976d2; }
        .header .profile-email { font-size: 0.98em; color: #444; }
        .hero { background: #457393; color: #fff; text-align: center; padding: 80px 20px 40px 20px; border-radius: 0 0 24px 24px; }
        .hero h1 { font-size: 3rem; margin-bottom: 18px; font-weight: 700; }
        .hero p { font-size: 1.3rem; margin-bottom: 32px; }
        .search-bar { display: flex; justify-content: center; gap: 0; max-width: 420px; width: 100%; background: #f4f8fb; border-radius: 1.2rem; box-shadow: 0 2px 12px 0 rgba(109, 131, 242, 0.10); padding: 6px 8px; margin: 0 auto; }
        .search-bar form { display: flex; width: 100%; gap: 10px; }
        .search-bar input { padding: 14px 16px; width: 100%; border: none; border-radius: 1rem 0 0 1rem; font-size: 1.1em; color: #232946; background: transparent; outline: none; flex: 1; }
        .search-bar input::placeholder { color: #6d83f2; opacity: 0.8; }
        .search-bar button { padding: 0 28px; background: linear-gradient(90deg, #1976d2 0%, #125ea7 100%); color: #fff; border: none; border-radius: 0 1rem 1rem 0; font-size: 1.1em; font-weight: 700; cursor: pointer; transition: background 0.2s, box-shadow 0.2s; box-shadow: 0 2px 8px 0 rgba(109, 131, 242, 0.10); height: 48px; }
        .search-bar button:hover { background: linear-gradient(90deg, #125ea7 0%, #1976d2 100%); }
        .books-section { background: none; margin: 0; width: 100%; max-width: 1200px; margin: 0 auto; margin-top: 18px; }
        .books-section h2 { font-size: 2em; margin-bottom: 24px; color: #1a3557; font-weight: 800; text-align: left; width: 100%; }
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(270px, 1fr));
            gap: 32px;
            width: 100%;
            padding: 0 20px;
            box-sizing: border-box;
            min-height: 0;
        }
        .book-card {
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px 0 rgba(25, 118, 210, 0.13);
            transition: transform 0.22s, box-shadow 0.22s;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 380px;
            position: relative;
            overflow: hidden;
            padding: 0 0 22px 0;
            border: 1.5px solid #e3e9f3;
        }
        .book-card:hover {
            transform: translateY(-10px) scale(1.04);
            box-shadow: 0 16px 48px 0 rgba(25, 118, 210, 0.18);
            border-color: #1976d2;
        }
        .book-card .book-genre-badge {
            position: absolute;
            top: 0;
            left: 0;
            background: linear-gradient(90deg, #1976d2 0%, #125ea7 100%);
            color: #fff;
            font-size: 1em;
            font-weight: 600;
            padding: 8px 24px 8px 18px;
            border-radius: 0 0 1.2rem 0;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px #1976d233;
            z-index: 2;
        }
        .book-card img {
            width: 100%;
            max-width: 200px;
            height: 240px;
            object-fit: cover;
            border-radius: 1rem;
            margin: 36px 0 18px 0;
            box-shadow: 0 2px 16px #1976d233;
            border: 3px solid #f4f6fb;
            background: #f4f6fb;
        }
        .book-card h3 {
            font-size: 1.22em;
            margin-bottom: 8px;
            color: #232946;
            font-weight: 700;
            text-align: center;
            margin-top: 0;
        }
        .book-card p {
            font-size: 1.04em;
            color: #444;
            margin-bottom: 6px;
            text-align: center;
            margin-top: 0;
        }
        .status-available { background-color: #48BB78; color: #FFFFFF; padding: 5px 10px; border-radius: 5px; display: inline-block; font-size: 0.9em; margin-bottom: 10px; }
        .status-loaned { background-color: #EF4444; color: #FFFFFF; padding: 5px 10px; border-radius: 5px; display: inline-block; font-size: 0.9em; margin-bottom: 10px; }
        .see-more { display: block; text-align: center; padding: 8px 0; background-color: #1976d2; color: #FFFFFF; border-radius: 5px; font-size: 0.9em; margin-top: 10px; transition: background-color 0.3s; }
        .see-more:hover { background-color: #125ea7; }
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
            <a href="home" class="active">Home</a>
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                <a href="dashboard">Dashboard</a>
            </c:if>
            <a href="recent_activities">My Profile</a>
        </nav>
        <div class="profile">
            <c:choose>
                <c:when test="${sessionScope.user != null && not empty sessionScope.user.imageData}">
                    <img src="user-image/${sessionScope.user.userID}" alt="Profile" class="profile-img" onerror="this.onerror=null;this.src='assets/default-avatar.jpg';" />
                </c:when>
                <c:otherwise>
                    <img src="assets/default-avatar.jpg" alt="Default" class="profile-img" />
                </c:otherwise>
            </c:choose>
            <c:if test="${sessionScope.user != null}">
                <div class="profile-info">
                    <span class="profile-name">${sessionScope.user.name}</span>
                </div>
            </c:if>
            <form action="logout" method="post" style="margin-left:18px;display:inline;">
                <button type="submit" class="logout-btn" style="background:#ef4444;color:#fff;border:none;padding:8px 18px;border-radius:5px;font-weight:500;cursor:pointer;">Logout</button>
            </form>
        </div>
    </div>
    <div class="main-content">
        <section class="hero">
            <h1>Discover a World of Knowledge</h1>
            <p>Explore our vast collection of books and resources. Your journey to knowledge starts here.</p>
            <div class="search-bar">
                <form action="search" method="GET">
                    <input type="text" name="query" placeholder="Search for books..." value="${searchQuery}">
                    <button type="submit"><i class="fas fa-search"></i> Search</button>
                </form>
            </div>
        </section>
        <section class="books-section">
            <h2>
                <c:choose>
                    <c:when test="${not empty searchQuery}">
                        Search Results for "${searchQuery}"
                    </c:when>
                    <c:otherwise>
                        Explore Our Collection
                    </c:otherwise>
                </c:choose>
            </h2>
            <c:choose>
                <c:when test="${empty books}">
                    <div style="text-align: center; padding: 40px;">
                        <i class="fas fa-search" style="font-size: 48px; color: #CBD5E0; margin-bottom: 20px;"></i>
                        <h3 style="color: #4A5568;">No books found</h3>
                        <p style="color: #718096;">Try different search terms or browse our collection</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="book-grid" style="min-height:0;">
                        <c:forEach var="book" items="${books}">
                            <a href="${pageContext.request.contextPath}/book-details?id=${book.id}" style="text-decoration: none; color: inherit; display: block;">
                                <div class="book-card">
                                    <div class="book-genre-badge">${book.genre}</div>
                                    <c:choose>
                                        <c:when test="${not empty book.imageData}">
                                            <img src="book-image/${book.id}" alt="Book Cover" onerror="this.onerror=null;this.src='assets/default-book.jpg';" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="assets/default-book.jpg" alt="Book Cover" />
                                        </c:otherwise>
                                    </c:choose>
                                    <h3>${book.title}</h3>
                                    <p><strong>Author:</strong> ${book.author}</p>
                                    <p><strong>Year:</strong> ${book.publicationYear}</p>
                                    <p><strong>Pages:</strong> ${book.pages}</p>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
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
                    <li><a href="home">Home</a></li>
                    <li><a href="View/jsp/about.jsp">About Us</a></li>
                    <li><a href="View/jsp/contact.jsp">Contact</a></li>
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
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.book-grid a').forEach(function(link) {
            var card = link.querySelector('.book-card');
            if (card) {
                card.style.cursor = 'pointer';
                card.addEventListener('click', function(e) {
                    // Prevent double navigation if the user clicks the link directly
                    if (e.target.tagName.toLowerCase() === 'a') return;
                    window.location.href = link.getAttribute('href');
                });
            }
        });
    });
</script>
</html>