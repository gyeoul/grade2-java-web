<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>

<% request.setCharacterEncoding("utf-8"); %>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String pwcheck = request.getParameter("pwcheck");
	String mail = request.getParameter("mail");
	
	if(mail==""){mail=null;}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt3 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;

	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String jdbcDriver = "jdbc:mysql://211.193.44.86:31022/dongyang?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "dongyang";
		String dbPass = "web";
		
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		String sql = "insert into dongyang.test_member values(?,?,?,?)";	
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, mail);
		pstmt.setString(4, null);
		
		String sql2 = "select * from dongyang.test_member where id = ?";
		pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, id);
		rs = pstmt2.executeQuery();
		
		String sql3 = "select * from dongyang.test_member where mail = ?";
		pstmt3 = conn.prepareStatement(sql3);
		pstmt3.setString(1, mail);
		rs2 = pstmt3.executeQuery();
		

		if( id == "" || id == null ) { 
			%> 
			<script type="text/javascript">
			alert("아이디를 입력하세요");
			location.href='joinform.jsp';
			</script>
			<% 
			}
		else if(pw == "" || pw == null){
			%> 
			<script type="text/javascript">
			alert("비밀번호를 입력하세요");
			location.href='joinform.jsp';
		    </script>
			<% 
			}
		else if(rs.next()){
						String memid = rs.getString("id");
						if(id.equals(memid)){
							%> 
							<script type="text/javascript">
							alert("중복된 아이디입니다.");
							location.href='joinform.jsp';
						    </script>
							<% 
						}
					}
		else if(rs2.next()){
			String memmail = rs2.getString("mail");
			if( memmail!=null && mail.equals(memmail)){
				%> 
				<script type="text/javascript">
				alert("중복된 이메일입니다.");
				location.href='joinform.jsp';
			    </script>
				<% 
			}
		}
		else {	 
			if(pw.equals(pwcheck)){ 
					pstmt.executeUpdate();
					System.out.println (pw);
					System.out.println (pwcheck);
					%> 
					<script type="text/javascript">
					alert("회원가입됐습니다.");
					location.href='index.jsp';
					 </script>
					<%
				}
			else{
				System.out.println (pw);
				System.out.println (pwcheck);
				%>
				<script type="text/javascript">
				alert("비밀번호가 다릅니다.");
				location.href='joinform.jsp';
			    </script>
				<%
			}
		}			 

	}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (rs2 != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex) {}
			if (pstmt3 != null) try { pstmt2.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
			
%>