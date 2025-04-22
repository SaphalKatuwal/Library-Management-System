<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard - Library Management System</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
    <h2>Welcome, <c:out value="${member.firstName}"/> <c:out value="${member.lastName}"/>!</h2>
    <c:choose>
        <c:when test="${member.role == 'ADMIN'}">
            <h3>Admin Dashboard</h3>
            <p>Manage users, books, and library settings.</p>
        </c:when>
        <c:otherwise>
            <h3>Member Dashboard</h3>
            <p>View your borrowed books and account details.</p>
        </c:otherwise>
    </c:choose>
</main>
<jsp:include page="footer.jsp"/>
</body>
</html>