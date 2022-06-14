package com.starbook.app.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static com.starbook.app.util.Constants.*;

public class Database {

    private Connection connection;

    public Connection getConnection(){
        try{
            Class.forName(ORACLE_DRIVER);
            connection = DriverManager.getConnection(ORACLE_URL, USERNAME, PASSWORD);
            System.out.println("Conectado a la base de datos!");
        } catch (ClassNotFoundException cnfe){
            System.out.println("No se ha podido cargar el driver de conexion. Verifique que los drivers estan disponibles.");
            cnfe.getStackTrace();
        } catch (SQLException sqle){
            System.out.println("No se ha podido conectar con el servidor de base de datos. Comprueba que el servidor esta conectado y los datos son correctos.");
            sqle.getStackTrace();
        }

        return connection;
    }

    public void close(){
        try{
            connection.close();
            System.out.println("Desconectado de la base de datos.");
        } catch (SQLException sqle){
            System.out.println("No se ha podido cerrar la conexion. Comprueba que la conexion estaba iniciada y que los datos son correctos.");
            sqle.getStackTrace();
        }
    }
}
