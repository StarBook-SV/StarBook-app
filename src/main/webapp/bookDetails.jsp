<%@ page import="com.starbook.app.dao.Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.starbook.app.util.AuxiliaryFunctions" %>
<%@ page import="com.starbook.app.dao.ReviewDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.starbook.app.dao.UserDAO" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.starbook.app.dao.UserLibraryDAO" %>
<%@ page import="com.starbook.app.domain.*" %>
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
    UserLibrary userLibrary = null;
    ReviewDAO reviewDAO = new ReviewDAO(connection);
    UserDAO userDAO = new UserDAO(connection);
    UserLibraryDAO userLibraryDAO = new UserLibraryDAO(connection);
    try {
        reviews = reviewDAO.findAllByISBN(ISBN);
        users = userDAO.findAll();
        userLibrary = userLibraryDAO.findByISBNandUser(ISBN, idUser);

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

    if(book == null){
        book = new Book("000", 1, 1," "," ", 1);
    }
%>
<head>
    <title><% if(book != null){out.print(book.getTitle());} %></title>
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
        .pagination {
            display: block;
            width: 75%;
            margin: 1em auto;
            text-align: center;
            justify-content: center;
        }
        .pagination:after {
            content: "";
            clear: both;
        }

        .pagination-button {
            display: inline-block;
            padding: 5px 10px;
            border: 1px solid #e0e0e0;
            background-color: #eee;
            color: #333;
            cursor: pointer;
            transition: background 0.1s, color 0.1s;
        }
        .pagination-button:hover {
            background-color: #ddd;
            color: #3366cc;
        }
        .pagination-button.active {
            background-color: #bbb;
            border-color: #bbb;
            color: #3366cc;
        }
        .pagination-button:first-of-type {
            border-radius: 18px 0 0 18px;
        }
        .pagination-button:last-of-type {
            border-radius: 0 18px 18px 0;
        }
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

        (function($){

            var paginate = {
                startPos: function(pageNumber, perPage) {
                    // determine what array position to start from
                    // based on current page and # per page
                    return pageNumber * perPage;
                },

                getPage: function(items, startPos, perPage) {
                    // declare an empty array to hold our page items
                    var page = [];

                    // only get items after the starting position
                    items = items.slice(startPos, items.length);

                    // loop remaining items until max per page
                    for (var i=0; i < perPage; i++) {
                        page.push(items[i]); }

                    return page;
                },

                totalPages: function(items, perPage) {
                    // determine total number of pages
                    return Math.ceil(items.length / perPage);
                },

                createBtns: function(totalPages, currentPage) {
                    // create buttons to manipulate current page
                    var pagination = $('<div class="pagination" />');

                    // add a "first" button
                    pagination.append('<span class="pagination-button">&laquo;</span>');

                    // add pages inbetween
                    for (var i=1; i <= totalPages; i++) {
                        // truncate list when too large
                        if (totalPages > 5 && currentPage !== i) {
                            // if on first two pages
                            if (currentPage === 1 || currentPage === 2) {
                                // show first 5 pages
                                if (i > 5) continue;
                                // if on last two pages
                            } else if (currentPage === totalPages || currentPage === totalPages - 1) {
                                // show last 5 pages
                                if (i < totalPages - 4) continue;
                                // otherwise show 5 pages w/ current in middle
                            } else {
                                if (i < currentPage - 2 || i > currentPage + 2) {
                                    continue; }
                            }
                        }

                        // markup for page button
                        var pageBtn = $('<span class="pagination-button page-num" />');

                        // add active class for current page
                        if (i == currentPage) {
                            pageBtn.addClass('active'); }

                        // set text to the page number
                        pageBtn.text(i);

                        // add button to the container
                        pagination.append(pageBtn);
                    }

                    // add a "last" button
                    pagination.append($('<span class="pagination-button">&raquo;</span>'));

                    return pagination;
                },

                createPage: function(items, currentPage, perPage) {
                    // remove pagination from the page
                    $('.pagination').remove();

                    // set context for the items
                    var container = items.parent(),
                        // detach items from the page and cast as array
                        items = items.detach().toArray(),
                        // get start position and select items for page
                        startPos = this.startPos(currentPage - 1, perPage),
                        page = this.getPage(items, startPos, perPage);

                    // loop items and readd to page
                    $.each(page, function(){
                        // prevent empty items that return as Window
                        if (this.window === undefined) {
                            container.append($(this)); }
                    });

                    // prep pagination buttons and add to page
                    var totalPages = this.totalPages(items, perPage),
                        pageButtons = this.createBtns(totalPages, currentPage);

                    container.after(pageButtons);
                }
            };

            // stuff it all into a jQuery method!
            $.fn.paginate = function(perPage) {
                var items = $(this);

                // default perPage to 5
                if (isNaN(perPage) || perPage === undefined) {
                    perPage = 5; }

                // don't fire if fewer items than perPage
                if (items.length <= perPage) {
                    return true; }

                // ensure items stay in the same DOM position
                if (items.length !== items.parent()[0].children.length) {
                    items.wrapAll('<div class="pagination-items" />');
                }

                // paginate the items starting at page 1
                paginate.createPage(items, 1, perPage);

                // handle click events on the buttons
                $(document).on('click', '.pagination-button', function(e) {
                    // get current page from active button
                    var currentPage = parseInt($('.pagination-button.active').text(), 10),
                        newPage = currentPage,
                        totalPages = paginate.totalPages(items, perPage),
                        target = $(e.target);

                    // get numbered page
                    newPage = parseInt(target.text(), 10);
                    if (target.text() == '«') newPage = 1;
                    if (target.text() == '»') newPage = totalPages;

                    // ensure newPage is in available range
                    if (newPage > 0 && newPage <= totalPages) {
                        paginate.createPage(items, newPage, perPage); }
                });
            };

        })(jQuery);
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
                        <div>
                            <i class="bi bi-book"></i><span class="author-no"><% if(book != null){out.print(book.getPages());} %></span>
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
                                <option <% if(userLibrary != null && userLibrary.getStatus().equals("PENDING")){out.print("selected");} %>>Pending</option>
                                <option <% if(userLibrary != null && userLibrary.getStatus().equals("READING")){out.print("selected");} %>>Reading</option>
                                <option <% if(userLibrary != null && userLibrary.getStatus().equals("READ")){out.print("selected");} %>>Read</option>
                            </select>
                            <div class="form-group">
                                <label for="pages">If you are reading the book, you can save your progress</label>
                                <input type="number" class="form-control" id="pages" name="pages" min="0" max="<% if(book != null){out.print(book.getPages());} else {out.print("0");}%>" value="<% if(userLibrary != null && userLibrary.getStatus().equals("READING")){out.print(userLibrary.getPage());}else{out.print("0");}%>">
                                <div class="progress t">
                                    <div class="progress-bar progress-bar-striped bg-info " role="progressbar" style="width: <% if(userLibrary != null && userLibrary.getStatus().equals("READING")){out.print(((userLibrary.getPage()*100)/book.getPages()));} else if(userLibrary != null && userLibrary.getStatus().equals("READ")){out.print("100");} else{out.print("0");}%>%" aria-valuenow="<% if(userLibrary != null && userLibrary.getStatus().equals("READING")){out.print(userLibrary.getPage());}else{out.print("0");}%>" aria-valuemin="0" aria-valuemax="<%=book.getPages()%>"></div>
                                </div>
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
                <div class="card article-loop"> <i class="fa fa-quote-left"></i>
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
    <script>
        $('.article-loop').paginate(2);
    </script>
</main>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>
