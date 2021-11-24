<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리 페이지</title>
    <link rel="stylesheet" href="./style.css">
<style>
	input[type="text"]{
      	    all: unset;
      }
      table, th, td {
		  border: 1px solid black;
		  border-collapse: collapse;
		}
    tr, td {
  			height :  28px;
		}
    thead tr td {
    	background-color: #333333;
    	color : #ffffff;
    	margin-top : 30px;
    	margin-bottom : 30px;
    	font-size : 20px;
    	height : 30px;
    }
    input[type="submit"]:hover{
    	color : #ff0000;
    	text-decoration: underline; 
    	text-underline-position:under;
    }

</style>
</head>
<body>
<jsp:include page="./header.jsp" />
<section>
	<article>
		<h2>회원관리</h2>
		<hr>
		<% 

			Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt2 = null;
			ResultSet rs = null;
			ResultSet rs2 = null;

			try{
				Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				String sql = "select * from dongyang.test_member";
				pstmt = conn.prepareStatement(sql);

				rs = pstmt.executeQuery();
				System.out.println(rs);
				%>

				<table>
					<thead>
						<tr>
							<td>id</td>
							<td>pw</td>
							<td>mail</td>
							<td>admin</td>
							<td>delete</td>
						</tr>
					</thead>
					<tbody>
						<%
							while(rs.next()){
								System.out.println(rs);
								String memid = rs.getString("id");
								String mempw = rs.getString("pw");
								String memmail = rs.getString("mail");
								String memadmin = rs.getString("admin");
								%>
								<tr>
									<form method="post" action="deleteform.jsp?id=<%=memid%>">
										<td><input type="text" name=memid value=<%=memid%> readonly></td>
										<td><%=mempw %></td>
										<td><%=memmail%></td>
										<td><%=memadmin%></td>
										<td><input type="submit" value="회원삭제"></td>
									</form>
								</tr>
								<%
							}
						%>
					</tbody>
		</table>
		
		<%
			} catch (Exception e){
				e.printStackTrace();
			} finally {
				if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
			}
%>
		
		
		
	</article>
</section>
<jsp:include page="./footer.jsp" />
</body>
</html>