<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, webproject.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean  id="memberBean" class="webproject.memberBean"/>
<jsp:setProperty name="memBean" property="*" />
<jsp:useBean id="memberMg" class="webproject.memberMg" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리 페이지</title>
    <link rel="stylesheet" href="./style.css">
<style>

     .admintab th, td {
     	height :  28px;
		  border: 1px solid black;
		  border-collapse: collapse;
		}
    .admintab thead tr td {
    	background-color: #333333;
    	color : #ffffff;
    	margin-top : 30px;
    	margin-bottom : 30px;
    	font-size : 20px;
    	height : 30px;
    }
    .admintab a {
      	    all: unset;
      }
    .admintab a:hover {
    	color : #ff0000;
    	text-decoration: underline; 
    	text-underline-position:under;
    	cursor:pointer;
    }

</style>
</head>
<body>
<jsp:include page="./header.jsp" />
<section>
	<article>
		<h2>회원관리</h2>
		<hr>
		<table class="admintab">
			<thead>
				<tr>
				<td> 회원 ID </td>
				<td> 회원 PW </td>
				<td> 회원 Email </td>
				<td> admin </td>
				<td> 회원삭제 </td>
				</tr>
			</thead>
			<%
				Vector<memberBean> mResult = memberMg.getMemberList();
				for(int i=0; i<mResult.size(); i++){
					memberBean = mResult.get(i);
			%>
			<tr>
			<td align="center"><%=memberBean.getId()%></td>
			<td align="center"><%=memberBean.getPw()%></td>
			<td align="center"><%=memberBean.getEmail()%></td>
			<td align="center"><%=memberBean.getAdmin()%></td>
			<td align="center"><a href="admin_deleteform.jsp?id=<%=memberBean.getId()%>">회원삭제</a></td>
			</tr>
			<%
			}
			%>
		</table>
		
	</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>