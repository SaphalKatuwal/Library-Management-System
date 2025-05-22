<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${book.title} - Library Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { margin: 0; font-family: 'Segoe UI', Arial, sans-serif; background: #f4f8fb; }
        .header { background: #fff; padding: 20px 40px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 8px rgba(0,0,0,0.03); }
        .header .logo { font-size: 2rem; font-weight: bold; color: #1976d2; display: flex; align-items: center; }
        .header .logo i { margin-right: 10px; }
        .header nav a { margin: 0 18px; color: #222; text-decoration: none; font-weight: 500; }
        .header nav a.active, .header nav a:hover { color: #1976d2; text-decoration: underline; }
        .header .profile { display: flex; gap: 12px; align-items: center; }
        .header .profile-img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 2px solid #1976d2; box-shadow: 0 2px 8px #1976d233; }
        .header .profile-info { display: flex; flex-direction: column; align-items: flex-start; margin-left: 10px; }
        .header .profile-name { font-size: 1.08em; font-weight: 600; color: #1976d2; }
        .main-content { padding: 40px 20px; max-width: 1200px; margin: 0 auto; }
        .book-details-card {
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px 0 rgba(25, 118, 210, 0.13);
            padding: 40px;
            display: flex;
            gap: 40px;
            margin-bottom: 40px;
        }
        .book-image-section {
            flex: 0 0 300px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .book-image-section img {
            width: 280px;
            height: 400px;
            object-fit: cover;
            border-radius: 1rem;
            box-shadow: 0 4px 24px rgba(25, 118, 210, 0.18);
            border: 3px solid #f4f6fb;
        }
        .book-details-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        .book-title {
            font-size: 2.4em;
            color: #1a3557;
            font-weight: 800;
            margin-bottom: 8px;
        }
        .book-author {
            font-size: 1.2em;
            color: #1976d2;
            font-weight: 600;
            margin-bottom: 16px;
        }
        .book-meta {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        .meta-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .meta-label {
            font-size: 0.9em;
            color: #666;
            font-weight: 500;
        }
        .meta-value {
            font-size: 1.1em;
            color: #1a3557;
            font-weight: 600;
        }
        .book-description {
            font-size: 1.1em;
            line-height: 1.6;
            color: #444;
            margin-bottom: 24px;
        }
        .availability {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            margin-bottom: 24px;
        }
        .available {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        .unavailable {
            background-color: #ffebee;
            color: #c62828;
        }
        .action-buttons {
            display: flex;
            gap: 16px;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1em;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-primary {
            background: linear-gradient(90deg, #1976d2 0%, #125ea7 100%);
            color: #fff;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #125ea7 0%, #1976d2 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(25, 118, 210, 0.2);
        }
        .btn-primary:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        .btn-secondary {
            background: #f5f5f5;
            color: #1976d2;
        }
        .btn-secondary:hover {
            background: #e0e0e0;
            transform: translateY(-2px);
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
        @media (max-width: 900px) {
            .book-details-card {
            flex-direction: column;
                padding: 24px;
        }
            .book-image-section {
                flex: none;
        }
            .book-meta {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo"><i class="fa fa-book"></i> LibrarySystem</div>
        <nav>
            <a href="home" >Home</a>
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
        <div class="book-details-card">
            <div class="book-image-section">
                        <c:if test="${not empty book.imageData}">
                            <img src="${pageContext.request.contextPath}/book-image/${book.id}" alt="${book.title}">
                        </c:if>
                    </div>
            <div class="book-details-section">
                <div>
                        <h1 class="book-title">${book.title}</h1>
                        <div class="book-author">by ${book.author}</div>
                            </div>
                        <div class="availability ${bookAvailable ? 'available' : 'unavailable'}">
                            <i class="fas ${bookAvailable ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                            ${bookAvailable ? 'Available for Borrowing' : 'Currently Unavailable'}
                        </div>
                        <div class="book-meta">
                            <div class="meta-item">
                        <span class="meta-label">Publisher</span>
                                <span class="meta-value">${book.publisher}</span>
                            </div>
                            <div class="meta-item">
                        <span class="meta-label">ISBN</span>
                                <span class="meta-value">${book.isbn}</span>
                            </div>
                            <div class="meta-item">
                        <span class="meta-label">Publication Year</span>
                                <span class="meta-value">${book.publicationYear}</span>
                            </div>
                            <div class="meta-item">
                        <span class="meta-label">Genre</span>
                                <span class="meta-value">${book.genre}</span>
                            </div>
                            <div class="meta-item">
                        <span class="meta-label">Pages</span>
                                <span class="meta-value">${book.pages}</span>
                            </div>
                        </div>
                        <div class="action-buttons">
                            <c:choose>
                                <c:when test="${bookAvailable}">
                                    <form action="${pageContext.request.contextPath}/borrow" method="POST" style="display: inline;">
                                        <input type="hidden" name="bookId" value="${book.id}">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-book-reader"></i> Borrow This Book
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-primary" disabled>
                                        <i class="fas fa-book-reader"></i> Currently Unavailable
                                    </button>
                                </c:otherwise>
                            </c:choose>

                        </div>
            </div>
                            </div>
                    </div>

    <div class="footer">
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
</html>