package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class BorrowDAO {
    public static void borrowBook(int userId, int bookId) throws Exception {
        Connection con = DBConnection.getConnection();
        
        // Calculate due date (14 days from now)
        Calendar cal = Calendar.getInstance();
        Date borrowDate = cal.getTime();
        cal.add(Calendar.DAY_OF_MONTH, 14);
        Date dueDate = cal.getTime();
        
        String sql = "INSERT INTO borrows (user_id, book_id, borrow_date, due_date, fine) VALUES (?, ?, ?, ?, 0.0)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, userId);
        pstmt.setInt(2, bookId);
        pstmt.setDate(3, new java.sql.Date(borrowDate.getTime()));
        pstmt.setDate(4, new java.sql.Date(dueDate.getTime()));
        pstmt.executeUpdate();
    }

    public static List<Borrow> getUserBorrows(int userId) throws Exception {
        List<Borrow> borrows = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM borrows WHERE user_id = ? ORDER BY borrow_date DESC";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, userId);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            borrows.add(new Borrow(
                rs.getInt("id"),
                rs.getInt("user_id"),
                rs.getInt("book_id"),
                rs.getDate("borrow_date"),
                rs.getDate("due_date"),
                rs.getDate("return_date"),
                rs.getDouble("fine")
            ));
        }
        return borrows;
    }

    public static boolean isBookAvailable(int bookId) throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM borrows WHERE book_id = ? AND return_date IS NULL";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, bookId);
        ResultSet rs = pstmt.executeQuery();
        rs.next();
        return rs.getInt(1) == 0;
    }

    public static void returnBook(int borrowId) throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "UPDATE borrows SET return_date = ?, fine = ? WHERE id = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        
        // Set return date to current date
        Date returnDate = new Date();
        pstmt.setDate(1, new java.sql.Date(returnDate.getTime()));
        
        // Calculate fine if overdue
        Borrow borrow = getBorrowById(borrowId);
        double fine = 0.0;
        if (returnDate.after(borrow.getDueDate())) {
            long diff = returnDate.getTime() - borrow.getDueDate().getTime();
            long diffDays = diff / (24 * 60 * 60 * 1000);
            fine = diffDays * 1.0; // $1 per day late
        }
        pstmt.setDouble(2, fine);
        pstmt.setInt(3, borrowId);
        pstmt.executeUpdate();
    }

    public static Borrow getBorrowById(int borrowId) throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM borrows WHERE id = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, borrowId);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            return new Borrow(
                rs.getInt("id"),
                rs.getInt("user_id"),
                rs.getInt("book_id"),
                rs.getDate("borrow_date"),
                rs.getDate("due_date"),
                rs.getDate("return_date"),
                rs.getDouble("fine")
            );
        }
        return null;
    }

    public static List<Borrow> getAllBorrows() throws Exception {
        List<Borrow> borrows = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM borrows ORDER BY borrow_date DESC";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            borrows.add(new Borrow(
                rs.getInt("id"),
                rs.getInt("user_id"),
                rs.getInt("book_id"),
                rs.getDate("borrow_date"),
                rs.getDate("due_date"),
                rs.getDate("return_date"),
                rs.getDouble("fine")
            ));
        }
        return borrows;
    }

    public static boolean deleteBorrowById(int borrowId) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM borrows WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, borrowId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<Map<String, Object>> getAllBorrowsWithDetails() throws Exception {
        List<Map<String, Object>> borrows = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String sql = "SELECT b.*, u.name, u.image_data, u.image_type, bk.title " +
                    "FROM borrows b " +
                    "JOIN users u ON b.user_id = u.id " +
                    "JOIN books bk ON b.book_id = bk.id " +
                    "ORDER BY b.borrow_date DESC";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> borrow = new HashMap<>();
            borrow.put("id", rs.getInt("id"));
            borrow.put("userId", rs.getInt("user_id"));
            borrow.put("bookId", rs.getInt("book_id"));
            borrow.put("username", rs.getString("name"));
            borrow.put("userImageData", rs.getBytes("image_data"));
            borrow.put("userImageType", rs.getString("image_type"));
            borrow.put("bookTitle", rs.getString("title"));
            borrow.put("borrowDate", rs.getDate("borrow_date"));
            borrow.put("dueDate", rs.getDate("due_date"));
            borrow.put("returnDate", rs.getDate("return_date"));
            borrow.put("fine", rs.getDouble("fine"));
            borrows.add(borrow);
        }
        return borrows;
    }

    public static int getActiveLoansCount() throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM borrows WHERE return_date IS NULL";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    public static int getOverdueBooksCount() throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM borrows WHERE return_date IS NULL AND due_date < CURDATE()";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    public static List<Map<String, Object>> getOverdueBooksList() throws Exception {
        List<Map<String, Object>> overdueBooks = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String sql = "SELECT b.*, br.due_date, u.name as borrower_name " +
                    "FROM borrows br " +
                    "JOIN books b ON br.book_id = b.id " +
                    "JOIN users u ON br.user_id = u.id " +
                    "WHERE br.return_date IS NULL AND br.due_date < CURDATE() " +
                    "ORDER BY br.due_date ASC";
        
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> book = new HashMap<>();
            book.put("id", rs.getInt("id"));
            book.put("title", rs.getString("title"));
            book.put("author", rs.getString("author"));
            book.put("dueDate", rs.getDate("due_date"));
            book.put("borrowerName", rs.getString("borrower_name"));
            overdueBooks.add(book);
        }
        return overdueBooks;
    }
} 