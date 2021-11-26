<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="memMg" class="webproject.memberMg" />
<jsp:useBean id="memBean" class="webproject.memberBean" />
<jsp:setProperty name="memBean" property="*" />
<% 
	boolean flag = memMg.memberDelete(memBean); 
%>

<%	
if(flag) {

		%>
 		<script>
 		alert("삭제완료");
 		location.href="admin.jsp";
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
