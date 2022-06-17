package com.starbook.app.servlets;

import com.starbook.app.dao.AuthorDAO;
import com.starbook.app.dao.BookDAO;
import com.starbook.app.dao.Database;
import com.starbook.app.dao.UserDAO;
import com.starbook.app.domain.Author;
import com.starbook.app.domain.Book;
import com.starbook.app.domain.User;
import com.starbook.app.exception.AuthorNotFoundException;
import com.starbook.app.exception.BookAlreadyExistsException;
import com.starbook.app.exception.UsernameAlreadyExistsException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        Author author;
        Database database = new Database();
        AuthorDAO authorDAO = new AuthorDAO(database.getConnection());
        BookDAO bookDAO = new BookDAO(database.getConnection());
        Integer idAuthor;
        String authorName = req.getParameter("author");
        String ISBN = req.getParameter("ISBN");
        Integer idGenre = Integer.valueOf(req.getParameter("genre"));
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        Integer pages = Integer.valueOf(req.getParameter("pages"));
        Boolean edit = Boolean.valueOf(req.getParameter("edit"));
        if (!edit) {
            try {
                if (bookDAO.findByISBN(ISBN).isPresent()) throw new BookAlreadyExistsException();
                author = authorDAO.findByName(authorName).orElseThrow(AuthorNotFoundException::new);
                idAuthor = author.getId_author();
                Book book = new Book(ISBN, idAuthor, idGenre, title, description, pages);
                try {
                    bookDAO.addBook(book);
                    out.println("<div class='alert alert-success' role='alert'>Book added to database</div>");
                } catch (SQLException sqle) {
                    out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");
            } catch (AuthorNotFoundException | BookAlreadyExistsException ee) {
                out.println("<div class='alert alert-danger' role='alert'>");
                out.println(ee.getMessage());
                out.println("</div>");
            } finally {
                database.close();
            }
        } else {
            try {
                author = authorDAO.findByName(authorName).orElseThrow(AuthorNotFoundException::new);
                idAuthor = author.getId_author();
                Book book = new Book(ISBN, idAuthor, idGenre, title, description, pages);
                try {
                    bookDAO.modifyBook(book);
                    out.println("<div class='alert alert-success' role='alert'>Book edited</div>");
                } catch (SQLException sqle) {
                    out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");
            } catch (AuthorNotFoundException ee) {
                out.println("<div class='alert alert-danger' role='alert'>");
                out.println(ee.getMessage());
                out.println("</div>");
            } finally {
                database.close();
            }


        }


    }
}

