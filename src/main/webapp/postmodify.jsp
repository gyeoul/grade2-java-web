<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="webproject.*" %>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<% request.setCharacterEncoding("utf-8");%>
<% String memid = (String)session.getAttribute("memid"); %>
<% String id = request.getParameter("writer"); %>
<% int bno = Integer.parseInt(request.getParameter("no")); %>
<% boardB = boardmg.getPost(bno); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<link rel="stylesheet" href="./style.css">
<style>
	.modifyform {
		margin-bottom :20px;
	}
	.modifyform td {
		height : 40px;
	}
	.modifyform input[type=text] {
		height : 30px;
		border-top:none;
		border-left:none;
		border-right:none;
		border-bottom: 1px solid;
	}
	
	.modifyform div {
		display : inline-block;
	}
	.modifyform div:hover {
		font-weight: bold;
	}
	.modifyform input[type=reset] {
		all: unset;
		border-bottom : 1px solid;
	}
	.modifyform input[type=submit] {
		border-bottom : 1px solid;
	}
</style>
</head>
<body>
<jsp:include page="./header.jsp" />
<section>
<article>
	<h2>글작성</h2>
	<hr>
	<form method="post" action="write.jsp?flag=update&bno=<%=bno %>" encType="multipart/form-data">
		<table class="modifyform">
			<tr>
				<td style="margin-left:-20px;" >말머리</td>
				<td style="float:left;"><input type='text' name='btag' style="width:70px;" value="<%=boardB.getBtag()%>"></td>
			</tr>
			<tr>
				<td style="width:150px;">제목</td>
				<td style="float:left;"><input type='text' name='btitle' style="width:600px;" value="<%=boardB.getBtitle()%>"></td>
			</tr>
			<tr>
				<td colspan='2'>
					<textarea name='bcontent' rows="25" cols="140"  style="resize: none; padding:20px; margin-top:10px;"><%=boardB.getBcontent()%></textarea>
				</td>
			</tr>
			<tr>
				<td colspan='2'  style="float:left;"><input type="file" name='bimage'></td>
			</tr>
			<tr>
				<td colspan='2'>
					<div style="width:200px;"><input type="submit" value="작성"></div>
					<div style="width:200px;"><input type="reset" value="다시쓰기"></div>
				</td>
			</tr>
		</table>
		<input type=hidden name="bno" value="<%=boardB.getBno()%>">
	</form>
</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>