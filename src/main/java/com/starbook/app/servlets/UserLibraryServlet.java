package com.starbook.app.servlets;

import com.starbook.app.dao.Database;
import com.starbook.app.dao.UserLibraryDAO;
import com.starbook.app.domain.UserLibrary;
import com.starbook.app.util.CheckLogin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/updateStatus")
public class UserLibraryServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        Integer idUser = Integer.parseInt(req.getParameter("idUser"));
        String ISBN  = req.getParameter("ISBN");
        Integer pages = Integer.parseInt(req.getParameter("pages"));
        String option = req.getParameter("option");

        String status;
        switch (option){
            case "Not interested":
                status = "DELETE";
                break;
            case "Pending":
                status = "PENDING";
                break;
            case "Reading":
                status = "READING";
                break;
            case "Read":
                status = "READ";
                break;
            default:
                status = "";
        }

        System.out.println(idUser + " " + ISBN + " " + pages + " " + option);

        HttpSession sesion = req.getSession();

        String username = (String) sesion.getAttribute("username");
        String password = (String) sesion.getAttribute("password");

        if(username == null || password == null ||  !CheckLogin.validate(username, password)){
            resp.sendRedirect("login.jsp");
        } else {
            Database database = new Database();
            Connection connection = database.getConnection();

            UserLibraryDAO userLibraryDAO = new UserLibraryDAO(connection);
            UserLibrary aux;
            UserLibrary userLibrary = new UserLibrary(ISBN, idUser, status, pages);

            Boolean correct;

            try{
                aux = userLibraryDAO.findByISBNandUser(ISBN, idUser);
                if(aux != null){
                    aux.setStatus(userLibrary.getStatus());
                    aux.setPage(userLibrary.getPage());

                    if(status.equals("DELETE")){
                        correct = userLibraryDAO.deleteByUserAndISBN(idUser, ISBN);
                    } else {
                        correct = userLibraryDAO.modifyStatusByUserAndISBN(aux);
                    }

                }  else {
                    correct = userLibraryDAO.addUserLibrary(userLibrary);
                }

                if(correct){
                    out.println("<i class=\"bi bi-check-circle-fill\"></i>\n");
                } else {
                    out.print("<i class=\"bi bi-exclamation-circle-fill\"></i>\n");
                }
            } catch (SQLException sqle){
                out.print("<i class=\"bi bi-exclamation-circle-fill\"></i>\n");

            }
        }

    }
}
