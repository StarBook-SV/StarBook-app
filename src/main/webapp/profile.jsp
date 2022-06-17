<%@ page import="java.sql.Connection" %>
<%@ page import="com.starbook.app.domain.User" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.starbook.app.domain.Review" %>
<%@ page import="com.starbook.app.domain.Book" %>
<%@ page import="com.starbook.app.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%
    Database database = new Database();
    Connection connection = database.getConnection();
    Integer idUser = Integer.parseInt(request.getParameter("id"));

    UserDAO userDAOP = new UserDAO(connection);
    UserLibraryDAO userLibraryDAO = new UserLibraryDAO(connection);
    ReviewDAO reviewDAO = new ReviewDAO(connection);
    BookDAO bookDAO = new BookDAO(connection);
    List<Integer> statusP = new ArrayList<>();
    User userP = new User();
    List<Review> reviews = new ArrayList<>();
    List<Book> books = new ArrayList<>();


    try{
        userP = userDAOP.findByID(idUser).get();
        reviews.addAll(reviewDAO.findAllByUserId(idUser));
        statusP = userLibraryDAO.findStatusUser(idUser);
        books.addAll(bookDAO.findAll());

    } catch (SQLException sqle){

    } finally {
        database.close();

    }

    Map<String, String> listIDName = new HashMap<>();
    for(Book book : books){
        listIDName.put(book.getISBN(),book.getTitle());
    }
%>

<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">

    <style>
        .card {
            margin-top: 50px;
            background: #eee;
            padding: 3em;
            line-height: 1.5em; }
    </style>
</head>

<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<main>
<div class="row py-5 px-4">
    <div class="col-xl-4 col-md-6 col-sm-10 mx-auto">

        <!-- Profile widget -->
        <div class="bg-white shadow rounded overflow-hidden">
            <div class="px-4 pt-0 pb-4 bg-dark">
                <div class="media align-items-end profile-header">
                    <div class="media-body mb-5 text-white">
                        <h4 class="mt-0 mb-0"><%=userP.getName()%></h4>
                        <p class="small mb-4"> <i class="bi bi-person-circle mr-2"></i><%=userP.getUsername()%></p>
                    </div>
                </div>
            </div>

            <div class="bg-light p-4 d-flex justify-content-end text-center">
                <ul class="list-inline mb-0">
                    <li class="list-inline-item">
                        <h5 class="font-weight-bold mb-0 d-block"><%=reviews.size()%></h5><small class="text-muted"> <i class="bi bi-blockquote-left mr-1"></i>Reviews</small>
                    </li>
                    <li class="list-inline-item">
                        <h5 class="font-weight-bold mb-0 d-block"><%=statusP.get(0)%></h5><small class="text-muted"> <i class="bi bi-book mr-1"></i>Pending</small>
                    </li>
                    <li class="list-inline-item">
                        <h5 class="font-weight-bold mb-0 d-block"><%=statusP.get(1)%></h5><small class="text-muted"> <i class="bi bi-book-half mr-1"></i>Reading</small>
                    </li>
                    <li class="list-inline-item">
                        <h5 class="font-weight-bold mb-0 d-block"><%=statusP.get(2)%></h5><small class="text-muted"> <i class="bi bi-book-fill mr-1"></i>Read</small>
                    </li>
                </ul>
            </div>

            <div class="py-4">
                <h5 class="mb-3">Biography</h5>
                <div class="p-4 bg-light rounded shadow-sm">
                    <p class="font-italic mb-0"><%=userP.getBiography()%></p>
                </div>
            </div>

            <div class="py-4 px-4">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h5 class="mb-0">Recent reviews</h5>
                </div>
                <%
                    int salirBucle = 3;
                    for(Review review : reviews){
                        if(salirBucle==0){
                            break;
                        }
                        salirBucle--;
                    %>
                <div class="card"> <i class="fa fa-quote-left"></i>
                    <p><%=review.getTitle()%></p>
                    <p><%=review.getDescription()%></p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="user-about"> <span class="font-weight-bold d-block"><a href="bookDetails.jsp?ISBN=<%=review.getISBN()%>"><%=listIDName.get(review.getISBN())%></a></span>
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
                        </div>
                    </div>
                </div>
        <%
            }
                %>
            </div>
        </div><!-- End profile widget -->
    </div>
</div>
</main>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>

</html>
