package com.starbook.app.util;

import com.starbook.app.dao.Database;
import com.starbook.app.dao.UserDAO;
import com.starbook.app.domain.User;
import com.starbook.app.exception.UserNotFoundException;

import java.sql.SQLException;

public class CheckLogin {
    public static boolean validate(String name, String password) {
        Database database = new Database();
        UserDAO userDAO = new UserDAO(database.getConnection());
        User actualUser = null;
        try {
            System.out.println("Nombre y contrasenia pasada por parametro: " + name + " " + password);
            actualUser = userDAO.login(name, password).orElseThrow(UserNotFoundException::new);
            System.out.println("Nombre y rol del usuario conseguido:");
            System.out.println(actualUser.getName());
            System.out.println(actualUser.getRole());
            database.close();
        } catch (SQLException sqle) {
            System.out.println("Ha habido un error con la base de datos");
            sqle.printStackTrace();
            database.close();
            return false;
        } catch (UserNotFoundException une) {
            System.out.println(une.getMessage());
            database.close();
            return false;
        } finally {
            database.close();
        }
        return true;
    }
}
