package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Borrow;
import model.Book;
import model.User;
import model.BorrowDAO;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet("/library_loans")
public class LibraryLoansServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Map<String, Object>> loans = BorrowDAO.getAllBorrowsWithDetails();
            request.setAttribute("loans", loans);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("loans", new ArrayList<>());
        }
        request.getRequestDispatcher("/View/jsp/library_loans.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String deleteBorrowId = request.getParameter("deleteBorrowId");
        boolean deleted = false;
        if (deleteBorrowId != null) {
            try {
                int borrowId = Integer.parseInt(deleteBorrowId);
                deleted = BorrowDAO.deleteBorrowById(borrowId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (!deleted && deleteBorrowId != null) {
            request.getSession().setAttribute("error", "Failed to delete borrow record. There may be related records in other tables.");
        }
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}