package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.BookDAO;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/add_book")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message;
        try {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            String isbn = request.getParameter("isbn");
            String genre = request.getParameter("genre");
            int publicationYear = 0;
            int pages = 0;
            
            try {
                publicationYear = Integer.parseInt(request.getParameter("publicationYear"));
            } catch (Exception ignored) {}
            
            try {
                pages = Integer.parseInt(request.getParameter("pages"));
            } catch (Exception ignored) {}

            // Handle image upload
            Part imagePart = request.getPart("image");
            byte[] imageData = null;
            String imageType = null;
            
            if (imagePart != null && imagePart.getSize() > 0) {
                imageType = imagePart.getContentType();
                try (InputStream inputStream = imagePart.getInputStream()) {
                    imageData = inputStream.readAllBytes();
                }
            }

            BookDAO.addBook(title, author, publisher, isbn, publicationYear, genre, pages, imageData, imageType);
            message = "Book added successfully!";
        } catch (Exception e) {
            e.printStackTrace();
            message = "Failed to add book: " + e.getMessage();
        }
        request.getSession().setAttribute("addBookMessage", message);
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
} 