package com.starbook.app.util;

import com.starbook.app.dao.AuthorDAO;
import com.starbook.app.dao.BookDAO;
import com.starbook.app.dao.Database;
import com.starbook.app.dao.UserDAO;
import com.starbook.app.domain.Author;
import com.starbook.app.domain.Book;
import com.starbook.app.domain.User;
import com.starbook.app.exception.AuthorNotFoundException;
import com.starbook.app.exception.BookNotFoundException;
import com.starbook.app.exception.UserNotFoundException;

import java.sql.Connection;
import java.sql.SQLException;

public class AuxiliaryFunctions {
    public static Book getBook(String ISBN){
        Database database = new Database();
        Connection connection = database.getConnection();

        BookDAO bookDAO = new BookDAO(connection);
        Book book = null;

        try{
            book = bookDAO.findByISBN(ISBN).orElseThrow(BookNotFoundException::new);
        } catch (SQLException sqle){

        } catch (BookNotFoundException bne){

        } finally {
            database.close();
        }

        return book;
    }

    public static Author getAuthor(Integer id){
        Database database = new Database();
        Connection connection = database.getConnection();

        AuthorDAO authorDAO = new AuthorDAO(connection);
        Author author = null;

        try{
            author = authorDAO.findByID(id).orElseThrow(AuthorNotFoundException::new);
        } catch (SQLException sqle){

        } catch (AuthorNotFoundException bne){

        } finally {
            database.close();
        }

        return author;
    }
}
