package dao;

import model.Activity;
import model.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO {
    
    public void addActivity(int userId, String activityType, int bookId, String description) {
        String sql = "INSERT INTO activities (user_id, activity_type, book_id, activity_date, description) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, activityType);
            stmt.setInt(3, bookId);
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            stmt.setString(5, description);
            
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Activity> getUserActivities(int userId) {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT * FROM activities WHERE user_id = ? ORDER BY activity_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                activities.add(new Activity(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("activity_type"),
                    rs.getInt("book_id"),
                    rs.getTimestamp("activity_date"),
                    rs.getString("description")
                ));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return activities;
    }

    public static List<Activity> getRecentActivities(int limit) {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT * FROM activities ORDER BY activity_date DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                activities.add(new Activity(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("activity_type"),
                    rs.getInt("book_id"),
                    rs.getTimestamp("activity_date"),
                    rs.getString("description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }
} 