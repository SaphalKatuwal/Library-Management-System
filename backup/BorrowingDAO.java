package com.library.dao;

import com.library.model.Borrowing;
import com.library.util.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class BorrowingDAO {
    private static final BigDecimal FINE_PER_DAY = new BigDecimal("1.00");

    public void addBorrowing(Borrowing borrowing) throws SQLException {
        String sql = "INSERT INTO Borrowings (book_id, member_id, borrow_date, due_date) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, borrowing.getBookId());
            stmt.setInt(2, borrowing.getMemberId());
            stmt.setObject(3, borrowing.getBorrowDate());
            stmt.setObject(4, borrowing.getDueDate());
            stmt.executeUpdate();
        }
    }

    public void updateBorrowing(Borrowing borrowing) throws SQLException {
        String sql = "UPDATE Borrowings SET book_id = ?, member_id = ?, borrow_date = ?, due_date = ?, return_date = ?, fine_amount = ? WHERE borrowing_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, borrowing.getBookId());
            stmt.setInt(2, borrowing.getMemberId());
            stmt.setObject(3, borrowing.getBorrowDate());
            stmt.setObject(4, borrowing.getDueDate());
            stmt.setObject(5, borrowing.getReturnDate());
            stmt.setBigDecimal(6, borrowing.getFineAmount());
            stmt.setInt(7, borrowing.getBorrowingId());
            stmt.executeUpdate();
        }
    }

    public void deleteBorrowing(int borrowingId) throws SQLException {
        String sql = "DELETE FROM Borrowings WHERE borrowing_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, borrowingId);
            stmt.executeUpdate();
        }
    }

    public Borrowing findBorrowingById(int borrowingId) throws SQLException {
        String sql = "SELECT * FROM Borrowings WHERE borrowing_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, borrowingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Borrowing borrowing = new Borrowing();
                borrowing.setBorrowingId(rs.getInt("borrowing_id"));
                borrowing.setBookId(rs.getInt("book_id"));
                borrowing.setMemberId(rs.getInt("member_id"));
                borrowing.setBorrowDate(rs.getObject("borrow_date", LocalDate.class));
                borrowing.setDueDate(rs.getObject("due_date", LocalDate.class));
                borrowing.setReturnDate(rs.getObject("return_date", LocalDate.class));
                borrowing.setFineAmount(rs.getBigDecimal("fine_amount"));
                return borrowing;
            }
            return null;
        }
    }

    public List<Borrowing> findBorrowingsByMember(int memberId) throws SQLException {
        List<Borrowing> borrowings = new ArrayList<>();
        String sql = "SELECT * FROM Borrowings WHERE member_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, memberId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Borrowing borrowing = new Borrowing();
                borrowing.setBorrowingId(rs.getInt("borrowing_id"));
                borrowing.setBookId(rs.getInt("book_id"));
                borrowing.setMemberId(rs.getInt("member_id"));
                borrowing.setBorrowDate(rs.getObject("borrow_date", LocalDate.class));
                borrowing.setDueDate(rs.getObject("due_date", LocalDate.class));
                borrowing.setReturnDate(rs.getObject("return_date", LocalDate.class));
                borrowing.setFineAmount(rs.getBigDecimal("fine_amount"));
                borrowings.add(borrowing);
            }
        }
        return borrowings;
    }

    public List<Borrowing> findOverdueBorrowings() throws SQLException {
        List<Borrowing> borrowings = new ArrayList<>();
        String sql = "SELECT * FROM Borrowings WHERE due_date < CURDATE() AND return_date IS NULL";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Borrowing borrowing = new Borrowing();
                borrowing.setBorrowingId(rs.getInt("borrowing_id"));
                borrowing.setBookId(rs.getInt("book_id"));
                borrowing.setMemberId(rs.getInt("member_id"));
                borrowing.setBorrowDate(rs.getObject("borrow_date", LocalDate.class));
                borrowing.setDueDate(rs.getObject("due_date", LocalDate.class));
                borrowing.setReturnDate(rs.getObject("return_date", LocalDate.class));
                borrowing.setFineAmount(rs.getBigDecimal("fine_amount"));
                borrowings.add(borrowing);
            }
        }
        return borrowings;
    }

    public BigDecimal calculateFine(Borrowing borrowing) {
        if (borrowing.getReturnDate() == null) {
            LocalDate today = LocalDate.now();
            if (today.isAfter(borrowing.getDueDate())) {
                long daysOverdue = ChronoUnit.DAYS.between(borrowing.getDueDate(), today);
                return FINE_PER_DAY.multiply(BigDecimal.valueOf(daysOverdue));
            }
        } else if (borrowing.getReturnDate().isAfter(borrowing.getDueDate())) {
            long daysOverdue = ChronoUnit.DAYS.between(borrowing.getDueDate(), borrowing.getReturnDate());
            return FINE_PER_DAY.multiply(BigDecimal.valueOf(daysOverdue));
        }
        return BigDecimal.ZERO;
    }
}