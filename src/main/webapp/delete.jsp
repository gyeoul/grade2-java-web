<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<% 
		request.setCharacterEncoding("utf-8");
		String memid = request.getParameter("memid");

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try{
				String jdbcDriver = "jdbc:mysql://211.193.44.86:31022/dongyang?useUnicode=true&characterEncoding=utf-8";
				String dbUser = "dongyang";
				String dbPass = "web";
				
				
				
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
					String sql_del = "DELETE FROM dongyang.test_member WHERE id = '"+ memid + "';";
					pstmt = conn.prepareStatement(sql_del);
					pstmt.executeUpdate();
			}	
			finally {
				if (rs != null) try { rs.close(); } catch(SQLException ex) {}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
			}
			response.sendRedirect("admin.jsp");
%>

	
