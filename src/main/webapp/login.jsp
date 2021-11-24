<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
		conn = ds.getConnection();

		String sql = "select * from dongyang.test_member where id = ? and pw = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.executeQuery();

		rs = pstmt.executeQuery();
		if(rs.next()){
			do {
				System.out.println(rs);
				String memid = rs.getString("id");
				session.setAttribute("memid", memid);
				String admin = rs.getString("admin");
				session.setAttribute("admin", admin);
				session.setAttribute("memlogin", "ok");
				response.sendRedirect("index.jsp");

				} while(rs.next());
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
	catch (Exception e) {
		e.printStackTrace();
	}
	finally {
		if (rs != null) try {rs.close();} catch (SQLException ex) {ex.printStackTrace();}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	}
%>
