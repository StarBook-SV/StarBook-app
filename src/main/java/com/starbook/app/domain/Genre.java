package com.starbook.app.domain;

public class Genre {
    private Integer id_genre;
    private String name;
    private String description;

    public Genre(Integer id_genre, String name, String description) {
        this.id_genre = id_genre;
        this.name = name;
        this.description = description;
    }

    public Genre() {
    }

    public Integer getId_genre() {
        return id_genre;
    }

    public void setId_genre(Integer id_genre) {
        this.id_genre = id_genre;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Genre{" +
                "id_genre=" + id_genre +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
