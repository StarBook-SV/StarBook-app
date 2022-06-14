package com.starbook.app.domain;

import java.time.LocalDate;

public class Mail {
    private Integer idMail;
    private Integer idUserFrom;
    private Integer idUserTo;
    private LocalDate timestamp;
    private String message;

    public Mail(Integer idMail, Integer idUserFrom, Integer idUserTo, LocalDate timestamp, String message) {
        this.idMail = idMail;
        this.idUserFrom = idUserFrom;
        this.idUserTo = idUserTo;
        this.timestamp = timestamp;
        this.message = message;
    }

    public Mail() {
    }

    @Override
    public String toString() {
        return "Mail{" +
                "idMail=" + idMail +
                ", idUserFrom=" + idUserFrom +
                ", idUserTo=" + idUserTo +
                ", timestamp=" + timestamp +
                ", message='" + message + '\'' +
                '}';
    }

    public Integer getIdMail() {
        return idMail;
    }

    public void setIdMail(Integer idMail) {
        this.idMail = idMail;
    }

    public Integer getIdUserFrom() {
        return idUserFrom;
    }

    public void setIdUserFrom(Integer idUserFrom) {
        this.idUserFrom = idUserFrom;
    }

    public Integer getIdUserTo() {
        return idUserTo;
    }

    public void setIdUserTo(Integer idUserTo) {
        this.idUserTo = idUserTo;
    }

    public LocalDate getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDate timestamp) {
        this.timestamp = timestamp;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
