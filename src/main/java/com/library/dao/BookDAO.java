package com.library.dao;

import com.library.model.Book;
import com.library.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    public void saveBook(Book book) throws SQLException {
        String sql = "INSERT INTO Books (title, author, isbn, available) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getIsbn());
            stmt.setBoolean(4, book.isAvailable());
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    book.setBookId(rs.getInt(1));
                }
            }
        }
    }

    public List<Book> findAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM Books";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setIsbn(rs.getString("isbn"));
                book.setAvailable(rs.getBoolean("available"));
                books.add(book);
            }
        }
        return books;
    }

    public Book findBookById(int bookId) throws SQLException {
        String sql = "SELECT * FROM Books WHERE book_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setAvailable(rs.getBoolean("available"));
                    return book;
                }
            }
        }
        return null;
    }

    public void updateBook(Book book) throws SQLException {
        String sql = "UPDATE Books SET title = ?, author = ?, isbn = ?, available = ? WHERE book_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getIsbn());
            stmt.setBoolean(4, book.isAvailable());
            stmt.setInt(5, book.getBookId());
            stmt.executeUpdate();
        }
    }

    public void deleteBook(int bookId) throws SQLException {
        String sql = "DELETE FROM Books WHERE book_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            stmt.executeUpdate();
        }
    }

    public void borrowBook(int bookId, int memberId) throws SQLException {
        String sql = "INSERT INTO Transactions (book_id, member_id, borrow_date) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            stmt.setInt(2, memberId);
            stmt.setDate(3, new Date(System.currentTimeMillis()));
            stmt.executeUpdate();

            Book book = findBookById(bookId);
            if (book != null) {
                book.setAvailable(false);
                updateBook(book);
            }
        }
    }

    public void returnBook(int bookId) throws SQLException {
        String sql = "UPDATE Transactions SET return_date = ? WHERE book_id = ? AND return_date IS NULL";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, new Date(System.currentTimeMillis()));
            stmt.setInt(2, bookId);
            stmt.executeUpdate();

            Book book = findBookById(bookId);
            if (book != null) {
                book.setAvailable(true);
                updateBook(book);
            }
        }
    }
}