<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean class="webproject.memberBean" id="memBean" scope="page" />
<jsp:setProperty name="memBean" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
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
		text-align: center;
	}
	section #ok {
		margin-top : 30px;
		width : 100px;
		height : 35px;
		font-size : 18px;
		background-color : #333333;
		color : #ffffff;
	}
</style>
<script>
	function noSpaceForm(obj) { // 공백사용못하게
	    var str_space = /\s/;  // 공백체크
	    if(str_space.exec(obj.value)) { //공백 체크
	        obj.focus();
	        obj.value = obj.value.replace(' ',''); // 공백제거
	        return false;
	    }

	}
</script>
</head>
<body>
	<jsp:include page="./header.jsp" />
	<section>
	<article id="join">
		<h2>회원가입</h2>
		<hr>
		<form action="join.jsp" method="post">
			<label >아이디</label>
			<input type="text" name="id" size="15" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" >
			<br>
			<label >비밀번호</label>
			<input  type="password" name="pw" size="15" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);">
			<br>
			<label>비밀번호 확인</label>
			<input type="password" name="pwcheck" size="15" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);">
			<br>
			<label>이메일</label>
			<input type="text" name="email" size="25" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);">
			<br>
			<input id="ok" type="submit" value="회원가입">
		</form>
	</article>
</section>
	<jsp:include page="./footer.jsp" />
</body>
</html>