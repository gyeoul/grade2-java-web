package webproject;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.*;
import java.util.Vector;



public class memberMg {
	//로그인
	public memberBean getLogin (String id, String pw) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        memberBean memBean = null;
        try {
        	Context initContext = new InitialContext();
    		Context envContext = (Context)initContext.lookup("java:/comp/env");
    		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
    		conn = ds.getConnection();
    		String sql = "select * from dongyang.Member where id = ? and pw = ?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, id );
    		pstmt.setString(2, pw );
    		pstmt.executeQuery();
    		 rs = pstmt.executeQuery();
    		 if(rs.next()) {
    			 do {
    				 memBean = new memberBean();
    	             	memBean.setId(rs.getString("id"));
    	             	memBean.setPw(rs.getString("pw"));
    	    			memBean.setAdmin(rs.getString("admin"));
    			 }while(rs.next());
    		 }
    		 else {memBean = null;}
        }catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
        }
        return memBean;
	}
	
	//마이페이지 조회
	public memberBean getMember (String memid ){
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        memberBean memBean = null;

        try {
        	Context initContext = new InitialContext();
    		Context envContext = (Context)initContext.lookup("java:/comp/env");
    		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
    		conn = ds.getConnection();
            String sql = "select * from dongyang.Member where id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memid);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	memBean = new memberBean();
            	memBean.setId(rs.getString("id"));
            	memBean.setPw(rs.getString("pw"));
            	memBean.setEmail(rs.getString("mail"));
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
        }
        return memBean;
	}
	
	//마이페이지 정보수정
	public boolean memberUpdate(memberBean memBean) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    boolean flag = false;
	    try {
	    	Context initContext = new InitialContext();
    		Context envContext = (Context)initContext.lookup("java:/comp/env");
    		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
    		conn = ds.getConnection();
	        String sql = "update dongyang.Member set pw=?, mail=?  where id=? ";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, memBean.getPw());
	        pstmt.setString(2, memBean.getEmail());
	        pstmt.setString(3, memBean.getId());
	        int count = pstmt.executeUpdate();

	        if (count == 1) {
	            flag = true;
	        }
	    } catch (Exception ex) {
	        System.out.println("Exception" + ex);
	    } finally {
	    	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	    }
	    return flag;
	}
	//회원탈퇴
	public boolean  memberDelete(memberBean memBean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try{
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
			conn = ds.getConnection();
			String sql = "DELETE FROM dongyang.Member WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memBean.getId());
			int count = pstmt.executeUpdate();
			if (count == 1) {
	            flag = true;
	        }

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
		}
		return flag;
		
	}
	//중복 아이디 체크 
	  public boolean idCheck(String id) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        boolean idCheck = false;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();;
	            String sql = "select id from dongyang.Member where id = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();
	            idCheck = rs.next();

	        } catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
			}
			return idCheck;
	    }
	  //중복 메일 체크
	  public boolean emailCheck(String email) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        boolean emailCheck = false;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();
	            String sql= "select mail from dongyang.Member where mail = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, email);
	            rs = pstmt.executeQuery();
	            emailCheck = rs.next();

	        } catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
			}
			return emailCheck;
	    }
	  //회원 가입
	  public boolean memberInsert(memberBean memBean) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        boolean flag = false;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();
	            String sql = "insert into dongyang.Member values(?,?,?,?)";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, memBean.getId());
	            pstmt.setString(2, memBean.getPw());
	            pstmt.setString(3, memBean.getEmail());
	            pstmt.setString(4, null);
	            int count = pstmt.executeUpdate();

	            if (count == 1) {
	                flag = true;
	            }

	        } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
	        return flag;
	    }
	  
	  //회원목록
	  public Vector<memberBean> getMemberList() {
		  Connection conn = null;
	        Statement stmt = null;
	        ResultSet rs = null;
	        Vector<memberBean> mResult = new Vector<memberBean>();

	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();
	            String sql = "select * from dongyang.Member";
	            stmt = conn.createStatement();
	            rs = stmt.executeQuery(sql);

	            while (rs.next()) {
	                memberBean memBean = new memberBean();
	                memBean.setId(rs.getString("id"));
	                memBean.setPw(rs.getString("pw"));
	                memBean.setEmail(rs.getString("mail"));
	                memBean.setAdmin(rs.getString("admin"));
	                mResult.add(memBean);
	            }
	        } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (stmt != null) try { stmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
	        return mResult;
	  }

}
