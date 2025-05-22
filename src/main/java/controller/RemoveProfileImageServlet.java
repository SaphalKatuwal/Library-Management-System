package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;

@WebServlet("/remove_profile_image")
public class RemoveProfileImageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try {
            model.UserDAO.removeUserImage(user.getUserID());
            user.setImageData(null);
            user.setImageType(null);
            session.setAttribute("user", user);
            session.setAttribute("successMessage", "Profile image removed.");
        } catch (Exception e) {
            session.setAttribute("error", "Failed to remove profile image.");
        }
        response.sendRedirect(request.getContextPath() + "/recent_activities");
    }
} 