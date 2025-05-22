package model;

import java.sql.*;

public class UserDAO {
    private Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }

    public boolean registerUser(User user) {
        try {
            String query = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPassword());
            pst.setString(4, user.getRole());
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public User login(String email, String plainPassword) {
        try {
            String query = "SELECT * FROM users WHERE email=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                if (PasswordUtil.checkPassword(plainPassword, hashedPassword)) {
                    User user = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                    );
                    user.setImageData(rs.getBytes("image_data"));
                    user.setImageType(rs.getString("image_type"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public java.util.List<User> getAllUsers() {
        java.util.List<User> users = new java.util.ArrayList<>();
        try {
            String query = "SELECT id, name, email, role FROM users";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                User user = new User(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("role")
                );
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean deleteUserById(int userId) {
        try {
            String query = "DELETE FROM users WHERE id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, userId);
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int getTotalMembers() throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'user'";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    public static void addUser(String name, String email, String password, String role, byte[] imageData, String imageType) throws Exception {
        Connection con = DBConnection.getConnection();
        String hashedPassword;
        try {
            // Ensure PasswordUtil is available for hashing
            hashedPassword = model.PasswordUtil.hashPassword(password);
        } catch (Exception e) {
            throw new Exception("Failed to hash password: " + e.getMessage());
        }
        String sql = "INSERT INTO users (name, email, password, role, image_data, image_type) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, hashedPassword);
        pstmt.setString(4, role);
        pstmt.setBytes(5, imageData);
        pstmt.setString(6, imageType);
        pstmt.executeUpdate();
    }

    public static User getUserById(int id) throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE id = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            User user = new User(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("role")
            );
            user.setImageData(rs.getBytes("image_data"));
            user.setImageType(rs.getString("image_type"));
            return user;
        }
        return null;
    }

    public static void updateUserImage(int userId, byte[] imageData, String imageType) throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "UPDATE users SET image_data=?, image_type=? WHERE id=?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setBytes(1, imageData);
        pstmt.setString(2, imageType);
        pstmt.setInt(3, userId);
        pstmt.executeUpdate();
    }

    public static void removeUserImage(int userId) throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "UPDATE users SET image_data=NULL, image_type=NULL WHERE id=?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, userId);
        pstmt.executeUpdate();
    }
} 