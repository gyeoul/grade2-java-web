<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<% request.setCharacterEncoding("utf-8"); %>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		String jdbcDriver = "jdbc:mysql://211.193.44.86:31022/jspdb?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "dongyang";
		String dbPass = "web";
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		String sql = "select * from jspdb.member where member_id = ? and member_pw = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		
		rs = pstmt.executeQuery();
		
		
		if(rs.next()){
			System.out.println(rs);
			session.setAttribute("memid", id);
			session.setAttribute("memlogin", "ok");
			response.sendRedirect("index.jsp");
		}
		else {
			%> 
			<script type="text/javascript">
			alert("아이디와 비밀번호를 다시 확인해주세요");
			location.href='loginform.jsp';
		  </script>
		<% 
		}
		} 
		finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
%>
