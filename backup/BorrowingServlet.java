package com.library.controller;

import com.library.dao.BookDAO;
import com.library.dao.BorrowingDAO;
import com.library.model.Borrowing;
import com.library.model.Book;
import com.library.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/borrowings")
public class BorrowingServlet extends HttpServlet {
    private BorrowingDAO borrowingDAO;
    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        borrowingDAO = new BorrowingDAO();
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            HttpSession session = request.getSession();
            Member member = (Member) session.getAttribute("member");
            if (member == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            if ("overdue".equals(action)) {
                List<Borrowing> borrowings = borrowingDAO.findOverdueBorrowings();
                request.setAttribute("borrowings", borrowings);
                request.getRequestDispatcher("overdueBorrowings.jsp").forward(request, response);
            } else {
                List<Borrowing> borrowings = borrowingDAO.findBorrowingsByMember(member.getMemberId());
                request.setAttribute("borrowings", borrowings);
                request.getRequestDispatcher("borrow.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            HttpSession session = request.getSession();
            Member member = (Member) session.getAttribute("member");
            if (member == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            if ("borrow".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                Book book = bookDAO.findBookById(bookId);
                if (book != null && book.getAvailableCopies() > 0) {
                    Borrowing borrowing = new Borrowing();
                    borrowing.setBookId(bookId);
                    borrowing.setMemberId(member.getMemberId());
                    borrowing.setBorrowDate(LocalDate.now());
                    borrowing.setDueDate(LocalDate.now().plusDays(7));
                    borrowingDAO.addBorrowing(borrowing);
                    book.setAvailableCopies(book.getAvailableCopies() - 1);
                    bookDAO.updateBook(book);
                }
            } else if ("return".equals(action)) {
                int borrowingId = Integer.parseInt(request.getParameter("borrowingId"));
                Borrowing borrowing = borrowingDAO.findBorrowingById(borrowingId);
                if (borrowing != null) {
                    borrowing.setReturnDate(LocalDate.now());
                    BigDecimal fine = borrowingDAO.calculateFine(borrowing);
                    borrowing.setFineAmount(fine);
                    borrowingDAO.updateBorrowing(borrowing);
                    Book book = bookDAO.findBookById(borrowing.getBookId());
                    book.setAvailableCopies(book.getAvailableCopies() + 1);
                    bookDAO.updateBook(book);
                }
            }
            response.sendRedirect("borrowings");
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}