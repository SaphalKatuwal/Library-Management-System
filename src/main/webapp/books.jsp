<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Books - Library Management System</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
    <h2>Manage Books</h2>
    <h3>Add New Book</h3>
    <form action="books" method="post">
        <input type="hidden" name="action" value="add">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>
        <label for="author">Author:</label>
        <input type="text" id="author" name="author" required>
        <label for="isbn">ISBN:</label>
        <input type="text" id="isbn" name="isbn" required>
        <button type="submit">Add Book</button>
    </form>
    <h3>Book List</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>ISBN</th>
            <th>Available</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="book" items="${books}">
            <tr>
                <td><c:out value="${book.bookId}"/></td>
                <td><c:out value="${book.title}"/></td>
                <td><c:out value="${book.author}"/></td>
                <td><c:out value="${book.isbn}"/></td>
                <td><c:out value="${book.available ? 'Yes' : 'No'}"/></td>
                <td>
                    <form action="books" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="bookId" value="${book.bookId}">
                        <button type="submit">Delete</button>
                    </form>
                    <form action="books" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="bookId" value="${book.bookId}">
                        <input type="text" name="title" value="${book.title}" required>
                        <input type="text" name="author" value="${book.author}" required>
                        <input type="text" name="isbn" value="${book.isbn}" required>
                        <button type="submit">Update</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</main>
<jsp:include page="footer.jsp"/>
</body>
</html>