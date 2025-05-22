package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.User;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/edit_profile")
@MultipartConfig
public class EditProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Part imagePart = request.getPart("image");
        byte[] imageData = null;
        String imageType = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            imageType = imagePart.getContentType();
            try (InputStream inputStream = imagePart.getInputStream()) {
                imageData = inputStream.readAllBytes();
            }
        }
        try {
            if (imageData != null) {
                model.UserDAO.updateUserImage(user.getUserID(), imageData, imageType);
                user.setImageData(imageData);
                user.setImageType(imageType);
                session.setAttribute("user", user);
                session.setAttribute("successMessage", "Profile image updated successfully!");
            } else {
                session.setAttribute("error", "No image selected.");
            }
        } catch (Exception e) {
            session.setAttribute("error", "Failed to update profile image.");
        }
        response.sendRedirect(request.getContextPath() + "/recent_activities");
    }
} 