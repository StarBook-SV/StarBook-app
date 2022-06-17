package com.starbook.app.servlets;

import com.starbook.app.dao.Database;
import com.starbook.app.dao.UserDAO;
import com.starbook.app.domain.User;
import com.starbook.app.exception.UsernameAlreadyExistsException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        String name = req.getParameter("name");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("e-mail");
        User user = new User(null, name, username, password, " ", email, "USER");
        Database database = new Database();
        UserDAO userDAO = new UserDAO(database.getConnection());

        try {
            if (userDAO.findByUsername(username).isPresent()) throw new UsernameAlreadyExistsException();
            userDAO.addUser(user);
            out.println("/StarBook/login.jsp");
        } catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");
        } catch (UsernameAlreadyExistsException ue) {
            out.println("<div class='alert alert-danger' role='alert'>The user already exists</div>");
        } finally {
            database.close();
        }

    }

}

