package com.starbook.app.servlets;

import com.starbook.app.dao.Database;
import com.starbook.app.dao.MailDAO;
import com.starbook.app.dao.UserDAO;
import com.starbook.app.domain.Mail;
import com.starbook.app.domain.User;
import com.starbook.app.exception.UserNotFoundException;
import com.starbook.app.exception.UsernameAlreadyExistsException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/replyMail")
public class mailReplyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        Database database = new Database();
        MailDAO mailDao = new MailDAO(database.getConnection());
        UserDAO userDAO = new UserDAO(database.getConnection());

        Integer userFrom;
        Integer userTo;
        String message = req.getParameter("message");
        String userFromStr=req.getParameter("userFrom");
        String userToStr=req.getParameter("userTo");

        try {
            if (!userDAO.findByUsername(userFromStr).isPresent()) throw new UserNotFoundException();
            if (!userDAO.findByUsername(userToStr).isPresent()) throw new UserNotFoundException();
            userFrom = userDAO.findByUsername(req.getParameter("userFrom")).get().getIdUser();
            userTo = userDAO.findByUsername(req.getParameter("userTo")).get().getIdUser();
            Mail mail = new Mail(null, userFrom, userTo, null, message);
            try {
                mailDao.addMail(mail);
                resp.sendRedirect("mail.jsp");
            } catch (SQLException sqle) {
                out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");
            }
        } catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");
        } catch (UserNotFoundException e) {
            out.println(e.getMessage());
        } finally {
            database.close();
        }

    }

}

