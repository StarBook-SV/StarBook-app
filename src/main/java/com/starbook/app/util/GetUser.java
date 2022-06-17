package com.starbook.app.util;

import com.starbook.app.dao.Database;
import com.starbook.app.dao.UserDAO;
import com.starbook.app.domain.User;
import com.starbook.app.exception.UserNotFoundException;

import java.sql.Connection;
import java.sql.SQLException;

public class GetUser {
    public static User getUser(String username, String password){
        Database database = new Database();
        Connection connection = database.getConnection();

        UserDAO userDAO = new UserDAO(connection);
        User user = null;

        try{
            user = userDAO.login(username,password).orElseThrow(UserNotFoundException::new);
        } catch (SQLException sqle){

        } catch (UserNotFoundException une){

        } finally {
            database.close();
        }

        return user;
    }
}
