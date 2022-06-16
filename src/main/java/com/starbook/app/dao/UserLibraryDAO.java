package com.starbook.app.dao;

import com.starbook.app.domain.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserLibraryDAO {
    private Connection connection;

    public UserLibraryDAO(Connection connection) {
        this.connection = connection;
    }

    public ArrayList<UserLibrary> findAllByISBN(String ISBN) throws SQLException {
        String sql = "SELECT * FROM USERLIBRARY where UPPER(ISBN)=UPPER(?)";
        ArrayList<UserLibrary> userLibraries = new ArrayList<>();
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, ISBN);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            UserLibrary userLibrary = fromResultSet(res);
            userLibraries.add(userLibrary);
        }
        st.close();
        return userLibraries;
    }

    private Integer findByISBNAndStatus(String ISBN, String status) throws SQLException {
        String sql = "SELECT count(ISBN) FROM USERLIBRARY WHERE ISBN = ? AND STATUS=?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, ISBN);
        st.setString(2, status);
        ResultSet res = st.executeQuery();
        st.close();
        return res.getInt(1);
    }

    private Integer findByUserAndStatus(Integer idUser, String status) throws SQLException {
        String sql = "SELECT count(ISBN) FROM USERLIBRARY WHERE ID_USER = ? AND STATUS=?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, idUser);
        st.setString(2, status);
        ResultSet res = st.executeQuery();
        st.close();
        return res.getInt(1);
    }

    public boolean deleteByUserAndISBN(Integer idUser, String ISBN) throws SQLException {
        String sql = "DELETE FROM USERLIBRARY WHERE ISBN = ? and ID_USER = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, ISBN);
        st.setInt(2, idUser);
        int rows = st.executeUpdate();
        st.close();
        return rows == 1;

    }

    public boolean modifyStatusByUserAndISBN(UserLibrary userLibrary) throws SQLException {
        String sql = "UPDATE USERLIBRARY SET STATUS=?, PAGE=? WHERE ISBN = ? and ID_USER = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, userLibrary.getStatus());
        st.setInt(2, userLibrary.getPage());
        st.setString(3, userLibrary.getISBN());
        st.setInt(4, userLibrary.getIdUser());
        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    public boolean addUserLibrary(UserLibrary userLibrary) throws SQLException {
        String sql = "INSERT INTO USERLIBRARY (ISBN, ID_USER, STATUS, PAGE) VALUES (?, ?, ?, ?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, userLibrary.getISBN());
        st.setInt(2, userLibrary.getIdUser());
        st.setString(3, userLibrary.getStatus());
        st.setInt(4, userLibrary.getPage());
        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    public Integer[] findStatusISBN(String ISBN) throws SQLException {
        Integer[] count = new Integer[3];
        count[0] = findByISBNAndStatus(ISBN, "PENDING");
        count[1] = findByISBNAndStatus(ISBN, "READING");
        count[2] = findByISBNAndStatus(ISBN, "READ");
        return count;
    }

    public Integer[] findStatusUser(Integer idUser) throws SQLException {
        Integer[] count = new Integer[3];
        count[0] = findByUserAndStatus(idUser, "PENDING");
        count[1] = findByUserAndStatus(idUser, "READING");
        count[2] = findByUserAndStatus(idUser, "READ");
        return count;
    }


    private UserLibrary fromResultSet(ResultSet res) throws SQLException {
        UserLibrary userLibrary = new UserLibrary();
        userLibrary.setIdUser(res.getInt("ID_USER"));
        userLibrary.setISBN(res.getString("ISBN"));
        userLibrary.setStatus(res.getString("STATUS"));
        userLibrary.setPage(res.getInt("PAGE"));
        return userLibrary;
    }

    public UserLibrary findByISBNandUser(String ISBN, Integer idUser) throws SQLException {
        String sql = "SELECT * FROM USERLIBRARY where UPPER(ISBN)=UPPER(?) AND ID_USER = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, ISBN);
        st.setInt(2, idUser);
        ResultSet res = st.executeQuery();

        UserLibrary userLibrary = null;

        while (res.next()) {
            userLibrary = fromResultSet(res);
        }
        st.close();
        return userLibrary;
    }
}
