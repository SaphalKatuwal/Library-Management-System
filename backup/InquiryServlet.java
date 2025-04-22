package com.library.controller;

import com.library.dao.InquiryDAO;
import com.library.model.Inquiry;
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

@WebServlet("/inquiries")
public class InquiryServlet extends HttpServlet {
    private InquiryDAO inquiryDAO;

    @Override
    public void init() throws ServletException {
        inquiryDAO = new InquiryDAO();
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

            if ("pending".equals(action) && ("ADMIN".equals(member.getRole()) || "LIBRARIAN".equals(member.getRole()))) {
                List<Inquiry> inquiries = inquiryDAO.findPendingInquiries();
                request.setAttribute("inquiries", inquiries);
                request.getRequestDispatcher("pendingInquiries.jsp").forward(request, response);
            } else {
                List<Inquiry> inquiries = inquiryDAO.findInquiriesByMember(member.getMemberId());
                request.setAttribute("inquiries", inquiries);
                request.getRequestDispatcher("inquiries.jsp").forward(request, response);
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

            if ("submit".equals(action)) {
                Inquiry inquiry = new Inquiry();
                inquiry.setMemberId(member.getMemberId());
                inquiry.setSubject(request.getParameter("subject"));
                inquiry.setMessage(request.getParameter("message"));
                inquiry.setSubmissionDate(LocalDateTime.now());
                inquiry.setStatus("PENDING");
                inquiryDAO.addInquiry(inquiry);
            } else if ("respond".equals(action) && ("ADMIN".equals(member.getRole()) || "LIBRARIAN".equals(member.getRole()))) {
                int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));
                Inquiry inquiry = inquiryDAO.findInquiryById(inquiryId);
                if (inquiry != null) {
                    inquiry.setResponse(request.getParameter("response"));
                    inquiry.setStatus("RESOLVED");
                    inquiryDAO.updateInquiry(inquiry);
                }
            }
            response.sendRedirect("inquiries");
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}