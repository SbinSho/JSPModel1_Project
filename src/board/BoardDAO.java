package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BoardDAO {
	
	Connection con = null;
	ResultSet  rs = null;
	PreparedStatement pstmt = null;
	String sql="";
	
	public void resourceClose(){
	  try{	
		if(pstmt != null) pstmt.close();
		if(rs != null) rs.close();
		if(con != null) con.close();
	  }catch(Exception e){
		  System.out.println("자원해제 오류: " + e);
	  }
	} 
	
	
	
	private Connection getConnection() throws Exception{ 		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/JspProject");
		con = ds.getConnection();
		
		return con; 
		
	}
	
	public int insertBoard(BoardBean bBean){ 
		
		
		int check = 0;
		
		try {
			con = getConnection();
			sql = "insert into board "
				+ "( id , passwd, subject, "
				+ "content, readcount, date) "
				+ "values(?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bBean.getId());
			pstmt.setString(2, bBean.getPasswd());
			pstmt.setString(3, bBean.getSubject());
			pstmt.setString(4, bBean.getContent());
			pstmt.setInt(5, 0);
			
			check = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertBoard 메소드 내부에서 오류 : " + e);
		} finally {
			resourceClose();
		}
		return check;
		
	}
	
	
	public int getBoardCount(HashMap<String, String> serArr){
		int count = 0;
		try {
			con = getConnection();
			if(serArr.get("opt").equals("0")){
				sql = "select count(*) from board";
				pstmt = con.prepareStatement(sql);
			}
			else if(serArr.get("opt").equals("1")){
				String search = serArr.get("search");
				sql = "select count(*) from board where content LIKE ? OR subject LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setString(2, "%"+search+"%");
			}
			else if(serArr.get("opt").equals("2")){
				String search = serArr.get("search");
				sql = "select count(*) from board where id LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("getBoardCount()메소드 내부에서 오류 : " + e);
		} finally {
			resourceClose();
		}	
		return count; 
	}

	public int Main_getBoardCount(){
		int count = 0;
		
		try {
			con = getConnection();

			sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("Main_getBoardCount()메소드 내부에서 오류 : " + e);
		} finally {
			resourceClose();
		}	
		return count;
	}
	
	public List<BoardBean> getBoardList(int startRow,int pageSize, HashMap<String, String> serArr){
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try{
			con = getConnection();
			if(serArr.get("opt").equals("0")){
				sql = "select * from board order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				
			}
			else if(serArr.get("opt").equals("1")){
				String search = serArr.get("search");
				sql = "select * from board where subject LIKE ? or content LIKE ? "
						+ "order by num desc limit ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setString(2, "%"+search+"%");
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, pageSize);
			}
			else if(serArr.get("opt").equals("2")){
				String search = serArr.get("search");
				sql = "select * from board where id LIKE ?"
						+ "order by num desc limit ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setId(rs.getString("id"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
				boardList.add(bBean);
			
			}
		
		}catch(Exception e){
			System.out.println("getBoardList 메소드 내부에서 오류 : " + e);
		}finally {
			resourceClose();
		}
		
		return boardList; 
	}
	
	public List<BoardBean> Main_getBoardList(int startRow,int pageSize){
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try{
			con = getConnection();
			sql = "select * from board order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
				
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setId(rs.getString("id"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
				boardList.add(bBean);
				
			}
			
		}catch(Exception e){
			System.out.println("Main_getBoardList 메소드 내부에서 오류 : " + e);
		}finally {
			
			resourceClose();
		}
		
		return boardList; 
	}
	
	public void updateReadCount(int num){
		try {
			con = getConnection();
			sql = "update board set readcount = readcount+1  where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateReadCount 메소드 내부에서 오류 : " + e.toString());
		} finally {
			resourceClose();
		}	
	}
	
	public BoardBean getBoard(int num){	
		BoardBean bBean = null;		
		try {
			con = getConnection();
			sql = "select * from board where num=?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
				
			if(rs.next()){
				bBean = new BoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setId(rs.getString("id"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
			};

		} catch (Exception e) {
			System.out.println("getBoard硫붿냼�뱶�뿉�꽌 �삁�쇅 諛쒖깮 : " + e);
		} finally{
			resourceClose();
		}
		return bBean;
	}

	public int deleteBoard(String id, int num, String  passwd){
		int check = 0;
			
		try {
			con = getConnection();
			sql = "select id, passwd from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd")) && id.equals(rs.getString("id"))){
					check = 1;
					
					sql = "delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					
				}else{
					check = 0; 
				}				
			}	
		} catch (Exception e) {
			System.out.println("deleteBoard 메소드 내부에서 오류 : " + e);
		} finally {
			resourceClose();
		}
		return check;
	}
	
	public int MemberdeleteBoard(String id, String  passwd){
		int check = 0;
		
		try {
			con = getConnection();
			
					
			sql = "delete from board where id=? AND passwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			pstmt.executeUpdate();
					
						
			
		} catch (Exception e) {
			System.out.println("MemberdeleteBoard 메소드 내부에서 오류 : " + e);
		} finally {
			resourceClose();
		}
		return check;
	}
	
	public int updateBoard(String id, int num, String Subject, String Content){
		
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "update board "
					+ "set subject=?, content=? "
					+ "where num=? AND id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, Subject);
			pstmt.setString(2, Content);
			pstmt.setInt(3, num);
			pstmt.setString(4, id);
			
			check = pstmt.executeUpdate();
			
		} catch (Exception e) {
						
			System.out.println("updateBoard 메소드 내부에서 오류 : " + e);

		} finally {
			resourceClose();
		}
		
		
		
		return check;
		
		
	}
	
	public int Member_updateBoard(String id, String passwd){
			
			int check = 0;
			
			try {
				
				con = getConnection();
				sql = "update board "
						+ "set passwd=?"
						+ "where id=?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, passwd);
				pstmt.setString(2, id);
				
				check = pstmt.executeUpdate();
				
			} catch (Exception e) {
							
				System.out.println("Member_updateBoard 메소드 오류 : " + e);
		
			} finally {
				resourceClose();
			}
			return check;
		}
	
	
	
}















