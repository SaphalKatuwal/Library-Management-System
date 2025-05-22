package model;

import java.util.Date;

public class Activity {
    private int id;
    private int userId;
    private String activityType; // "BORROW", "RETURN", etc.
    private int bookId;
    private Date activityDate;
    private String description;

    public Activity(int id, int userId, String activityType, int bookId, Date activityDate, String description) {
        this.id = id;
        this.userId = userId;
        this.activityType = activityType;
        this.bookId = bookId;
        this.activityDate = activityDate;
        this.description = description;
    }

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getActivityType() { return activityType; }
    public int getBookId() { return bookId; }
    public Date getActivityDate() { return activityDate; }
    public String getDescription() { return description; }
} 