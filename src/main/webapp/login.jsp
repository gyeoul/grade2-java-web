<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean class="webproject.memberBean" id="memBean"/>
<jsp:setProperty name="memBean" property="*" />
<jsp:useBean class="webproject.memberMg" id="memMg"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String adminCheck = null;
	String loginCheck = memMg.memberLogin(id, pw, adminCheck); 
%>
<%
	if(loginCheck.equals("member")){
		session.setAttribute("memid",id);
		session.setAttribute("memlogin","ok");
		response.sendRedirect("index.jsp");
	}
	else if(loginCheck.equals("admin")){
		session.setAttribute("memid",id);
		session.setAttribute("admin", "admin");
		session.setAttribute("memlogin","ok");
		response.sendRedirect("index.jsp");
	}
	else {
		%>
		<script>
 		alert("아이디와 비밀번호 다시 입럭해주세요");
 		history.back();
 		</script>
		<%
	}
%>