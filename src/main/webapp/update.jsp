<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memMg" class="webproject.memberMg" />
<jsp:useBean id="memBean" class="webproject.memberBean" />
<jsp:setProperty name="memBean" property="*" />
<%
	request.setCharacterEncoding("utf-8");

	String mempw = request.getParameter("pw");
	String pwcheck = request.getParameter("pwcheck");
	
	if(mempw.equals(pwcheck)){
		 boolean flag = memMg.memberUpdate(memBean);
		 if(flag){
		 %>
		 		<script>
		 		alert("성공적으로 수정하였습니다");
		 		location.href="index.jsp";
		 		</script>
		 <%
		 	}
		 else{
		 %>
		 		<script>
		 		alert("수정도중 에러가 발생하였습니다.");
		 		history.back();
		 		</script>

		 <%
		 	  }
		 }
	else {
			 %>
		 		<script>
		 		alert("비밀번호를 정확하게 입력해주세요");
		 		history.back();
		 		</script>

		 <%
		 }		
%>