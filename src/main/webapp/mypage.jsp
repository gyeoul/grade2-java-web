<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="memMg" class="webproject.memberMg" />
<jsp:useBean id="memBean" class="webproject.memberBean" />

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./style.css">
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
<style>
	section label, input, form  {
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
	#update, #delete {
		margin: 30px;
		font-size: 1.3em;
		font-weight : bold;
	}
	#update:hover, #delete:hover {
		color : red;
		
	}
	section div {
	margin-top: 30px;
	text-align: center;
	margin-left : 300px;
	}
	#update {
	text-align: center;
	margin-left:400px;
	}
	#delete {
	margin-left:-120px;
	}
</style>
<title>마이페이지</title>
</head>
<body>
<jsp:include page="./header.jsp" />
<section>
<article>
 <h2>마이페이지</h2>
 <hr>
<% 	String memid = (String)session.getAttribute("memid"); 
	memBean = memMg.getMember(memid); %>
			<form action="update.jsp?id=<%=memBean.getId()%>" method="post">
 			<div>
			<label >아이디</label>
			<input type="text" name="id" size="15" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" value="<%=memBean.getId()%>" readonly>
			<br>
			<label >비밀번호</label>
			<input  type="password" name="pw" size="15" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" value="<%=memBean.getPw()%>">
			<br>
			<label>비밀번호 확인</label>
			<input type="password" name="pwcheck" size="15" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this); ">
			<br>
			<label>이메일</label>
			<input type="text" name="email" size="25" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" value="<%=memBean.getEmail()%>" >
			<br>
			</div>
			<input id="update" type="submit" value="수정하기">
			</form>
			<form action="deleteform.jsp?id=<%=memBean.getId()%>" method="post">
			<input id="delete" type="submit" value="탈퇴하기">
			</form>
</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>