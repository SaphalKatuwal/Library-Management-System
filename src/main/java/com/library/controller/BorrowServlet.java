package com.library.controller;

import com.library.dao.BookDAO;
import com.library.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {
    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("auth.jsp?action=login");
            return;
        }

        try {
            request.getRequestDispatcher("borrow.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error displaying borrow page", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("auth.jsp?action=login");
            return;
        }

        Member member = (Member) session.getAttribute("user");
        String action = request.getParameter("action");
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try {
            if ("borrow".equals(action)) {
                bookDAO.borrowBook(bookId, member.getMemberId());
            } else if ("return".equals(action)) {
                bookDAO.returnBook(bookId);
            }
            response.sendRedirect("dashboard");
        } catch (Exception e) {
            throw new ServletException("Error processing borrow/return action", e);
        }
    }
}