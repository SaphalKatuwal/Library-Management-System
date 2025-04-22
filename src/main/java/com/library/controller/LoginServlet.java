package com.library.controller;

import com.library.dao.MemberDAO;
import com.library.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private MemberDAO memberDAO;

    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        try {
            Member member = memberDAO.findMemberByEmail(email);
            if (member != null && BCrypt.checkpw(password, member.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("user", member);

                if ("on".equals(rememberMe)) {
                    Cookie emailCookie = new Cookie("email", email);
                    emailCookie.setMaxAge(30 * 24 * 60 * 60);
                    response.addCookie(emailCookie);
                } else {
                    Cookie emailCookie = new Cookie("email", "");
                    emailCookie.setMaxAge(0);
                    response.addCookie(emailCookie);
                }

                response.sendRedirect("dashboard");
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("auth.jsp?action=login").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Login failed", e);
        }
    }
}