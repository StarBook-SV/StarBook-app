<%@ page import="com.starbook.app.dao.Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.starbook.app.dao.BookDAO" %>
<%@ page import="com.starbook.app.domain.Book" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<html>
<%
    String n=(String)session.getAttribute("username");
    String r=(String)session.getAttribute("role");
    if(n != null){
        //Si el usuario no es null, cambia unos datos
    }

    Database database = new Database();
    Connection connection = database.getConnection();

%>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.98.0">
    <title>StarBook-HomePage</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/album/">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        /*Centra la barra de navegacion*/
        @media (min-width: 992px) {
            .mt-lg-0 {
                margin: 0 !important;
            }
        }

        .b-example-divider {
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }
        .img-card-s{
            object-fit: scale-down;
            max-height: 300px;
        }
        .card-body{
            height: 360px ;
                    }
        .d2-flex {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: flex-start;
        }
        .book-title{
            margin-left: 5%;
        }
        .w100{
            width: 100%;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<main>
    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="fw-light">StarBook</h1>
                <p class="lead text-muted">StarBook is your application to share your book reviews with other users.</p>
                <p>
                    <a href="listGenres.jsp" class="btn btn-primary my-2">Search by genre </a>
                    <a href="listAuthors.jsp" class="btn btn-secondary my-2">Search by author</a>
                </p>
            </div>
        </div>
    </section>

    <div class="album py-5 bg-light">
        <div class="container">

            <h2>Last added books</h2>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <%
                    BookDAO bookDAO = new BookDAO(connection);
                    List<Book> books = new ArrayList<>();
                    try{
                        books = bookDAO.getLastBooks();
                    } catch (SQLException sqle){

                    } finally {
                        database.close();
                    }
                    for(Book book : books){
                %>
                <div class="col">
                    <div class="card shadow-sm">
                        <object class="card-img-top img-card-s" data="https://covers.openlibrary.org/b/isbn/<%=book.getISBN()%>-M.jpg?default=false" type="image/jpg" alt="<%=book.getTitle()%>" title="<%=book.getTitle()%>"  width="100%" height="100%">
                            <img class="card-img-top img-card-s" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png" height="100%" width="100%"/>
                        </object>
                        <h2 class="book-title"><%=book.getTitle()%></h2>
                     <!--<text x="50%" y="50%" fill="#eceeef" dy=".3em"><%=book.getTitle()%></text>-->

                        <div class="card-body d2-flex">
                            <p class="card-text"><%=book.getDescription()%></p>
                            <div class="d-flex justify-content-between align-items-center flex-row w100" >
                                <div class="btn-group" >
                                    <%
                                        if(r != null && r.equals("MGR")){
                                            out.println("<a class=\"btn btn-sm btn-outline-secondary\" href=addBook.jsp?ISBN="+ book.getISBN() +" role=\"button\">Edit</a>");
                                        }
                                        out.println("<a class=\"btn btn-sm btn-outline-secondary\" href=bookDetails.jsp?ISBN="+ book.getISBN() +" role=\"button\">View</a>");
                                    %>

                                </div>
                                <small class="text-muted"><%=book.getPages()%> pages</small>

                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</main>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>
</body>
</html>
