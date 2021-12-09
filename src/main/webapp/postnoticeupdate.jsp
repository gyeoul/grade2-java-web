<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="webproject.*" %>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<% request.setCharacterEncoding("utf-8");%>
<% String flag = request.getParameter("flag");%>
<% String memid = (String)session.getAttribute("memid"); %>
<% int bno = Integer.parseInt(request.getParameter("no")); %>
<% boardB = boardmg.getNoticePost(bno); %>
<%
	if(memid.equals(boardB.getBwriter())){
		if(flag.equals("noticedel")){
					boolean result = boardmg.deleteNoticePost(bno);
					if(result){
						%>
						<script>
				 		alert("공지 게시글을 삭제했습니다.");
				 		location.href='boardnotice.jsp';
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
				else if(flag.equals("noticemod")){
					%>
					<script>
					location.href='postmodify.jsp?no=<%=bno%>&flag=noticeup';
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
%>