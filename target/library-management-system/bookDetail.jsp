<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Details - Library</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<main class="container">
    <div class="card">
        <h2>${requestScope.book.title}</h2>
        <p><strong>Author:</strong> ${requestScope.book.author}</p>
        <p><strong>ISBN:</strong> ${requestScope.book.isbn}</p>
        <p><strong>Category:</strong> ${requestScope.category.name}</p>
        <p><strong>Publication Year:</strong> ${requestScope.book.publicationYear}</p>
        <p><strong>Available Copies:</strong> ${requestScope.book.availableCopies} / ${requestScope.book.totalCopies}</p>
        <c:if test="${not empty sessionScope.member and requestScope.book.availableCopies > 0}">
            <form action="${pageContext.request.contextPath}/borrowings" method="post">
                <input type="hidden" name="action" value="borrow">
                <input type="hidden" name="bookId" value="${requestScope.book.bookId}">
                <button type="submit">Borrow Book</button>
            </form>
        </c:if>
    </div>
    <div class="card">
        <h2>Reviews</h2>
        <c:if test="${empty requestScope.reviews}">
            <p>No reviews yet.</p>
        </c:if>
        <c:forEach var="review" items="${requestScope.reviews}">
            <div class="card" style="margin: 0.5rem 0;">
                <p><strong>Rating:</strong> ${review.rating}/5</p>
                <p><strong>Comment:</strong> ${review.comment}</p>
                <p><strong>By:</strong> ${review.memberId} on ${review.reviewDate}</p>
            </div>
        </c:forEach>
        <c:if test="${not empty sessionScope.member}">
            <h3>Add a Review</h3>
            <form action="${pageContext.request.contextPath}/reviews" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="bookId" value="${requestScope.book.bookId}">
                <div class="form-group">
                    <label for="rating">Rating (1-5)</label>
                    <input type="number" id="rating" name="rating" min="1" max="5" required>
                </div>
                <div class="form-group">
                    <label for="comment">Comment</label>
                    <textarea id="comment" name="comment" rows="4" required></textarea>
                </div>
                <button type="submit">Submit Review</button>
            </form>
        </c:if>
    </div>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>