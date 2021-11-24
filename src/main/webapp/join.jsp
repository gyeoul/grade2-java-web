<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String pwcheck = request.getParameter("pwcheck");
	String mail = request.getParameter("mail");

	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt3 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;

	if(mail.equals(""))mail=null;

	try{
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
		conn = ds.getConnection();
		
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
		

		if(id.equals("")) {
			%> 
			<script type="text/javascript">
			alert("아이디를 입력하세요");
			location.href='joinform.jsp';
			</script>
			<% 
			}
		else if(pw.equals("")){
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
			if(mail.equals(memmail)){
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
					location.href='loginform.jsp';
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

	}catch (Exception e){
		e.printStackTrace();
	}finally {
		if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
		if (rs2 != null) try { rs2.close(); } catch(SQLException ex) {ex.printStackTrace();}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
		if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex) {ex.printStackTrace();}
		if (pstmt3 != null) try { pstmt2.close(); } catch(SQLException ex) {ex.printStackTrace();}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	}
			
%>