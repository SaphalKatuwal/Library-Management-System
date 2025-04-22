package com.library.model;

import java.time.LocalDateTime;

public class Inquiry {
    private int inquiryId;
    private int memberId;
    private String subject; // Limited to 100 characters in database
    private String message;
    private LocalDateTime submissionDate;
    private String status;
    private String response;

    // Constructors
    public Inquiry() {}

    public Inquiry(int inquiryId, int memberId, String subject, String message, LocalDateTime submissionDate, String status, String response) {
        this.inquiryId = inquiryId;
        this.memberId = memberId;
        this.subject = subject;
        this.message = message;
        this.submissionDate = submissionDate;
        this.status = status;
        this.response = response;
    }

    // Getters and Setters
    public int getInquiryId() {
        return inquiryId;
    }

    public void setInquiryId(int inquiryId) {
        this.inquiryId = inquiryId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public LocalDateTime getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(LocalDateTime submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    @Override
    public String toString() {
        return "Inquiry{" +
                "inquiryId=" + inquiryId +
                ", memberId=" + memberId +
                ", subject='" + subject + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}