<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, webproject.*"%>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="./style.css">
<style>
	.board a{
		color: black;
	}
	.board input[type='button'] {
		all: unset;
		text-align: center;
		float: right;
		font-size:1.2em;
		background-color: #333333;
		color:white;
		padding: 3px;
	}
	.btitle a:hover{
		border-bottom:1px solid;
	}
	.board span{
	 font-size:0.8em;
	}
</style>
<% String admin = (String)session.getAttribute("admin");
 	Vector<boardBean> pResult = boardmg.getNoticePostList (); %>
</head>
<body>
<jsp:include page="./header.jsp" />
<section>
	<article>
	<h2><a href="boardnotice.jsp" style="color:black;">공지 게시판</a></h2>
		<hr>
		<table class="board">
			<thead style="background-color:#333333; color:white; height : 40px;">
				<tr>
					<td> 글번호 </td>
					<td> 말머리 </td>
					<td> 글제목 </td>
					<td> 작성자 </td>
					<td> 작성일 </td>
					<td> 추천수 </td>
				</tr>
			</thead>
				<% for (int i=0; i<pResult.size(); i++) {
						boardB = pResult.get(i);%>
				<tr  style="height: 30px;">
					<td><%=boardB.getBno()%> </td>
					<td><%=boardB.getBtag()%></td>
					<% int cocnt = boardmg.countComment(boardB.getBno()); %>
					<td class="btitle"><a href="postnotice.jsp?bno=<%=boardB.getBno()%>"><%=boardB.getBtitle()%></a></td>
					<td><%=boardB.getBwriter()%></td>
					<td><%=boardB.getBdate()%> </td>
				</tr>
				<% }%>
				<tr >
					<td colspan="6"><input type="button" onclick='<%if(admin==null){
						%>
					alert("권한이 없습니다");
				<% }
				else {
					%>
					location="writeform.jsp?flag=noticeins"
					<%
				}
				%>' value="글쓰기">
				</tr>
				
		</table>
	</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>