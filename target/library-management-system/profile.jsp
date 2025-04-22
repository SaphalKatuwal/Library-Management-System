<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile - Library</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<main class="container">
  <div class="card">
    <h2>My Profile</h2>
    <c:if test="${not empty requestScope.message}">
      <p class="error">${requestScope.message}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/member" method="post">
      <input type="hidden" name="action" value="update">
      <div class="form-group">
        <label for="firstName">First Name</label>
        <input type="text" id="firstName" name="firstName" value="${sessionScope.member.firstName}" required>
      </div>
      <div class="form-group">
        <label for="lastName">Last Name</label>
        <input type="text" id="lastName" name="lastName" value="${sessionScope.member.lastName}" required>
      </div>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" value="${sessionScope.member.email}" required>
      </div>
      <div class="form-group">
        <label for="phone">Phone</label>
        <input type="tel" id="phone" name="phone" value="${sessionScope.member.phone}">
      </div>
      <div class="form-group">
        <label for="address">Address</label>
        <input type="text" id="address" name="address" value="${sessionScope.member.address}">
      </div>
      <div class="form-group">
        <label for="password">New Password (leave blank to keep current)</label>
        <input type="password" id="password" name="password">
      </div>
      <button type="submit">Update Profile</button>
    </form>
  </div>
  <div class="card">
    <h2>Borrowing History</h2>
    <c:if test="${empty requestScope.borrowings}">
      <p>No borrowing history.</p>
    </c:if>
    <c:forEach var="borrowing" items="${requestScope.borrowings}">
      <div class="card" style="margin: 0.5rem 0;">
        <p><strong>Book ID:</strong> ${borrowing.bookId}</p>
        <p><strong>Borrow Date:</strong> ${borrowing.borrowDate}</p>
        <p><strong>Due Date:</strong> ${borrowing.dueDate}</p>
        <p><strong>Return Date:</strong> ${borrowing.returnDate != null ? borrowing.returnDate : 'Not Returned'}</p>
        <p><strong>Fine Amount:</strong> ${borrowing.fineAmount}</p>
      </div>
    </c:forEach>
  </div>
  <div class="card">
    <h2>Inquiry History</h2>
    <c:if test="${empty requestScope.inquiries}">
      <p>No inquiry history.</p>
    </c:if>
    <c:forEach var="inquiry" items="${requestScope.inquiries}">
      <div class="card" style="margin: 0.5rem 0;">
        <p><strong>Subject:</strong> ${inquiry.subject}</p>
        <p><strong>Message:</strong> ${inquiry.message}</p>
        <p><strong>Status:</strong> ${inquiry.status}</p>
        <p><strong>Submitted:</strong> ${inquiry.submissionDate}</p>
        <c:if test="${not empty inquiry.response}">
          <p><strong>Response:</strong> ${inquiry.response}</p>
        </c:if>
      </div>
    </c:forEach>
  </div>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>