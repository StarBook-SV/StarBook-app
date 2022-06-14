package com.starbook.app.domain;

import java.time.LocalDate;

public class Author {
    private Integer id_author;
    private String name;
    private String biography;
    private LocalDate birthdate;
    private LocalDate deathdate;
    private String nacionality;

    public Author(Integer id_author, String name, String biography, LocalDate birthdate, LocalDate deathdate, String nacionality) {
        this.id_author = id_author;
        this.name = name;
        this.biography = biography;
        this.birthdate = birthdate;
        this.deathdate = deathdate;
        this.nacionality = nacionality;
    }

    public Author() {
    }

    public Integer getId_author() {
        return id_author;
    }

    public void setId_author(Integer id_author) {
        this.id_author = id_author;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBiography() {
        return biography;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    public LocalDate getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(LocalDate birthdate) {
        this.birthdate = birthdate;
    }

    public LocalDate getDeathdate() {
        return deathdate;
    }

    public void setDeathdate(LocalDate deathdate) {
        this.deathdate = deathdate;
    }

    public String getNacionality() {
        return nacionality;
    }

    public void setNacionality(String nacionality) {
        this.nacionality = nacionality;
    }

    @Override
    public String toString() {
        return "Author{" +
                "id_author=" + id_author +
                ", name='" + name + '\'' +
                ", biography='" + biography + '\'' +
                ", birthdate=" + birthdate +
                ", deathdate=" + deathdate +
                ", nacionality='" + nacionality + '\'' +
                '}';
    }
}
