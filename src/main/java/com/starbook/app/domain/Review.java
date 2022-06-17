package com.starbook.app.domain;

public class Review {
    private Integer idReview;
    private String ISBN;
    private Integer idUser;
    private String title;
    private String description;
    private Integer stars;

    public Review(Integer idReview, String ISBN, Integer idUser, String title, String description, Integer stars) {
        this.idReview = idReview;
        this.ISBN = ISBN;
        this.idUser = idUser;
        this.title = title;
        this.description = description;
        this.stars = stars;
    }

    public Review() {
    }

    public Integer getIdReview() {
        return idReview;
    }

    public void setIdReview(Integer idReview) {
        this.idReview = idReview;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public Integer getIdUser() {
        return idUser;
    }

    public void setIdUser(Integer idUser) {
        this.idUser = idUser;
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

    public Integer getStars() {
        return stars;
    }

    public void setStars(Integer stars) {
        this.stars = stars;
    }
}
