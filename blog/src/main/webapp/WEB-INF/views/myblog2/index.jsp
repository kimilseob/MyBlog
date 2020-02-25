<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Clean Blog - Start Bootstrap Theme</title>

  <!-- Bootstrap core CSS -->
  <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

  <!-- Custom styles for this template -->
  <link href="resources/css/clean-blog.min.css" rel="stylesheet">
  <!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" 
		crossorigin="anonymous"></script>
 	
 	<script>
  
	$(document).on('click', '#btnWriteForm' , function(e){
		e.preventDefault();
		
		location.href = "${pageContext.request.contextPath}/write";
	});
	function fn_contentView(bid){
		var url = "${pageContext.request.contextPath}/content";
		url = url + "?bid="+bid;
		location.href = url;
	}
	$(document).on('click', '#btnSearch', function(e){
		e.preventDefault();
		var url = "${pageContext.request.contextPath}/getBoardList";
		url = url + "?searchType=" + $('#searchType').val();
		url = url + "&keyword=" + $('#keyword').val();
		location.href = url;
		console.log(url);
	});	
	
  </script>

</head>

<body>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        Menu
        <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="getBoardList">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="about">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="sample">Sample Post</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="login/login">Login</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Header -->
  <header class="masthead" style="background-image: url('resources/img/home-bg.jpg')">
    <div class="overlay"></div>
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          <div class="site-heading">
            <h1>일서방's Blog</h1>
          </div>
        </div>
      </div>
    </div>
  </header>

  <!-- Main Content -->
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
      <c:forEach var = "list" items="${boardList }">
        <div class="post-preview">
          <a href="#" onClick="fn_contentView(<c:out value="${list.bid}"/>)">
            <h2 class="post-title">
              ${list.title}
            </h2>
            <h3 class="post-subtitle">
              ${list.content }
            </h3>
          </a>
          <p class="post-meta">Posted by
            <a href="#">on</a>
            ${list.reg_dt }</p>
        </div>
       
     
        <hr>
        </c:forEach>
        <!-- Pager -->
        <div>
			<button type="button" class="btn btn-primary float-right"
					id="btnSearchForm">Order posts &rarr;</button>
		</div>
        <br><br>
        <div>
			<button type="button" class="btn btn-primary float-right"
					id="btnWriteForm">Write Posts &rarr;</button>
		</div>
      </div>
    </div>
    	<br><br>
    		<div class="form-group row justify-content-center">

				<div class="w100" style="padding-right: 10px">

					<select class="form-control form-control-sm" name="searchType"
						id="searchType">

						<option value="title">제목</option>

						<option value="Content">본문</option>

						<option value="reg_id">작성자</option>

					</select>

				</div>

				<div class="w300" style="padding-right: 10px">

					<input type="text" class="form-control form-control-sm"
						name="keyword" id="keyword">

				</div>

				<div>

					<button class="btn btn-sm btn-primary" name="btnSearch"
						id="btnSearch">검색</button>

				</div>

			</div>
  </div>

  <hr>

  <!-- Footer -->
  <footer>
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          <ul class="list-inline text-center">
            <li class="list-inline-item">
              <a href="#">
                <span class="fa-stack fa-lg">
                  <i class="fas fa-circle fa-stack-2x"></i>
                  <i class="fab fa-twitter fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </li>
            <li class="list-inline-item">
              <a href="#">
                <span class="fa-stack fa-lg">
                  <i class="fas fa-circle fa-stack-2x"></i>
                  <i class="fab fa-facebook-f fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </li>
            <li class="list-inline-item">
              <a href="#">
                <span class="fa-stack fa-lg">
                  <i class="fas fa-circle fa-stack-2x"></i>
                  <i class="fab fa-github fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </li>
          </ul>
          <p class="copyright text-muted">Copyright &copy; Your Website 2019</p>
        </div>
      </div>
    </div>
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="resources/vendor/jquery/jquery.min.js"></script>
  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="resources/js/clean-blog.min.js"></script>

</body>

</html>
