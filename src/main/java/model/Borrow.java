package model;

import java.util.Date;

public class Borrow {
    // Instance variables
    private int id;
    private int userId;
    private int bookId;
    private Date borrowDate;
    private Date dueDate;
    private Date returnDate;
    private double fine;
    private String status; // "BORROWED", "RETURNED", "OVERDUE"

    // Constructors
    public Borrow() {
    }

    public Borrow(int id, int userId, int bookId, Date borrowDate, Date dueDate, Date returnDate, double fine) {
        this.id = id;
        this.userId = userId;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
        this.fine = fine;
        this.status = returnDate != null ? "RETURNED" : 
                     (new Date().after(dueDate) ? "OVERDUE" : "BORROWED");
    }

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public int getBookId() { return bookId; }
    public Date getBorrowDate() { return borrowDate; }
    public Date getDueDate() { return dueDate; }
    public Date getReturnDate() { return returnDate; }
    public double getFine() { return fine; }
    public String getStatus() { return status; }

    // Setters
    public void setReturnDate(Date returnDate) { 
        this.returnDate = returnDate;
        this.status = "RETURNED";
    }
    public void setFine(double fine) { this.fine = fine; }
}