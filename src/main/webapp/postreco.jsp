<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<%@page import="java.util.*, webproject.*"%>
<% String no = request.getParameter("bno"); %>
<%String memid = (String)session.getAttribute("memid"); %>
<%String memlogin = (String)session.getAttribute("memlogin"); %>
<%
	boolean flag =false;
	if(memlogin==null){
		%>
		  <script>
		    alert("로그인하세요");
			history.back();
		  </script>
	<%	
	}
	else{
		flag = boardmg.postReco(no, memid);
		if(flag){
			int count = boardmg.countReco(Integer.parseInt(no));
			%>
			  <script>
			    alert("추천했습니다");
			    location.href="post.jsp?bno=<%=no%>";
			  </script>
		<%	
		}
		else{
			%>
			  <script>
			    alert("추천한 게시글입니다.");
			    location.href="post.jsp?bno=<%=no%>";
			  </script>
		<%	
		}
	}
%>