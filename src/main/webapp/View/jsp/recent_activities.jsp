<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Profile - Library Management System</title>
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
    .profile-section {
        background: #fff;
        border-radius: 1.5rem;
        box-shadow: 0 8px 32px 0 rgba(25, 118, 210, 0.13);
        padding: 40px;
        margin-bottom: 40px;
    }
    .profile-content {
        display: flex;
        gap: 40px;
        align-items: flex-start;
    }
    .profile-image-section {
        flex: 0 0 300px;
      display: flex;
      flex-direction: column;
      align-items: center;
        gap: 20px;
    }
    .profile-image-large {
        width: 200px;
        height: 200px;
      border-radius: 50%;
      object-fit: cover;
        border: 3px solid #1976d2;
        box-shadow: 0 4px 24px rgba(25, 118, 210, 0.18);
    }
    .profile-image-actions {
      display: flex;
      flex-direction: column;
        gap: 12px;
        width: 100%;
    }
    .file-input-wrapper {
        position: relative;
      width: 100%;
    }
    .file-input-wrapper input[type="file"] {
      width: 100%;
        padding: 8px;
        border: 2px dashed #1976d2;
        border-radius: 8px;
        background: #f8fafc;
        cursor: pointer;
    }
    .profile-image-preview {
      width: 100%;
        height: 200px;
        border-radius: 8px;
      object-fit: cover;
        display: none;
        margin-top: 12px;
        border: 2px solid #1976d2;
    }
    .profile-info-section {
        flex: 1;
      display: flex;
      flex-direction: column;
        gap: 24px;
    }
    .profile-name-large {
        font-size: 2.4em;
        color: #1a3557;
        font-weight: 800;
        margin-bottom: 8px;
    }
    .profile-email {
        font-size: 1.2em;
        color: #1976d2;
        font-weight: 600;
        margin-bottom: 16px;
    }
    .profile-role {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        background: #e3f2fd;
        color: #1976d2;
        border-radius: 20px;
        font-weight: 600;
    }
    .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 1.1em;
        cursor: pointer;
        transition: all 0.2s;
        width: 100%;
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
    .recent-activities {
        background: #fff;
        border-radius: 1.5rem;
        box-shadow: 0 8px 32px 0 rgba(25, 118, 210, 0.13);
        padding: 40px;
    }
    .section-title {
        font-size: 2em;
        color: #1a3557;
        font-weight: 800;
        margin-bottom: 24px;
    }
    .books-table {
      width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-top: 20px;
    }
    .books-table th {
        background: #f8fafc;
        padding: 16px;
      text-align: left;
        font-weight: 600;
        color: #1a3557;
        border-bottom: 2px solid #e2e8f0;
    }
    .books-table td {
        padding: 16px;
        border-bottom: 1px solid #e2e8f0;
        color: #4a5568;
    }
    .books-table tr:hover {
        background: #f8fafc;
    }
    .book-cover {
        width: 60px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 12px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.9em;
    }
    .status-overdue {
        background: #fee2e2;
        color: #dc2626;
    }
    .status-returned {
        background: #dcfce7;
        color: #16a34a;
    }
    .status-on-loan {
        background: #fef3c7;
        color: #d97706;
    }
    .return-btn {
        padding: 8px 16px;
        background: #1976d2;
      color: #fff;
      border: none;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
    }
    .return-btn:hover {
        background: #1565c0;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(25, 118, 210, 0.2);
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
        .profile-content {
            flex-direction: column;
            align-items: center;
    }
    .profile-image-section {
            flex: none;
            width: 100%;
        }
        .profile-info-section {
      text-align: center;
    }
        .profile-role {
      justify-content: center;
        }
    }
  </style>
</head>
<body>
    <div class="header">
        <div class="logo"><i class="fa fa-book"></i> LibrarySystem</div>
        <nav>
            <a href="home">Home</a>
      <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                <a href="dashboard">Dashboard</a>
      </c:if>
            <a href="recent_activities" class="active">My Profile</a>
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
      <div class="profile-section">
            <div class="profile-content">
                <div class="profile-image-section">
          <c:choose>
            <c:when test="${not empty sessionScope.user.imageData}">
                            <img src="${pageContext.request.contextPath}/user-image/${sessionScope.user.userID}" alt="Profile" class="profile-image-large" />
            </c:when>
            <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/default-avatar.jpg" alt="Default" class="profile-image-large" />
            </c:otherwise>
          </c:choose>
                    <div class="profile-image-actions">
                        <form method="post" action="${pageContext.request.contextPath}/edit_profile" enctype="multipart/form-data">
                            <div class="file-input-wrapper">
                                <input type="file" name="image" accept="image/*" onchange="previewProfileImage(event)" />
                            </div>
                            <img id="profileImagePreview" class="profile-image-preview" />
                            <button type="submit" class="btn btn-primary">Update Profile Image</button>
                        </form>
                        <form method="post" action="${pageContext.request.contextPath}/remove_profile_image">
                            <button type="submit" class="btn btn-danger">Remove Profile Image</button>
            </form>
                    </div>
                </div>
                <div class="profile-info-section">
                    <div>
                        <h1 class="profile-name-large">${sessionScope.user.name}</h1>
                        <div class="profile-email">${sessionScope.user.email}</div>
                        <div class="profile-role">
                            <i class="fas fa-user-shield"></i>
                            ${sessionScope.user.role}
          </div>
        </div>
        <c:if test="${not empty sessionScope.successMessage}">
          <div class="success-message">
            <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
          </div>
          <% session.removeAttribute("successMessage"); %>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
          <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${sessionScope.error}
          </div>
          <% session.removeAttribute("error"); %>
        </c:if>
                </div>
            </div>
        </div>

        <div class="recent-activities">
            <h2 class="section-title">My Books</h2>
        <c:choose>
          <c:when test="${empty myBooks}">
                    <div style="text-align: center; padding: 40px; color: #4a5568;">
                        <i class="fas fa-book" style="font-size: 48px; color: #cbd5e0; margin-bottom: 16px;"></i>
                        <h3 style="font-size: 1.5em; color: #1a3557; margin-bottom: 8px;">No Books Yet</h3>
                        <p style="color: #718096;">You haven't borrowed any books yet. Start exploring our collection!</p>
                    </div>
          </c:when>
          <c:otherwise>
                    <table class="books-table">
              <thead>
              <tr>
                <th>Cover</th>
                <th>Title</th>
                <th>Author</th>
                <th>Loan Date</th>
                <th>Due Date</th>
                <th>Status</th>
                                <th>Action</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="book" items="${myBooks}">
                <tr>
                  <td>
                    <c:if test="${not empty book.bookImageURL}">
                                            <img src="${book.bookImageURL}" alt="${book.bookTitle}" class="book-cover" />
                    </c:if>
                  </td>
                  <td>${book.bookTitle}</td>
                  <td>${book.bookAuthor}</td>
                  <td><fmt:formatDate value="${book.borrowDate}" pattern="MMM dd, yyyy" /></td>
                  <td><fmt:formatDate value="${book.dueDate}" pattern="MMM dd, yyyy" /></td>
                  <td>
                    <c:choose>
                      <c:when test="${book.status == 'OVERDUE'}">
                                                <span class="status-badge status-overdue">
                                                    <i class="fas fa-exclamation-circle"></i> Overdue
                                                </span>
                      </c:when>
                      <c:when test="${book.status == 'RETURNED'}">
                                                <span class="status-badge status-returned">
                                                    <i class="fas fa-check-circle"></i> Returned
                                                </span>
                      </c:when>
                      <c:otherwise>
                                                <span class="status-badge status-on-loan">
                                                    <i class="fas fa-book-reader"></i> On Loan
                                                </span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <c:if test="${book.status == 'BORROWED' || book.status == 'OVERDUE'}">
                      <form action="${pageContext.request.contextPath}/return" method="post" style="margin:0;" onsubmit="return confirmReturn(this);">
                        <input type="hidden" name="borrowId" value="${book.borrowId}" />
                                                <button type="submit" class="return-btn">Return</button>
                      </form>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </c:otherwise>
        </c:choose>
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
  function confirmReturn(form) {
    if (confirm('Are you sure you want to return this book?')) {
      form.submit();
    }
    return false;
  }

  function previewProfileImage(event) {
    const preview = document.getElementById('profileImagePreview');
            preview.style.display = 'block';
    if (event.target.files && event.target.files[0]) {
      const reader = new FileReader();
      reader.onload = function(e) {
                    preview.src = e.target.result;
      };
      reader.readAsDataURL(event.target.files[0]);
    }
  }
</script>
</body>
</html>