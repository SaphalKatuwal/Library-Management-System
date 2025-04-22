<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <h1>Library Management System</h1>
    <nav>
        <a href="home">Home</a>
        <c:choose>
            <c:when test="${sessionScope.user != null}">
                <a href="dashboard">Dashboard</a>
                <a href="logout">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="auth.jsp?action=login">Login</a>
                <a href="auth.jsp?action=register">Register</a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>