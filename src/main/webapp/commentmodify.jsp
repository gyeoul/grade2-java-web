 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% int bno = Integer.parseInt(request.getParameter("bno")); %>
<% int cno = Integer.parseInt(request.getParameter("cno")); %>
<html>
<head>
<meta charset="UTF-8">
<title>댓글수정</title>
</head>
<style>
	div {
		text-align : center;
	}
	input {
		 all: unset;
		 font-size:1.2em;
		 margin-top : 10px;
		 margin-left : 20px;
		float : center;
	}
	input:hover{
		border-bottom: 1px solid black;
	}
</style>
<body>
	<h2>댓글수정</h2>
	<hr>
	<form method="post" action="commentmodify2.jsp?bno=<%=bno%>&cno=<%=cno%>">
	<textarea rows="2" cols="95 " name="ccontent" style="resize: none; padding:20px; margin-top:10px;"></textarea>
	<div>
		<input type="submit" value="수정"><input type="button" onClick="window.close()"  value="취소">
	</div>
	</form>
</body>
</html>