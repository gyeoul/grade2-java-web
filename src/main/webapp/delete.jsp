<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<% 
	request.setCharacterEncoding("utf-8");
	String memid = request.getParameter("memid");

	Connection conn = null;
	PreparedStatement pstmt = null;

	try{
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
		conn = ds.getConnection();



		String sql_del = "DELETE FROM dongyang.test_member WHERE id = '"+ memid + "';";
		pstmt = conn.prepareStatement(sql_del);
		pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	}
	response.sendRedirect("admin.jsp");
%>

	
