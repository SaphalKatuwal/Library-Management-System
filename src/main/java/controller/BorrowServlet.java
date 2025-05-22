package controller;

import model.BorrowDAO;
import model.BookDAO;
import dao.ActivityDAO;
import model.Borrow;
import model.Book;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.Calendar;

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {
    private BorrowDAO borrowDAO = new BorrowDAO();
    private BookDAO bookDAO = new BookDAO();
    private ActivityDAO activityDAO = new ActivityDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book book = null;
        try {
            book = bookDAO.getBookById(bookId);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error retrieving book details: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        boolean available = false;
        try {
            available = BorrowDAO.isBookAvailable(bookId);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error checking book availability: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/book-details?id=" + bookId);
            return;
        }
        if (book == null || !available) {
            session.setAttribute("error", "This book is not available for borrowing.");
            response.sendRedirect(request.getContextPath() + "/book-details?id=" + bookId);
            return;
        }

        // Set borrow date to current date
        Date borrowDate = new Date();
        
        // Set due date to 14 days from now
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(borrowDate);
        calendar.add(Calendar.DAY_OF_MONTH, 14);
        Date dueDate = calendar.getTime();

        try {
            System.out.println("Attempting to borrow: user_id=" + user.getUserID() + ", book_id=" + bookId);
            BorrowDAO.borrowBook(user.getUserID(), bookId);
            // Record the activity
            String description = "Borrowed '" + book.getTitle() + "' - Due: " + dueDate;
            activityDAO.addActivity(user.getUserID(), "BORROW", bookId, description);
            // Set success message
            session.setAttribute("successMessage", "Successfully borrowed '" + book.getTitle() + 
                "'. Due date: " + dueDate);
        } catch (Exception e) {
            session.setAttribute("error", "Failed to borrow the book: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/book-details?id=" + bookId);
    }
} 