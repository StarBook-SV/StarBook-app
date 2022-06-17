package com.starbook.app.servlets;

import com.starbook.app.dao.Database;
import com.starbook.app.dao.ReviewDAO;
import com.starbook.app.util.CheckLogin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/deleteReview")
public class DeleteReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("POST");

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        HttpSession sesion = req.getSession();
        String username = (String) sesion.getAttribute("username");
        String password = (String) sesion.getAttribute("password");
        String role = (String) sesion.getAttribute("role");

        String id = req.getParameter("id");
        System.out.println("Parametro eliminar conseguido: " + id);

        if(username == null || password == null || !role.equals("MGR") || !CheckLogin.validate(username, password)){
            resp.sendRedirect("login.jsp");
        } else {
            Database database = new Database();
            Connection connection = database.getConnection();

            ReviewDAO reviewDAO = new ReviewDAO(connection);
            Boolean correct;

            try{
                correct = reviewDAO.deleteReview(Integer.parseInt(id));

                if(correct){
                    out.println("<div class='alert alert-success' role='alert'>Review deleted.</div>");
                } else {
                    out.println("<div class='alert alert-danger' role='alert'>Review NOT deleted.</div>");
                }
            } catch (SQLException sqle){
                out.println("<div class='alert alert-danger' role='alert'>There is an error.</div>");
            } finally {
                database.close();
            }
        }
    }
}
