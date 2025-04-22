<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><c:out value="${param.action == 'login' ? 'Login' : 'Register'}"/> - Library Management System</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
    <h2><c:out value="${param.action == 'login' ? 'Login' : 'Register'}"/></h2>
    <c:if test="${not empty error}">
        <p class="error"><c:out value="${error}"/></p>
    </c:if>
    <form action="${param.action == 'login' ? 'login' : 'register'}" method="post">
        <c:if test="${param.action != 'login'}">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" required>

            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" required>
        </c:if>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${cookie.email.value}" required>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <c:if test="${param.action == 'login'}">
            <label><input type="checkbox" name="rememberMe" ${cookie.email != null ? 'checked' : ''}> Remember Me</label>
        </c:if>
        <button type="submit"><c:out value="${param.action == 'login' ? 'Login' : 'Register'}"/></button>
    </form>
    <p>
        <c:choose>
            <c:when test="${param.action == 'login'}">
                Don't have an account? <a href="auth.jsp?action=register">Register here</a>.
            </c:when>
            <c:otherwise>
                Already have an account? <a href="auth.jsp?action=login">Login here</a>.
            </c:otherwise>
        </c:choose>
    </p>
</main>
<jsp:include page="footer.jsp"/>
</body>
</html>