package com.library.controller;

import com.library.dao.BookDAO;
import com.library.model.Book;
import com.library.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
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

        Member member = (Member) session.getAttribute("user");
        if (!"ADMIN".equals(member.getRole())) {
            response.sendRedirect("dashboard");
            return;
        }

        try {
            List<Book> books = bookDAO.findAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("books.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error retrieving books", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"ADMIN".equals(((Member) session.getAttribute("user")).getRole())) {
            response.sendRedirect("auth.jsp?action=login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Book book = new Book();
                book.setTitle(request.getParameter("title"));
                book.setAuthor(request.getParameter("author"));
                book.setIsbn(request.getParameter("isbn"));
                book.setAvailable(true);
                bookDAO.saveBook(book);
            } else if ("delete".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                bookDAO.deleteBook(bookId);
            } else if ("edit".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                Book book = bookDAO.findBookById(bookId);
                if (book != null) {
                    book.setTitle(request.getParameter("title"));
                    book.setAuthor(request.getParameter("author"));
                    book.setIsbn(request.getParameter("isbn"));
                    bookDAO.updateBook(book);
                }
            }
            response.sendRedirect("books");
        } catch (Exception e) {
            throw new ServletException("Error processing book action", e);
        }
    }
}