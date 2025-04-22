<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inquiries - Library</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<main class="container">
    <div class="card">
        <h2>${param.action == 'pending' ? 'Pending Inquiries' : 'My Inquiries'}</h2>
        <c:if test="${sessionScope.member.role == 'ADMIN' || sessionScope.member.role == 'LIBRARIAN'}">
            <p><a href="${pageContext.request.contextPath}/inquiries?action=pending" class="btn">View Pending Inquiries</a></p>
        </c:if>
        <c:if test="${not empty sessionScope.member}">
            <h3>Submit New Inquiry</h3>
            <form action="${pageContext.request.contextPath}/inquiries" method="post">
                <input type="hidden" name="action" value="submit">
                <div class="form-group">
                    <label for="subject">Subject</label>
                    <input type="text" id="subject" name="subject" required>
                </div>
                <div class="form-group">
                    <label for="message">Message</label>
                    <textarea id="message" name="message" rows="4" required></textarea>
                </div>
                <button type="submit">Submit Inquiry</button>
            </form>
        </c:if>
        <c:if test="${empty requestScope.inquiries}">
            <p>No inquiries found.</p>
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
                <c:if test="${param.action == 'pending' && (sessionScope.member.role == 'ADMIN' || sessionScope.member.role == 'LIBRARIAN')}">
                    <form action="${pageContext.request.contextPath}/inquiries" method="post">
                        <input type="hidden" name="action" value="respond">
                        <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
                        <div class="form-group">
                            <label for="response">Response</label>
                            <textarea id="response" name="response" rows="4" required></textarea>
                        </div>
                        <button type="submit">Submit Response</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
    </div>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>