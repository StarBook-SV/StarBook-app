<%@ page import="com.starbook.app.dao.Database" %>
<%@ page import="com.starbook.app.dao.UserDAO" %>
<%@ page import="com.starbook.app.domain.User" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.starbook.app.dao.MailDAO" %>
<%@ page import="com.starbook.app.domain.Mail" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.starbook.app.util.DateUtils" %>


<!DOCTYPE html>
<html lang="es">

<%
    String n = (String) session.getAttribute("username");
    if (n == null) {
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }

    String r = (String) session.getAttribute("role");


%>

<head>
    <!-- Comentario -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mailbox</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        .h100 {
            height: 100%;
        }

        .m90 {
            min-width: 90px;
        }

        .w100 {
            width: 100%;
        }
    </style>
</head>

<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<h2>
    <p class="text-center">Message Center</p>
</h2>
<div class="container">
    <div class="my-3 p-3 bg-white rounded box-shadow"><h6 class="border-bottom border-gray pb-2 mb-0">Mailbox
        <a class="btn btn-outline-info btn-sm"
           href="mailSend.jsp"
           role="button">Send new Mail</a>
        <%
            if (Objects.equals(r, "MGR")) {
        %>
        <a class="btn btn-outline-warning btn-sm"
           href="adminMail.jsp"
           role="button">Admin mail</a>
        <% } %>
    </h6>

        <%

            Database database = new Database();
            UserDAO userDAO = new UserDAO(database.getConnection());
            User userFrom = null;
            User userTo = null;
            User user = null;
            MailDAO mailDAO = new MailDAO(database.getConnection());
            ArrayList<Mail> mails = new ArrayList<>();

            try {
                if (userDAO.findByUsername(n).isPresent()) {
                    user = userDAO.findByUsername(n).get();
                    mails = mailDAO.findAllByUserId(user.getIdUser());
                    for (Mail mail : mails) {
                        userFrom = userDAO.findByID(mail.getIdUserFrom()).get();
                        userTo = userDAO.findByID(mail.getIdUserTo()).get();
        %>
        <div class="media text-muted pt-3 container-md">
            <div class="p-3 m-0 small lh-125 border-bottom border-gray d-flex justify-content-between align-items-start flex-row h100 w100">
                <div class="col-1">
                    <p><strong>From: <%= userFrom.getUsername()%>
                    </strong>
                    <p><strong> To: <%= userTo.getUsername()%>
                    </strong>
                </div>
                <p class="col-8"><%=mail.getMessage()%>
                <p class="col-3"><small
                        class="text-muted pl-4 d-flex flex-column justify-content-between align-items-end m90 h100">
                    <%=DateUtils.formatterLocalDateTime(mail.getTimestamp())%>
                    <% if (!Objects.equals(userFrom.getUsername(), n)) {%>
                    <a class="btn btn-outline-info btn-sm"
                       href="mailReply.jsp?idMail=<%=mail.getIdMail()%>&userTo=<%=userFrom.getUsername()%>"
                       role="button">Reply</a>
                    <%}%>
                </small>
            </div>
        </div>
            <%
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }finally {
                            database.close();
                        }


            %>


    </div>
</div>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>

</html>