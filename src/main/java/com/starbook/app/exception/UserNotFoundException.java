package com.starbook.app.exception;

public class UserNotFoundException extends Exception{
    public UserNotFoundException(){
        super("ERROR: User not found");
    }
}
