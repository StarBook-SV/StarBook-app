package com.starbook.app.servlets;

import com.starbook.app.dao.Database;
import com.starbook.app.dao.MailDAO;
import com.starbook.app.dao.UserDAO;
import com.starbook.app.domain.Mail;
import com.starbook.app.exception.UserNotFoundException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/deleteMail")
public class deleteMailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        Database database = new Database();
        MailDAO mailDao = new MailDAO(database.getConnection());


        String idMail = req.getParameter("idMail");


        try {
            mailDao.deleteById(idMail);
            resp.sendRedirect("adminMail.jsp");
        } catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");

        } finally {
            database.close();
        }

    }

}

