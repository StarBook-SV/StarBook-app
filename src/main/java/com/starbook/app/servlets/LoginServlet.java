package com.starbook.app.servlets;

import com.starbook.app.dao.Database;
import com.starbook.app.dao.UserDAO;
import com.starbook.app.domain.User;
import com.starbook.app.exception.UserNotFoundException;
import com.starbook.app.util.CheckLogin;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    public LoginServlet(){ super();}
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("POST LOGIN");

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession();
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if(username == null || password == null || !CheckLogin.validate(username, password)){
            resp.sendRedirect("errorLogin.jsp");
        } else {
            User user = null;
            Database database = new Database();
            UserDAO userDAO = new UserDAO(database.getConnection());

            try{
                user = userDAO.login(username, password).orElseThrow(UserNotFoundException::new);
            } catch (SQLException sqle){
                System.out.println("Ha habido un error con la base de datos");
                out.println("<div class='alert alert-danger' role='alert'>An error has occurred</div>");
            } catch (UserNotFoundException une){
                System.out.println(une.getMessage());
                out.println("<div class='alert alert-danger' role='alert'>Login incorrect</div>");
            } finally {
                database.close();
            }

            session.setAttribute("username", username);
            session.setAttribute("password", password);
            session.setAttribute("role", user.getRole());
            session.setAttribute("idUser", user.getIdUser());

            resp.sendRedirect("index.jsp");
        }

    }
}
