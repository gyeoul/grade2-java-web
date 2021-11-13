<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./style.css">
<style>

	section form {
		text-align: center;
		margin-top :30px;
		margin-bottom :30px;
	}
	section label, input {
	  display:inline-block;
	}
	section label {
		width:150px;
	}
	section input {
		margin-top : 10px;
		margin-bottom : 10px;
		height :28px;
	}
	section #ok {
		margin-top : 10px;
		width : 100px;
		height : 35px;
		font-size : 18px;
		background-color : #333333;
		color : #ffffff;	
	}
</style>
</head>
<body>
	<jsp:include page="./header.jsp" />
	<section>
	<article id="join">
		<h2>회원가입</h2>
		<hr>
		<form action="join.jsp" method="post">	
			<label id="ID">아이디</label>
			<input id="ID" type="text" name="id" size="15" >
			<br>
			<label id="PW">비밀번호</label>
			<input id="PW" type="password" name="pw" size="15">
			<br>
			<label id="PW">비밀번호 확인</label>
			<input id="PW" type="password" name="pwcheck" size="15">
			<br>
			<label id="MAIL">이메일</label>
			<input id="MAIL" type="text" name="mail" size="25">
			<br>
			<input id="ok" type="submit" value="회원가입">
		</form>
	</article>
</section>
	<jsp:include page="./footer.jsp" />
</body>
</html>