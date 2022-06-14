package com.starbook.app.domain;

public class Book {
    private String ISBN;
    private Integer id_author;
    private Integer id_genre;
    private String title;
    private String description;
    private Integer pages;

    public Book(String ISBN, Integer id_author, Integer id_genre, String title, String description, Integer pages) {
        this.ISBN = ISBN;
        this.id_author = id_author;
        this.id_genre = id_genre;
        this.title = title;
        this.description = description;
        this.pages = pages;
    }

    public Book() {
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public Integer getId_author() {
        return id_author;
    }

    public void setId_author(Integer id_author) {
        this.id_author = id_author;
    }

    public Integer getId_genre() {
        return id_genre;
    }

    public void setId_genre(Integer id_genre) {
        this.id_genre = id_genre;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }

    @Override
    public String toString() {
        return "Book{" +
                "ISBN='" + ISBN + '\'' +
                ", id_author=" + id_author +
                ", id_genre=" + id_genre +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", pages=" + pages +
                '}';
    }
}
