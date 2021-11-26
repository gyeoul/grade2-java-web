<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="webproject.memberBean" id="memBean" scope="page" />
<jsp:setProperty name="memBean" property="*" />
<jsp:useBean class="webproject.memberMg" id="memMg" scope="page" />
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String pwcheck = request.getParameter("pwcheck");
	String email = request.getParameter("email");
	
	boolean idCheck = memMg.idCheck(id);
	boolean emailCheck = memMg.emailCheck(email); 
	
	if(id.equals("")||pw.equals("")||email.equals(""))
	{%>
	<script>
		alert("빈칸없이 입력해주세요");
		history.back();
		</script>
	<%}
	else if(id==null||pw==null||email==null)
	{%>
	<script>
	alert("빈칸없이 입력해주세요");
	history.back();
	</script>
	<%}
	else if(pw.equals(pwcheck))
	{
		if(idCheck)
		{%>
		<script>
		alert("중복된 아이디 다시 입력해주세요");
		history.back();
		</script>
		<%}
		else {
			if(emailCheck)
			{%>
			<script>
			alert("중복된 이메일 다시 입력해주세요");
			history.back();
			</script>
			<%}
			else{
				boolean flag = memMg.memberInsert(memBean);
				if(flag){%>
				<script>
				alert("회원가입완료");
				location.href='loginform.jsp';
				</script>
				<%}
				else {%>
				<script>
				alert("오류 다시입력해주세요");
				history.back();
				</script>
				<%}
			}
		}
		
	}
	else {%>
	<script>
	alert("비밀번호 제대로 입력해주세요");
	history.back();
	</script>
	<%
		
	}
	
%>