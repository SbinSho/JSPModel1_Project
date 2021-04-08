package databoard;

import java.sql.Timestamp;

//VO

//1.DB게시판의 하나의 글정보를 검색하여 각변수에 저장할 용도의 클래스
//2.입력한 새글정보를  DB로 전송하여 INSERT하기전에 임시로 각변수에 저장할 용도의 클래스 
public class DataBoardBean {
	//변수
	private int num;
	private String id;
	private String passwd;
	private String subject;
	private String content;
	private int readcount;
	private Timestamp date;
	private String serverFileName1;
	private String serverFileName2;
	
	
	public String getServerFileName2() {
		return serverFileName2;
	}
	public void setServerFileName2(String serverFileName2) {
		this.serverFileName2 = serverFileName2;
	}
	public String getServerFileName1() {
		return serverFileName1;
	}
	public void setServerFileName1(String serverFileName1) {
		this.serverFileName1 = serverFileName1;
	}
	
	
	//getter,setter메소드 
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}

	
	
	
}
