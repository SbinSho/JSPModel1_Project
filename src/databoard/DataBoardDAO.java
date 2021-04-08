package databoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;


public class DataBoardDAO {//DB작업 하는 클래스 
	
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
		
		return con; //커넥션을 반환
		
	}//getConnection메소드 끝
	
	public int insert_DataBoard(DataBoardBean bBean){ //<--입력한 새글정보는 매개변수로 전달 받음
		
		int check = 0;
		
		try {
			con = getConnection();
			sql = "insert into data_board "
				+ "( id , passwd, subject, "
				+ "content, readcount, date, serverFileName1, serverFileName2) "
				+ "values(?,?,?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bBean.getId());
			pstmt.setString(2, bBean.getPasswd());
			pstmt.setString(3, bBean.getSubject());
			pstmt.setString(4, bBean.getContent());
			pstmt.setInt(5, 0);
			pstmt.setString(6, bBean.getServerFileName1());
			pstmt.setString(7, bBean.getServerFileName2());
			
			//insert문 실행
			check = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertBoard메소드 내부에서 예외발생 : " + e);
		} finally {
			//자원해제
			resourceClose();
		}
		return check;
		
	}//insertBoard메소드 끝 <------ writePro.jsp페이지에서 호출하는 메소드 	
	
	
	public int getBoardCount(HashMap<String, String> serArr){
		int count = 0;
		
		try {
			con = getConnection();
			if(serArr.get("opt").equals("0")){
				sql = "select count(*) from data_board";
				pstmt = con.prepareStatement(sql);
			}
			else if(serArr.get("opt").equals("1")){
				String search = serArr.get("search");
				sql = "select count(*) from data_board where content LIKE ? OR subject LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setString(2, "%"+search+"%");
			}
			else if(serArr.get("opt").equals("2")){
				String search = serArr.get("search");
				sql = "select count(*) from data_board where id LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);// 조회한 글개수를 저장
			}
		} catch (Exception e) {
			System.out.println("getBoardCount()메소드 내부에서 예외발생 : " + e);
		} finally {
			resourceClose();
		}	
		return count; //조회한 글 개수를 리턴
	}
	
	public List<DataBoardBean> getBoardList(int startRow,int pageSize, HashMap<String, String> serArr){
		
		List<DataBoardBean> boardList = new ArrayList<DataBoardBean>();
		
		try{
			con = getConnection();
			if(serArr.get("opt").equals("0")){
				sql = "select * from data_board order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				
			}
			else if(serArr.get("opt").equals("1")){
				String search = serArr.get("search");
				sql = "select * from data_board where subject LIKE ? or content LIKE ? "
						+ "order by num desc limit ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setString(2, "%"+search+"%");
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, pageSize);
			}
			else if(serArr.get("opt").equals("2")){
				String search = serArr.get("search");
				sql = "select * from data_board where id LIKE ?"
						+ "order by num desc limit ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, pageSize);
			}
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				DataBoardBean bBean = new DataBoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setId(rs.getString("id"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
				boardList.add(bBean);
			
			}//while반복문 끝
		
		}catch(Exception e){
			System.out.println("getBoardList메소드 내부에서 예외 발생 : " + e);
		}finally {
			//자원해제
			resourceClose();
		}
		
		return boardList; 
	}//getBoardList메소드 끝
	
	public void updateReadCount(int num){
		try {
			con = getConnection();
			sql = "update data_board set readcount = readcount+1  where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateReadCount메소드 내부에서 예외 발생 : " + e.toString());
		} finally {
			//자원해제
			resourceClose();
		}	
	}
	
	public DataBoardBean getBoard(int num){	
		DataBoardBean bBean = null;		
		try {
			con = getConnection();
			sql = "select * from data_board where num=?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
				
			if(rs.next()){
				bBean = new DataBoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setId(rs.getString("id"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setServerFileName1(rs.getString("serverFileName1"));
				bBean.setServerFileName2(rs.getString("serverFileName2"));
				
			};

		} catch (Exception e) {
			System.out.println("getBoard메소드에서 예외 발생 : " + e);
		} finally{
			resourceClose();
		}
		//BoardBean객체 리턴
		return bBean;
	}

	public int data_deleteBoard(String id, int num, String  passwd){
		int check = 0;
			
		try {
			con = getConnection();
			sql = "select id, passwd from data_board where num=? AND id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd")) && id.equals(rs.getString("id"))){
					sql = "delete from data_board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					check = pstmt.executeUpdate();
					
				}else{
					check = 0; 
				}				
			}	
		} catch (Exception e) {
			System.out.println("data_deleteBoard메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		return check;
	}
	
	public int Member_data_deleteBoard(String id, String  passwd){
		int check = 0;
		
		try {
			con = getConnection();
			
					
			sql = "delete from data_board where id=? AND passwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			pstmt.executeUpdate();
					
						
			
		} catch (Exception e) {
			System.out.println("Member_data_deleteBoard메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		return check;
	}
	
	public int updateBoard(String id, int num, String Subject, String Content){
		
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "update data_board "
					+ "set subject=?, content=? "
					+ "where num=? AND id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, Subject);
			pstmt.setString(2, Content);
			pstmt.setInt(3, num);
			pstmt.setString(4, id);
			
			check = pstmt.executeUpdate();
			
		} catch (Exception e) {
						
			System.out.println("updateBoard 메소드 오류 : " + e);

		} finally {
			resourceClose();
		}
		
		
		
		return check;
		
		
	}
	
	public int Main_getDataBoardCount(){
		int count = 0;
		
		try {
			con = getConnection();

			sql = "select count(*) from data_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("Main_getDataBoardCount()메소드 내부에서 오류 : " + e);
		} finally {
			resourceClose();
		}	
		return count;
	}
	
	public List<DataBoardBean> Main_getDataBoardList(int startRow,int pageSize){
		
		List<DataBoardBean> boardList = new ArrayList<DataBoardBean>();
		
		try{
			con = getConnection();
			sql = "select * from data_board order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
				
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				DataBoardBean bBean = new DataBoardBean();
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
			System.out.println("Main_getDataBoardList 메소드 내부에서 오류 : " + e);
		}finally {
			
			resourceClose();
		}
		
		return boardList; 
	}
	
	public int Member_updateBoard(String id, String passwd){
		
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "update data_board "
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















