<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.commentBean" id="commentB" scope="page" />
<% request.setCharacterEncoding("utf-8");%>
<% int bno = Integer.parseInt(request.getParameter("bno")); %>
<% String flag = request.getParameter("flag"); %>
<%String id = (String)session.getAttribute("memid"); %>
<%String memlogin = (String)session.getAttribute("memlogin"); %>
<% String ccontent = request.getParameter("ccontent"); %>
<% 
		int cno = Integer.parseInt(request.getParameter("cno")); 
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

%>