package com.library.controller;

import com.library.dao.ReviewDAO;
import com.library.model.Review;
import com.library.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            List<Review> reviews = reviewDAO.findReviewsByBook(bookId);
            request.setAttribute("reviews", reviews);
            request.setAttribute("bookId", bookId);
            request.getRequestDispatcher("reviews.jsp").forward(request, response);
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

            if ("add".equals(action)) {
                Review review = new Review();
                review.setBookId(Integer.parseInt(request.getParameter("bookId")));
                review.setMemberId(member.getMemberId());
                review.setRating(Integer.parseInt(request.getParameter("rating")));
                review.setComment(request.getParameter("comment"));
                review.setReviewDate(LocalDateTime.now());
                reviewDAO.addReview(review);
            }
            response.sendRedirect("reviews?bookId=" + request.getParameter("bookId"));
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}