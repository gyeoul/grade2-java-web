<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="memBean" class="webproject.memberBean" />
<jsp:setProperty name="memBean" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="stylesheet" href="./style.css">
<style >
	#dele{
		margin-top : 20px;
		
	}
	input[type="text"]{
      	    all: unset;
      	    text-align : center;
      	    font-size : 20px;
      	    font-weight : bold;
      }
      #dele input[type="submit"]{
	      color: #333333;
		  background: #fff;
		  border: 1px solid #333333;
		  font-size: 17px;
		  text-align : center;
		  padding: 7px 12px;
		  margin-top: 40px;
		  margin-right: 12px;
		  display: inline-block;
		  width: 120px;
      }
      #dele input[type="submit"]:hover{
      	font-weight : bold;
      	color : #ffffff;
      	background: #333333;
      }
</style>
</head>
<body>
	<jsp:include page="./header.jsp" />
	<section>
		<article>
			<h2> 회원탈퇴</h2>
			<hr>
			<form id="dele" action="delete.jsp" >
			<input type="text" name=id value=<%=memBean.getId()%> readonly>님 탈퇴하시겠습니까?
			<br>
			<input type="submit" value="확인">
		</form>  
		</article>
	</section>
	<jsp:include page="./footer.jsp" />
</body>
</html>