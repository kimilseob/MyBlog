<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">

<title>board</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>



<script>
	function fn_btnSignupClick() {
		location.href = "${pageContext.request.contextPath}/login/signupForm";
	}
</script>

<style type ="text/css">
	html, body {
	height: 100%;
}

body {
	display: -ms-flexbox;
	display: flex;
	-ms-flex-align: center;
	align-items: center;
	padding-top: 40px;
	padding-bottom: 40px;
}

.form-signin {
	width: 100%;
	max-width: 330px;
	padding: 15px;
	margin: auto;
}

.form-signin .checkbox {
	font-weight: 400;
}

.form-signin .form-control {
	position: relative;
	box-sizing: border-box;
	height: auto;
	padding: 10px;
	font-size: 16px;
}

.form-signin .form-control:focus {
	z-index: 2;
}

.form-signin input[id="uid"] {
	margin-bottom: -1px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

.form-signin input[id="pwd"] {
	margin-bottom: 10px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}
	
</style>
</head>
<body>
<!-- login form {s} -->
	<c:choose>
		<c:when test="${sessionId != null}">
			<h2> 네이버 아이디 로그인 성공하셨습니다!! </h2>
			<h3>'${sessionId}' 님 환영합니다! </h3>
			<h3><a href="logout">로그아웃</a></h3>
		</c:when>

		<c:otherwise>
		<form:form class="form-signin" name="form" id="form" role="form"
			modelAttribute="userVO" method="post"
			action="${pageContext.request.contextPath}/board/saveBoard">

		<div class="text-center mb-4">
			<h1 class="h3 mb-3 font-weight-normal">ILSEOB.COM</h1>
		</div>
		<div class="form-label-group">
			<form:input path="uid" id="uid" class="form-control"
				placeholder="User ID" required="" autofocus="" />
			<label for="uid" class="sr-only">User ID</label>
		</div>

		<div class="form-label-group">
			<form:password path="pwd" id="pwd" class="form-control"
				placeholder="User Password" required="" />
			<label for="pwd" class="sr-only">User Password</label>
		</div>

		<button class="btn btn-lg btn-primary btn-block" type="submit">Signin</button>
		<span style="font-size: 11pt;"> <a href="#" onClick="fn_btnSignupClick()">Sign up</a>
		</span>
		<p class="mt-5 mb-3 text-muted text-center">© 2020. ILSEOB. All
			rights reserved.</p>
	
		</form:form>
		<!-- 네이버 로그인 창으로 이동 -->
		<div id="naver_id_login" style="text-align:center"><a href="${url}">
			<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
		<br>
		
		</c:otherwise>
		</c:choose>

	


</body>
</html>

<!-- login form {e} -->
