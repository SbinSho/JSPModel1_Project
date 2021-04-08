package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {//DB작업 하는 클래스 
	
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
	
	
	public  int  insertMember(MemberBean  memberBean){
		
		int check = 0;
		
		try{	
			con = getConnection();
			
			sql = "insert into member"
					+ "(id, passwd, name, age, gender, mtel, email, postcode, address, detailAddress, extraAddress, reg_date) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberBean.getId());
			pstmt.setString(2, memberBean.getPasswd());
			pstmt.setString(3, memberBean.getName());
			pstmt.setString(4, memberBean.getAge());
			pstmt.setString(5, memberBean.getGender());
			pstmt.setString(6, memberBean.getMtel());
			pstmt.setString(7, memberBean.getEmail());
			pstmt.setString(8, memberBean.getPostcode());
			pstmt.setString(9, memberBean.getAddress());
			pstmt.setString(10, memberBean.getDetailAddress());
			pstmt.setString(11, memberBean.getExtraAddress());

			//5. insert 문장을 DB에 전송 하여 실행
			check = pstmt.executeUpdate();
		  }catch(Exception e){
			  System.out.println("insertMember메소드 내부에서 SQL실행예외 : " + e);
		  }	finally { //무조건 한번 실행 해야 할 구문이 있을때.... 작성하는 영역
			//6.자원해제
			resourceClose();  
		  }
		
		return check;
	}//insertMember메소드 끝
	
	
	public int idCheck(String id){//입력한 아이디를 매개변수로 전달 받는다.
		
		int check = 0; //아이디 중복이냐 , 아니냐를? 판단 하는값을 저장
		
		try {
			con = getConnection();
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				check = 1; //아이디중복
			}else{
				check = 0; //아이디중복아님
			}
		} catch (Exception e) {
			System.out.println("idCheck메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		//8.리턴 
		return check; // 1 또는 0을  join_IDcheck.jsp로 리턴한다.
	
	}//idCheck()메소드 끝
	public int mtelCheck(String mtel){//입력한 아이디를 매개변수로 전달 받는다.
		
		int check = 0; //아이디 중복이냐 , 아니냐를? 판단 하는값을 저장
		
		try {
			con = getConnection();
			sql = "select * from member where mtel=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mtel);
			rs = pstmt.executeQuery();
			if(rs.next()){
				check = 1; //아이디중복
			}else{
				check = 0; //아이디중복아님
			}
		} catch (Exception e) {
			System.out.println("mtelCheck메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		//8.리턴 
		return check; // 1 또는 0을  join_IDcheck.jsp로 리턴한다.
		
	}//idCheck()메소드 끝
	
	public int emailCheck(String email){
		
		int check = 0; 
		
		try {
			con = getConnection();
			sql = "select * from member where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				check = 1; 
			}else{
				check = 0; 
			}
		} catch (Exception e) {
			System.out.println("emailCheck메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		return check;
	
	}
	
	
	public int userCheck(String id, String passwd){//사용자가 입력한 아이디, 비밀번호 전달 받음
		
		int check = -1;  //  1  ->  아이디 맞음, 비밀번호 맞음
						 //  0  ->  아이디 맞음 , 비밀번호 틀림
						 //  -1 ->  아이디 틀림	
		try {
			con = getConnection();
			sql = "select * from member where id=?";
			pstmt  = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){//입력한 아이디가 DB에 저장되어 있다면
				if(passwd.equals(rs.getString("passwd"))){
					check = 1; //아이디 맞음 , 비밀번호 맞음
				}else{	
					check = 0; //아이디 맞음 , 비밀번호 틀림
				}
			}else{//입력한 아이디에 해당하는 레코드가 검색되지 않는다면
				 //(입력한 아이디가 DB에 저장되어 있지 않다면)
				check = -1;
			}
		} catch (Exception e) {
			System.out.println("userCheck메소드 내부에서 예외 발생 : " + e);
		} finally {
			//자원해제
			resourceClose();
		}
		return check;//loginPro.jsp로 반환 
	}
	
	public String getMemberPwd(String id){
		String pwd = null;
		
		
		try {
			con = getConnection();
			sql = "select passwd from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				pwd = rs.getString(1);
			}
			
			
		} catch (Exception e) {
			System.out.println("getMemberPwd메소드 내부에서 오류 발생 : " + e);
		} finally {
			resourceClose();
		}
		
		
		return pwd; 
	}
	public String getMemberauth(String email){
		String pwd = null;
		
		
		try {
			con = getConnection();
			sql = "select passwd from member where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				pwd = rs.getString(1);
			}
			
			
		} catch (Exception e) {
			System.out.println("getMemberauth메소드 내부에서 오류 발생 : " + e);
		} finally {
			resourceClose();
		}
		
		
		return pwd; 
	}
	
	public void updateMember(String id) {
		
		
		try {
			con = getConnection();
			
			sql = "update member set "
					+ "id=?, passwd=?, mtel=?, postcode=?, address=? "
					+ "where id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			

			
		} catch (Exception e) {

			System.out.println("updateMemeber 메소드 오류 : " + e);
		} finally {
			resourceClose();
		}
		
		
		
	}
	
	public MemberBean getMember(String id) {
		MemberBean mbean = new MemberBean();
		
		try {
			
			con = getConnection();
			sql = "select * from member where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()){
				mbean.setId(rs.getString(1));
				mbean.setPasswd(rs.getString(2));
				mbean.setName(rs.getString(3));
				mbean.setAge(rs.getString(4));
				mbean.setGender(rs.getString(5));
				mbean.setMtel(rs.getString(6));
				mbean.setEmail(rs.getString(7));
				mbean.setPostcode(rs.getString(8));
				mbean.setAddress(rs.getString(9));
				mbean.setDetailAddress(rs.getString(10));
				mbean.setExtraAddress(rs.getString(11));
			}
			
		} catch (Exception e) {
			
			System.out.println("getMember 메소드 내부에서 오류 : " + e);
			
		} finally {
			resourceClose();
		}
		
		return mbean;
	}
	
	public  int  updateMember(MemberBean  memberBean){
		
		int check = 0;
		
		try{	
			con = getConnection();
			
			sql = "update member set  "
					+ "passwd=?, name=?, age=?, gender=?, mtel=?, email=?, "
					+ "postcode=?, address=?, detailaddress=?, extraaddress=?"
					+ " where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberBean.getPasswd());
			pstmt.setString(2, memberBean.getName());
			pstmt.setString(3, memberBean.getAge());
			pstmt.setString(4, memberBean.getGender());
			pstmt.setString(5, memberBean.getMtel());
			pstmt.setString(6, memberBean.getEmail());
			pstmt.setString(7, memberBean.getPostcode());
			pstmt.setString(8, memberBean.getAddress());
			pstmt.setString(9, memberBean.getDetailAddress());
			pstmt.setString(10, memberBean.getExtraAddress());
			pstmt.setString(11, memberBean.getId());

			//5. insert 문장을 DB에 전송 하여 실행
			check = pstmt.executeUpdate();
		  }catch(Exception e){
			  System.out.println("insertMember메소드 내부에서 SQL실행예외 : " + e);
		  }	finally { //무조건 한번 실행 해야 할 구문이 있을때.... 작성하는 영역
			//6.자원해제
			resourceClose();  
		  }
		
		return check;
	}
	public  int  deleteMember(String id, String passwd){
		
		int check = 0;
		
		try{	
			con = getConnection();
			
			sql = "delete from member where id=? and passwd=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			
			check = pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("deleteMember메소드 내부에서 SQL실행예외 : " + e);
		}	finally { 
			//6.자원해제
			resourceClose();  
		}
		
		return check;
	}
	public String id_find(String name, String email){//입력한 아이디를 매개변수로 전달 받는다.
		String find_id=null;
		
		try {
			con = getConnection();
			sql = "select id from member where name=? AND email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				find_id = rs.getString("id"); //아이디중복
			}
		} catch (Exception e) {
			System.out.println("id_find 메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		//8.리턴 
		return find_id; // 1 또는 0을  join_IDcheck.jsp로 리턴한다.
		
	}//idCheck()메소드 끝
	
	public String passwd_find(String id, String name, String email){//입력한 아이디를 매개변수로 전달 받는다.
		String find_passwd=null;

		try {
			con = getConnection();
			sql = "select passwd from member where id=? AND name=? AND email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				find_passwd = rs.getString("passwd");
			}
		} catch (Exception e) {
			System.out.println("passwd_find 메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		return find_passwd;
		
	}
	
	public int passwd_findCheck(String id, String name, String email){//입력한 아이디를 매개변수로 전달 받는다.
		int result = 0;
		
		try {
			con = getConnection();
			sql = "select passwd from member where id=? AND name=? AND email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = 1;
			}
		} catch (Exception e) {
			System.out.println("passwd_find 메소드 내부에서 예외 발생 : " + e);
		} finally {
			resourceClose();
		}
		return result;
		
	}
	
	public int passwd_check(MemberBean bean) {
		
		int result = 0;
		
		try {
			con = getConnection();
			sql = "select passwd from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("passwd").equals(bean.getPasswd())) result = 1;
			}
			
		} catch (Exception e) {
			
			System.out.println("passwd_check 메소드 내부에서 예외 발생 : " + e);
			
		}	finally {
			resourceClose();
		}
		
		return result;
	}
	
}//MemberDAO클래스 끝








