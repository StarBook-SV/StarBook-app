<%@ page import="com.starbook.app.dao.Database" %>
<%@ page import="com.starbook.app.dao.GenreDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.starbook.app.domain.Genre" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.starbook.app.dao.BookDAO" %>
<%@ page import="com.starbook.app.domain.Book" %>
<%@ page import="com.starbook.app.dao.AuthorDAO" %>
<%@ page import="com.starbook.app.domain.Author" %>


<!DOCTYPE html>
<html lang="es">

<%
    Database database = new Database();
    String n = (String) session.getAttribute("role");
    if (!Objects.equals(n, "MGR")) {
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
    boolean edit = false;
    Book book = null;
    Author author = null;
    Genre genre = null;
    BookDAO bookDAO = new BookDAO(database.getConnection());
    try {
        if (request.getParameter("ISBN") != null) {
            edit = true;
            AuthorDAO authorDAO = new AuthorDAO(database.getConnection());
            GenreDAO genreDAO = new GenreDAO(database.getConnection());
            try {
                if (bookDAO.findByISBN(request.getParameter("ISBN")).isPresent()) {
                    book = bookDAO.findByISBN(request.getParameter("ISBN")).get();
                    if (authorDAO.findByID(book.getId_author()).isPresent())
                        author = authorDAO.findByID(book.getId_author()).get();
                    if (genreDAO.findById(book.getId_genre()).isPresent())
                        genre = genreDAO.findById(book.getId_genre()).get();
                }
            } catch (SQLException e) {
            }
        }
    } finally {
        database.close();
    }


%>

<head>
    <!-- Comentario -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <% if (edit) { %>
    <title>Edit a book</title>
            <% }
                        else {
                              %>
    <title>Add a book to StarApp</title>
    <%
        }
    %>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>

<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<script type="text/javascript">
    $(document).ready(function () {
        $("form").on("submit", function (event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("addBook", formValue, function (data) {
                $("#result").html(data);
            });
        });
    });
</script>
<h2>
    <% if (edit) { %>
    <p class="text-center">Edit a book</p>
    <% }
    else {
    %>
    <p class="text-center">Add a book to StarApp</p>
    <%
        }
    %>

</h2>
<div class="container">
    <form class="container">
        <div class="form-group row">
            <label for="ISBN" class="col-sm-2 col-form-label">ISBN</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="ISBN" name="ISBN"
                       <% if (edit){ %>value="<%=book.getISBN()%>" readonly <%}%> required>
            </div>
        </div>
        <div class="form-group row">
            <label for="title" class="col-sm-2 col-form-label">Title</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="title" name="title"
                       <% if (edit){ %>value="<%=book.getTitle()%>"<%}%> required>
            </div>
        </div>
        <div class="form-group row">
            <label for="author" class="col-sm-2 col-form-label">Author</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="author" name="author"
                       <% if (edit){ %>value="<%= author.getName()%>"<%}%> required>
            </div>
        </div>
        <div class="form-group row">
            <label for="genre" class="col-sm-2 col-form-label">Genre</label>
            <div class="col-sm-10">
                <select class="form-select" id="genre" name="genre" required> >
                    <% if (edit) { %>
                    <option selected value="<%= book.getId_genre()%>"> <%= genre.getName()%>
                            <% }
                        else {
                              %>
                    <option selected>Select Genre</option>
                    <%
                        }
                    %>
                    <%
                        GenreDAO genreDAO = new GenreDAO(database.getConnection());
                        try {
                            ArrayList<Genre> genres = genreDAO.findAll();
                            for (Genre genre1 : genres) {
                    %>
                    <option value=<%= genre1.getId_genre() %>><%= genre1.getName() %>
                    </option>
                    <%
                            }
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        } finally {
                            database.close();
                        }
                    %>
                </select>
            </div>
        </div>


        <div class="form-group row">
            <label for="description" class="col-sm-2 col-form-label">Description</label>
            <div class="col-sm-10">
                <textarea class="form-control" id="description" name="description" rows="3"
                ><% if (edit) { %> <%=book.getDescription()%><%}%></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="pages" class="col-sm-2 col-form-label">Nº of pages</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" id="pages" name="pages"
                       <% if (edit){ %>value="<%= book.getPages()%>" <%}%>required>
            </div>
        </div>

        <input type="hidden" class="hidden" id="edit" name="edit" value="<%=edit%>">

        <div class="form-group row">
            <button type="submit" class="btn btn-primary">

                <% if (edit) { %>
                Edit book <% } else { %>
                Add book <% } %>
            </button>
        </div>
    </form>
    <div id="result"></div>
</div>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>

</html>