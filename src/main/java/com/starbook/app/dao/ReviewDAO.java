package com.starbook.app.dao;

import com.starbook.app.domain.Mail;
import com.starbook.app.domain.Review;
import com.starbook.app.util.DateUtils;

import java.net.Inet4Address;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

public class ReviewDAO {


    private Connection connection;

    public ReviewDAO(Connection connection) {
        this.connection = connection;
    }

    public ArrayList<Review> findAll() throws SQLException {
        String sql = "SELECT * FROM REVIEWS";
        ArrayList<Review> reviews = new ArrayList<>();
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            Review review = fromResultSet(res);
            reviews.add(review);
        }
        st.close();
        return reviews;
    }

    public Optional<Review> findByIdReview(Integer idReview) throws SQLException {
        String sql = "SELECT * FROM REVIEWS WHERE ID_REVIEW = ?";
        Review review = null;
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, idReview);
        ResultSet res = st.executeQuery();
        if (res.next()) {
            review = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(review);
    }


    public ArrayList<Review> findAllByUserId(Integer idUser) throws SQLException {
        String sql = "SELECT * FROM REVIEWS where ID_USER=? ORDER BY ID_REVIEW DESC";
        ArrayList<Review> reviews = new ArrayList<>();
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, idUser);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            Review review = fromResultSet(res);
            reviews.add(review);
        }
        st.close();
        return reviews;
    }

    public ArrayList<Review> findAllByISBN(String ISBN) throws SQLException {
        String sql = "SELECT * FROM REVIEWS where UPPER(ISBN)=UPPER(?)";
        ArrayList<Review> reviews = new ArrayList<>();
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, ISBN);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            Review review = fromResultSet(res);
            reviews.add(review);
        }
        st.close();
        return reviews;
    }

    public Boolean addReview(Review review) throws SQLException{
        String sql = "INSERT INTO REVIEWS (ISBN, ID_USER, TITLE, DESCRIPTION, STARS) VALUES (?, ?, ?, ?, ?)";

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, review.getISBN());
        st.setInt(2, review.getIdUser());
        st.setString(3, review.getTitle());
        st.setString(4, review.getDescription());
        st.setInt(5, review.getStars());

        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    public Boolean deleteReview(Integer id) throws SQLException{
        String sql = "DELETE FROM REVIEWS WHERE ID_REVIEW = ?";

        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        int rows = st.executeUpdate();
        st.close();

        return rows == 1;
    }

    public Boolean modifyReview(Review review) throws SQLException {
        String sql = "UPDATE REVIEWS SET TITLE = ?, DESCRIPTION = ?, STARS = ? WHERE ID_REVIEW = ? AND ID_USER = ?";

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1,review.getTitle());
        st.setString(2,review.getDescription());
        st.setInt(3,review.getStars());
        st.setInt(4,review.getIdReview());
        st.setInt(5,review.getIdUser());

        int rows = st.executeUpdate();
        st.close();

        return rows == 1;
    }

    private Review fromResultSet(ResultSet res) throws SQLException {
        Review review = new Review();
        review.setIdReview(res.getInt("ID_REVIEW"));
        review.setISBN(res.getString("ISBN"));
        review.setIdUser(res.getInt("ID_USER"));
        review.setTitle(res.getString("TITLE"));
        review.setDescription(res.getString("DESCRIPTION"));
        review.setStars(res.getInt("STARS"));
        return review;
    }
}
