package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;
import model.BookDAO;

import java.io.IOException;

@WebServlet("/book-image/*")
public class BookImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get book ID from URL
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.length() <= 1) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            int bookId = Integer.parseInt(pathInfo.substring(1));
            Book book = BookDAO.getBookById(bookId);
            
            if (book == null || book.getImageData() == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Set content type
            response.setContentType(book.getImageType());
            response.setContentLength(book.getImageData().length);
            
            // Write image data to response
            response.getOutputStream().write(book.getImageData());
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
} 