<%@ page import="com.starbook.app.dao.Database" %>
<%@ page import="com.starbook.app.dao.UserDAO" %>
<%@ page import="com.starbook.app.domain.User" %>
<%@ page import="com.starbook.app.dao.MailDAO" %>
<%@ page import="com.starbook.app.domain.Mail" %>

<!DOCTYPE html>
<html lang="es">

<%
    String n = (String) session.getAttribute("username");
    if (n == null) {
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
    Database database = new Database();
    UserDAO userDAO = new UserDAO(database.getConnection());
    User userFrom = null;
    User userTo = null;
    MailDAO mailDAO = new MailDAO(database.getConnection());
    Mail mail = null;


%>

<head>
    <!-- Comentario -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send new mail</title>
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
    <p class="text-center">Answer mail</p>
</h2>
<div class="container">
    <form class="container " action="sendMail" method="post">
        <div class="form-group row justify-content-center">
            <label for="userFrom" class="col-sm-2 col-form-label">userFrom</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" value="<%=n%>" id="userFrom" name="userFrom" required
                       readonly>
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <label for="userTo" class="col-sm-2 col-form-label">userTo</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="userTo"
                       name="userTo" required>
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <label for="message" class="col-sm-2 col-form-label">Message</label>
            <div class="col-sm-5">
                <textarea class="form-control" id="message" name="message" rows="6" required></textarea>
            </div>
        </div>
        <div class="form-group row justify-content-center">
            <button type="submit" class="btn btn-primary col-sm-5">Send</button>
        </div>
    </form>
    <div id="result"></div>
</div>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>

</html>