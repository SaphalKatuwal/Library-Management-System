package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Book;
import model.BookDAO;

public class HomeServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("HomeServlet initialized");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("HomeServlet: Handling GET request for /");
        List<Book> books = new ArrayList<>();
        try {
            books = BookDAO.getAllBooks();
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("books", books);
        request.getRequestDispatcher("/View/jsp/home.jsp").forward(request, response);
    }
}