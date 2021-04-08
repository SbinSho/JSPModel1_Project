package imgboard_comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class imgCommentDAO {

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
		  System.out.println("자원해제 실패 : " + e);
	  }
	}//resourceClose()
	
	private Connection getConnection() throws Exception{ 		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/JspProject");
		con = ds.getConnection();
		
		return con;
		
	}
	
	public int insert_CommnetBoard(int cNum,String id, String comment){ //<--입력한 새글정보는 매개변수로 전달 받음
		
		//추가할 새글번호를 저장할 변수 
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "insert into comment_imgboard "
				+ "(cNum , id, comment) "
				+ "values(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cNum);
			pstmt.setString(2, id);
			pstmt.setString(3, comment);
			
			//insert문 실행
			check = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insert_CommnetBoard메소드 내부에서 예외발생 : " + e);
		} finally {
			//자원해제
			resourceClose();
		}
		
		return check;
		
	}//insertBoard메소드 끝 <------ writePro.jsp페이지에서 호출하는 메소드 	
	
	
	public List<imgCommentBean> getComment_BoardList(int cNum){
		
		List<imgCommentBean> boardList = new ArrayList<imgCommentBean>();
		
		try{
			con = getConnection();
			sql = "select * from comment_imgboard where cNum=? order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cNum);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				imgCommentBean cBean = new imgCommentBean();
				
				cBean.setId(rs.getString("id"));
				cBean.setComment(rs.getString("comment"));
				cBean.setDate(rs.getTimestamp("date"));
				cBean.setNum(rs.getInt("num"));
				
				
				boardList.add(cBean);
				
			}//while반복문 끝
			
		}catch(Exception e){
			System.out.println("getComment_BoardList메소드 내부에서 예외 발생 : " + e);
		}finally {
			//자원해제
			resourceClose();
		}
		
		return boardList; 
	}//getBoardList메소드 끝
	
	public int delete_CommentBoard(String id, int num){
		int check = 0;
			
		try {
			con = getConnection();
			sql = "delete from comment_imgboard where num=? AND id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			
			check = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("deleteBoard메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		return check;
	}
	public int update_CommentimgBoard(String id, int num, String comment){
		int check = 0;
			
		try {
			con = getConnection();
			sql = "update comment_imgboard set comment=? where num=? AND id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, comment);
			pstmt.setInt(2, num);
			pstmt.setString(3, id);
			check = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("update_CommentimgBoard메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		return check;
	}
}

