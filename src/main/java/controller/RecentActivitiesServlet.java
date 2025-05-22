package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpSession;
import model.BorrowDAO;
import model.BookDAO;
import model.Borrow;
import model.Book;
import model.User;


public class RecentActivitiesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Map<String, Object>> myBooks = new ArrayList<>();
        if (user != null) {
            try {
                List<Borrow> borrows = BorrowDAO.getUserBorrows(user.getUserID());
                for (Borrow borrow : borrows) {
                    Book book = BookDAO.getBookById(borrow.getBookId());
                    Map<String, Object> entry = new HashMap<>();
                    entry.put("bookTitle", book != null ? book.getTitle() : "Unknown");
                    entry.put("bookAuthor", book != null ? book.getAuthor() : "");
                    entry.put("bookImageURL", book != null && book.getImageData() != null ? request.getContextPath() + "/book-image/" + book.getId() : "");
                    entry.put("borrowDate", borrow.getBorrowDate());
                    entry.put("dueDate", borrow.getDueDate());
                    entry.put("status", borrow.getStatus());
                    entry.put("returnDate", borrow.getReturnDate());
                    entry.put("fine", borrow.getFine());
                    entry.put("borrowId", borrow.getId());
                    myBooks.add(entry);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        request.setAttribute("myBooks", myBooks);
        request.getRequestDispatcher("/View/jsp/recent_activities.jsp").forward(request, response);
    }
}