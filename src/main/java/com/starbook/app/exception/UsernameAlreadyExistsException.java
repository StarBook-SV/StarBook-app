package com.starbook.app.exception;

public class UsernameAlreadyExistsException extends Exception {
    public UsernameAlreadyExistsException() {
        super("ERROR: Username is taken, try a different one");
    }
}
