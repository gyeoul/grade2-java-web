<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean class="webproject.memberBean" id="memBean" scope="page" />
<jsp:setProperty name="memBean" property="*" />
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="./style.css">
<style>
	section span {
		font-size : 1.4em;
		font-weight: 600;
		margin-right : 10px;
	}
	section a {
		background-color : #333333;
		color :#ffffff;
	}
	section form {
		margin-top :30px;
		margin-bottom :30px;
		text-align: center;
	}
	section label, input {
	  display:inline-block;
	}
	section label {
		width:100px;
	}
	section input {
		margin-top : 10px;
		margin-bottom : 10px;
		height :28px;
		text-align: center;
	}
	section #ok {
		margin-top : 20px;
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
	<article id="login">
		<div style= "margin-top: 19.92px; margin-bottom: 19.92px;" >
		<span>로그인</span>
		<span>|</span>
		<span><a href="joinform.jsp">회원가입</a></span>
		</div>
			
		<hr>
		<form action="login.jsp" method="post">	
			<label id="ID">아이디</label>
			<input id="ID" type="text" name="id" size="15" >
			<br>
			<label id="PW">비밀번호</label>
			<input id="PW" type="password" name="pw" size="15">
			<br>
			<input id="ok" type="submit" value="로그인">
		</form>
	</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>