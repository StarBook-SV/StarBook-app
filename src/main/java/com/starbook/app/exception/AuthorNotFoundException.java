package com.starbook.app.exception;

public class AuthorNotFoundException extends Exception {
    public AuthorNotFoundException() {
        super("ERROR: Author not found");
    }
}
