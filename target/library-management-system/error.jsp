<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Error - Library Management System</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
    <h2>Error</h2>
    <p class="error"><c:out value="${exception.message != null ? exception.message : 'An unexpected error occurred'}"/></p>
    <p><a href="home">Return to Home</a></p>
</main>
<jsp:include page="footer.jsp"/>
</body>
</html>