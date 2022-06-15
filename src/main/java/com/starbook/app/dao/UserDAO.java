package com.starbook.app.dao;

import com.starbook.app.domain.User;
import oracle.jdbc.proxy.annotation.Pre;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDAO {

    private Connection connection;

    public UserDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean addUser(User user) throws SQLException {
        String sql = "INSERT INTO USERS (U_NAME, USERNAME, PASWORD, BIOGRAPHY, EMAIL) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement st = toStatement(user, sql);
        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    public boolean modifyUser(User user) throws SQLException {
        String sql = "UPDATE USERS SET U_NAME = ?, USERNAME = ?, PASWORD = ? , BIOGRAPHY= ?, EMAIL=? WHERE ID_USER = ?";
        PreparedStatement st = toStatement(user, sql);
        st.setInt(6, user.getIdUser());
        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    public List<User> findAll() throws SQLException {
        String sql = "SELECT * FROM USERS";
        List<User> users = new ArrayList<>();

        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            User user = fromResultSet(res);
            users.add(user);
        }
        st.close();
        return users;
    }

    public Optional<User> findByID(Integer id) throws SQLException {
        String sql = "SELECT * FROM USERS WHERE ID_USER = ?";
        User user = null;

        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            user = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(user);
    }

    public Optional<User> findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM USERS WHERE upper(USERNAME) = Upper(?)";
        User user = null;
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, username);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            user = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(user);
    }

    public Optional<User> login(String username, String password) throws SQLException {
        String sql = "SELECT * FROM USERS WHERE USERNAME = ? AND PASWORD = ?";
        User user = null;

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, username);
        st.setString(2, password);
        ResultSet res = st.executeQuery();

        while (res.next()) {
            user = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(user);

    }

    public User fromResultSet(ResultSet resultSet) throws SQLException {
        User user = new User();

        user.setIdUser(resultSet.getInt("ID_USER"));
        user.setName(resultSet.getString("U_NAME"));
        user.setUsername(resultSet.getString("USERNAME"));
        user.setPassword(resultSet.getString("PASWORD"));
        user.setBiography(resultSet.getString("BIOGRAPHY"));
        user.setBiography(resultSet.getString("EMAIL"));
        user.setRole(resultSet.getString("ROLE"));

        return user;
    }

    private PreparedStatement toStatement(User user, String sql) throws SQLException {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, user.getName());
        st.setString(2, user.getUsername());
        st.setString(3, user.getPassword());
        st.setString(4, user.getBiography());
        st.setString(5, user.getEmail());
        return st;
    }
}
