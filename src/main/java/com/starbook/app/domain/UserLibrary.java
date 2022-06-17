package com.starbook.app.domain;

public class UserLibrary {
    private String ISBN;
    private Integer idUser;
    private String status;
    private Integer page;

    public UserLibrary(String ISBN, Integer idUser, String status, Integer page) {
        this.ISBN = ISBN;
        this.idUser = idUser;
        this.status = status;
        this.page = page;
    }

    public UserLibrary() {
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    @Override
    public String toString() {
        return "UserLibrary{" +
                "ISBN='" + ISBN + '\'' +
                ", idUser=" + idUser +
                ", status='" + status + '\'' +
                ", page=" + page +
                '}';
    }
}
