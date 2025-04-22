package com.library.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Borrowing {
    private int borrowingId;
    private int bookId;
    private int memberId;
    private LocalDate borrowDate;
    private LocalDate dueDate;
    private LocalDate returnDate;
    private BigDecimal fineAmount;

    // Constructors
    public Borrowing() {
        this.fineAmount = BigDecimal.ZERO;
    }

    public Borrowing(int borrowingId, int bookId, int memberId, LocalDate borrowDate, LocalDate dueDate, LocalDate returnDate, BigDecimal fineAmount) {
        this.borrowingId = borrowingId;
        this.bookId = bookId;
        this.memberId = memberId;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
        this.fineAmount = (fineAmount != null) ? fineAmount : BigDecimal.ZERO;
    }

    // Getters and Setters
    public int getBorrowingId() {
        return borrowingId;
    }

    public void setBorrowingId(int borrowingId) {
        this.borrowingId = borrowingId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public LocalDate getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(LocalDate borrowDate) {
        this.borrowDate = borrowDate;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public BigDecimal getFineAmount() {
        return fineAmount;
    }

    public void setFineAmount(BigDecimal fineAmount) {
        this.fineAmount = (fineAmount != null) ? fineAmount : BigDecimal.ZERO;
    }

    @Override
    public String toString() {
        return "Borrowing{" +
                "borrowingId=" + borrowingId +
                ", bookId=" + bookId +
                ", memberId=" + memberId +
                ", borrowDate=" + borrowDate +
                ", dueDate=" + dueDate +
                ", returnDate=" + returnDate +
                ", fineAmount=" + fineAmount +
                '}';
    }
}