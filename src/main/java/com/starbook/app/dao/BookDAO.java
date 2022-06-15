package com.starbook.app.dao;

import com.starbook.app.domain.Book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BookDAO {

    private Connection connection;

    public BookDAO(Connection connection){this.connection = connection;}

    public List<Book> findAll() throws SQLException {
        String sql = "SELECT * FROM BOOKS";
        List<Book> books = new ArrayList<>();

        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();

        while(res.next()){
            Book book = fromResultSet(res);
            books.add(book);
        }
        st.close();
        return books;
    }

    //TODO: Probar con paginacion

    public Optional<Book> findByISBN(String isbn) throws SQLException{
        String sql = "SELECT * FROM BOOKS WHERE ISBN = ?";
        Book book = null;

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1,isbn);
        ResultSet res = st.executeQuery();
        while(res.next()){
            book = fromResultSet(res);
        }
        st.close();
        return Optional.ofNullable(book);
    }

    private List<Book> findByParametric(Integer id, String field) throws SQLException{
        String sql = "SELECT * FROM BOOKS WHERE ? = ?";
        List<Book> books = new ArrayList<>();

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1,field);
        st.setInt(2,id);
        ResultSet res = st.executeQuery();
        while(res.next()){
            Book book = fromResultSet(res);
            books.add(book);
        }
        st.close();
        return books;

    }

    public List<Book> findByGenre(Integer id) throws SQLException{
        return findByParametric(id, "ID_GENRE");
    }

    public List<Book> findByAuthor(Integer id) throws SQLException{
        return findByParametric(id, "ID_AUTHOR");
    }

    public List<Book> findByName(String name) throws SQLException{
        String sql = "SELECT * FROM BOOKS WHERE INSTR(TITLE, ?) != 0";
        List<Book> books = new ArrayList<>();

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1,name);
        ResultSet res = st.executeQuery();
        while(res.next()){
            Book book = fromResultSet(res);
            books.add(book);
        }
        st.close();
        return books;
    }

    public Boolean addBook(Book book) throws SQLException{
        String sql = "INSERT INTO BOOKS (ISBN, ID_AUTHOR, ID_GENRE, TITLE, DESCRIPTION, PAGES) VALUES (?,?,?,?,?,?)";

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, book.getISBN());
        st.setInt(2, book.getId_author());
        st.setInt(3, book.getId_genre());
        st.setString(4, book.getTitle());
        st.setString(5, book.getDescription());
        st.setInt(6, book.getPages());

        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    public Boolean modifyBook(Book book) throws SQLException{
        String sql = "UPDATE BOOKS SET ID_AUTHOR = ?, ID_GENRE = ?, TITLE = ?, DESCRIPTION = ?, PAGES = ? WHERE ISBN = ?";

        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(6, book.getISBN());
        st.setInt(1, book.getId_author());
        st.setInt(2, book.getId_genre());
        st.setString(3, book.getTitle());
        st.setString(4, book.getDescription());
        st.setInt(5, book.getPages());

        int rows = st.executeUpdate();
        st.close();
        return rows == 1;
    }

    private Book fromResultSet(ResultSet resultSet) throws SQLException{
        Book book = new Book();

        book.setISBN(resultSet.getString("ISBN"));
        book.setId_author(resultSet.getInt("ID_AUTHOR"));
        book.setId_genre(resultSet.getInt("ID_GENRE"));
        book.setTitle(resultSet.getString("TITLE"));
        book.setDescription(resultSet.getString("DESCRIPTION"));
        book.setPages(resultSet.getInt("PAGES"));

        return book;
    }
}
