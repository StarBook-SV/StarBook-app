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
</head>

<body>
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
    <h2>
        <p class="text-center">Login to StarApp</p>
    </h2>
    <div class="container">
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" class="form-control" id="username" name="username">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password">
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Login</button>
            </div>
            <!--
            Esto no funciona bien asi
            <div id="result"></div>
            -->
        </form>
    </div>
</body>

</html>