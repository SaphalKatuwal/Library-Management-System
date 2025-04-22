<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Library Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f4f4f4;
            color: #333;
        }

        header {
            background-color: #333;
            color: white;
            padding: 1em;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            font-size: 1.5em;
        }

        nav a {
            color: white;
            margin: 0 1em;
            text-decoration: none;
        }

        nav a:hover {
            text-decoration: underline;
        }

        main {
            padding: 2em;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        main h2 {
            font-size: 2em;
            margin-bottom: 0.5em;
        }

        main p.subtitle {
            font-size: 1.1em;
            color: #666;
            margin-bottom: 2em;
        }

        .search-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 3em;
        }

        .search-bar input {
            padding: 0.5em;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 4px 0 0 4px;
            font-size: 1em;
        }

        .search-bar button {
            padding: 0.5em 1em;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            font-size: 1em;
        }

        .search-bar button:hover {
            background-color: #555;
        }

        .collection-section {
            margin-top: 2em;
        }

        .collection-section h3 {
            font-size: 1.5em;
            margin-bottom: 1em;
            text-align: left;
            color: #666;
        }

        .cards {
            display: flex;
            justify-content: space-between;
            gap: 1em;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 30%;
            padding: 1em;
            text-align: left;
        }

        .card h4 {
            font-size: 1.2em;
            margin-bottom: 0.5em;
        }

        .card p {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 1em;
        }

        .card a {
            display: inline-block;
            padding: 0.5em 1em;
            background-color: #333;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        .card a:hover {
            background-color: #555;
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 1em;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
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
                <a href="auth?action=register">Register</a>
                <a href="auth?action=login">Login</a>
            </c:otherwise>
        </c:choose>
        <a href="books">Books</a>
    </nav>
</header>
<main>
    <h2>Welcome to Library Management System</h2>
    <p class="subtitle">Your one-stop digital library for managing books, members, and lending history</p>
    <div class="search-bar">
        <input type="text" placeholder="Search for books">
        <button>Search</button>
    </div>
    <div class="collection-section">
        <h3>Explore Our Collection</h3>
        <div class="cards">
            <div class="card">
                <h4>The Great Gatsby</h4>
                <p>A classic novel by F. Scott Fitzgerald exploring themes of wealth and ambition.</p>
                <a href="books?bookId=1">View Details</a>
            </div>
            <div class="card">
                <h4>1984</h4>
                <p>George Orwell's dystopian masterpiece about surveillance and control.</p>
                <a href="books?bookId=2">View Details</a>
            </div>
            <div class="card">
                <h4>Explore Classics</h4>
                <p>Discover more timeless classics in our collection.</p>
                <a href="books">Browse All</a>
            </div>
        </div>
    </div>
</main>
<footer>
    <p>© 2025 Library Management System. All rights reserved.</p>
</footer>
</body>
</html>