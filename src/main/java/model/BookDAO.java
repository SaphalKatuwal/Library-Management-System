package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookDAO {
    public static List<Book> getAllBooks() throws Exception {
        List<Book> books = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String query = "SELECT * FROM books";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            books.add(new Book(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("publisher"),
                rs.getString("isbn"),
                rs.getInt("publicationYear"),
                rs.getString("genre"),
                rs.getInt("pages"),
                rs.getBytes("image_data"),
                rs.getString("image_type")
            ));
        }
        return books;
    }

    public static Book getBookById(int id) throws Exception {
        Connection con = DBConnection.getConnection();
        String query = "SELECT * FROM books WHERE id = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            return new Book(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("publisher"),
                rs.getString("isbn"),
                rs.getInt("publicationYear"),
                rs.getString("genre"),
                rs.getInt("pages"),
                rs.getBytes("image_data"),
                rs.getString("image_type")
            );
        }
        return null;
    }

    public static List<Book> searchBooks(String query) throws Exception {
        List<Book> books = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM books WHERE " +
                    "LOWER(title) LIKE LOWER(?) OR " +
                    "LOWER(author) LIKE LOWER(?) OR " +
                    "LOWER(genre) LIKE LOWER(?)";
        
        PreparedStatement pstmt = con.prepareStatement(sql);
        String searchPattern = "%" + query + "%";
        pstmt.setString(1, searchPattern);
        pstmt.setString(2, searchPattern);
        pstmt.setString(3, searchPattern);
        
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            books.add(new Book(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("publisher"),
                rs.getString("isbn"),
                rs.getInt("publicationYear"),
                rs.getString("genre"),
                rs.getInt("pages"),
                rs.getBytes("image_data"),
                rs.getString("image_type")
            ));
        }
        return books;
    }

    public static boolean deleteBookById(int bookId) {
        try {
            Connection con = DBConnection.getConnection();
            // First, delete all borrows for this book
            String deleteBorrows = "DELETE FROM borrows WHERE book_id = ?";
            PreparedStatement pstBorrows = con.prepareStatement(deleteBorrows);
            pstBorrows.setInt(1, bookId);
            pstBorrows.executeUpdate();

            // Now, delete the book itself
            String query = "DELETE FROM books WHERE id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, bookId);
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int getTotalBooks() throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM books";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    public static List<Map<String, Object>> getPopularBooks(int limit) throws Exception {
        List<Map<String, Object>> popularBooks = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String sql = "SELECT b.*, COUNT(br.id) as borrow_count " +
                    "FROM books b " +
                    "LEFT JOIN borrows br ON b.id = br.book_id " +
                    "GROUP BY b.id " +
                    "ORDER BY borrow_count DESC " +
                    "LIMIT ?";
        
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, limit);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> book = new HashMap<>();
            book.put("id", rs.getInt("id"));
            book.put("title", rs.getString("title"));
            book.put("author", rs.getString("author"));
            book.put("borrowCount", rs.getInt("borrow_count"));
            popularBooks.add(book);
        }
        return popularBooks;
    }

    public static void addBook(String title, String author, String publisher, String isbn, int publicationYear, String genre, int pages, byte[] imageData, String imageType) throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "INSERT INTO books (title, author, publisher, isbn, publicationYear, genre, pages, image_data, image_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, author);
        pstmt.setString(3, publisher);
        pstmt.setString(4, isbn);
        pstmt.setInt(5, publicationYear);
        pstmt.setString(6, genre);
        pstmt.setInt(7, pages);
        pstmt.setBytes(8, imageData);
        pstmt.setString(9, imageType);
        pstmt.executeUpdate();
    }
} 