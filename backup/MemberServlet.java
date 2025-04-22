package com.library.controller;

import com.library.dao.MemberDAO;
import com.library.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/member")
public class MemberServlet extends HttpServlet {
    private MemberDAO memberDAO;

    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Member loggedInMember = (Member) request.getSession().getAttribute("member");

        if (loggedInMember == null) {
            response.sendRedirect("auth.jsp");
            return;
        }

        if ("list".equals(action) && "ADMIN".equals(loggedInMember.getRole())) {
            List<Member> members = memberDAO.getAllMembers();
            request.setAttribute("members", members);
            request.getRequestDispatcher("members.jsp").forward(request, response);
        } else {
            // Default: Load profile with history
            request.setAttribute("borrowings", memberDAO.getBorrowings(loggedInMember.getMemberId()));
            request.setAttribute("inquiries", memberDAO.getInquiries(loggedInMember.getMemberId()));
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Member loggedInMember = (Member) request.getSession().getAttribute("member");

        if (loggedInMember == null) {
            response.sendRedirect("auth.jsp");
            return;
        }

        if ("update".equals(action)) {
            // Update profile
            Member updatedMember = new Member();
            updatedMember.setMemberId(loggedInMember.getMemberId());
            updatedMember.setFirstName(request.getParameter("firstName"));
            updatedMember.setLastName(request.getParameter("lastName"));
            updatedMember.setEmail(request.getParameter("email"));
            updatedMember.setPhone(request.getParameter("phone"));
            updatedMember.setAddress(request.getParameter("address"));
            String password = request.getParameter("password");
            if (password != null && !password.isEmpty()) {
                updatedMember.setPassword(org.mindrot.jbcrypt.BCrypt.hashpw(password, org.mindrot.jbcrypt.BCrypt.gensalt()));
            } else {
                updatedMember.setPassword(loggedInMember.getPassword());
            }
            updatedMember.setRole(loggedInMember.getRole());

            boolean success = memberDAO.updateMember(updatedMember);
            if (success) {
                request.getSession().setAttribute("member", updatedMember);
                request.setAttribute("message", "Profile updated successfully.");
            } else {
                request.setAttribute("message", "Failed to update profile.");
            }
            request.setAttribute("borrowings", memberDAO.getBorrowings(loggedInMember.getMemberId()));
            request.setAttribute("inquiries", memberDAO.getInquiries(loggedInMember.getMemberId()));
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if ("edit".equals(action) && "ADMIN".equals(loggedInMember.getRole())) {
            // Update member role
            int memberId = Integer.parseInt(request.getParameter("memberId"));
            String role = request.getParameter("role");
            boolean success = memberDAO.updateMemberRole(memberId, role);
            if (success) {
                request.setAttribute("message", "Member role updated successfully.");
            } else {
                request.setAttribute("message", "Failed to update member role.");
            }
            List<Member> members = memberDAO.getAllMembers();
            request.setAttribute("members", members);
            request.getRequestDispatcher("members.jsp").forward(request, response);
        } else if ("delete".equals(action) && "ADMIN".equals(loggedInMember.getRole())) {
            // Delete member
            int memberId = Integer.parseInt(request.getParameter("memberId"));
            boolean success = memberDAO.deleteMember(memberId);
            if (success) {
                request.setAttribute("message", "Member deleted successfully.");
            } else {
                request.setAttribute("message", "Failed to delete member.");
            }
            List<Member> members = memberDAO.getAllMembers();
            request.setAttribute("members", members);
            request.getRequestDispatcher("members.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}