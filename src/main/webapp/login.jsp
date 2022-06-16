<!DOCTYPE html>
<html lang="es">

<%
    String n=(String)session.getAttribute("username");
    if(n != null){
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
%>

<head>
    <!-- Comentario -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login to StarApp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <style>
        .form-signin {
            width: 100%;
            max-width: 330px;
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
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

    </style>


</head>



    <body class="text-center">
    <!--
    <script type="text/javascript">
        $(document).ready(function() {
            $("form").on("submit", function(event) {
                event.preventDefault();
                var formValue = $(this).serialize();
                $.post("login", formValue, function(data) {
                    $("#result").html(data);
                });
            });
        });
    </script>
    -->
    <header>
        <jsp:include page="header.jsp"/>
    </header>

        <h2 class="text-center">Login to StarApp</h2>

        <main class = "form-signin">
                <form action="login" method="post">
                    <div class="form-floating">
                        <input type="text" class="form-control" id="username" name="username">
                        <label for="username" class="col-sm-2 col-form-label">Username</label>
                    </div>
                    <div class="form-floating">
                        <input type="password" class="form-control" id="password" name="password">
                        <label for="password" class="col-sm-2 col-form-label">Password</label>
                    </div>
                    <div class="form-group row">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                    <!--
                    Esto no funciona bien asi
                    <div id="result"></div>
                    -->
                </form>
        </main>


    <footer>
        <jsp:include page="footer.jsp"/>
    </footer>
</body>

</html>