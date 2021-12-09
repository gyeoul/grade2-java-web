<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="webproject.*" %>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<% request.setCharacterEncoding("utf-8");%>
<% String flag = request.getParameter("flag");%>
<% String memid = (String)session.getAttribute("memid"); %>
<% String admin = (String)session.getAttribute("admin"); %>
<% String memlogin = (String)session.getAttribute("memlogin"); %>
<% int bno = Integer.parseInt(request.getParameter("no")); %>
<% boardB = boardmg.getPost(bno); %>
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
		if(memid.equals(boardB.getBwriter())){
			if(flag.equals("del")){
				boolean result = boardmg.deletePost(bno);
				if(result){
					%>
					<script>
			 		alert("게시글을 삭제했습니다.");
			 		location.href='board.jsp';
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
				location.href='postmodify.jsp?no=<%=bno%>&flag=update';
		 		</script>
				<%
			}
		}
		else if(admin!=null){
			if(flag.equals("del")){
				boolean result = boardmg.deletePost(bno);
				if(result){
					%>
					<script>
			 		alert("게시글을 삭제했습니다.");
			 		location.href='board.jsp';
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