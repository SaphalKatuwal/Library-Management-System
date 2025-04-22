<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Borrow Book - Library Management System</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
    <h2>Borrow a Book</h2>
    <form action="borrow" method="post">
        <input type="hidden" name="action" value="borrow">
        <label for="bookId">Book ID:</label>
        <input type="number" id="bookId" name="bookId" required>
        <button type="submit">Borrow</button>
    </form>
    <h3>Return a Book</h3>
    <form action="borrow" method="post">
        <input type="hidden" name="action" value="return">
        <label for="bookIdReturn">Book ID:</label>
        <input type="number" id="bookIdReturn" name="bookId" required>
        <button type="submit">Return</button>
    </form>
</main>
<jsp:include page="footer.jsp"/>
</body>
</html>