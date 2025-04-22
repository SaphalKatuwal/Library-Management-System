<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Members - Library</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<main class="container">
    <div class="card">
        <h2>Manage Members</h2>
        <c:if test="${not empty requestScope.message}">
            <p class="error">${requestScope.message}</p>
        </c:if>
        <c:if test="${empty requestScope.members}">
            <p>No members found.</p>
        </c:if>
        <c:forEach var="member" items="${requestScope.members}">
            <div class="card" style="margin: 0.5rem 0;">
                <p><strong>Name:</strong> ${member.firstName} ${member.lastName}</p>
                <p><strong>Email:</strong> ${member.email}</p>
                <p><strong>Role:</strong> ${member.role}</p>
                <p><strong>Phone:</strong> ${member.phone}</p>
                <p><strong>Address:</strong> ${member.address}</p>
                <form action="${pageContext.request.contextPath}/member" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="memberId" value="${member.memberId}">
                    <div class="form-group">
                        <label for="role_${member.memberId}">Update Role</label>
                        <select id="role_${member.memberId}" name="role">
                            <option value="MEMBER" ${member.role == 'MEMBER' ? 'selected' : ''}>Member</option>
                            <option value="LIBRARIAN" ${member.role == 'LIBRARIAN' ? 'selected' : ''}>Librarian</option>
                            <option value="ADMIN" ${member.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                        </select>
                    </div>
                    <button type="submit">Update Role</button>
                </form>
                <form action="${pageContext.request.contextPath}/member" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="memberId" value="${member.memberId}">
                    <button type="submit" onclick="return confirm('Are you sure you want to delete this member?');">Delete</button>
                </form>
            </div>
        </c:forEach>
    </div>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>