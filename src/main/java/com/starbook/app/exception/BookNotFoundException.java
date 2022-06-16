package com.starbook.app.exception;

public class BookNotFoundException extends Exception{
    public BookNotFoundException(){super("ERROR: Book not found.");
    }
}
