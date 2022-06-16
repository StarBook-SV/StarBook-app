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
    <title>Register to StarApp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <style>
        .form-signin {
            width: 100%;
            max-width: 700px;
            padding: 15px;
            margin: auto;
        }


        .form-signin .form-floating:focus-within {
            z-index: 2;
        }

        .form-signin input[type="text"] {
            margin-bottom: -1px;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
        }

        .form-signin input[type="password"] {
            margin-bottom: -1px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

    </style>


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

<h2 class="text-center">Register to StarApp</h2>

<main class = "form-signin">
    <div class="container">
        <form class="form-signin">
            <div class="form-floating">
                <input type="text" class="form-control" id="name" name="name" required>
                <label for="name">Full Name</label>
            </div>
            <div class="form-floating">
                <input type="text" class="form-control" id="username" name="username" required>
                <label for="username" class="col-sm-2 col-form-label">Username</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="password" name="password" required>
                <label for="password">Password</label>
            </div>
            <div class="form-floating">
                <input type="email" class="form-control" id="e-mail" name="e-mail" required>
                <label for="e-mail">e-mail</label>
            </div>
            <small class="form-text text-muted">By clicking on "Register" you agree to the terms and conditions of
                StarBook</small>
            <div class="form-group row">
                <button type="submit" class="btn btn-primary">Register</button>
            </div>
        </form>
        <div id="result"></div>
    </div>
</main>

<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>

</html>