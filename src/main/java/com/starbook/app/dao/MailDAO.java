package com.starbook.app.dao;

import com.starbook.app.domain.Mail;
import com.starbook.app.util.DateUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Optional;

public class MailDAO {
    private Connection connection;

    public MailDAO(Connection connection) {
        this.connection = connection;
    }

    public Optional<Mail> findByIdMail(Integer idMail) throws SQLException {
        String sql = "SELECT * FROM MAIL WHERE ID_MAIL = ?";
        Mail mail = null;
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, idMail);
        ResultSet res = st.executeQuery();
        if (res.next()) {
            mail = fromResultSet(res);
        }
        return Optional.ofNullable(mail);

    }


    public ArrayList<Mail> findAll() throws SQLException {
        String sql = "SELECT * FROM MAIL order by TIMESTAMP_M DESC";
        ArrayList<Mail> mails = new ArrayList<>();
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            Mail mail = fromResultSet(res);
            mails.add(mail);
        }
        st.close();
        return mails;
    }

    public ArrayList<Mail> findAllByUserId(Integer idUser) throws SQLException {
        String sql = "SELECT * FROM MAIL where ID_USER_FROM=? or ID_USER_TO = ? order by TIMESTAMP_M DESC";
        ArrayList<Mail> mails = new ArrayList<>();
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, idUser);
        st.setInt(2, idUser);
        ResultSet res = st.executeQuery();
        while (res.next()) {
            Mail mail = fromResultSet(res);
            mails.add(mail);
        }
        st.close();
        return mails;
    }

    public boolean deleteById(String idMail) throws SQLException {
        String sql = "DELETE FROM MAIL WHERE ID_MAIL = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, idMail);
        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    public boolean addMail(Mail mail) throws SQLException {
        String sql = "INSERT INTO MAIL (ID_USER_FROM, ID_USER_TO, MESSAGE, TIMESTAMP_M) VALUES (?, ?, ?, ?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, mail.getIdUserFrom());
        st.setInt(2, mail.getIdUserTo());
        st.setString(3, mail.getMessage());
        st.setTimestamp(4,DateUtils.toSqlDatetime(LocalDateTime.now()));
        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    private Mail fromResultSet(ResultSet res) throws SQLException {
        Mail mail = new Mail();
        mail.setIdMail(res.getInt("ID_MAIL"));
        mail.setIdUserFrom(res.getInt("ID_USER_FROM"));
        mail.setIdUserTo(res.getInt("ID_USER_TO"));
        mail.setMessage(res.getString("MESSAGE"));
        mail.setTimestamp(DateUtils.toLocalDateTime(res.getTimestamp("TIMESTAMP_M")));
        return mail;
    }
}
