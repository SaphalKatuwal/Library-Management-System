package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.UserDAO;
import model.DBConnection;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/members")
public class MembersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            java.sql.Connection con = DBConnection.getConnection();
            UserDAO userDAO = new UserDAO(con);
            java.util.List<User> members = userDAO.getAllUsers();
            request.setAttribute("members", members);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("members", new java.util.ArrayList<User>());
        }
        request.getRequestDispatcher("/View/jsp/members.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String deleteUserId = request.getParameter("deleteUserId");
        boolean deleted = false;
        if (deleteUserId != null) {
            try {
                int userId = Integer.parseInt(deleteUserId);
                java.sql.Connection con = DBConnection.getConnection();
                UserDAO userDAO = new UserDAO(con);
                deleted = userDAO.deleteUserById(userId);
                System.out.println("Delete user " + userId + ": " + deleted);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (!deleted && deleteUserId != null) {
            request.getSession().setAttribute("error", "Failed to delete user. There may be related records in other tables.");
        }
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}