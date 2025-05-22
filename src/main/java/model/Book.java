package model;

public class Book {
    private int id;
    private String title;
    private String author;
    private String publisher;
    private String isbn;
    private int publicationYear;
    private String genre;
    private int pages;
    private byte[] imageData;
    private String imageType;

    public Book(int id, String title, String author, String publisher, String isbn, int publicationYear, String genre, int pages, byte[] imageData, String imageType) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.isbn = isbn;
        this.publicationYear = publicationYear;
        this.genre = genre;
        this.pages = pages;
        this.imageData = imageData;
        this.imageType = imageType;
    }

    // Getters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public String getPublisher() { return publisher; }
    public String getIsbn() { return isbn; }
    public int getPublicationYear() { return publicationYear; }
    public String getGenre() { return genre; }
    public int getPages() { return pages; }
    public byte[] getImageData() { return imageData; }
    public String getImageType() { return imageType; }

    // Setters
    public void setPages(int pages) { this.pages = pages; }
    public void setImageData(byte[] imageData) { this.imageData = imageData; }
    public void setImageType(String imageType) { this.imageType = imageType; }
}