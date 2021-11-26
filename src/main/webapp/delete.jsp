<%@ page contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<jsp:useBean id="memMg" class="webproject.memberMg" />
<jsp:useBean id="memBean" class="webproject.memberBean" />
<jsp:setProperty name="memBean" property="*" />
<% 
	boolean flag = memMg.memberDelete(memBean); 
%>

<%	
if(flag) {
	
		session.invalidate();
		%>
 		<script>
 		alert("탈퇴완료");
 		location.href="index.jsp";
 		</script>

 <%
 	}
 else{
 %>
 		<script>
 		alert("에러가 발생하였습니다.");
 		history.back();
 		</script>

<%
 	  }
		
%>
