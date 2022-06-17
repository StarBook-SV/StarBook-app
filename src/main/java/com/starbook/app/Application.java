package com.starbook.app;

import com.starbook.app.dao.Database;

import java.sql.Connection;

public class Application {

    public static void main(String[] args) {
        Database database = new Database();
        Connection connection;

        //Test Conexion a la BD
        //Intentamos conectarnos
        connection = database.getConnection();

        //Y nos desconectamos
        database.close();

    }

}
