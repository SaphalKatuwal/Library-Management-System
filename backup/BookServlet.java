package com.library.controller;

import com.library.dao.BookDAO;
import com.library.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
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
        String action = request.getParameter("action");
        try {
            if ("view".equals(action)) {
                Book book = bookDAO.findBookById(Integer.parseInt(request.getParameter("id")));
                request.setAttribute("book", book);
                request.getRequestDispatcher("bookDetail.jsp").forward(request, response);
            } else if ("search".equals(action)) {
                String keyword = request.getParameter("keyword");
                List<Book> books = bookDAO.searchBooks(keyword);
                request.setAttribute("books", books);
                request.getRequestDispatcher("books.jsp").forward(request, response);
            } else {
                List<Book> books = bookDAO.findAvailableBooks();
                request.setAttribute("books", books);
                request.getRequestDispatcher("books.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                Book book = new Book();
                book.setTitle(request.getParameter("title"));
                book.setAuthor(request.getParameter("author"));
                book.setIsbn(request.getParameter("isbn"));
                book.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                book.setPublicationYear(Integer.parseInt(request.getParameter("publicationYear")));
                book.setTotalCopies(Integer.parseInt(request.getParameter("totalCopies")));
                book.setAvailableCopies(Integer.parseInt(request.getParameter("totalCopies")));
                bookDAO.addBook(book);
            } else if ("update".equals(action)) {
                Book book = new Book();
                book.setBookId(Integer.parseInt(request.getParameter("bookId")));
                book.setTitle(request.getParameter("title"));
                book.setAuthor(request.getParameter("author"));
                book.setIsbn(request.getParameter("isbn"));
                book.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                book.setPublicationYear(Integer.parseInt(request.getParameter("publicationYear")));
                book.setTotalCopies(Integer.parseInt(request.getParameter("totalCopies")));
                book.setAvailableCopies(Integer.parseInt(request.getParameter("availableCopies")));
                bookDAO.updateBook(book);
            } else if ("delete".equals(action)) {
                bookDAO.deleteBook(Integer.parseInt(request.getParameter("bookId")));
            }
            response.sendRedirect("books");
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}