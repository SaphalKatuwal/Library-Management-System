package controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.BookDAO;
@jakarta.servlet.annotation.WebServlet("/books")
public class BooksServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            java.util.List<Book> books = BookDAO.getAllBooks();
            request.setAttribute("books", books);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("books", new java.util.ArrayList<Book>());
        }
        request.getRequestDispatcher("/View/jsp/books.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String deleteBookId = request.getParameter("deleteBookId");
        boolean deleted = false;
        if (deleteBookId != null) {
            try {
                int bookId = Integer.parseInt(deleteBookId);
                deleted = model.BookDAO.deleteBookById(bookId);
                System.out.println("Delete book " + bookId + ": " + deleted);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (!deleted && deleteBookId != null) {
            request.getSession().setAttribute("error", "Failed to delete book. There may be related records in other tables.");
        }
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}