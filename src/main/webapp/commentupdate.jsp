<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="webproject.*" %>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.commentBean" id="commentB" scope="page" />

<% request.setCharacterEncoding("utf-8");%>
<% String flag = request.getParameter("flag");%>
<% String memid = (String)session.getAttribute("memid"); %>
<% String admin = (String)session.getAttribute("admin"); %>
<% String memlogin = (String)session.getAttribute("memlogin"); %>
<% int bo = Integer.parseInt(request.getParameter("bno")); %>
<% int co = Integer.parseInt(request.getParameter("cno")); %>
<% commentB = boardmg.getComment(bo, co); %>
<%
if(memlogin==null){
		%>
		<script>
 		alert("권한이없습니다.");
 		history.back();
 		</script>
		<%
	}
	else{
		if(memid.equals(commentB.getCwriter())){
			if(flag.equals("del")){
				boolean result = boardmg.deleteComment(bo, co);
				if(result){
					%>
					<script>
			 		alert("댓글을 삭제했습니다.");
			 		location.href='post.jsp?bno=<%=bo%>';
			 		</script>
					<%
				}
				else{
					%>
					<script>
			 		alert("오류");
			 		history.back();
			 		</script>
					<%
				}
			}
			else if(flag.equals("mod")){
				%>
				<script>
				window.open("commentmodify.jsp?bno=<%=bo%>&cno=<%=co%>", '댓글수정', ' width=700, height=200');
				location.href='post.jsp?bno=<%=bo%>';
				</script>
				<%
			}
		}
		else if(admin!=null){
			if(flag.equals("del")){
				boolean result = boardmg.deleteComment(bo, co);
				if(result){
					%>
					<script>
			 		alert("댓글을 삭제했습니다.");
			 		location.href='post.jsp?bno=<%=bo%>';
			 		</script>
					<%
				}
				else{
					%>
					<script>
			 		alert("오류");
			 		history.back();
			 		</script>
					<%
				}
			}
			else if(flag.equals("mod")){
				%>
				<script>
			 		alert("권한이없습니다.");
			 		history.back();
			 		</script>
				<%
			}
		}
		else{
			%>
			<script>
	 		alert("권한이없습니다.");
	 		history.back();
	 		</script>
			<%
		}
	}
%>