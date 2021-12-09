<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<jsp:useBean class="webproject.commentBean" id="commentB" scope="page" />
<%@page import="java.util.*, webproject.*"%>
<% request.setCharacterEncoding("utf-8");%>
<% int bno = Integer.parseInt(request.getParameter("bno")); %>
<% boardB = boardmg.getPost(bno); %>
<%String memid = (String)session.getAttribute("memid"); %>
<% 
	String memlogin = (String)session.getAttribute("memlogin");
 	Vector<commentBean> cResult = boardmg.getCommentList(bno);
 	String flag = request.getParameter("flag");

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

	<h2><% 	if(flag.equals("board")){%> <a href="board.jsp" style="color:black;">게시판</a> <%;}
 		else if(flag.equals("reco")){%> <a href="boardreco.jsp" style="color:black;">추천 게시판</a> <%;} %></h2>
	<hr>
	<table class="post">
		<thead style="background-color:#333333; color:white; height : 40px;">
			<tr style="border-bottom:1px solid; ">
				<td style="width:10%;"><a href="boardtag.jsp?tag=<%=boardB.getBtag()%>">[ <%=boardB.getBtag() %> ]</a></td>
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
			 <a href="postupdate.jsp?no=<%=bno%>&flag=mod">수정</a>
			 <a href="postupdate.jsp?no=<%=bno%>&flag=del">삭제</a>
		</div>
		<div style="margin:30px;">
			<%=boardB.getBcontent() %>
			<br><%if(boardB.getBimage()!=null){ %>
			<img src="data/<%=boardB.getBimage() %>" width=100%>
			<%} %>
		</div>
		<% int recnt = boardmg.countReco(bno); %>
		<div  style="text-align:center">
			<form method="post" action="postreco.jsp?bno=<%=bno%>" style="margin:10px;">
				<input class="reco" type="submit" value="추천하기" style="font-size:1.2em;">
				<span>[<%=recnt%>]</span>
			</form>
		</div>
		<table class="comment">
			<thead style="height : 40px;" >
				<tr>
					<td style="text-align:center; width:5%;">댓글</td>
					<% int cocnt = boardmg.countComment(bno); %>
					<td style="text-align:left;">[<%=cocnt%>]개</td>
				</tr>
			</thead>
			<% for (int i=0; i<cResult.size(); i++) {
						commentB = cResult.get(i);%>
				<tr style="background-color:#f2f2f2; border-top : white solid 2.5px;">
					<td rowspan="2" style="text-align:center;" ><%=commentB.getBcno() %></td>
					<td style="text-align:left;"><%=commentB.getCwriter() %></td>
					<td style="text-align:center; width:10%; font-size:0.8em;"><%=commentB.getCdate() %></td>
					<td style="text-align:center; width:5%; font-size:0.8em;"><a href="commentupdate.jsp?bno=<%=bno%>&cno=<%=commentB.getCno()%>&flag=mod">수정</a></td>
					<td style="text-align:center; width:5%; font-size:0.8em;"><a href="commentupdate.jsp?bno=<%=bno%>&cno=<%=commentB.getCno()%>&flag=del">삭제</a></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align:left; background-color:#f2f2f2;"><%=commentB.getCcontent()%> </td>
				</tr>
			<% }%>
		</table>
		<form method="post" action="postcomment.jsp?bno=<%=bno%>" style="margin-bottom:30px;">
			<input type=hidden name="cno" value="<%=commentB.getCno()%>">
			<textarea rows="2" cols="138" name="ccontent"  style="resize: none; padding:20px; margin-top:20px;"></textarea>
			<input type="submit"  value="댓글등록" style="float:right; font-size:1.2em;" class="commentbtn">
		</form>
		
</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>

