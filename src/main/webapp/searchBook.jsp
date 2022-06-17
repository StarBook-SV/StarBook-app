<%@ page import="com.starbook.app.dao.Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.starbook.app.domain.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.starbook.app.dao.BookDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.starbook.app.dao.AuthorDAO" %>
<%@ page import="com.starbook.app.domain.Author" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: toni-
  Date: 15/06/2022
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String search = request.getParameter("search");
    Database database = new Database();
    Connection connection = database.getConnection();

    List<Book> books = new ArrayList<>();
    List<Author> authors = new ArrayList<>();

    BookDAO bookDAO = new BookDAO(connection);
    AuthorDAO authorDAO = new AuthorDAO(connection);

        try {
            books = bookDAO.findByName(search);
            authors = authorDAO.findAll();

        } catch (SQLException e) {

        } finally {
            database.close();
        }

        Map<Integer, Author> listAuthor = new HashMap<>();
        for(Author author : authors){
            listAuthor.put(author.getId_author(), author);
        }
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">



</head>
<body>
<header>
    <jsp:include page="header.jsp"/>
    <style>
        @import "http://fonts.googleapis.com/css?family=Roboto:300,400,500,700";

        .container { margin-top: 20px; }
        .mb20 { margin-bottom: 20px; }

        hgroup { padding-left: 15px; border-bottom: 1px solid #ccc; }
        hgroup h1 { font: 500 normal 1.625em "Roboto",Arial,Verdana,sans-serif; color: #2a3644; margin-top: 0; line-height: 1.15; }
        hgroup h2.lead { font: normal normal 1.125em "Roboto",Arial,Verdana,sans-serif; color: #2a3644; margin: 0; padding-bottom: 10px; }

        .search-result .thumbnail { border-radius: 0 !important; }
        .search-result:first-child { margin-top: 0 !important; }
        .search-result { margin-top: 20px; }
        .search-result .col-md-2 { border-right: 1px dotted #ccc; min-height: 140px; }
        .search-result ul { padding-left: 0 !important; list-style: none;  }
        .search-result ul li { font: 400 normal .85em "Roboto",Arial,Verdana,sans-serif;  line-height: 30px; }
        .search-result ul li i { padding-right: 5px; }
        .search-result .col-md-7 { position: relative; }
        .search-result h3 { font: 500 normal 1.375em "Roboto",Arial,Verdana,sans-serif; margin-top: 0 !important; margin-bottom: 10px !important; }
        .search-result h3 > a, .search-result i { color: #248dc1 !important; }
        .search-result p { font: normal normal 1.125em "Roboto",Arial,Verdana,sans-serif; }
        .search-result span.plus { position: absolute; right: 0; top: 126px; }
        .search-result span.plus a { background-color: #248dc1; padding: 5px 5px 3px 5px; }
        .search-result span.plus a:hover { background-color: #414141; }
        .search-result span.plus a i { color: #fff !important; }
        .search-result span.border { display: block; width: 97%; margin: 0 15px; border-bottom: 1px dotted #ccc; }
    </style>
</header>

<main>
    <div class="container">

        <hgroup class="mb20">
            <h1>Search Results</h1>
            <h2 class="lead"><strong class="text-danger"><%=books.size()%></strong> results were found for the search for <strong class="text-danger"><%=search%></strong></h2>
        </hgroup>

        <section class="col-xs-12 col-sm-6 col-md-12">
            <%
                for(Book book : books){
            %>
            <article class="search-result row">
                <div class="col-xs-12 col-sm-12 col-md-3">
                    <object class="card-img-top img-card-s" data="https://covers.openlibrary.org/b/isbn/<%=book.getISBN()%>-M.jpg?default=false" type="image/jpg" alt="<%=book.getTitle()%>" title="<%=book.getTitle()%>"  width="100%" height="100%">
                        <img class="card-img-top img-card-s" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png" height="100%" width="100%"/>
                    </object>                </div>
                <div class="col-xs-12 col-sm-12 col-md-2">
                    <ul class="meta-search">
                        <li><i class="bi bi-person"></i> <span><%=listAuthor.get(book.getId_author()).getName()%></span></li>
                        <li><i class="bi bi-book"></i> <span><%=book.getPages()%></span></li>
                    </ul>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-7 excerpet">
                    <h3><a href="bookDetails.jsp?ISBN=<%=book.getISBN()%>" title=""><%=book.getTitle()%></a></h3>
                    <p><%=book.getDescription()%></p>
                </div>
                <span class="clearfix borda"></span>
            </article>
            <%
                }
            %>
        </section>
    </div>
</main>

<footer>
    <jsp:include page="footer.jsp"/>
</footer>

</body>
</html>
