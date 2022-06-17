<%@ page import="com.starbook.app.dao.Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.starbook.app.dao.ReviewDAO" %>
<%@ page import="com.starbook.app.domain.Review" %>
<!DOCTYPE html>
<html lang="es">

<%
  String r=(String)session.getAttribute("role");
  if(r == null || !r.equals("MGR")){
    String redirectURL = "index.jsp";
    response.sendRedirect(redirectURL);
  }
%>

<head>
  <!-- Comentario -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Delete review</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>
<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      var formValue = $(this).serialize();
      $.post("deleteReview", formValue, function(data) {
        $("#result").html(data);
      });
      $('#send').button('dispose')
    });
  });
</script>
<div class="container">
  <form action="deleteReview" method="post">
    <div class="form-group">
      <label for="name">Are you sure you want to delete this review?:</label>
      <input type="hidden" class="form-control" id="id" name="id" <% out.println("value=\"" + request.getParameter("id") + "\""); %>>
    </div>

    <div class="form-group">
      <button type="submit" id="send" class="btn btn-danger">Yes</button>
      <button type="button" onclick="window.location.href='index.jsp'" class="btn btn-success">Cancel</button>
    </div>
    <div id="result"></div>
  </form>
</div>
</body>

</html>