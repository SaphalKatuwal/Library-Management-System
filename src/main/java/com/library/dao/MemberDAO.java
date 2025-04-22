package com.library.dao;

import com.library.model.Member;
import com.library.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
    public void saveMember(Member member) throws SQLException {
        String sql = "INSERT INTO Members (first_name, last_name, email, password, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, member.getFirstName());
            stmt.setString(2, member.getLastName());
            stmt.setString(3, member.getEmail());
            stmt.setString(4, member.getPassword());
            stmt.setString(5, member.getRole());
            stmt.executeUpdate();
        }
    }

    public List<Member> findAllMembers() throws SQLException {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT * FROM Members";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Member member = new Member();
                member.setMemberId(rs.getInt("member_id"));
                member.setFirstName(rs.getString("first_name"));
                member.setLastName(rs.getString("last_name"));
                member.setEmail(rs.getString("email"));
                member.setPassword(rs.getString("password"));
                member.setRole(rs.getString("role"));
                members.add(member);
            }
        }
        return members;
    }

    public Member findMemberByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM Members WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Member member = new Member();
                    member.setMemberId(rs.getInt("member_id"));
                    member.setFirstName(rs.getString("first_name"));
                    member.setLastName(rs.getString("last_name"));
                    member.setEmail(rs.getString("email"));
                    member.setPassword(rs.getString("password"));
                    member.setRole(rs.getString("role"));
                    return member;
                }
            }
        }
        return null;
    }
}