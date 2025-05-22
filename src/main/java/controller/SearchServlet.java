package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;
import model.BookDAO;

import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String query = request.getParameter("query");
            
            if (query != null && !query.trim().isEmpty()) {
                List<Book> searchResults = BookDAO.searchBooks(query.trim());
                request.setAttribute("books", searchResults);
                request.setAttribute("searchQuery", query);
            } else {
                // If no search query, show all books
                request.setAttribute("books", BookDAO.getAllBooks());
            }
            
            request.getRequestDispatcher("/View/jsp/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
} 