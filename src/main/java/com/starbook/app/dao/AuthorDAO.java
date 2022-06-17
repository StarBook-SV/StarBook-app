package com.starbook.app.dao;

import com.starbook.app.domain.Author;
import com.starbook.app.util.DateUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AuthorDAO {
    private Connection connection;

    public AuthorDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Author> findAll() throws SQLException {
        String sql = "SELECT * FROM AUTHORS";
        List<Author> authors = new ArrayList<>();

        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();

        while (res.next()) {
            Author author = fromResultSet(res);
            authors.add(author);
        }
        st.close();
        return authors;
    }

    public Optional<Author> findByID(Integer id) throws SQLException {
        String sql = "SELECT * FROM AUTHORS WHERE ID_AUTHOR = ?";
        Author author = null;

        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        ResultSet res = st.executeQuery();

        while (res.next()) {
            author = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(author);
    }

    public Optional<Author> findByName(String name) throws SQLException {
        String sql = "SELECT * FROM AUTHORS WHERE A_NAME = ?";
        Author author = null;
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, name);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            author = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(author);
    }

    public Boolean addAuthor(Author author) throws SQLException {
        String sql = "INSERT INTO AUTHORS (A_NAME, BIOGRAPHY, BIRTHDATE, DEATHDATE, NACIONALITY) VALUES (?,?,?,?,?)";

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, author.getName());
        st.setString(2, author.getBiography());
        st.setDate(3, DateUtils.toSqlDate(author.getBirthdate()));
        st.setDate(4, DateUtils.toSqlDate(author.getBirthdate()));
        st.setString(5, author.getNacionality());

        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    //TODO: modifyAuthor
    //TODO: deleteAuthor

    private Author fromResultSet(ResultSet resultSet) throws SQLException {
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
