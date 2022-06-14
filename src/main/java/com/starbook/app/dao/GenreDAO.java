package com.starbook.app.dao;

import com.starbook.app.domain.Genre;
import com.starbook.app.domain.Review;

import javax.swing.text.html.Option;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

public class GenreDAO {
    private Connection connection;

    public GenreDAO(Connection connection) {
        this.connection = connection;
    }

    public ArrayList<Genre> findAll() throws SQLException {
        String sql = "SELECT * FROM GENRES";
        ArrayList<Genre> genres = new ArrayList<>();
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            Genre genre = fromResultSet(res);
            genres.add(genre);
        }
        st.close();
        return genres;
    }

    public Optional<Genre> findByName(String gName) throws SQLException {
        String sql = "SELECT * FROM GENRES where upper(G_NAME)=upper(?)";
        Genre genre = null;
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, gName);
        ResultSet res = st.executeQuery();
        if (res.next()) {
            genre = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(genre);
    }

    public Optional<Genre> findById(Integer idGenre) throws SQLException {
        String sql = "SELECT * FROM GENRES where ID_GENRE=?";
        Genre genre = null;
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, idGenre);
        ResultSet res = st.executeQuery();
        if (res.next()) {
            genre = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(genre);
    }

    private Genre fromResultSet(ResultSet res) throws SQLException {
        Genre genre = new Genre();
        genre.setId_genre(res.getInt("ID_GENRE"));
        genre.setName(res.getString("G_NAME"));
        genre.setDescription(res.getString("DESCRIPTION"));
        return genre;
    }
}
