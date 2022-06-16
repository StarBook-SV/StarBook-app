<%@ page import="com.starbook.app.dao.Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.starbook.app.domain.Book" %>
<%@ page import="com.starbook.app.domain.Author" %>
<%@ page import="com.starbook.app.util.AuxiliaryFunctions" %>
<%@ page import="com.starbook.app.dao.ReviewDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.starbook.app.domain.Review" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.starbook.app.dao.UserDAO" %>
<%@ page import="com.starbook.app.domain.User" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String n=(String)session.getAttribute("username");
    String r=(String)session.getAttribute("role");
    Integer idUser=0;

    if(n != null){
        idUser = (Integer)session.getAttribute("idUser");
    }

    String ISBN = request.getParameter("ISBN");
    Database database = new Database();
    Connection connection = database.getConnection();

    Book book;
    Author author = null;

    book = AuxiliaryFunctions.getBook(ISBN);
    if(book != null) {
        author = AuxiliaryFunctions.getAuthor(book.getId_author());

    } else {
        String redirectURL = "notFound.jsp";
        response.sendRedirect(redirectURL);
    }

    List<Review> reviews = new ArrayList<>();
    List<User> users = new ArrayList<>();
    ReviewDAO reviewDAO = new ReviewDAO(connection);
    UserDAO userDAO = new UserDAO(connection);
    try {
        reviews = reviewDAO.findAllByISBN(ISBN);
        users = userDAO.findAll();
    } catch (SQLException e) {

    } finally {
        database.close();
    }
    Integer sum = 0;
    if(book != null && reviews.size() != 0) {
        for (Review review : reviews) {
            sum += review.getStars();
        }
        sum = sum / reviews.size();
    }

    Map<Integer, String> nameByID = new HashMap<>();
    for(User user : users){
        nameByID.put(user.getIdUser(), user.getName());
    }
%>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">

    <style>
        body {
            font-family: 'open sans';
            overflow-x: hidden; }

        img {
            max-width: 100%; }

        .preview {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column; }
        @media screen and (max-width: 996px) {
            .preview {
                margin-bottom: 20px; } }

        .preview-pic {
            -webkit-box-flex: 1;
            -webkit-flex-grow: 1;
            -ms-flex-positive: 1;
            flex-grow: 1; }

        .preview-thumbnail.nav-tabs li {
            width: 18%;
            margin-right: 2.5%; }
        .preview-thumbnail.nav-tabs li img {
            max-width: 100%;
            display: block; }
        .preview-thumbnail.nav-tabs li a {
            padding: 0;
            margin: 0; }
        .preview-thumbnail.nav-tabs li:last-of-type {
            margin-right: 0; }

        .tab-content {
            overflow: hidden; }
        .tab-content img {
            width: 100%;
            -webkit-animation-name: opacity;
            animation-name: opacity;
            -webkit-animation-duration: .3s;
            animation-duration: .3s; }

        .card {
            margin-top: 50px;
            background: #eee;
            padding: 3em;
            line-height: 1.5em; }

        @media screen and (min-width: 997px) {
            .wrapper {
                display: -webkit-box;
                display: -webkit-flex;
                display: -ms-flexbox;
                display: flex; } }

        .details {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column; }


        .product-title{
            text-transform: UPPERCASE;
            font-weight: bold; }


        .product-title, .rating, .product-description{
            margin-bottom: 15px; }

        .product-title {
            margin-top: 0; }

        .save-btn{
            border-radius: 4px;
            padding: 1.2em 1.5em;
            border: none;
            font-weight: bold;
            color: #fff;
            -webkit-transition: background .3s ease;
            transition: background .3s ease;}
        .save-btn:hover:hover {
            background: #b36800;
            color: #fff; }

        @-webkit-keyframes opacity {
            0% {
                opacity: 0;
                -webkit-transform: scale(3);
                transform: scale(3); }
            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1); } }

        @keyframes opacity {
            0% {
                opacity: 0;
                -webkit-transform: scale(3);
                transform: scale(3); }
            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1); } }
    </style>
</head>
<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<main>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#formUpdate").on("submit", function(event) {
                event.preventDefault();
                var formValue = $(this).serialize();
                $.post("updateStatus", formValue, function(data) {
                    $("#result-form1").html(data);
                });
            });
        });
    </script>
    <div class="container">
    <div class="card">
        <div class="container-fliud">
            <div class="wrapper row">
                <div class="preview col-md-6">
                    <div class="preview-pic tab-content">
                        <div class="tab-pane active" id="pic-1"><object class="card-img-top img-card-s" data="https://covers.openlibrary.org/b/isbn/<% if(book != null){out.print(book.getISBN());} %>-L.jpg?default=false" type="image/jpg" alt="<% if(book != null){out.print(book.getTitle());} %>" title="<% if(book != null){out.print(book.getTitle());} %>"  width="100%" height="100%">
                            <img class="card-img-top img-card-s" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png" height="100%" width="100%"/>
                        </object></div>
                    </div>
                </div>
                <div class="details col-md-6">
                    <h3 class="product-title"><% if(book != null){out.print(book.getTitle());} %></h3>
                    <div class="rating">
                        <div class="stars">
                            <%
                                for(int i = 0; i<sum; i++){
                                    out.print("<i class=\"bi bi-star-fill\"></i>");
                                }

                                for(int i = 5; i>sum; i--){
                                    out.print("<i class=\"bi bi-star\"></i>");
                                }
                            %>
                        </div>
                        <span class="review-no"><%=reviews.size()%> reviews</span>
                        <div>
                            <i class="bi bi-person"></i><span class="author-no"><% if(author != null){out.print(author.getName());} %></span>
                        </div>
                    </div>
                    <p class="product-description"><% if(book != null){out.print(book.getDescription());} %></p>
                    <%
                        if(n != null){
                    %>
                    <div class="action">
                        <form id="formUpdate">
                            <select class="form-control" id="option" name="option">
                                <option>Not interested</option>
                                <option>Pending</option>
                                <option>Reading</option>
                                <option>Read</option>
                            </select>
                            <div class="form-group">
                                <label for="pages">If you are reading the book, you can save your progress</label>
                                <input type="text" class="form-control" id="pages" name="pages" value="0">
                                <input type="hidden" class="form-control" id="ISBN" name="ISBN" <% out.println("value=\"" + book.getISBN() + "\""); %>>
                                <input type="hidden" class="form-control" id="idUser" name="idUser" <% out.println("value=\"" + idUser + "\""); %>>

                            </div>
                            <div class="d-flex flex-row mt-1">
                            <button class="save-btn btn-info" type="submit">Save</button>
                            <div id="result-form1"></div>
                            </div>
                        </form>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
    <div class="container">
        <div class="card">
            <h3 class="product-title">Reviews</h3>
                <%
                    for(Review review : reviews){
                %>
                <div class="card"> <i class="fa fa-quote-left"></i>
                    <p><%=review.getTitle()%></p>
                    <p><%=review.getDescription()%></p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="user-about"> <span class="font-weight-bold d-block"><%=nameByID.get(review.getIdUser())%></span>
                            <div class="d-flex flex-row mt-1">
                                <%
                                    for(int i = 0; i<review.getStars(); i++){
                                        out.print("<i class=\"bi bi-star-fill\"></i>");
                                    }

                                    for(int i = 5; i>review.getStars(); i--){
                                        out.print("<i class=\"bi bi-star\"></i>");
                                    }
                                %>
                            </div>
                            <%
                                if(r != null && r.equals("MGR")){
                                    out.print("<a href=\"deleteReview.jsp?id=" + review.getIdReview() + "\" class=\"like btn btn-default\" role=\"button\" >Delete review</a>");
                                }
                            %>
                        </div>
                    </div>
                </div>
            <%
                }
            %>
            </div>
    </div>
</main>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>
