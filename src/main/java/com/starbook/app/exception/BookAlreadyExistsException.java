package com.starbook.app.exception;

public class BookAlreadyExistsException extends Exception {
    public BookAlreadyExistsException() {
        super("ERROR: That book is already registered in our database");
    }
}
