package com.library.dao;

import com.library.model.Review;
import com.library.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    public void addReview(Review review) throws SQLException {
        String sql = "INSERT INTO Reviews (book_id, member_id, rating, comment, review_date) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, review.getBookId());
            stmt.setInt(2, review.getMemberId());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getComment());
            stmt.setObject(5, review.getReviewDate());
            stmt.executeUpdate();
        }
    }

    public void updateReview(Review review) throws SQLException {
        String sql = "UPDATE Reviews SET book_id = ?, member_id = ?, rating = ?, comment = ?, review_date = ? WHERE review_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, review.getBookId());
            stmt.setInt(2, review.getMemberId());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getComment());
            stmt.setObject(5, review.getReviewDate());
            stmt.setInt(6, review.getReviewId());
            stmt.executeUpdate();
        }
    }

    public void deleteReview(int reviewId) throws SQLException {
        String sql = "DELETE FROM Reviews WHERE review_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            stmt.executeUpdate();
        }
    }

    public Review findReviewById(int reviewId) throws SQLException {
        String sql = "SELECT * FROM Reviews WHERE review_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setBookId(rs.getInt("book_id"));
                review.setMemberId(rs.getInt("member_id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewDate(rs.getObject("review_date", LocalDateTime.class));
                return review;
            }
            return null;
        }
    }

    public List<Review> findReviewsByBook(int bookId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM Reviews WHERE book_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setBookId(rs.getInt("book_id"));
                review.setMemberId(rs.getInt("member_id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewDate(rs.getObject("review_date", LocalDateTime.class));
                reviews.add(review);
            }
        }
        return reviews;
    }

    public List<Review> findAllReviews() throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM Reviews";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setBookId(rs.getInt("book_id"));
                review.setMemberId(rs.getInt("member_id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewDate(rs.getObject("review_date", LocalDateTime.class));
                reviews.add(review);
            }
        }
        return reviews;
    }
}