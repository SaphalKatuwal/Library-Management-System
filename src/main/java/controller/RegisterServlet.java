package controller;

import model.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        byte[] imageData = null;
        String imageType = null;
        Part imagePart = req.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            imageType = imagePart.getContentType();
            java.io.InputStream is = imagePart.getInputStream();
            imageData = is.readAllBytes();
        }

        try {
            if (imageData != null && imageType != null) {
                // Use static addUser for image support
                model.UserDAO.addUser(name, email, password, role, imageData, imageType);
            } else {
                // Fallback to old logic if no image
                Connection con = DBConnection.getConnection();
                User user = new User(name, email, password, role);
                UserDAO dao = new UserDAO(con);
                dao.registerUser(user);
            }
            res.sendRedirect("View/jsp/login.jsp?success=Registered Successfully");
        } catch (Exception e) {
            e.printStackTrace();
            res.setContentType("text/plain");
            res.getWriter().write("Registration error: " + e.getMessage());
        }
    }
} 