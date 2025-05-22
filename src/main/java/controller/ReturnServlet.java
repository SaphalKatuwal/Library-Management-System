package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BorrowDAO;
import dao.ActivityDAO;

import java.io.IOException;
import java.util.Date;

@WebServlet("/return")
public class ReturnServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String borrowIdStr = request.getParameter("borrowId");
        HttpSession session = request.getSession();
        if (borrowIdStr != null) {
            try {
                int borrowId = Integer.parseInt(borrowIdStr);
                BorrowDAO.returnBook(borrowId);
                double fine = 0.0;
                try {
                    model.Borrow borrow = BorrowDAO.getBorrowById(borrowId);
                    if (borrow != null) fine = borrow.getFine();
                } catch (Exception ex) { ex.printStackTrace(); }
                // Log activity
                try {
                    ActivityDAO activityDAO = new ActivityDAO();
                    activityDAO.addActivity((Integer) session.getAttribute("userId"), "RETURN", borrowId, "Returned book (borrowId: " + borrowId + ")");
                } catch (Exception ex) { ex.printStackTrace(); }
                if (fine > 0.0) {
                    session.setAttribute("successMessage", "Book returned successfully! Fine: $" + String.format("%.2f", fine));
                } else {
                    session.setAttribute("successMessage", "Book returned successfully!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Failed to return the book. Please try again.");
            }
        } else {
            session.setAttribute("error", "Invalid return request.");
        }
        response.sendRedirect(request.getContextPath() + "/recent_activities");
    }
} 