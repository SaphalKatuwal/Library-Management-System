package com.library.dao;

import com.library.model.Inquiry;
import com.library.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class InquiryDAO {
    public void addInquiry(Inquiry inquiry) throws SQLException {
        String sql = "INSERT INTO Inquiries (member_id, subject, message, submission_date, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, inquiry.getMemberId());
            stmt.setString(2, inquiry.getSubject());
            stmt.setString(3, inquiry.getMessage());
            stmt.setObject(4, inquiry.getSubmissionDate());
            stmt.setString(5, inquiry.getStatus());
            stmt.executeUpdate();
        }
    }

    public void updateInquiry(Inquiry inquiry) throws SQLException {
        String sql = "UPDATE Inquiries SET member_id = ?, subject = ?, message = ?, submission_date = ?, status = ?, response = ? WHERE inquiry_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, inquiry.getMemberId());
            stmt.setString(2, inquiry.getSubject());
            stmt.setString(3, inquiry.getMessage());
            stmt.setObject(4, inquiry.getSubmissionDate());
            stmt.setString(5, inquiry.getStatus());
            stmt.setString(6, inquiry.getResponse());
            stmt.setInt(7, inquiry.getInquiryId());
            stmt.executeUpdate();
        }
    }

    public void deleteInquiry(int inquiryId) throws SQLException {
        String sql = "DELETE FROM Inquiries WHERE inquiry_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, inquiryId);
            stmt.executeUpdate();
        }
    }

    public Inquiry findInquiryById(int inquiryId) throws SQLException {
        String sql = "SELECT * FROM Inquiries WHERE inquiry_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, inquiryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Inquiry inquiry = new Inquiry();
                inquiry.setInquiryId(rs.getInt("inquiry_id"));
                inquiry.setMemberId(rs.getInt("member_id"));
                inquiry.setSubject(rs.getString("subject"));
                inquiry.setMessage(rs.getString("message"));
                inquiry.setSubmissionDate(rs.getObject("submission_date", LocalDateTime.class));
                inquiry.setStatus(rs.getString("status"));
                inquiry.setResponse(rs.getString("response"));
                return inquiry;
            }
            return null;
        }
    }

    public List<Inquiry> findInquiriesByMember(int memberId) throws SQLException {
        List<Inquiry> inquiries = new ArrayList<>();
        String sql = "SELECT * FROM Inquiries WHERE member_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, memberId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Inquiry inquiry = new Inquiry();
                inquiry.setInquiryId(rs.getInt("inquiry_id"));
                inquiry.setMemberId(rs.getInt("member_id"));
                inquiry.setSubject(rs.getString("subject"));
                inquiry.setMessage(rs.getString("message"));
                inquiry.setSubmissionDate(rs.getObject("submission_date", LocalDateTime.class));
                inquiry.setStatus(rs.getString("status"));
                inquiry.setResponse(rs.getString("response"));
                inquiries.add(inquiry);
            }
        }
        return inquiries;
    }

    public List<Inquiry> findPendingInquiries() throws SQLException {
        List<Inquiry> inquiries = new ArrayList<>();
        String sql = "SELECT * FROM Inquiries WHERE status = 'PENDING'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Inquiry inquiry = new Inquiry();
                inquiry.setInquiryId(rs.getInt("inquiry_id"));
                inquiry.setMemberId(rs.getInt("member_id"));
                inquiry.setSubject(rs.getString("subject"));
                inquiry.setMessage(rs.getString("message"));
                inquiry.setSubmissionDate(rs.getObject("submission_date", LocalDateTime.class));
                inquiry.setStatus(rs.getString("status"));
                inquiry.setResponse(rs.getString("response"));
                inquiries.add(inquiry);
            }
        }
        return inquiries;
    }
}