package com.library.controller;

import com.library.dao.MemberDAO;
import com.library.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private MemberDAO memberDAO;

    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        Member member = new Member();
        member.setFirstName(firstName);
        member.setLastName(lastName);
        member.setEmail(email);
        member.setPassword(hashedPassword);
        member.setRole("MEMBER");

        try {
            memberDAO.saveMember(member);
            response.sendRedirect("auth.jsp?action=login");
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("auth.jsp?action=register").forward(request, response);
        }
    }
}