package webproject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import java.sql.*;
import java.util.Vector;

public class BoardMg {
	//글목록
	public Vector<boardBean> getPostList() {
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Vector<boardBean> pResult = new Vector<boardBean>();
        try {
        	Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
			conn = ds.getConnection();

			 String sql = "select * from dongyang.Board ORDER BY bdate DESC";
	            stmt = conn.createStatement();
	            rs = stmt.executeQuery(sql);

	            while (rs.next()) {
	                boardBean boardB = new boardBean();
	                boardB.setBno(rs.getInt("bno"));
	                boardB.setBtag(rs.getString("btag"));
	                boardB.setBtitle(rs.getString("btitle"));
	                boardB.setBwriter(rs.getString("bwriter"));
	                boardB.setBdate(rs.getDate("bdate"));
	                boardB.setBreco(rs.getInt("breco"));
	                pResult.add(boardB);
	            }
			 } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	if (stmt != null) try { stmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
        }
	        return pResult;
	  }

	//글삽입
	 public boolean insertPost(HttpServletRequest req) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        boolean result = false;
	        try {
	        	String uploadDir =this.getClass().getResource("").getPath();
	        	uploadDir =	uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"webproject/src/main/webapp/data";
	            MultipartRequest multi = new MultipartRequest(req, uploadDir, 15 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());

	            Context initContext = new InitialContext();
	    		Context envContext = (Context)initContext.lookup("java:/comp/env");
	    		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
	    		conn = ds.getConnection();
	            String query = "insert into dongyang.Board(btag, btitle, bwriter, bdate, bcontent, bimage, breco)"
	                    + "values(?, ?, ?, now(), ?, ?, null)";
	            pstmt = conn.prepareStatement(query);
	            if( multi.getParameter("btag").equals("")||multi.getParameter("btitle").equals("")||multi.getParameter("bcontent").equals(""))
	            	{return result=false;}
	            pstmt.setString(1, multi.getParameter("btag"));
	            pstmt.setString(2, multi.getParameter("btitle"));
	            pstmt.setString(3, multi.getParameter("bwriter"));
	            pstmt.setString(4, multi.getParameter("bcontent"));
	            pstmt.setString(5, multi.getParameter("bimage"));
	            if (multi.getFilesystemName("bimage") == null) {
	                pstmt.setString(5, null);
	            } else {
	                pstmt.setString(5, multi.getFilesystemName("bimage"));
	            }
	            int count = pstmt.executeUpdate();
	            if (count == 1) result = true;

	        }catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
	        return result;
	    }
	//글조회
	 public boardBean getPost(int bno) {
			Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        boardBean boardB = null;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select * from dongyang.Board where bno = ?";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		pstmt.executeQuery();
		    		rs = pstmt.executeQuery();

		            while (rs.next()) {
		                boardB = new boardBean();
		                boardB.setBno(rs.getInt("bno"));
		                boardB.setBtag(rs.getString("btag"));
		                boardB.setBtitle(rs.getString("btitle"));
		                boardB.setBwriter(rs.getString("bwriter"));
		                boardB.setBdate(rs.getDate("bdate"));
		                boardB.setBreco(rs.getInt("breco"));
		                boardB.setBimage(rs.getString("bimage"));
		                boardB.setBcontent(rs.getString("bcontent"));
		            }
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return boardB;
		  }
	 //글 삭제
	 public boolean deletePost( int bno) {
			Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        boolean result = false;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "delete from dongyang.Board where bno = ?";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		int count = pstmt.executeUpdate();
		            if (count == 1) result = true;

				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return result;
		  }
	//글 수정
	 public boolean modifyPost(HttpServletRequest req) {
		 Connection conn = null;
	        PreparedStatement pstmt = null;
	        boolean result = false;
	        try {
	        	String uploadDir =this.getClass().getResource("").getPath();
	        	uploadDir =	uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"webproject/src/main/webapp/data";
	            MultipartRequest multi = new MultipartRequest(req, uploadDir, 15 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());

	            if( multi.getParameter("btag").equals("")||multi.getParameter("btitle").equals("")||multi.getParameter("bcontent").equals(""))
            	{return result=false;}

	            Context initContext = new InitialContext();
	    		Context envContext = (Context)initContext.lookup("java:/comp/env");
	    		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
	    		conn = ds.getConnection();

	    		if (multi.getFilesystemName("bimage") == null) {
	                String query = "update dongyang.Board set btag = ?, btitle = ?, bcontent = ? where bno = ?";
	                pstmt = conn.prepareStatement(query);
	                pstmt.setString(1, multi.getParameter("btag"));
	                pstmt.setString(2, multi.getParameter("btitle"));
	                pstmt.setString(3, multi.getParameter("bcontent"));
	                pstmt.setInt(4, Integer.parseInt(multi.getParameter("bno")));
	            } else {
	                String query = "update dongyang.Board set btag = ?, btitle = ?, bcontent = ?, bimage = ? where bno = ?";
	                pstmt = conn.prepareStatement(query);
	                pstmt.setString(1, multi.getParameter("btag"));
	                pstmt.setString(2, multi.getParameter("btitle"));
	                pstmt.setString(3, multi.getParameter("bcontent"));
	                pstmt.setString(4, multi.getFilesystemName("bimage"));
	                pstmt.setInt(5, Integer.parseInt(multi.getParameter("bno")));
	            }
	            int count = pstmt.executeUpdate();
	            if (count == 1) result = true;

	        }catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
	        return result;
	 }
	 //추천하기
	 public boolean postReco( String no, String id) {
		 Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt1 = null;
	        ResultSet rs = null;
	        boolean flag = false;
	        int bno = Integer.parseInt(no);
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				String sql1 = "select * from dongyang.Recommend where bno= ? and id= ? ";
				pstmt1 = conn.prepareStatement(sql1);
				pstmt1.setInt(1, bno);
				pstmt1.setString(2, id);
				pstmt1.executeQuery();
	    		rs = pstmt1.executeQuery();
				if(rs.next())
				{return flag = false;}
				else {
				 String sql = "insert into dongyang.Recommend (bno, id) value(?, ?)";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		pstmt.setString(2, id );
		    		int count = pstmt.executeUpdate();
		            if (count == 1) flag = true;
		            }
				}catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return flag;
	}
	 //추천수 가져오기
	 public int countReco(int bno) {
		 	Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt1 = null;
	        ResultSet rs = null;
	        ResultSet rs1 = null;
	        int count = 0;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select count(id) as cnt from dongyang.Recommend where bno = ?";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		pstmt.executeQuery();
		    		rs = pstmt.executeQuery();
		    		if(rs.next()) {
		    			count = rs.getInt("cnt");
		    			String query = "update dongyang.Board set breco = ? where bno = ?";
		    			pstmt1 = conn.prepareStatement(query);
			    		pstmt1.setInt(1, count );
			    		pstmt1.setInt(2, bno );
			    		pstmt1.executeUpdate();
		    		}
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (pstmt1 != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs1 != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return count;
	 }
	 //댓글등록
	 public boolean postComment(int bno, String id, String ccontent) {
		 Connection conn = null;
			PreparedStatement pstmt = null;
	        boolean result = false;
	        if(ccontent==""){return result=false;}
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "insert into dongyang.Comment (bno, cwriter, cdate, ccontent ) value(?, ?, now(),?)";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		pstmt.setString(2, id );
		    		pstmt.setString(3, ccontent );
		    		int count = pstmt.executeUpdate();
		            if (count == 1) result = true;

				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return result;
	 }
	 //해당하는 게시글 댓글리스트 가져오기
	 public Vector<commentBean> getCommentList( int bno) {
			Connection conn = null;
			PreparedStatement pstmt = null;;
	        ResultSet rs = null;
	        commentBean commentB = null;
	        int count = 0;
	        Vector<commentBean> cResult = new Vector<commentBean>();
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select * from dongyang.Comment where bno= ?";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, bno );
				 pstmt.executeQuery();
		         rs = pstmt.executeQuery();
		         while (rs.next()) {
		                commentB = new commentBean();
		                count +=1;
		                commentB.setBcno(count);
		                commentB.setCno(rs.getInt("cno"));
		                commentB.setCwriter(rs.getString("cwriter"));
		                commentB.setCcontent(rs.getString("ccontent"));
		                commentB.setCdate(rs.getDate("cdate"));
		                cResult.add(commentB);

		            }
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return cResult;
		  }
	 //댓글수가져오기
	 public int countComment(int bno) {
		 	Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int count = 0;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select count(cno) as cnt from dongyang.Comment where bno = ?";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		pstmt.executeQuery();
		    		rs = pstmt.executeQuery();
		    		if(rs.next()) {
		    			count = rs.getInt("cnt");
		    		}
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return count;
	 }
	 //댓글정보가저오기
	 public commentBean getComment(int bno, int cno) {
		 Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        commentBean commentB = null;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select * from dongyang.Comment where cno= ? and bno = ?";
				 pstmt = conn.prepareStatement(sql);
				 	pstmt.setInt(1, cno );
				 	pstmt.setInt(2, bno );
		    		pstmt.executeQuery();
		    		rs = pstmt.executeQuery();

		            while (rs.next()) {
		            	commentB = new commentBean();
		            	commentB.setCno(rs.getInt("cno"));
		            	commentB.setBno(rs.getInt("bno"));
		            	commentB.setCwriter(rs.getString("cwriter"));
		            	commentB.setCcontent(rs.getString("ccontent"));
		            }
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return commentB;
	 }
	 //댓글삭제하기
	 public boolean deleteComment( int bno, int cno) {
			Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        boolean result = false;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "delete from dongyang.Comment where bno = ? and cno = ? ";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		pstmt.setInt(2, cno );
		    		int count = pstmt.executeUpdate();
		            if (count == 1) result = true;

				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return result;
		  }
	 //댓글수정하기
	 public boolean updateComment(int bno, int cno, String ccontent) {
		 	Connection conn = null;
	        PreparedStatement pstmt = null;
	        boolean result = false;
	        if(ccontent==""){return result=false;}
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

                String sql = "update dongyang.Comment set ccontent=? where bno = ? and cno= ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, ccontent);
	    		pstmt.setInt(2, bno );
	    		pstmt.setInt(3, cno );
                int count = pstmt.executeUpdate();
	            if (count == 1) result = true;

	        }catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
	        return result;
	 }
	 //같은말머리의글만가져오기
	 public Vector<boardBean> getTagPostList( String tag) {
			Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Vector<boardBean> pResult = new Vector<boardBean>();
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select * from dongyang.Board where btag= ? ORDER BY bdate DESC";
		            pstmt = conn.prepareStatement(sql);
		            pstmt.setString(1, tag);
		            pstmt.executeQuery();
		            rs = pstmt.executeQuery();

		            while (rs.next()) {
		                boardBean boardB = new boardBean();
		                boardB.setBno(rs.getInt("bno"));
		                boardB.setBtag(rs.getString("btag"));
		                boardB.setBtitle(rs.getString("btitle"));
		                boardB.setBwriter(rs.getString("bwriter"));
		                boardB.setBdate(rs.getDate("bdate"));
		                boardB.setBreco(rs.getInt("breco"));
		                pResult.add(boardB);
		            }
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return pResult;
		  }
	 //추천게시판 목록
	 public Vector<boardBean> getRecoPostList( ) {
			Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Vector<boardBean> pResult = new Vector<boardBean>();
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select * from dongyang.Board where breco >= 5 ORDER BY bdate DESC";
		            pstmt = conn.prepareStatement(sql);
		            pstmt.executeQuery();
		            rs = pstmt.executeQuery();

		            while (rs.next()) {
		                boardBean boardB = new boardBean();
		                boardB.setBno(rs.getInt("bno"));
		                boardB.setBtag(rs.getString("btag"));
		                boardB.setBtitle(rs.getString("btitle"));
		                boardB.setBwriter(rs.getString("bwriter"));
		                boardB.setBdate(rs.getDate("bdate"));
		                boardB.setBreco(rs.getInt("breco"));
		                pResult.add(boardB);
		            }
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return pResult;
		  }
	 //공지게시판 목록가져오기
	 public Vector<boardBean> getNoticePostList() {
			Connection conn = null;
	        Statement stmt = null;
	        ResultSet rs = null;
	        Vector<boardBean> pResult = new Vector<boardBean>();
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select * from dongyang.Notice ORDER BY bdate DESC";
		            stmt = conn.createStatement();
		            rs = stmt.executeQuery(sql);

		            while (rs.next()) {
		                boardBean boardB = new boardBean();
		                boardB.setBno(rs.getInt("bno"));
		                boardB.setBtag(rs.getString("btag"));
		                boardB.setBtitle(rs.getString("btitle"));
		                boardB.setBwriter(rs.getString("bwriter"));
		                boardB.setBdate(rs.getDate("bdate"));
		                pResult.add(boardB);
		            }
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (stmt != null) try { stmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return pResult;
		  }
	 //공지게시판 글 작성
	 public boolean insertNoticePost(HttpServletRequest req) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        boolean result = false;
	        try {
	        	String uploadDir =this.getClass().getResource("").getPath();
	        	uploadDir =	uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"webproject/src/main/webapp/data";
	            MultipartRequest multi = new MultipartRequest(req, uploadDir, 15 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());

	            Context initContext = new InitialContext();
	    		Context envContext = (Context)initContext.lookup("java:/comp/env");
	    		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
	    		conn = ds.getConnection();
	            String query = "insert into dongyang.Notice(btag, btitle, bwriter, bdate, bcontent, bimage)"
	                    + "values(?, ?, ?, now(), ?, ?)";
	            pstmt = conn.prepareStatement(query);
	            if( multi.getParameter("btag").equals("")||multi.getParameter("btitle").equals("")||multi.getParameter("bcontent").equals(""))
	            	{return result=false;}
	            pstmt.setString(1, multi.getParameter("btag"));
	            pstmt.setString(2, multi.getParameter("btitle"));
	            pstmt.setString(3, multi.getParameter("bwriter"));
	            pstmt.setString(4, multi.getParameter("bcontent"));
	            pstmt.setString(5, multi.getParameter("bimage"));
	            if (multi.getFilesystemName("bimage") == null) {
	                pstmt.setString(5, null);
	            } else {
	                pstmt.setString(5, multi.getFilesystemName("bimage"));
	            }
	            int count = pstmt.executeUpdate();
	            if (count == 1) result = true;

	        }catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
	        return result;
	    }
	 //공지글 조회
	 public boardBean getNoticePost(int bno) {
			Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        boardBean boardB = null;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "select * from dongyang.Notice where bno = ?";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		pstmt.executeQuery();
		    		rs = pstmt.executeQuery();

		            while (rs.next()) {
		                boardB = new boardBean();
		                boardB.setBno(rs.getInt("bno"));
		                boardB.setBtag(rs.getString("btag"));
		                boardB.setBtitle(rs.getString("btitle"));
		                boardB.setBwriter(rs.getString("bwriter"));
		                boardB.setBdate(rs.getDate("bdate"));
		                boardB.setBimage(rs.getString("bimage"));
		                boardB.setBcontent(rs.getString("bcontent"));
		            }
				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return boardB;
		  }
	 //공지글 삭제
	 public boolean deleteNoticePost( int bno) {
			Connection conn = null;
			PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        boolean result = false;
	        try {
	        	Context initContext = new InitialContext();
				Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
				conn = ds.getConnection();

				 String sql = "delete from dongyang.Notice where bno = ?";
				 pstmt = conn.prepareStatement(sql);
		    		pstmt.setInt(1, bno );
		    		int count = pstmt.executeUpdate();
		            if (count == 1) result = true;

				 } catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
	        	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        	if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
		        return result;
		  }
	 //공지글 수정
	 public boolean updateNoticePost(HttpServletRequest req) {
		 Connection conn = null;
	        PreparedStatement pstmt = null;
	        boolean result = false;
	        try {
	        	String uploadDir =this.getClass().getResource("").getPath();
	        	uploadDir =	uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"webproject/src/main/webapp/data";
	            MultipartRequest multi = new MultipartRequest(req, uploadDir, 15 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());

	            if( multi.getParameter("btag").equals("")||multi.getParameter("btitle").equals("")||multi.getParameter("bcontent").equals(""))
            	{return result=false;}

	            Context initContext = new InitialContext();
	    		Context envContext = (Context)initContext.lookup("java:/comp/env");
	    		DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
	    		conn = ds.getConnection();

	    		if (multi.getFilesystemName("bimage") == null) {
	                String query = "update dongyang.Notice set btag = ?, btitle = ?, bcontent = ? where bno = ?";
	                pstmt = conn.prepareStatement(query);
	                pstmt.setString(1, multi.getParameter("btag"));
	                pstmt.setString(2, multi.getParameter("btitle"));
	                pstmt.setString(3, multi.getParameter("bcontent"));
	                pstmt.setInt(4, Integer.parseInt(multi.getParameter("bno")));
	            } else {
	                String query = "update dongyang.Notice set btag = ?, btitle = ?, bcontent = ?, bimage = ? where bno = ?";
	                pstmt = conn.prepareStatement(query);
	                pstmt.setString(1, multi.getParameter("btag"));
	                pstmt.setString(2, multi.getParameter("btitle"));
	                pstmt.setString(3, multi.getParameter("bcontent"));
	                pstmt.setString(4, multi.getFilesystemName("bimage"));
	                pstmt.setInt(5, Integer.parseInt(multi.getParameter("bno")));
	            }
	            int count = pstmt.executeUpdate();
	            if (count == 1) result = true;

	        }catch (Exception ex) {
	            System.out.println("Exception" + ex);
	        } finally {
				if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
	        }
	        return result;
	 }
}
