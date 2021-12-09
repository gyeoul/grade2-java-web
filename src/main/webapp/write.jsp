<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ page import="webproject.*" %>
<jsp:useBean class="webproject.BoardMg" id="boardmg" scope="page" />
<jsp:useBean class="webproject.boardBean" id="boardB" scope="page" />
<% request.setCharacterEncoding("utf-8");%>
<%
	String flag = request.getParameter("flag");
	boolean result = false;
	
	if(flag.equals("insert")){
    	result=boardmg.insertPost(request);
    	if(result){
    		%>
    			  <script>
    			    alert("작성완료");
    				location.href="board.jsp";
    			  </script>
    		<%	}else{%>
    			  <script>
    			    alert("오류가 발생하였습니다. 제대로 입력했는지 확인해주세요.");
    			    location.href="writeform.jsp?flag=insert";
    			  </script>
    		<%	}
	}else if(flag.equals("update")){
    	result=boardmg.modifyPost(request);
    	if(result){
    	%>
    			  <script>
    			    alert("수정완료");
    				location.href="board.jsp";
    			  </script>
    		<%	}else{%>
    			  <script>
    			    alert("오류가 발생하였습니다.");
    			    location.href="board.jsp";
    			  </script>
    		<%	}
	}else if(flag.equals("noticeins")){
    	result=boardmg.insertNoticePost(request);
    	if(result){
    		%>
    			  <script>
    			    alert("작성완료");
    				location.href="boardnotice.jsp";
    			  </script>
    		<%	}else{%>
    			  <script>
    			    alert("오류가 발생하였습니다. 제대로 입력했는지 확인해주세요.");
    			    location.href="writeform.jsp?flag=notice";
    			  </script>
    		<%	}
	}else if(flag.equals("noticeup")){
    	result=boardmg.updateNoticePost(request);
    	if(result){
    		%>
    			  <script>
    			    alert("수정완료");
    				location.href="boardnotice.jsp";
    			  </script>
    		<%	}else{%>
    			  <script>
    			  alert("오류가 발생하였습니다.");
  			    location.href="boardnotice.jsp";
    			  </script>
    		<%	}
	}
	else{
		response.sendRedirect("board.jsp");
	}
	%>	