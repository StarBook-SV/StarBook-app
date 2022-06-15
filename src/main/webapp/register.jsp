<!DOCTYPE html>
<html lang="es">

<%
    String n = (String) session.getAttribute("username");
    if (n != null) {
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
%>

<head>
    <!-- Comentario -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login to StarApp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>

<body>
<script type="text/javascript">
    $(document).ready(function () {
        $("form").on("submit", function (event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("register", formValue, function (data) {
                if (data === "/StarBook_app_war/login.jsp") {
                    window.location.href = data;
                } else
                    $("#result").html(data);
            });
        });
    });
</script>
<header>
    <jsp:include page="header.jsp"/>
</header>
<h2>
    <p class="text-center">Register to StarApp</p>
</h2>
<div class="container">
    <form class="container">
        <div class="form-group row">
            <label for="name" class="col-sm-2 col-form-label">Full Name</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
        </div>
        <div class="form-group row">
            <label for="username" class="col-sm-2 col-form-label">Username</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
        </div>
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
        </div>
        <div class="form-group row">
            <label for="e-mail" class="col-sm-2 col-form-label">e-mail</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" id="e-mail" name="e-mail" required>
            </div>
        </div>
        <small class="form-text text-muted">By clicking on "Register" you agree to the terms and conditions of
            StarBook</small>
        <div class="form-group row">
            <button type="submit" class="btn btn-primary">Register</button>
        </div>
    </form>
    <div id="result"></div>
</div>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>

</html>