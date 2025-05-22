<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Library Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .main-content { padding: 40px 20px; max-width: 1300px; margin: 0 auto; }
        .library-summary-card {
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px 0 rgba(25, 118, 210, 0.13);
            padding: 32px 40px;
            margin-bottom: 40px;
            display: flex;
            justify-content: center;
            gap: 60px;
        }
        .summary-stat {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-width: 180px;
        }
        .summary-stat .stat-label {
            font-size: 1.1em;
            color: #1976d2;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .summary-stat .stat-value {
            font-size: 2.6em;
            color: #1a3557;
            font-weight: 800;
        }
        .section-card {
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px 0 rgba(25, 118, 210, 0.13);
            padding: 38px 32px 32px 32px;
            margin-bottom: 40px;
        }
        .section-title {
            font-size: 2em;
            color: #1a3557;
            font-weight: 800;
            margin-bottom: 24px;
            text-align: left;
        }
        .books-table, .members-table, .loans-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 10px;
            background: #fff;
        }
        .books-table th, .members-table th, .loans-table th {
            background: #f8fafc;
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: #1a3557;
            border-bottom: 2px solid #e2e8f0;
        }
        .books-table td, .members-table td, .loans-table td {
            padding: 16px;
            border-bottom: 1px solid #e2e8f0;
            color: #4a5568;
        }
        .books-table tr:hover, .members-table tr:hover, .loans-table tr:hover {
            background: #f8fafc;
        }
        .book-cover, .member-avatar, .loan-book-cover, .loan-user-avatar {
            width: 48px;
            height: 64px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .member-avatar, .loan-user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
        }
        .center-btn-row {
            display: flex;
            justify-content: center;
            margin-top: 18px;
        }
        .btn {
            padding: 12px 28px;
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
        .btn-danger {
            background: #ef4444;
            color: #fff;
        }
        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
        }
        .delete-button {
            background: #ef4444;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 6px 12px;
            cursor: pointer;
            font-weight: 500;
        }
        .delete-button:hover {
            background: #dc2626;
        }
        .status-returned {
            background: #dcfce7;
            color: #16a34a;
            padding: 5px 10px;
            border-radius: 5px;
            display: inline-block;
            font-size: 0.98em;
        }
        .status-overdue {
            background: #fee2e2;
            color: #dc2626;
            padding: 5px 10px;
            border-radius: 5px;
            display: inline-block;
            font-size: 0.98em;
        }
        .reports-section {
            display: flex;
            flex-wrap: wrap;
            gap: 32px;
            margin-bottom: 40px;
        }
        .report-card {
            flex: 1 1 420px;
            min-width: 340px;
            background: linear-gradient(135deg, #f8fafc 60%, #e3f0fa 100%);
            border-radius: 1.2rem;
            padding: 32px;
            box-shadow: 0 2px 12px #1976d233;
            margin-bottom: 0;
        }
        .report-card h3 {
            color: #1976d2;
            font-size: 1.3em;
            margin-bottom: 18px;
            font-weight: 700;
        }
        .report-card table {
            width: 100%;
            margin-bottom: 18px;
            background: none;
        }
        .report-card th, .report-card td {
            padding: 10px 8px;
            text-align: left;
            font-size: 1em;
        }
        .report-card th {
            color: #1976d2;
            background: none;
            font-weight: 700;
        }
        .report-card td {
            color: #1a3557;
        }
        .star {
            color: #f39c12;
            font-size: 1.1em;
        }
        .activity-bar {
            background: #e3e8f0;
            border-radius: 8px;
            width: 100px;
            height: 8px;
            overflow: hidden;
            display: inline-block;
        }
        .activity-bar-inner {
            background: #1976d2;
            height: 100%;
            border-radius: 8px;
        }
        .footer {
            background: #1a3557;
            color: #fff;
            padding: 60px 0 0 0;
            margin-top: 60px;
        }
        .footer-content {
            max-width: 1300px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            padding: 0 20px;
        }
        .footer-section {
            margin-bottom: 30px;
        }
        .footer-section h3 {
            color: #fff;
            font-size: 1.3em;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .footer-section p {
            color: #e2e8f0;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        .footer-section ul {
            list-style: none;
            padding: 0;
        }
        .footer-section ul li {
            margin-bottom: 12px;
            color: #e2e8f0;
        }
        .footer-section ul li a {
            color: #e2e8f0;
            text-decoration: none;
            transition: color 0.3s;
        }
        .footer-section ul li a:hover {
            color: #1976d2;
        }
        .socials {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        .socials a {
            color: #fff;
            font-size: 1.2em;
            transition: color 0.3s;
        }
        .socials a:hover {
            color: #1976d2;
        }
        .footer-bottom {
            text-align: center;
            padding: 20px;
            background: rgba(0, 0, 0, 0.2);
            margin-top: 40px;
            color: #e2e8f0;
        }
        @media (max-width: 900px) {
            .library-summary-card, .reports-section { flex-direction: column; gap: 24px; }
            .section-card { padding: 24px 8px; }
            .footer-content { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo"><i class="fa fa-book"></i> LibrarySystem</div>
        <nav>
            <a href="home">Home</a>
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                <a href="dashboard" class="active">Dashboard</a>
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
        <div class="library-summary-card">
            <div class="summary-stat">
                <div class="stat-label">Total Members</div>
                <div class="stat-value">${totalMembers}</div>
                </div>
            <div class="summary-stat">
                <div class="stat-label">Total Books</div>
                <div class="stat-value">${totalBooks}</div>
                </div>
            <div class="summary-stat">
                <div class="stat-label">Active Loans</div>
                <div class="stat-value">${activeLoans}</div>
            </div>
        </div>
        <div class="section-card">
            <h2 class="section-title">Book Management</h2>
            <table class="books-table">
                            <thead>
                            <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Publisher</th>
                    <th>ISBN</th>
                    <th>Year</th>
                    <th>Genre</th>
                    <th>Pages</th>
                    <th>Image</th>
                    <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr class="book-row" data-href="${pageContext.request.contextPath}/book-details?id=${book.id}">
                        <td>${book.id}</td>
                        <td><span style="color: #1976d2; text-decoration: none; cursor:pointer;">${book.title}</span></td>
                        <td>${book.author}</td>
                        <td>${book.publisher}</td>
                        <td>${book.isbn}</td>
                        <td>${book.publicationYear}</td>
                        <td>${book.genre}</td>
                        <td>${book.pages}</td>
                        <td>
                            <c:if test="${not empty book.imageData}">
                                <img src="${pageContext.request.contextPath}/book-image/${book.id}" alt="Book Cover" class="book-cover">
                            </c:if>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/books" method="post" style="display:inline;" onsubmit="event.stopPropagation(); return confirm('Are you sure you want to delete this book?');">
                                <input type="hidden" name="deleteBookId" value="${book.id}" />
                                <button type="submit" class="delete-button">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                            </tbody>
                        </table>
            <div class="center-btn-row">
                <button class="btn btn-primary" onclick="openModal('addBookModal')"><i class="fas fa-plus"></i> Add New Book</button>
                    </div>
                </div>
        <div class="section-card">
            <h2 class="section-title">Member Management</h2>
            <table class="members-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="member" items="${members}">
                    <tr>
                        <td>${member.userID}</td>
                        <td>${member.name}</td>
                        <td>${member.email}</td>
                        <td>${member.role}</td>
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin' && sessionScope.user.userID != member.userID}">
                            <td>
                                <form action="${pageContext.request.contextPath}/members" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                    <input type="hidden" name="deleteUserId" value="${member.userID}" />
                                    <button type="submit" class="delete-button">Delete</button>
                                </form>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="center-btn-row">
            </div>
        </div>
        <div class="section-card">
            <h2 class="section-title">Borrowings</h2>
            <table class="loans-table">
                <thead>
                <tr>
                    <th>Loan ID</th>
                    <th>Book Cover</th>
                    <th>User</th>
                    <th>Book</th>
                    <th>Loan Date</th>
                    <th>Due Date</th>
                    <th>Return Date</th>
                    <th>Fine</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                            <tbody>
                <c:forEach var="loan" items="${loans}">
                    <tr>
                        <td>${loan.id}</td>
                        <td><img src="${pageContext.request.contextPath}/book-image/${loan.bookId}" alt="Book Cover" class="loan-book-cover" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty loan.userImageData}">
                                    <img src="${pageContext.request.contextPath}/user-image/${loan.userId}" alt="User" class="loan-user-avatar" />
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/default-avatar.jpg" alt="Default" class="loan-user-avatar" />
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${loan.bookTitle}</td>
                        <td><fmt:formatDate value="${loan.borrowDate}" pattern="MMM dd, yyyy" /></td>
                        <td><fmt:formatDate value="${loan.dueDate}" pattern="MMM dd, yyyy" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${loan.returnDate != null}">
                                    <fmt:formatDate value="${loan.returnDate}" pattern="MMM dd, yyyy" />
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>$${loan.fine}</td>
                        <td>
                            <c:choose>
                                <c:when test="${loan.returnDate != null}">
                                    <span class="status-returned">Returned</span>
                                </c:when>
                                <c:when test="${loan.dueDate lt now && loan.returnDate == null}">
                                    <span class="status-overdue">Overdue</span>
                                </c:when>
                                <c:otherwise>Borrowed</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/library_loans" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this loan record?');">
                                <input type="hidden" name="deleteBorrowId" value="${loan.id}" />
                                <button type="submit" class="delete-button">Delete</button>
                            </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
        <div class="reports-section">
            <div class="report-card">
                <h3>Popular Books Report</h3>
                <table>
                    <thead>
                        <tr><th>Title</th><th>Author</th><th>Loan Count</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="book" items="${popularBooks}">
                            <tr>
                                <td>${book.title}</td>
                                <td>${book.author}</td>
                                <td>${book.borrowCount}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<!-- Modals for Add Book and Add Member -->
    <div id="addBookModal" class="modal" style="display:none;position:fixed;z-index:1000;left:0;top:0;width:100vw;height:100vh;background:rgba(0,0,0,0.4);align-items:center;justify-content:center;">
        <div class="modal-content" style="background:#fff;padding:30px;border-radius:1.3rem;min-width:350px;max-width:90vw;position:relative;box-shadow:0 8px 32px 0 rgba(35, 41, 70, 0.13);width:100%;display:flex;flex-direction:column;align-items:center;">
        <h2>Add New Book</h2>
        <form method="post" action="${pageContext.request.contextPath}/add_book" enctype="multipart/form-data" style="display:flex;flex-direction:column;align-items:center;gap:16px;width:100%;max-width:400px;">
            <div><label>Title:<br><input type="text" name="title" required></label></div>
            <div><label>Author:<br><input type="text" name="author" required></label></div>
            <div><label>Publisher:<br><input type="text" name="publisher"></label></div>
            <div><label>ISBN:<br><input type="text" name="isbn"></label></div>
            <div><label>Publication Year:<br><input type="number" name="publicationYear"></label></div>
            <div><label>Genre:<br><input type="text" name="genre"></label></div>
            <div><label>Pages:<br><input type="number" name="pages"></label></div>
            <div><label>Book Cover Image:<br><input type="file" name="image" accept="image/*"></label></div>
            <div style="text-align:right;">
                <button type="button" onclick="closeModal('addBookModal')">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Book</button>
            </div>
        </form>
            <button onclick="closeModal('addBookModal')" class="close-btn" style="position:absolute;top:10px;right:10px;background:none;border:none;font-size:1.5em;color:#232946;">×</button>
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
<script>
    // Make book rows clickable except when clicking the delete button
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.book-row').forEach(function(row) {
            row.addEventListener('click', function(e) {
                // Prevent navigation if a button or input inside the row was clicked
                if (e.target.closest('button') || e.target.closest('form')) return;
                window.location.href = row.getAttribute('data-href');
            });
        });
    });
    function openModal(id) {
        document.getElementById(id).style.display = 'flex';
    }
    function closeModal(id) {
        document.getElementById(id).style.display = 'none';
    }
</script>
</body>
</html>