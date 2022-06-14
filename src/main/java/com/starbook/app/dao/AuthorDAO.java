package com.starbook.app.dao;

import com.starbook.app.domain.Author;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AuthorDAO {
    private Connection connection;

    public AuthorDAO(Connection connection){this.connection = connection;}

    public List<Author> findAll() throws SQLException{
        String sql = "SELECT * FROM AUTHORS";
        List<Author> authors = new ArrayList<>();

        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();

        while(res.next()){
            Author author = fromResultSet(res);
            authors.add(author);
        }
        st.close();
        return authors;
    }

    public Optional<Author> findByID(Integer id) throws SQLException{
        String sql = "SELECT * FROM AUTHORS WHERE ID_AUTHOR = ?";
        Author author = null;

        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();

        while(res.next()){
            author = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(author);
    }

    private Author fromResultSet(ResultSet resultSet) throws SQLException{
        Author author = new Author();

        author.setId_author(resultSet.getInt("ID_AUTHOR"));
        author.setName(resultSet.getString("A_NAME"));
        author.setBiography(resultSet.getString("BIOGRAPHY"));

        //TODO: Hacer cuando este hecho la clase de utilidad de DateUtils
        //author.setBirthdate(resultSet.getString("BIRTHDATE"));
        //author.setDeathdate(resultSet.getString("DEATHDATE"));

        author.setNacionality(resultSet.getString("NACIONALITY"));

        return author;
    }
}
