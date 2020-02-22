<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/header.jsp"%>
<%@ taglib prefix="form" uri = "http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Clean Blog - Start Bootstrap Theme</title>

<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>

<!-- Custom styles for this template -->
<link href="resources/css/clean-blog.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous">
	
</script>

<script>

	$(document).ready(function(){
		showReplyList();
	});
	
	$(document).on('click', '#btnReplySave', function(){

		var replyContent = $('#content').val();
		var replyReg_id = $('#reg_id').val();
		var paramData = JSON.stringify({"content": replyContent

				, "reg_id": replyReg_id
				, "bid":'${boardContent.bid}'
		});

		var headers = {"Content-Type" : "application/json"
				, "X-HTTP-Method-Override" : "POST"};

		$.ajax({
			url: "${pageContext.request.contextPath}/restBoard/saveReply"

			, headers : headers
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){

				showReplyList();

				$('#content').val('');
				$('#reg_id').val('');
			}

			, error: function(error){
				console.log("에러 : " + error);
			}
		});
	});


	$(document).on('click', '#btnList', function() {

		location.href = "${pageContext.request.contextPath}/getBoardList";

	});

	$(document).on('click', '#btnUpdate', function() {
		var url = "${pageContext.request.contextPath}/editForm";
		url = url + "?bid=" + $
		{
			boardContent.bid
		}
		;
		url = url + "&mode=edit";
		location.href = url;
	});

	//삭제 버튼 클릭 이벤트

	$(document).on('click', '#btnDelete', function() {
		var url = "${pageContext.request.contextPath}/deleteBoard";
		url = url + "?bid=" + $
		{
			boardContent.bid
		}
		;
		location.href = url;
	});

	

	function showReplyList() {

		var url = "${pageContext.request.contextPath}/restBoard/getReplyList";
		var paramData = {
			"bid" : "${boardContent.bid}"
		};

		$.ajax({

					type : 'POST',
					url : url,
					data : paramData,
					dataType : 'json',

					success : function(result) {
						var htmls = "";
						if (result.length < 1) {
							htmls.push("등록된 댓글이 없습니다.");
						} else {
							$(result).each(function() {

												htmls += '<div class="media text-muted pt-3" id="rid' + this.rid + '">';
												htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
												htmls += '<title>Placeholder</title>';
												htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
												htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
												htmls += '</svg>';

												htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';

												htmls += '<span class="d-block">';

												htmls += '<strong class="text-gray-dark">'
														+ this.reg_id
														+ '</strong>';

												htmls += '<span style="padding-left: 7px; font-size: 9pt">';
												htmls += '<a href="javascript:void(0)" onclick="fn_editReply('
														+ this.rid
														+ ', \''
														+ this.reg_id
														+ '\', \''
														+ this.content
														+ '\' )" style="padding-right:5px">수정</a>';

												htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply('
														+ this.rid
														+ ')" >삭제</a>';
												htmls += '</span>';
												htmls += '</span>';
												htmls += this.content;
												htmls += '</p>';
												htmls += '</div>';
											}); //each end
						}

						$("#replyList").html(htmls);

					} // Ajax success end

				}); // Ajax end
				
		function fn_editReply(rid, reg_id, content){

			var htmls = "";

			htmls += '<div class="media text-muted pt-3" id="rid' + rid + '">';
			htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
			htmls += '<title>Placeholder</title>';
			htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
			htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
			htmls += '</svg>';
			htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
			htmls += '<span class="d-block">';
			htmls += '<strong class="text-gray-dark">' + reg_id + '</strong>';
			htmls += '<span style="padding-left: 7px; font-size: 9pt">';
			htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + rid + ', \'' + reg_id + '\')" style="padding-right:5px">저장</a>';
			htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';
			htmls += '</span>';
			htmls += '</span>';		
			htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
			htmls += content;
			htmls += '</textarea>';
			htmls += '</p>';
			htmls += '</div>';
			$('#rid' + rid).replaceWith(htmls);
			$('#rid' + rid + ' #editContent').focus();

		}

		function fn_updateReply(rid, reg_id){

			var replyEditContent = $('#editContent').val();

			var paramData = JSON.stringify({"content": replyEditContent
					, "rid": rid
			});

			var headers = {"Content-Type" : "application/json"
					, "X-HTTP-Method-Override" : "POST"};
			$.ajax({
				url: "${pageContext.request.contextPath}/restBoard/updateReply"
				, headers : headers
				, data : paramData
				, type : 'POST'
				, dataType : 'text'
				, success: function(result){
	                                console.log(result);
					showReplyList();
				}
				, error: function(error){
					console.log("에러 : " + error);
				}
			});
		}
		function fn_deleteReply(rid){

			var paramData = {"rid": rid};

			$.ajax({
				url: "${pageContext.request.contextPath}/restBoard/deleteReply"
				, data : paramData
				, type : 'POST'
				, dataType : 'text'
				, success: function(result){
					showReplyList();
				}
				, error: function(error){
					console.log("에러 : " + error);
				}
			});
		}
	}
</script>

</head>

<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container">
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="index">Home</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="about">About</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="sample">Sample
							Post</a></li>
					<li class="nav-item"><a class="nav-link" href="contact">Contact</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Page Header -->
	<header class="masthead"
		style="background-image: url('resources/img/home-bg.jpg')">
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
	<article>
		<div class="container" role="main">
			<h2>board Content</h2>
			<br>
			<div class="bg-white rounded shadow-sm">
				<div class="board_title">
					<h2>
						<c:out value="${boardContent.title}" />
					</h2>
				</div>
				<div class="board_info_box">
					<span class="board_author"><c:out
							value="${boardContent.reg_id}" /> , </span><span class="board_date"><c:out
							value="${boardContent.reg_dt}" /></span>
				</div>
				<div class="board_content">${boardContent.content}</div>
				<div class="board_tag">
					TAG :
					<c:out value="${boardContent.tag}" />
				</div>
			</div>

			<div style="margin-top: 20px">
				<button type="button" class="btn btn-sm btn-primary" id="btnUpdate">수정</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnDelete">삭제</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
			</div>


			<!-- Reply Form {s} -->
			<br>
			<br>
			<div class="my-3 p-3 bg-white rounded shadow-sm"
				style="padding-top: 10px">
				<form:form name="form" id="form" role="form"
					modelAttribute="replyVO" method="post">
					<form:hidden path="bid" id="bid" /> 
					<div class="row">
						<div class="col-sm-10">
							<form:textarea path="content" id="content" class="form-control"
								rows="3" placeholder="댓글을 입력해 주세요"></form:textarea>
						</div>

						<div class = "col-sm-2">
							<form:input path="reg_id" class="form-control" id="reg_id"
								placeholder="댓글 작성자"></form:input>

							<button type="button" class="btn btn-sm btn-primary"
								id="btnReplySave" style="width: 100%; margin-top: 10px">
								저 장</button>
						</div>
					</div>
				</form:form>
			</div>
			<!-- Reply Form {e} -->

			<!-- Reply List {s}-->
			<div class="my-3 p-3 bg-white rounded shadow-sm"
				style="padding-top: 10px">
				<h6 class="border-bottom pb-2 mb-0">Reply list</h6>
				<div id="replyList"></div>
			</div>
			<!-- Reply List {e}-->
		</div>
	</article>



	<hr>

	<!-- Footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<ul class="list-inline text-center">
						<li class="list-inline-item"><a href="#"> <span
								class="fa-stack fa-lg"> <i
									class="fas fa-circle fa-stack-2x"></i> <i
									class="fab fa-twitter fa-stack-1x fa-inverse"></i>
							</span>
						</a></li>
						<li class="list-inline-item"><a href="#"> <span
								class="fa-stack fa-lg"> <i
									class="fas fa-circle fa-stack-2x"></i> <i
									class="fab fa-facebook-f fa-stack-1x fa-inverse"></i>
							</span>
						</a></li>
						<li class="list-inline-item"><a href="#"> <span
								class="fa-stack fa-lg"> <i
									class="fas fa-circle fa-stack-2x"></i> <i
									class="fab fa-github fa-stack-1x fa-inverse"></i>
							</span>
						</a></li>
					</ul>
					<p class="copyright text-muted">Copyright &copy; Your Website
						2019</p>
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
