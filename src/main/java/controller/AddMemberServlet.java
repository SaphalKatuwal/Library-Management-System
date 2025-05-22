package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.UserDAO;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/add_member")
public class AddMemberServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message;
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            Part imagePart = request.getPart("image");
            byte[] imageData = null;
            String imageType = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                imageType = imagePart.getContentType();
                try (InputStream inputStream = imagePart.getInputStream()) {
                    imageData = inputStream.readAllBytes();
                }
            }
            UserDAO.addUser(name, email, password, role, imageData, imageType);
            message = "Member added successfully!";
        } catch (Exception e) {
            e.printStackTrace();
            message = "Failed to add member: " + e.getMessage();
        }
        request.getSession().setAttribute("addMemberMessage", message);
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
} 