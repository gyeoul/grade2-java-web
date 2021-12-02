<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<%@page import="java.util.*, webproject.*"%>
<% request.setCharacterEncoding("utf-8");%>
<% int bno = Integer.parseInt(request.getParameter("bno")); %>
<% int cno = Integer.parseInt(request.getParameter("cno")); %>
<% String flag = request.getParameter("flag"); %>
<% boardB = boardmg.getPost(bno); %>
<%String id = (String)session.getAttribute("memid"); %>
<%String memlogin = (String)session.getAttribute("memlogin"); %>
<% String ccontent = request.getParameter("ccontent"); %>
<%
	if(memlogin==null){
		%>
		<script>
		alert("로그인하세요");
		location.href='post.jsp?bno=<%=bno%>';
		</script>
		<%
	}
	else if(flag.equals("mod")){
		boolean result = boardmg.updateComment(bno, cno, ccontent);
		if(result){
			%>
			<script>
			window.alert("댓글등록");
			self.close();
			</script>
			<%
		} else {
			%>
			<script>
			alert("오류");
			self.close();
			</script>
			<%
		}
	}
	else{
		boolean result = boardmg.postComment(bno, id, ccontent);
		if(result){
			%>
			<script>
			alert("댓글등록");
			location.href='post.jsp?bno=<%=bno%>';
			</script>
			<%
		} else {
			%>
			<script>
			alert("오류");
			location.href='post.jsp?bno=<%=bno%>';
			</script>
			<%
		}
	}
	
%>