<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<jsp:useBean class="webproject.commentBean" id="commentB" scope="page" />
<%@page import="java.util.*, webproject.*"%>
<% int bno = Integer.parseInt(request.getParameter("bno")); %>
<% boardB = boardmg.getNoticePost(bno); %>
<%String memid = (String)session.getAttribute("memid"); %>
<% 
	String memlogin = (String)session.getAttribute("memlogin");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>post no.<%=bno %></title>
<style>
	.post a{
		color: white;
	}
	.update a{
		text-decoration :none;
		color:#333333;
	}
	.update a:hover{
		border-bottom: 1px solid;
	}
	form span {
		color:#777777;
	}
	.reco:hover{
		border-bottom : 1px solid;
	}
	.comment td {
		height :28px;
	}
	.comment a{
		text-decoration: none;
		color: #333333;
	} 
	.comment a:hover{
		border-bottom: 1px solid;
	}
	.commentbtn:hover {
		border-bottom: 1px solid;
	}
</style>

</head>
 <link rel="stylesheet" href="./style.css">
<body>
<jsp:include page="./header.jsp" />
<section>
<article>
	<h2><a href="boardnotice.jsp" style="color:black;">공지 게시판</a></h2>
	<hr>
	<table class="post">
		<thead style="background-color:#333333; color:white; height : 40px;">
			<tr style="border-bottom:1px solid; ">
				<td style="width:10%;">[ <%=boardB.getBtag() %> ]</td>
				<td style="text-align:left"><%=boardB.getBtitle() %></td>
			</tr>
		</thead>
			<tr style="background-color:#f2f2f2; height : 30px;">
				<td style="width:10%;"><%=boardB.getBwriter() %></td>
				<td style="text-align: left"><%=boardB.getBdate() %></td>
			</tr>
		</table>
		<ul>
			<li></li>
		</ul>
		<div class="update" style="float:right">
			 <a href="postnoticeupdate.jsp?no=<%=bno%>&flag=noticemod">수정</a>
			 <a href="postnoticeupdate.jsp?no=<%=bno%>&flag=noticedel">삭제</a>
		</div>
		<div style="margin:30px;">
			<%=boardB.getBcontent() %>
			<br><%if(boardB.getBimage()!=null){ %>
			<img src="data/<%=boardB.getBimage() %>" width=100%>
			<%} %>
		</div>
</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>

