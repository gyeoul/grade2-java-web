<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글작성</title>
<link rel="stylesheet" href="./style.css">
<style>
	.writeform{
		margin-bottom :20px;
	}
	.writeform td {
		height : 40px;
	}
	.writeform input[type=text] {
		height : 30px;
		border-top:none;
		border-left:none;
		border-right:none;
		border-bottom: 1px solid;
	}
	
	.writeform div {
		display : inline-block;
	}
	.writeform div:hover {
		font-weight: bold;
	}
	.writeform input[type=reset] {
		all: unset;
		border-bottom : 1px solid;
	}
	.writeform input[type=submit] {
		border-bottom : 1px solid;
	}
</style>
<%String memid = (String)session.getAttribute("memid"); %>
<%String flag = request.getParameter("flag"); %>
</head>
<body>
<jsp:include page="./header.jsp" />
<section>
<article>
	<h2>글작성</h2>
	<hr>
	<form method="post" action="write.jsp?flag=<%=flag%>" encType="multipart/form-data">
		<table class="writeform">
			<tr>
				<td style="width:20%;">말머리</td>
				<td style="float:left; margin-left:-150px;"><input type='text' name='btag' style="width:30%;"></td>
				<td style="width:30%;">작성자</td>
				<td style="float:left; margin-left:-150px;"><input type='text' name='bwriter' value="<%=memid%>" readonly style="width:50%;"></td>
			</tr>
			<tr>
				<td style="width:20%;">제목</td>
				<td style="float:left; margin-left:-100px;" ><input type='text' name='btitle' style="width:300%;"></td>
			</tr>
			<tr>
				<td colspan='4'>
					<textarea name='bcontent' rows="25" cols="140"  style="resize: none; padding:20px; margin-top:10px;" ></textarea>
				</td>
			</tr>
			<tr>
				<td colspan='4'  style="float:left;"><input type="file" name='bimage'></td>
			</tr>
			<tr>
				<td colspan='4'>
					<div style="width:200px;"><input type="submit" value="작성"></div>
					<div style="width:200px;"><input type="reset" value="다시쓰기"></div>
				</td>
			</tr>
		</table>
		
	</form>
</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>